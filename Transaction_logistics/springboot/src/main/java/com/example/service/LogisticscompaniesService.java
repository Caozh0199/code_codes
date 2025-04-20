package com.example.service;

import cn.hutool.core.date.DateUtil;
import com.example.common.enums.RoleEnum;
import com.example.entity.Account;
import com.example.entity.Logisticscompanies;
import com.example.mapper.LogisticscompaniesMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 二手商品业务处理
 **/
@Service
public class LogisticscompaniesService {
    @Resource
    private LogisticscompaniesMapper logisticscompaniesMapper;

    /**
     * 分页查询
     */
    public PageInfo<Logisticscompanies> selectPage(Logisticscompanies logisticscompanies, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.USER.name().equals(currentUser.getRole())) {
            logisticscompanies.setId(currentUser.getId());
        }
        PageHelper.startPage(pageNum, pageSize);
        List<Logisticscompanies> list = logisticscompaniesMapper.selectAll(logisticscompanies);
        return PageInfo.of(list);
    }


    public void add(Logisticscompanies logisticscompanies) {
        logisticscompanies.setCreatetime(DateUtil.now());
        logisticscompaniesMapper.insert(logisticscompanies);
    }

    public void deleteById(Integer id) {
        logisticscompaniesMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            this.deleteById(id);
        }
    }

    public void updateById(Logisticscompanies logisticscompanies) {
        logisticscompaniesMapper.updateById(logisticscompanies);
    }

    public void selectById(Integer logisticscompaniesId) {
        logisticscompaniesMapper.selectById(logisticscompaniesId);
    }
    public List<Logisticscompanies> selectAll(Logisticscompanies logisticscompanies) {
        return logisticscompaniesMapper.selectAll(logisticscompanies);
    }

    public Logisticscompanies selectByName(String logisticscompanies) {

        return logisticscompaniesMapper.selectByName(logisticscompanies);
    }
}