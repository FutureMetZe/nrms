package com.eshore.nrms.sysmgr.service.impl;

import com.eshore.khala.common.model.PageConfig;
import com.eshore.khala.core.data.api.dao.IBaseDao;
import com.eshore.khala.core.service.impl.BaseServiceImpl;
import com.eshore.nrms.sysmgr.dao.IApplyDao;
import com.eshore.nrms.sysmgr.dao.IDeveloperAppraiseDao;
import com.eshore.nrms.sysmgr.dao.TaskDao;
import com.eshore.nrms.sysmgr.dao.UsersDao;
import com.eshore.nrms.sysmgr.pojo.Apply;
import com.eshore.nrms.sysmgr.pojo.DeveloperAppraise;
import com.eshore.nrms.sysmgr.pojo.Task;
import com.eshore.nrms.sysmgr.pojo.Users;
import com.eshore.nrms.sysmgr.service.IReleaseService;
import com.eshore.nrms.util.DateUtils;
import com.eshore.nrms.util.PageUtil;
import com.eshore.nrms.vo.ExecResult;
import com.eshore.nrms.vo.PageVo;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;


/**
 * 我发布的模块
 */
@Service
@Transactional(propagation = Propagation.REQUIRED)
public class IReleaseServiceImpl extends BaseServiceImpl implements IReleaseService {

    private Logger logger = Logger.getLogger(IReleaseServiceImpl.class);

    @Autowired
    private TaskDao taskDao;

    @Autowired
    private IApplyDao applyDao;

    @Autowired
    private UsersDao usersDao;

    @Autowired
    private IDeveloperAppraiseDao developerAppraiseDao;


    @Override
    public IBaseDao getDao() {
        return taskDao;
    }

    @Override
    public PageVo<Task> queryPageBean(Integer userId, String taskName, Integer taskStatus, PageConfig page) {
        List<Task> tasks = taskDao.queryPageBean(userId, taskName, taskStatus, page);

        return PageUtil.getPageList(page, tasks);
    }

    @Override
    public Task getTaskById(String taskId) {
        return this.taskDao.get(taskId);
    }

    @Override
    public ExecResult updateTaskStatus(String taskId, Integer status) {
        ExecResult result = new ExecResult();
        try {
            Task task = this.taskDao.get(taskId);
            task.setTaskStatus(status);
            task.setOverTime(DateUtils.getDate());
            this.taskDao.update(task);
            applyDao.updateTaskStatusInApply(taskId, status);
            result.setMsg("操作成功！");
            result.setSuccess(true);
        } catch (Exception e) {
            logger.info("操作失败！接口名称：updateTaskStatus，传入参数:taskId=" + taskId + "、status=" + status);
            result.setSuccess(false);
            result.setMsg("操作失败");
            return result;
        }
        return result;
    }

    @Override
    public List<Apply> getTeams(String taskId) {
        return applyDao.queryApplyListByTaskId(taskId);
    }

    @Override
    public ExecResult agreeApply(String applyId, int i) {
        ExecResult result = new ExecResult();
        try {
            applyDao.updateApplyStatusById(applyId, i);
            result.setSuccess(true);
            result.setMsg("已同意申请");
        } catch (Exception e) {
            logger.info("操作失败！接口名称：agreeApply");
            result.setSuccess(false);
            result.setMsg("请求失败！");
            return result;
        }

        return result;
    }

    @Override
    public Apply getApplyById(String applyId) {
        return applyDao.get(applyId);
    }

    @Override
    public ExecResult updateApply(Apply apply) {
        ExecResult result = new ExecResult();
        try {
            applyDao.update(apply);
            result.setMsg("删除成功！");
            result.setSuccess(true);
        } catch (Exception e) {
            result.setMsg("修改失败！");
            result.setSuccess(false);
        }
        return result;
    }

    @Override
    public String getUsersByName(String name) {
        String returnStr = "";
        String[] names = name.split(" ");
        ArrayList<Users> list = new ArrayList<Users>();
        for (String nameStr : names) {
            Users user = usersDao.getUserByName(nameStr);
            returnStr = returnStr + user.getId() + ",";
        }
        return returnStr.substring(0, returnStr.length() - 1);
    }

    @Override
    public ExecResult submitPerson(Apply apply, Users user, String[] ids) {
        ExecResult result = new ExecResult();
        Integer count = developerAppraiseDao.queryCountByApplyId(apply.getApplyId());
        if (count > 0) {
            result.setSuccess(false);
            result.setMsg("该申请已交付，请勿再次操作！");
            return result;
        }
        try {
            apply.setIsAppoint(1);
            applyDao.update(apply);
            for (String id : ids) {
                Users users = usersDao.get(Integer.valueOf(id));
                DeveloperAppraise da = new DeveloperAppraise();
                da.setApplyId(apply.getApplyId());
                da.setAppraiserId(user.getId());
                da.setAppraiserName(user.getFirstname());
                da.setTaskName(apply.getTaskName());
                da.setDeveloperName(users.getFirstname());
                da.setDeveloperId(users.getId());
                developerAppraiseDao.save(da);
            }
            result.setMsg("操作成功!");
            result.setSuccess(true);
        } catch (Exception e) {
            e.printStackTrace();
            logger.info("submitPerson接口异常！！");
            result.setMsg("操作失败!");
            result.setSuccess(false);
        }
        return result;
    }

    @Override
    public Integer getAppraiseNum(String applyId) {
        return developerAppraiseDao.queryCountByApplyId(applyId);
    }


}
