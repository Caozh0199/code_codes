package com.example.service;

import cn.hutool.core.date.DateUtil;
import com.example.entity.Account;
import com.example.entity.Logistics;
import com.example.mapper.LogisticsMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 公告信息表业务处理
 **/
@Service
public class LogisticsService {

    @Resource
    private LogisticsMapper logisticsMapper;

    /**
     * 新增
     */
    public void add(Logistics logistics) {
        logisticsMapper.insert(logistics);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        logisticsMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            logisticsMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Logistics logistics) {
        logisticsMapper.updateById(logistics);
    }

    /**
     * 根据ID查询
     */
    public Logistics selectById(Integer id) {
        return logisticsMapper.selectById(id);
    }

    /**
     * 查询所有
     */
    public List<Logistics> selectAll(Logistics logistics) {
        return logisticsMapper.selectAll(logistics);
    }

    /**
     * 分页查询
     */
    public PageInfo<Logistics> selectPage(Logistics logistics, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Logistics> list = logisticsMapper.selectAll(logistics);
        return PageInfo.of(list);
    }

    public PageInfo<Logistics> selectPageselectPagebylogistics(Logistics logistics, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Logistics> list = logisticsMapper.selectAllbylogistics(logistics);
        return PageInfo.of(list);
    }

    public Logistics selectByIds(String trackingNumber) {
        return logisticsMapper.selectByIds(trackingNumber);
    }
}