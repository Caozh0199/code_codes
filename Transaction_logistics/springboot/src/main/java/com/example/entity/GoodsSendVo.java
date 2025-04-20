package com.example.entity;

import java.math.BigDecimal;

public class GoodsSendVo {
    /**
     *
     */
    private Integer id;

    /**
     *
     */
    private String logisticsname;

    /**
     *
     */
    private Integer servicefrequency;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLogisticsname() {
        return logisticsname;
    }

    public void setLogisticsname(String logisticsname) {
        this.logisticsname = logisticsname;
    }

    public Integer getServicefrequency() {
        return servicefrequency;
    }

    public void setServicefrequency(Integer servicefrequency) {
        this.servicefrequency = servicefrequency;
    }

    public BigDecimal getScore() {
        return score;
    }

    public void setScore(BigDecimal score) {
        this.score = score;
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    /**
     *
     */
    private BigDecimal score;

    /**
     *
     */
    private String createtime;

    /**
     *
     */
    private Integer status;
}
