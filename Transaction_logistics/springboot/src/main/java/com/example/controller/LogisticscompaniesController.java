package com.example.controller;

import com.example.common.Result;
import com.example.entity.Goods;
import com.example.entity.Logisticscompanies;
import com.example.service.LogisticscompaniesService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 二手商品前端操作接口
 **/
@RestController
@RequestMapping("/logisticscompanies")
public class LogisticscompaniesController {

    @Resource
    private LogisticscompaniesService logisticscompaniesService;


    // 分页查询
    @GetMapping("/selectPage")
    public Result selectPage(Logisticscompanies logisticscompanies,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Logisticscompanies> page = logisticscompaniesService.selectPage(logisticscompanies, pageNum, pageSize);
        return Result.success(page);
    }

    // 新增
    @PostMapping("/add")
    public Result add(@RequestBody Logisticscompanies logisticscompanies) {
        logisticscompaniesService.add(logisticscompanies);
        return Result.success();
    }
    // 删除
    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id) {
        logisticscompaniesService.deleteById(id);
        return Result.success();
    }


    @DeleteMapping("/delete/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        logisticscompaniesService.deleteBatch(ids);
        return Result.success();
    }
    // 更新
    @PutMapping("/update")
    public Result update(@RequestBody Logisticscompanies logisticscompanies) {
        logisticscompaniesService.updateById(logisticscompanies);
        return Result.success();
    }

    //查全部
    @GetMapping("/selectAll")
    public Result selectAll(Logisticscompanies logisticscompanies) {
        List<Logisticscompanies> list = logisticscompaniesService.selectAll(logisticscompanies);
        return Result.success(list);
    }

    //评分




}
