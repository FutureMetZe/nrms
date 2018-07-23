package com.eshore.nrms.controller;

import com.eshore.khala.common.model.PageConfig;
import com.eshore.nrms.sysmgr.pojo.Apply;
import com.eshore.nrms.sysmgr.pojo.DeveloperAppraise;
import com.eshore.nrms.sysmgr.pojo.Task;
import com.eshore.nrms.sysmgr.pojo.Users;
import com.eshore.nrms.sysmgr.service.IApplyService;
import com.eshore.nrms.sysmgr.service.IDeveloperAppraiseService;
import com.eshore.nrms.sysmgr.service.IReleaseService;
import com.eshore.nrms.sysmgr.service.UsersService;
import com.eshore.nrms.vo.Conts;
import com.eshore.nrms.vo.ExecResult;
import com.eshore.nrms.vo.PageVo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * 我发布的
 */
@Controller
@RequestMapping("/release")
public class IReleaseController {

    @Autowired
    private IReleaseService iReleaseService;

    @Autowired
    private IApplyService applyService;

    @Autowired
    private IDeveloperAppraiseService iDeveloperAppraiseService;

    @Autowired
    private UsersService usersService;


    /**
     *
     * @param session    获取session
     * @param taskName  任务名
     * @param taskStatus    任务状态
     * @param page  分页信息
     * @return model视图
     */
    @RequestMapping("/myList")
    public ModelAndView iReleaseList(HttpSession session, String taskName,
                                     Integer taskStatus, PageConfig page) {
        Users user = (Users) session.getAttribute(Conts.USER_SESSION_KEY);
        ModelAndView view = new ModelAndView("release/releaseList");
        PageVo<Task> pageVo = this.iReleaseService.queryPageBean(user.getId(), taskName, taskStatus, page);
        view.addObject("page", pageVo);
        view.addObject("beans", pageVo.getDataList());
        view.addObject("taskName", taskName);
        view.addObject("taskStatus", taskStatus);
        return view;
    }


    /**
     * 查看任务详情
     * @param taskId     任务ID
     * @return ExecResult对象
     */
    @RequestMapping("/getTask")
    @ResponseBody
    public ExecResult getTask(String taskId) {
        ExecResult result = new ExecResult();
        Task task = iReleaseService.getTaskById(taskId);

        if (task == null) {
            result.setMsg("查询任务详情失败，请重试！");
            result.setSuccess(false);
            return result;
        } else {
            result.setMsg("查询成功");
            result.setSuccess(true);
            result.setBean(task);
            return result;
        }
    }


    /**
     * 修改任务状态
     * @param taskId    任务ID
     * @param status    任务状态
     * @return  ExecResult对象
     */
    @RequestMapping("/updateTaskStatus")
    @ResponseBody
    public ExecResult updateTaskStatus(String taskId, Integer status) {
        ExecResult result = iReleaseService.updateTaskStatus(taskId, status);
        return result;
    }


    /**
     * 修改申请状态，同意申请(将申请状态设置为 1 )
     * @param applyId   申请ID
     * @return  ExecResult对象
     */
    @RequestMapping("/agreeApply")
    @ResponseBody
    public ExecResult agreeApply(String applyId) {
        return iReleaseService.agreeApply(applyId, 1);
    }


    /**
     * 返回申请该任务的申请列表
     * @param taskId    任务ID
     * @return  ExecResult对象
     */
    @RequestMapping("/getApplyTeam")
    @ResponseBody
    public ExecResult getApplyTeam(String taskId) {
        Apply apply = new Apply();
        apply.setTaskId(taskId);
        ExecResult result = new ExecResult();
        List<Apply> list = iReleaseService.getTeams(taskId);
        result.setMsg("查询成功");
        result.setSuccess(true);
        result.setDataList(list);
        return result;

    }


    /**
     * 跳转到某任务查看申请列表页面
     * @param taskId    任务ID
     * @param pageConfig    分页对象
     * @return model视图
     */
    @RequestMapping("/choiceTeam")
    public ModelAndView choiceTeam(String taskId, PageConfig pageConfig) {
        ModelAndView view = new ModelAndView("release/choiceTeam");
        Apply apply = new Apply();
        apply.setApplyStatus(0);
        apply.setTaskId(taskId);
        PageVo<Apply> page = applyService.getApplyPageVO(apply, pageConfig);
        view.addObject("page", page);
        view.addObject("beans", page.getDataList());
        return view;
    }


