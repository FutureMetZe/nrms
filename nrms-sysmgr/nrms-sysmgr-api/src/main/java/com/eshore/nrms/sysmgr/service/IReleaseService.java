package com.eshore.nrms.sysmgr.service;

import com.eshore.khala.common.model.PageConfig;
import com.eshore.khala.core.api.IBaseService;
import com.eshore.nrms.sysmgr.pojo.Apply;
import com.eshore.nrms.sysmgr.pojo.DeveloperAppraise;
import com.eshore.nrms.sysmgr.pojo.Task;
import com.eshore.nrms.sysmgr.pojo.Users;
import com.eshore.nrms.vo.ExecResult;
import com.eshore.nrms.vo.PageVo;

import java.util.List;

/**
 * 我发布的模块接口
 */
public interface IReleaseService extends IBaseService {

    /**
     * 获取任务分页列表
     * @param userId 登录用户ID
     * @param taskName 任务名
     * @param taskStatus 任务状态
     * @param page 分页对象
     * @return  返回PageVo对象
     */
    PageVo<Task> queryPageBean(Integer userId, String taskName, Integer taskStatus, PageConfig page);

    /**
     * 通过主键查找任务
     * @param taskId 任务ID
     * @return Task
     */
    Task getTaskById(String taskId);

    /**
     * 通过任务ID修改任务状态
     * @param taskId 任务ID
     * @param status 任务状态
     * @return ExecResult对象
     */
    ExecResult updateTaskStatus(String taskId, Integer status);

    /**
     * 通过任务ID获取申请列表
     * @param taskId 任务ID
     * @return 申请list
     */
    List<Apply> getTeams(String taskId);

    /**
     * 通过申请ID修改任务状态
     * @param applyId 申请ID
     * @param i 任务状态
     * @return ExecResult对象
     */
    ExecResult agreeApply(String applyId, int i);


    /**
     * 通过主键ID查询申请信息
     * @param applyId  申请ID
     * @return pojo
     */
    Apply getApplyById(String applyId);

    /**
     * 修改申请信息
     * @param apply pojo
     * @return ExecResult
     */
    ExecResult updateApply(Apply apply);

    /**
     * 根据姓名字符串，查询id字符串
     * @param name 姓名
     * @return id字符串
     */
    String getUsersByName(String name);

    /**
     * 人员交付
     * @param apply 申请
     * @param user  发布人
     * @param ids   开发人员ID数组
     * @return ExecResult
     */
    ExecResult submitPerson(Apply apply, Users user, String[] ids);

    /**
     * 通过申请ID获得已交付人员的数量
     * @param applyId  申请ID
     * @return 数量
     */
    Integer getAppraiseNum(String applyId);
}
