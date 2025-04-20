package com.example.mapper;

import com.example.entity.Account;
import org.apache.ibatis.annotations.Select;

public interface WarehouseadminMapper {
    @Select("select * from warehouseadmin where username = #{username}")
    Account selectByUsername(String username);


    @Select("select * from warehouseadmin where id = #{id}")
    Account selectById(Integer id);
}