    /**
     * 跳转到查看团队页面
     * @param taskId    任务ID
     * @param pageConfig    分页对象
     * @return model视图
     */
    @RequestMapping("/confirmTeam")
    public ModelAndView confirmTeam(String taskId, PageConfig pageConfig) {
        ModelAndView view = new ModelAndView("release/confirmTeam");
        Apply apply = new Apply();
        apply.setApplyStatus(1);
        apply.setTaskId(taskId);
        PageVo<Apply> page = applyService.getApplyPageVO(apply, pageConfig);
        List<Users> users = usersService.getAllUsers();
        view.addObject("page", page);
        view.addObject("beans", page.getDataList());
        view.addObject("users", users);
        return view;
    }


    /**
     * 查看页面中，点击继续添加，查询该申请开发人员名单
     * @param idStr 已选择的开发人员ID列表
     * @param count 申请ID
     * @return  已选择的开发人员标签、所有开发人员列表
     */
    @RequestMapping("/choosePerson")
    @ResponseBody
    public ExecResult choosePerson(String idStr, Integer count) {
        ExecResult result = new ExecResult();
        // 开发人员ID列表不为空
        if (StringUtils.isNotEmpty(idStr)){
            String[] idsStr = idStr.split(",");
            ArrayList<Integer> ids = new ArrayList();
            for (String s :idsStr) {
                ids.add(Integer.parseInt(s));
            }
            //已选择的开发人员
            List<Users> selectedUsers = usersService.getUsersByIds(ids);
            result.setBean(selectedUsers);
        }

        //第一次访问
        if (count == 0) {
            //所有开发人员列表
            List<Users> allUsers = usersService.getAllUsers();
            result.setDataList(allUsers);
        }

        result.setSuccess(true);
        return result;
    }




    /**
     * 将成员增加到开发人员列表
     * @param applyId 申请ID
     * @param name 新加入的成员列表
     * @param session HttpSession
     * @return ExecResult
     */
    @RequestMapping("/addName")
    public @ResponseBody ExecResult addName(String applyId, String name, HttpSession session) {
        Apply apply = iReleaseService.getApplyById(applyId);
        if (name == null || name.equals("")) {
            apply.setDeveloperNameList("");
            apply.setDeveloperIdList("");
        } else {
            String ids = iReleaseService.getUsersByName(name);
            name = name.replaceAll(" ", ",");
            apply.setDeveloperNameList(name);
            apply.setDeveloperIdList(ids);
            applyService.update(apply);
        }
        return submitPerson(applyId, session);
    }

    /**
     * 人员交付
     * @param applyId 申请ID
     * @param session Session
     * @return ExecResult
     */
    @RequestMapping("/submitPerson")
    public @ResponseBody ExecResult submitPerson(String applyId, HttpSession session) {
        Apply apply = iReleaseService.getApplyById(applyId);
        Users user = (Users) session.getAttribute(Conts.USER_SESSION_KEY);
        String[] ids = apply.getDeveloperIdList().split(",");
        return iReleaseService.submitPerson(apply, user, ids);
    }


    /**
     * 取消申请
     * @param applyId 申请ID
     * @return ExecResult
     */
    @RequestMapping("/cancelApply")
    public @ResponseBody ExecResult cancelApply(String applyId) {
        ExecResult result = new ExecResult();
        try {
            Apply apply = iReleaseService.getApplyById(applyId);
            apply.setApplyStatus(0);
            applyService.update(apply);
            result.setSuccess(true);
            result.setMsg("操作成功！");
        } catch (Exception e) {
            e.printStackTrace();
            result.setSuccess(false);
            result.setMsg("操作失败！");
        }
        return result;
    }

