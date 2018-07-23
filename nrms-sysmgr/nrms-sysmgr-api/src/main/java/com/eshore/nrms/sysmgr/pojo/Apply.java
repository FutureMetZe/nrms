package com.eshore.nrms.sysmgr.pojo;
import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * 申请表
 */
@Entity
@Table(name = "apply")
public class Apply implements Serializable {
    private String applyId;
    private String taskId;
    private String applyDate;
    private Integer applyStatus;
    private String lendStartTime;
    private String lendOverTime;
    private String developerNameList;
    private String developerIdList;
    private Integer applyerId;
    private String applyerName;
    private String taskName;
    private Integer appraiseStatus;
    private Integer taskStatus;
    private Integer publisherId;
    private Integer applyDeveloperNum;
    private Integer isAppoint = 0;  //任务是否交付 0未交付 1已交付

    @Column(name = "is_appoint")
    public Integer getIsAppoint() {
        return isAppoint;
    }

    public void setIsAppoint(Integer isAppoint) {
        this.isAppoint = isAppoint;
    }

    @Column(name="apply_developer_num")
	public Integer getApplyDeveloperNum() {
		return applyDeveloperNum;
	}

	public void setApplyDeveloperNum(Integer applyDeveloperNum) {
		this.applyDeveloperNum = applyDeveloperNum;
	}

	@Column(name="appraise_status")
    public Integer getAppraiseStatus() {
		return appraiseStatus;
	}

	public void setAppraiseStatus(Integer appraiseStatus) {
		this.appraiseStatus = appraiseStatus;
	}

	@Column(name="publisher_id")
	public Integer getPublisherId() {
		return publisherId;
	}

	public void setPublisherId(Integer publisherId) {
		this.publisherId = publisherId;
	}

	@Column(name="task_status")
    public Integer getTaskStatus() {
		return taskStatus;
	}

	public void setTaskStatus(Integer taskStatus) {
		this.taskStatus = taskStatus;
	}

	@Column(name="task_Name")
	public String getTaskName() {
		return taskName;
	}

	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}

	@Id
    @Column(name="apply_id")
    public String getApplyId() {
        return applyId;
    }

    public void setApplyId(String applyId) {
        this.applyId = applyId == null ? null : applyId.trim();
    }

    @Column(name="task_id")
    public String getTaskId() {
        return taskId;
    }

    public void setTaskId(String taskId) {
        this.taskId = taskId == null ? null : taskId.trim();
    }

    @Column(name="apply_date")
    public String getApplyDate() {
        return applyDate;
    }

    public void setApplyDate(String applyDate) {
        this.applyDate = applyDate;
    }

    @Column(name="apply_status")
    public Integer getApplyStatus() {
		return applyStatus;
	}

	public void setApplyStatus(Integer applyStatus) {
		this.applyStatus = applyStatus;
	}

	@Column(name="lend_start_time")
    public String getLendStartTime() {
        return lendStartTime;
    }

    public void setLendStartTime(String lendStartTime) {
        this.lendStartTime = lendStartTime;
    }

    @Column(name="lend_over_time")
    public String getLendOverTime() {
        return lendOverTime;
    }

    public void setLendOverTime(String lendOverTime) {
        this.lendOverTime = lendOverTime;
    }

    @Column(name="developer_name_list")
    public String getDeveloperNameList() {
        return developerNameList;
    }

    public void setDeveloperNameList(String developerNameList) {
        this.developerNameList = developerNameList;
    }

    @Column(name="developer_id_list")
    public String getDeveloperIdList() {
        return developerIdList;
    }

    public void setDeveloperIdList(String developerIdList) {
        this.developerIdList = developerIdList;
    }

    @Column(name="applyer_id")
    public Integer getApplyerId() {
        return applyerId;
    }

    public void setApplyerId(Integer applyerId) {
        this.applyerId = applyerId;
    }


    @Column(name="applyer_name")
    public String getApplyerName() {
        return applyerName;
    }

    public void setApplyerName(String applyerName) {
        this.applyerName = applyerName == null ? null : applyerName.trim();
    }

}
