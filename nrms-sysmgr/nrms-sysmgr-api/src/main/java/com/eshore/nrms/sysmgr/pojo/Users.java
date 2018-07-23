package com.eshore.nrms.sysmgr.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

/**
 * 用户表
 */
@Entity
@Table(name = "users")
public class Users implements Serializable {
    private Integer id;
    private String login;
    private String hashedPassword;
    private String firstname;   //姓名用这个字段
    private String lastname;
    private String pinyin;
    private String mail;
    private Boolean admin;
    private Integer status;
    private Date lastLoginOn;
    private String language;
    private Integer authSourceId;
    private Date createdOn;
    private Date updatedOn;
    private String type;
    private String identityUrl;
    private String mailNotification;
    private String salt;
    private Boolean mustChangePasswd;
    private Date passwdChangedOn;
    private String svnPwd;
    private Integer headPicId;
    private String requirementFlag;
    private Long abilityLevelId;
    private String rankTime;
    private Long userTypeId;
    private String weightCoe;
    private String areaCode;
    private String bussCode;
    private String entryTime;
    private String trainingRole;
    private String role;
    private String ciRole;
    private String svnUserStatus;
    private Date createedOn;
    private Boolean  isSelected;

    @Id
    @Column(name="id")
    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }

    @Column(name="login")
    public String getLogin() {
        return login;
    }
    public void setLogin(String login) {
        this.login = login == null ? null : login.trim();
    }

    @Column(name="hashed_password")
    public String getHashedPassword() {
        return hashedPassword;
    }
    public void setHashedPassword(String hashedPassword) {
        this.hashedPassword = hashedPassword == null ? null : hashedPassword.trim();
    }

    @Column(name="firstname")
    public String getFirstname() {
        return firstname;
    }
    public void setFirstname(String firstname) {
        this.firstname = firstname == null ? null : firstname.trim();
    }

    @Column(name="lastname")
    public String getLastname() {
        return lastname;
    }
    public void setLastname(String lastname) {
        this.lastname = lastname == null ? null : lastname.trim();
    }

    @Column(name="pinyin")
    public String getPinyin() {
        return pinyin;
    }
    public void setPinyin(String pinyin) {
        this.pinyin = pinyin == null ? null : pinyin.trim();
    }

    @Column(name="mail")
    public String getMail() {
        return mail;
    }
    public void setMail(String mail) {
        this.mail = mail == null ? null : mail.trim();
    }

    @Column(name="admin")
    public Boolean getAdmin() {
        return admin;
    }
    public void setAdmin(Boolean admin) {
        this.admin = admin;
    }

    @Column(name="status")
    public Integer getStatus() {
        return status;
    }
    public void setStatus(Integer status) {
        this.status = status;
    }

    @Column(name="last_login_on")
    public Date getLastLoginOn() {
        return lastLoginOn;
    }
    public void setLastLoginOn(Date lastLoginOn) {
        this.lastLoginOn = lastLoginOn;
    }

    @Column(name="language")
    public String getLanguage() {
        return language;
    }
    public void setLanguage(String language) {
        this.language = language == null ? null : language.trim();
    }

    @Column(name="auth_source_id")
    public Integer getAuthSourceId() {
        return authSourceId;
    }
    public void setAuthSourceId(Integer authSourceId) {
        this.authSourceId = authSourceId;
    }

    @Column(name="created_on")
    public Date getCreatedOn() {
        return createdOn;
    }
    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    @Column(name="updated_on")
    public Date getUpdatedOn() {
        return updatedOn;
    }
    public void setUpdatedOn(Date updatedOn) {
        this.updatedOn = updatedOn;
    }

    @Column(name="type")
    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    @Column(name="identity_url")
    public String getIdentityUrl() {
        return identityUrl;
    }
    public void setIdentityUrl(String identityUrl) {
        this.identityUrl = identityUrl == null ? null : identityUrl.trim();
    }

    @Column(name="mail_notification")
    public String getMailNotification() {
        return mailNotification;
    }
    public void setMailNotification(String mailNotification) {
        this.mailNotification = mailNotification == null ? null : mailNotification.trim();
    }

    @Column(name="salt")
    public String getSalt() {
        return salt;
    }
    public void setSalt(String salt) {
        this.salt = salt == null ? null : salt.trim();
    }

    @Column(name="must_change_passwd")
    public Boolean getMustChangePasswd() {
        return mustChangePasswd;
    }
    public void setMustChangePasswd(Boolean mustChangePasswd) {
        this.mustChangePasswd = mustChangePasswd;
    }

    @Column(name="passwd_changed_on")
    public Date getPasswdChangedOn() {
        return passwdChangedOn;
    }
    public void setPasswdChangedOn(Date passwdChangedOn) {
        this.passwdChangedOn = passwdChangedOn;
    }

    @Column(name="svn_pwd")
    public String getSvnPwd() {
        return svnPwd;
    }
    public void setSvnPwd(String svnPwd) {
        this.svnPwd = svnPwd == null ? null : svnPwd.trim();
    }

    @Column(name="head_pic_id")
    public Integer getHeadPicId() {
        return headPicId;
    }
    public void setHeadPicId(Integer headPicId) {
        this.headPicId = headPicId;
    }

    @Column(name="requirement_flag")
    public String getRequirementFlag() {
        return requirementFlag;
    }
    public void setRequirementFlag(String requirementFlag) {
        this.requirementFlag = requirementFlag == null ? null : requirementFlag.trim();
    }

    @Column(name="ability_level_id")
    public Long getAbilityLevelId() {
        return abilityLevelId;
    }
    public void setAbilityLevelId(Long abilityLevelId) {
        this.abilityLevelId = abilityLevelId;
    }

    @Column(name="rank_time")
    public String getRankTime() {
        return rankTime;
    }
    public void setRankTime(String rankTime) {
        this.rankTime = rankTime == null ? null : rankTime.trim();
    }

    @Column(name="user_type_id")
    public Long getUserTypeId() {
        return userTypeId;
    }
    public void setUserTypeId(Long userTypeId) {
        this.userTypeId = userTypeId;
    }

    @Column(name="weight_coe")
    public String getWeightCoe() {
        return weightCoe;
    }
    public void setWeightCoe(String weightCoe) {
        this.weightCoe = weightCoe == null ? null : weightCoe.trim();
    }

    @Column(name="area_code")
    public String getAreaCode() {
        return areaCode;
    }
    public void setAreaCode(String areaCode) {
        this.areaCode = areaCode == null ? null : areaCode.trim();
    }

    @Column(name="buss_code")
    public String getBussCode() {
        return bussCode;
    }
    public void setBussCode(String bussCode) {
        this.bussCode = bussCode == null ? null : bussCode.trim();
    }

    @Column(name="entry_time")
    public String getEntryTime() {
        return entryTime;
    }
    public void setEntryTime(String entryTime) {
        this.entryTime = entryTime == null ? null : entryTime.trim();
    }

    @Column(name="training_role")
    public String getTrainingRole() {
        return trainingRole;
    }
    public void setTrainingRole(String trainingRole) {
        this.trainingRole = trainingRole == null ? null : trainingRole.trim();
    }

    @Column(name="role")
    public String getRole() {
        return role;
    }
    public void setRole(String role) {
        this.role = role == null ? null : role.trim();
    }

    @Column(name="ci_role")
    public String getCiRole() {
        return ciRole;
    }
    public void setCiRole(String ciRole) {
        this.ciRole = ciRole == null ? null : ciRole.trim();
    }

    @Column(name="svn_user_status")
    public String getSvnUserStatus() {
        return svnUserStatus;
    }
    public void setSvnUserStatus(String svnUserStatus) {
        this.svnUserStatus = svnUserStatus == null ? null : svnUserStatus.trim();
    }

    @Column(name="createed_on")
    public Date getCreateedOn() {
        return createedOn;
    }
    public void setCreateedOn(Date createedOn) {
        this.createedOn = createedOn;
    }

    @Override
    public String toString() {
        return "Users{" +
                "id=" + id +
                ", login='" + login + '\'' +
                ", hashedPassword='" + hashedPassword + '\'' +
                ", firstname='" + firstname + '\'' +
                ", lastname='" + lastname + '\'' +
                ", pinyin='" + pinyin + '\'' +
                ", mail='" + mail + '\'' +
                ", admin=" + admin +
                ", status=" + status +
                ", lastLoginOn=" + lastLoginOn +
                ", language='" + language + '\'' +
                ", authSourceId=" + authSourceId +
                ", createdOn=" + createdOn +
                ", updatedOn=" + updatedOn +
                ", type='" + type + '\'' +
                ", identityUrl='" + identityUrl + '\'' +
                ", mailNotification='" + mailNotification + '\'' +
                ", salt='" + salt + '\'' +
                ", mustChangePasswd=" + mustChangePasswd +
                ", passwdChangedOn=" + passwdChangedOn +
                ", svnPwd='" + svnPwd + '\'' +
                ", headPicId=" + headPicId +
                ", requirementFlag='" + requirementFlag + '\'' +
                ", abilityLevelId=" + abilityLevelId +
                ", rankTime='" + rankTime + '\'' +
                ", userTypeId=" + userTypeId +
                ", weightCoe='" + weightCoe + '\'' +
                ", areaCode='" + areaCode + '\'' +
                ", bussCode='" + bussCode + '\'' +
                ", entryTime='" + entryTime + '\'' +
                ", trainingRole='" + trainingRole + '\'' +
                ", role='" + role + '\'' +
                ", ciRole='" + ciRole + '\'' +
                ", svnUserStatus='" + svnUserStatus + '\'' +
                ", createedOn=" + createedOn +
                '}';
    }
    public Boolean getIsSelected() {
        return isSelected;
    }
    public void setIsSelected(Boolean isSelected) {
        this.isSelected = isSelected;
    }
}