    /**
     * 查看团队成员的评价列表
     * @param appraiseIdList 开发人员ID列表
     * @param userName  开发人员姓名
     * @param pageConf  分页属性
     * @return ModelAndView
     */
    @RequestMapping(value = "/appraiseList", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
    public ModelAndView appraiseList(String appraiseIdList, String userName, PageConfig pageConf) {
        ModelAndView view = new ModelAndView("release/appraiseList");
        view.addObject("appraiseIdList", appraiseIdList);
        ArrayList<Integer> ids = new ArrayList<Integer>();
        PageVo<DeveloperAppraise> page = null;

        String[] split = appraiseIdList.split(",");
        for (String str : split) {
            Integer id = Integer.valueOf(str);
            ids.add(id);
        }
        List<Users> users = usersService.getUsersByIds(ids);
        //传入userName
        if (userName != null && !userName.equals("")) {
            page = iDeveloperAppraiseService.queryPageBean(null, userName, pageConf);
            view.addObject("page", page);
            view.addObject("userName", userName);
            view.addObject("users", users);
            view.addObject("beans", page.getDataList());
            return view;
        } else if (appraiseIdList != null && !appraiseIdList.equals("")) {

                ArrayList<DeveloperAppraise> returnList = new ArrayList<DeveloperAppraise>();
                if (ids.size() > 0) {
                    for (Integer userId : ids) {
                        page = iDeveloperAppraiseService.queryPageBean(userId, null, pageConf);
                        returnList.addAll(page.getDataList());
                    }
                }
                page.setDataCount(returnList.size());
                view.addObject("page", page);
                view.addObject("users", users);
                view.addObject("beans", returnList);
                return view;
            }
        return view;
    }



    /**
     * 查看页面中，点击继续添加，查询该申请开发人员名单
     * @param applyId 申请ID
     * @return  已选择的开发人员标签、所有开发人员列表
     @RequestMapping("/choosePerson")
     @ResponseBody
     public ExecResult choosePerson(String applyId) {
     ExecResult result = new ExecResult();
     Integer appraiseNum = iReleaseService.getAppraiseNum(applyId);
     if (appraiseNum > 0) {
     result.setSuccess(false);
     result.setMsg("该申请已交付，请勿再次操作！");
     return result;
     }
     Apply apply = iReleaseService.getApplyById(applyId);
     String idsString = apply.getDeveloperIdList();

     StringBuilder builder = new StringBuilder();
     StringBuilder selectedDevBuilder  = new StringBuilder(); //已选择的开发人员
     List<Users> list = usersService.getAllUsers();
     if (!"".equals(idsString) && idsString != null) {    //有已选择的开发人员
     String[]  ids  = idsString.split(",");
     int[] developerIds = new int[ids.length];
     int i = 0;
     for (String s :ids) {
     developerIds[i] = Integer.parseInt(s);
     i++;
     }
     for (Users u : list) {
     int flag = 0;
     for (int j = 0; j < developerIds.length; j++) {
     if (u.getId() == developerIds[j]) {
     flag = 1;
     builder.append("<li value=\"" + u.getId()
     + "\" onclick=\" changeState(this)\" style=\"background-color: "
     + "rgb(43, 131, 193);\">"
     + u.getFirstname() + "<i  class=\"fa fa-check hide\">2</i></li>");
     selectedDevBuilder.append(" <button onclick = \"deleteDeveloper(" + u.getId()
     + ")\" class=\"btn\" value=\"" + u.getId() + "\">" + u.getFirstname() + " </button>");

     }
     }
     if (flag == 0) {
     builder.append("<li value=\"" + u.getId() + "\" onclick=\" changeState(this)\" >"
     + u.getFirstname() + "<i  class=\"fa fa-check hide\">1</i></li>");
     }
     }
     } else {
     //没有已选择的开发人员
     for (Users u : list) {
     builder.append("<li value=\"" + u.getId() + "\" onclick=\" changeState(this)\" >" + u.getFirstname()
     +  "<i  class=\"fa fa-check hide\">1</i></li>");
     }
     }
     result.setSuccess(true);
     result.setBean(builder.toString() + "==" + selectedDevBuilder.toString());
     return result;
     }
     */

    /**
     * 删除已添加的成员
     * @param name 成员姓名
     * @param applyId 申请ID
     * @return ExecResult

     @RequestMapping("/deleteName")
     @ResponseBody
     public ExecResult deleteName(String name, String applyId) {
     Apply apply = iReleaseService.getApplyById(applyId);
     String names = apply.getDeveloperNameList();
     String returnName = "";
     String[] strings = names.split(",");
     if (strings.length <= 1) {
     returnName = "";
     } else {
     for (String str:strings) {
     if (!str.equals(name)) {
     returnName = returnName + str + ",";
     }
     }
     returnName = returnName.substring(0, returnName.length() - 1);
     }
     apply.setDeveloperNameList(returnName);
     return iReleaseService.updateApply(apply);
     }
     */

}
