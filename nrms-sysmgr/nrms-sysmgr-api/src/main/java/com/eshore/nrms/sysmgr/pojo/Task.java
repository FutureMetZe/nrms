package com.eshore.nrms.sysmgr.pojo;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.format.annotation.NumberFormat;

/**
 * 任务表
 */
@Entity
@Table(name = "task")
public class Task implements Serializable {
    private String taskId;
    
    private String createdTime;

    private String startTime;

    private String  overTime;
    
    private Integer peopleNum;

    private Integer taskStatus; //开启1 关闭2 作废3

    private String abilityRequired;

    private String taskName;

    private Integer teamCount;

    private String publishName;

    private Integer publisherId;

    private String taskDesc;

    @Id
    @Column(name="task_id")
    public String getTaskId() {
        return taskId;
    }

    public void setTaskId(String taskId) {
        this.taskId = taskId == null ? null : taskId.trim();
    }
    @Column(name="created_time")
    public String getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(String createdTime) {
        this.createdTime = createdTime;
    }
    @Column(name="start_time")
    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }
    @Column(name="over_time")
    public String getOverTime() {
        return overTime;
    }

    public void setOverTime(String overTime) {
        this.overTime = overTime;
    }
    @Column(name="people_num")
    public Integer getPeopleNum() {
        return peopleNum;
    }

    public void setPeopleNum(Integer peopleNum) {
        this.peopleNum = peopleNum;
    }

    @Column(name="task_status")
    public Integer getTaskStatus() {
        return taskStatus;
    }

    public void setTaskStatus(Integer taskStatus) {
        this.taskStatus = taskStatus;
    }



    @Column(name="ability_required")
    public String getAbilityRequired() {
        return abilityRequired;
    }

    public void setAbilityRequired(String abilityRequired) {
        this.abilityRequired = abilityRequired == null ? null : abilityRequired.trim();
    }
    @Column(name="task_name")
    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName == null ? null : taskName.trim();
    }
    @Column(name="team_count")
    public Integer getTeamCount() {
        return teamCount;
    }

    public void setTeamCount(Integer teamCount) {
        this.teamCount = teamCount;
    }
    @Column(name="publish_name")
    public String getPublishName() {
        return publishName;
    }

    public void setPublishName(String publishName) {
        this.publishName = publishName == null ? null : publishName.trim();
    }

    @Column(name="publisher_id")
    public Integer getPublisherId() {
        return publisherId;
    }
    public void setPublisherId(Integer publisherId) {
        this.publisherId = publisherId;
    }



    @Column(name="task_desc")
    public String getTaskDesc() {
        return taskDesc;
    }

    public void setTaskDesc(String taskDesc) {
        this.taskDesc = taskDesc == null ? null : taskDesc.trim();
    }

    @Override
    public String toString() {
        return "Task{" +
                "taskId='" + taskId + '\'' +
                ", createdTime=" + createdTime +
                ", startTime=" + startTime +
                ", overTime=" + overTime +
                ", peopleNum=" + peopleNum +
                ", taskStatus=" + taskStatus +
                ", abilityRequired='" + abilityRequired + '\'' +
                ", taskName='" + taskName + '\'' +
                ", teamCount=" + teamCount +
                ", publishName='" + publishName + '\'' +
                ", publisherId='" + publisherId + '\'' +
                ", taskDesc='" + taskDesc + '\'' +
                '}';
    }
}