package com.eshore.nrms.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.eshore.khala.common.model.PageConfig;
import com.eshore.nrms.sysmgr.pojo.Task;
import com.eshore.nrms.sysmgr.pojo.Users;
import com.eshore.nrms.sysmgr.service.IApplyService;
import com.eshore.nrms.sysmgr.service.ITaskPublishService;
import com.eshore.nrms.sysmgr.service.UsersService;
import com.eshore.nrms.vo.Conts;
import com.eshore.nrms.vo.ExecResult;
import com.eshore.nrms.vo.PageVo;

/***
 * 
 * @author wh_zhangjx 任务发布
 *
 */

@Controller
@RequestMapping("/TaskPublishController")

public class TaskPublishController {
  @Autowired
 ITaskPublishService taskPublishService;
  @Autowired
 UsersService usersService;
  @Autowired
 IApplyService applyService;
  
  /***.
   * 
   * @param task 任务
   * @param page page对象
   * @return ModelAndView
   */
  @RequestMapping("/taskList")
 public ModelAndView getTaskList(Task task, PageConfig page) {
    ModelAndView view = new ModelAndView("taskPublish/taskPublish");
    PageVo<Task> pageVo = this.taskPublishService.queryTaskByPage(task, page);
    view.addObject("page", pageVo);
    view.addObject("taskList", pageVo.getDataList());
    view.addObject("searchParam", task);
    return view;
  }
  
  /***.
   * 
   * @param task 任务对象
   * @param request HttpServletRequest对象
   * @return 返回result
   * @throws ParseException 日期格式转换异常
   */
  @RequestMapping("/addTask")
 public @ResponseBody ExecResult addTask(Task task, HttpSession session) 
      throws ParseException {
    Users user = (Users) session.getAttribute(Conts.USER_SESSION_KEY);
    task.setPublisherId(user.getId());
    task.setPublishName(user.getFirstname());
    task.setTaskStatus(1);
    task.setTeamCount(0);
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd ");
    task.setCreatedTime(sdf.format(new Date()));
    taskPublishService.save(task);
    ExecResult result = new ExecResult();
    result.setSuccess(true);
    result.setMsg("任务发布成功");
    return  result;
  }

  /***.
   * 
   * @param taskId 任务id
   * @return 返回result对象
   */
  @RequestMapping("/taskDetail")
 public @ResponseBody ExecResult taskDetail(String taskId) {
    ExecResult result = new ExecResult();
    if (taskId == null || "".equals(taskId)) {
      result.setSuccess(false);
      result.setMsg("服务器错误");
      return result;
    } else {
      Task task = taskPublishService.get(taskId);
      result.setBean(task);
      result.setSuccess(true);
      return result;
    }
  }
  
  /***.
   * 
   * @param idsString 选择开发人员后 想追加开发人员 已选择的开发人员id
   * @return 返回开发人员的列表HTML
   */
  @RequestMapping("/getUserList")
  public ModelAndView getUserList(String idsString) {
    ModelAndView view = new ModelAndView("common/common-developerChoose");
    StringBuilder builder = new StringBuilder();
    StringBuilder selectedDevBuilder  = new StringBuilder(); //已选择的开发人员
    List<Users> list = usersService.getAllUsers();
    if (!"".equals(idsString) && idsString != null) {    //有已选择的开发人员
      String[]  ids  = idsString.split(","); 
      Map<Integer , Integer> map = new HashedMap();
      for (String s :ids) {
        int id =Integer.parseInt(s);
        map.put(id, id);
      }
      for (Users u : list) {
        if(map.containsKey(u.getId())) {
            u.setIsSelected(true);
        }
      }
    }
    view.addObject("userList", list);
     return view;
   
  }
  
  /**
   * 
   * @Description: 判断该任务是否已经被当前用户领取  
   * @param taskId	任务id
   * @param applyerId 当前用户id
   * @return ExecResult    
   *
   */
  @RequestMapping("/AppliedWhetherOrNot")
  @ResponseBody
  public ExecResult AppliedWhetherOrNot(String taskId, Integer applyerId) {
	  ExecResult result = new ExecResult();
	  int count = taskPublishService.AppliedWhetherOrNot(taskId, applyerId);
	  if(count > 0){
		  result.setMsg("您已经领取过该任务");
		  result.setSuccess(false);
	  }else {
		  result.setSuccess(true);
	  }
	  return result; 
  }
  
  
  /***.
   * 
   * @param taskId  任务id
   * @param publisherId 发布人id
   * @param session  HttpSession
   * @return 用户是否能领取改任务
   */
  
  /*
   * 已弃用（不能领取自己发布的任务：通过前台比较当前用户id和任务发布人id实现； 是否已经领取了该任务：通过任务id和申请人id查是否有申请记录得知）
  @RequestMapping("/queryRecieveTaskCondition")
   public @ResponseBody ExecResult queryRecieveTaskCondition(String taskId,
    Integer publisherId, HttpSession session) {
    Users user = (Users) session.getAttribute(Conts.USER_SESSION_KEY);
    Integer userId = user.getId();
    ExecResult result = new ExecResult();
    if (userId.equals(publisherId)) {
      result.setSuccess(false);
      result.setMsg("不能领取自己发布的任务！");
      return result;
    } else {
      List<Integer> applyerIds =  taskPublishService.queryApplyIdsByTaskId(taskId);
      if (applyerIds == null || applyerIds.size() == 0) {    //没有任何人申请
        result.setSuccess(true);
        return result;
      } else {
        for (Integer i : applyerIds) {
          if (i.equals(userId)) {
            result.setSuccess(false);
            result.setMsg("您已经领取了该任务！");
            return result;
          }
        }
        result.setSuccess(true); //有人申请 但自己没申请
        return result;
      }
    }
  }*/
  
}
