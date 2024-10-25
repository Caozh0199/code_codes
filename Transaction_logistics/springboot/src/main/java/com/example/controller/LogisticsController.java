package com.example.controller;

import com.example.common.Result;
import com.example.entity.Logistics;
import com.example.service.LogisticsService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 公告信息表前端操作接口
 **/
@RestController
@RequestMapping("/logistics")
public class LogisticsController {

    @Resource
    private LogisticsService logisticsService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody Logistics logistics) {
        logisticsService.add(logistics);
        return Result.success();
    }

    /**
     * 删除
     */
    @DeleteMapping("/delete/{id}")
    public Result deleteById(@PathVariable Integer id) {
        logisticsService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        logisticsService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result updateById(@RequestBody Logistics logistics) {
        logisticsService.updateById(logistics);
        return Result.success();
    }

    /**
     * 根据ID查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Logistics logistics = logisticsService.selectById(id);
        return Result.success(logistics);
    }

    @GetMapping("/selectByIds/{trackingNumber}")
    public Result selectByIds(@PathVariable String trackingNumber) {
        Logistics logistics = logisticsService.selectByIds(trackingNumber);
        return Result.success(logistics);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(Logistics logistics ) {
        List<Logistics> list = logisticsService.selectAll(logistics);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(Logistics logistics,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Logistics> page = logisticsService.selectPage(logistics, pageNum, pageSize);
        return Result.success(page);
    }


    @GetMapping("/selectPage1")
    public Result selectPagebylogistics(Logistics logistics,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Logistics> page = logisticsService.selectPageselectPagebylogistics(logistics, pageNum, pageSize);
        return Result.success(page);
    }



}