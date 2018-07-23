package com.eshore.nrms.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.eshore.khala.common.model.PageConfig;
import com.eshore.nrms.sysmgr.pojo.Apply;
import com.eshore.nrms.sysmgr.pojo.Task;
import com.eshore.nrms.sysmgr.pojo.Users;
import com.eshore.nrms.sysmgr.service.IApplyService;
import com.eshore.nrms.sysmgr.service.ITaskPublishService;
import com.eshore.nrms.util.DateUtils;
import com.eshore.nrms.vo.Conts;
import com.eshore.nrms.vo.ExecResult;
import com.eshore.nrms.vo.PageVo;

/**
 * 
 * @Description: 我的申请模块controller层接口  
 * @author xx
 * @date 2018年5月25日   
 *
 */
@Controller
@RequestMapping("/apply")
public class ApplyController {
	@Autowired
	private IApplyService applyService;
	
	@Autowired
	private ITaskPublishService taskPublishService;
	
	/**
	 * 
	 * @Description: 跳转到我的申请界面  
	 * @param session
	 * @param apply
	 * @param page
	 * @return ModelAndView	
	 *
	 */
	@RequestMapping("/toAppliedListPage")
	public ModelAndView toAppliedListPage(HttpSession session, Apply apply , PageConfig page) {
		Users user = (Users) session.getAttribute(Conts.USER_SESSION_KEY);
		ModelAndView view = new ModelAndView("/apply/appliedListPage");
		apply.setApplyerId(user.getId());
        PageVo<Apply> pageVo = applyService.getApplyPageVO(apply, page);
        view.addObject("page" , pageVo);
        view.addObject("beans" , pageVo.getDataList());
        
        //用于搜索栏回显
        view.addObject("apply", apply);
        return view;
	}
	
	/**
	 * 
	 * @Description: 申请人填写信息后点击确认申请 
	 * @param session
	 * @param apply
	 * @return ExecResult
	 *
	 */
	@RequestMapping("/confirmApplyTask")
	@ResponseBody
	public ExecResult confirmApplyTask(HttpSession session, Apply apply) {
		Users user = (Users) session.getAttribute(Conts.USER_SESSION_KEY);
		ExecResult result = new ExecResult();
		//获取当前申请的任务对象
		Task task = taskPublishService.get(apply.getTaskId());
		
		//领取任务时查询任务状态是否正常
		if(task.getTaskStatus() == 2) {
	        result.setSuccess(false);
	        result.setMsg("任务已关闭");
	        return result;
	    }else if(task.getTaskStatus() == 3) {
	    	result.setSuccess(false);
	        result.setMsg("任务已作废");
	        return result;
	    }
		apply.setApplyDate(DateUtils.getDate());
		apply.setApplyStatus(0);
		apply.setTaskName(task.getTaskName());
		apply.setTaskStatus(task.getTaskStatus());
		apply.setApplyerId(user.getId());
		apply.setApplyerName(user.getFirstname());
		apply.setPublisherId(task.getPublisherId());
		apply.setAppraiseStatus(0);
		
		//将该任务申请团队数加1
		task.setTeamCount(task.getTeamCount() + 1);
		try {
			applyService.confirmApplyTask(apply, task);
		} catch (Exception e) {
			result.setSuccess(false);
			result.setMsg("服务器异常");
	        return result;
		}
		result.setSuccess(true);
		result.setMsg("申请成功");
        return result;
	}
}
