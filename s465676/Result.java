package org.ITMO.s465676;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Result implements Serializable {
    private double x;
    private double y;
    private double r;
    private boolean isHit;
    private Double calTime;
    private LocalDateTime releaseTime;

    public Result() {
    }

    public Result(double x, double y, double r, boolean isHit, Double calTime, LocalDateTime releaseTime) {
        this.x = x;
        this.y = y;
        this.r = r;
        this.isHit = isHit;
        this.calTime = calTime;
        this.releaseTime = releaseTime;
    }

    public double getX() {
        return x;
    }

    public void setX(double x) {
        this.x = x;
    }

    public double getY() {
        return y;
    }

    public void setY(double y) {
        this.y = y;
    }

    public double getR() {
        return r;
    }

    public void setR(double r) {
        this.r = r;
    }

    public boolean isHit() {
        return isHit;
    }

    public boolean getIsHit() {
        return isHit;
    }

    public void setHit(boolean hit) {
        isHit = hit;
    }

    public Double getCalTime() {
        return calTime;
    }

    public void setCalTime(Double calTime) {
        this.calTime = calTime;
    }

    public LocalDateTime getReleaseTime() {
        return releaseTime;
    }

    public void setReleaseTime(LocalDateTime releaseTime) {
        this.releaseTime = releaseTime;
    }

    public LocalDateTime getCurTime() {
        return releaseTime;
    }

    public Double getExecTime() {
        return calTime;
    }
}


