package com.eshore.nrms.sysmgr.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import java.io.Serializable;

/**
 * 开发人员—评价 表
 */
@Entity
@Table(name = "developer_appraise")
public class DeveloperAppraise implements Serializable {
    private String id;

    private String appraiseContent;

    private String applyId;
    
    private String taskName;
    
    private Integer developerId;

    private String developerName;

    private Double score;

    private Integer appraiserId;

    private String appraiserName;
    
    private String appraiseDate;

    @Id
    @Column(name = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

	@Column(name = "appraise_content")
    public String getAppraiseContent() {
        return appraiseContent;
    }

    public void setAppraiseContent(String appraiseContent) {
        this.appraiseContent = appraiseContent == null ? null : appraiseContent.trim();
    }

    @Column(name = "apply_id")
    public String getApplyId() {
        return applyId;
    }

    public void setApplyId(String applyId) {
        this.applyId = applyId == null ? null : applyId.trim();
    }

    @Column(name = "task_name")
    public String getTaskName() {
		return taskName;
	}

	public void setTaskName(String taskName) {
		this.taskName = taskName == null ? null : taskName.trim();
	}
	
	@Column(name = "developer_id")
	public Integer getDeveloperId() {
		return developerId;
	}

	public void setDeveloperId(Integer developerId) {
		this.developerId = developerId;
	}

	@Column(name = "developer_name")
    public String getDeveloperName() {
        return developerName;
    }

    public void setDeveloperName(String developerName) {
        this.developerName = developerName == null ? null : developerName.trim();
    }
    @Column(name = "score")
    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }


    @Column(name = "appraiser_id")
    public Integer getAppraiserId() {
        return appraiserId;
    }

    public void setAppraiserId(Integer appraiserId) {
        this.appraiserId = appraiserId;
    }



    @Column(name = "appraiser_name")
    public String getAppraiserName() {
        return appraiserName;
    }

    public void setAppraiserName(String appraiserName) {
        this.appraiserName = appraiserName == null ? null : appraiserName.trim();
    }
    
    @Column(name = "appraise_date")
    public String getAppraiseDate() {
		return appraiseDate;
	}

	public void setAppraiseDate(String appraiseDate) {
		this.appraiseDate = appraiseDate;
	}

	@Override
    public String toString() {
        return "DeveloperAppraise{"
                + "id='" + id + '\''
                + ", appraiseContent='" + appraiseContent + '\''
                + ", applyId='" + applyId + '\''
                + ", taskName='" + taskName + '\''
                + ", developerId='" + developerId + '\''
                + ", developerName='" + developerName + '\''
                + ", score=" + score
                + ", appraiserId='" + appraiserId + '\''
                + ", appraiserName='" + appraiserName + '\''
                + ", appraiserDate='" + appraiseDate + '\''
                + '}';
    }
}
