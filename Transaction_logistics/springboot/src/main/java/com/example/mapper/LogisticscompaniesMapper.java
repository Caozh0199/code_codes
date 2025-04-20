package com.example.mapper;

import com.example.entity.Logisticscompanies;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface LogisticscompaniesMapper {
    List<Logisticscompanies> selectAll(Logisticscompanies logisticscompanies);

    void insert(Logisticscompanies logisticscompanies);

    @Delete("delete from logisticscompanies where id=#{id}")
    void deleteById(Integer id);

    void updateById(Logisticscompanies logisticscompanies);

    @Select("select * from logisticscompanies where id=#{logisticscompaniesId}")
    void selectById(Integer logisticscompaniesId);

    @Select("select * from logisticscompanies where logisticsname=#{logisticscompanies}")
    Logisticscompanies selectByName(String logisticscompanies);
}
