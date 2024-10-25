package com.example.mapper;

import com.example.entity.Logistics;

import java.util.List;

/**
 * 操作logistics相关数据接口
*/
public interface LogisticsMapper {

    /**
      * 新增
    */
    int insert(Logistics logistics);

    /**
      * 删除
    */
    int deleteById(Integer id);

    /**
      * 修改
    */
    int updateById(Logistics logistics);

    /**
      * 根据ID查询
    */
    Logistics selectById(Integer id);

    /**
      * 查询所有
    */
    List<Logistics> selectAll(Logistics logistics);

    List<Logistics> selectAllbylogistics(Logistics logistics);

    Logistics selectByIds(String trackingNumber);
}