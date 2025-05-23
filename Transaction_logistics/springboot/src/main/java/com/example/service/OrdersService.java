package com.example.service;

import cn.hutool.core.date.DateField;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.LocalDateTimeUtil;
import cn.hutool.core.lang.Dict;
import cn.hutool.core.util.RandomUtil;
import com.example.common.enums.OrderStatusEnum;
import com.example.common.enums.RoleEnum;
import com.example.entity.*;
import com.example.mapper.OrdersMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 订单信息业务处理
 **/
@Service
public class OrdersService {

    @Resource
    private OrdersMapper ordersMapper;
    @Resource
    GoodsService goodsService;
    @Resource
    AddressService addressService;
    @Resource
    LogisticsService logisticsService;
    @Resource
    LogisticscompaniesService logisticscompaniesService;

    /**
     * 新增
     */
    public void add(Orders orders) {
        Integer goodsId = orders.getGoodsId();
        Goods goods = goodsService.selectById(goodsId);
        orders.setGoodsName(goods.getName());
        orders.setGoodsImg(goods.getImg());
        orders.setSaleId(goods.getUserId());  //卖家用户ID
        orders.setTotal(goods.getPrice());

        Integer addressId = orders.getAddressId();
        Address address = addressService.selectById(addressId);
        orders.setUserName(address.getUserName());
        orders.setAddress(address.getAddress());
        orders.setPhone(address.getPhone());

        Account currentUser = TokenUtils.getCurrentUser();
        orders.setUserId(currentUser.getId());  //下单人的ID
        orders.setStatus(OrderStatusEnum.NOTPAY.value); // 订单默认是待支付
        orders.setOrderNo(System.currentTimeMillis() + RandomUtil.randomNumbers(7)); // 20位的订单号
        orders.setTime(DateUtil.now());

        ordersMapper.insert(orders);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        ordersMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            ordersMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Orders orders) {
        String status = orders.getStatus();
        if("已完成".equals(status)){
            Logisticscompanies logisticscompanies = logisticscompaniesService.selectByName(orders.getLogisticscompanies());
            int  score = logisticscompanies.getScore(); // 现有评分
            int servicefrequency = logisticscompanies.getServicefrequency(); // 服务次数
            Integer all = score * servicefrequency;
            servicefrequency ++;
            all = all+ orders.getScore();
            score = all / servicefrequency;
            logisticscompanies.setScore(score);
            logisticscompanies.setServicefrequency(servicefrequency);
            logisticscompaniesService.updateById(logisticscompanies);
        }
        Random random = new Random();
        int number = random.nextInt(41) + 80;
        int numbers = random.nextInt(21) + 40;
        String a = String.valueOf(number);
        String b = String.valueOf(numbers);
        a= a+".272955";
        b=b+".705404";
        Logistics logistics = new Logistics();
        logistics.setSender(orders.getUser());
        //随机生成15位的物流单号给
        String trackingNumber = RandomUtil.randomNumbers(15);
        logistics.setTrackingNumber(trackingNumber);
        logistics.setStatus(orders.getStatus());
        logistics.setShippingTime(String.valueOf(LocalDateTimeUtil.now()));
        logistics.setLongitude(a);
        logistics.setLatitude(b);
        logisticsService.add(logistics);
        orders.setTrackingNumber(trackingNumber);
        ordersMapper.updateById(orders);
    }

    /**
     * 根据ID查询
     */
    public Orders selectById(Integer id) {
        return ordersMapper.selectById(id);
    }

    /**
     * 查询所有
     */
    public List<Orders> selectAll(Orders orders) {
        return ordersMapper.selectAll(orders);
    }

    /**
     * 分页查询
     */
    public PageInfo<Orders> selectPage(Orders orders, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.USER.name().equals(currentUser.getRole())) {
            orders.setUserId(currentUser.getId());
        }
        PageHelper.startPage(pageNum, pageSize);
        List<Orders> list = ordersMapper.selectAll(orders);
        return PageInfo.of(list);
    }

    public Orders selectByOrderNo(String orderNo) {
        return ordersMapper.selectByOrderNo(orderNo);
    }

    public PageInfo<Orders> selectSalePage(Orders orders, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.USER.name().equals(currentUser.getRole())) {
            orders.setSaleId(currentUser.getId());
        }
        PageHelper.startPage(pageNum, pageSize);
        List<Orders> list = ordersMapper.selectAll(orders);
        return PageInfo.of(list);
    }


    public List<Dict> selectLine() {
        List<Dict> dictList = new ArrayList<>();
        // 所有已完成的订单
        List<Orders> ordersList = ordersMapper.selectAll(null).stream().filter(orders ->
                OrderStatusEnum.DONE.value.equals(orders.getStatus())).collect(Collectors.toList());
        Date date = new Date();
        DateTime start = DateUtil.offsetDay(date, -8);
        DateTime end = DateUtil.offsetDay(date, -1);
        List<DateTime> dateTimes = DateUtil.rangeToList(start, end, DateField.DAY_OF_YEAR);
        List<String> dateList = dateTimes.stream().map(DateUtil::formatDate).sorted(Comparator.naturalOrder()).collect(Collectors.toList());
        for (String day : dateList) {
            BigDecimal total = ordersList.stream().filter(orders -> orders.getTime().contains(day)).map(Orders::getTotal).reduce(BigDecimal::add).orElse(BigDecimal.ZERO);
            Dict dict = Dict.create().set("name", day).set("value", total);
            dictList.add(dict);
        }
        return dictList;
    }

    public List<Dict> selectBar() {
        List<Dict> dictList = new ArrayList<>();
        // 所有已完成的订单
        List<Orders> ordersList = ordersMapper.selectAll(null).stream().filter(orders ->
                OrderStatusEnum.DONE.value.equals(orders.getStatus())).collect(Collectors.toList());
        Set<String> saleList = ordersList.stream().map(Orders::getSaleName).collect(Collectors.toSet());
        for (String sale : saleList) {
            BigDecimal total = ordersList.stream().filter(orders -> orders.getSaleName().equals(sale)).map(Orders::getTotal).reduce(BigDecimal::add).orElse(BigDecimal.ZERO);
            Dict dict = Dict.create().set("name", sale).set("value", total);
            dictList.add(dict);
        }
        return dictList;
    }

    public void updateByIdSend(Orders orders) {
        Random random = new Random();
        int number = random.nextInt(41) + 80;
        int numbers = random.nextInt(21) + 40;
        String a = String.valueOf(number);
        String b = String.valueOf(numbers);
        a= a+".272955";
        b=b+".705404";
        Logistics logistics = new Logistics();
        logistics.setSender(orders.getUser());
        //随机生成15位的物流单号给
        String trackingNumber = RandomUtil.randomNumbers(15);
        logistics.setTrackingNumber(trackingNumber);
        logistics.setStatus(orders.getStatus());
        logistics.setShippingTime(String.valueOf(LocalDateTimeUtil.now()));
        logistics.setLongitude(a);
        logistics.setLatitude(b);
        logistics.setOrderId(orders.getOrderNo());
        logisticsService.add(logistics);
        ordersMapper.updateById(orders);
    }
}