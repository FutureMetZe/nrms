package com.eshore.nrms.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.eshore.khala.common.model.PageConfig;
import com.eshore.nrms.sysmgr.pojo.Apply;
import com.eshore.nrms.sysmgr.pojo.DeveloperAppraise;
import com.eshore.nrms.sysmgr.pojo.Users;
import com.eshore.nrms.sysmgr.service.IApplyService;
import com.eshore.nrms.sysmgr.service.IDeveloperAppraiseService;
import com.eshore.nrms.vo.Conts;
import com.eshore.nrms.vo.ExecResult;
import com.eshore.nrms.vo.PageVo;

/**
 * 我的评价功能模块
 *
 */
@Controller
@RequestMapping(value = "/appraise")
public class AppraiseController {

	@Autowired
	private IDeveloperAppraiseService developerAppraiseService;
	
	@Autowired
	private IApplyService applyService;
	
	/**
	 * 按照当前userId作为publisherId  status查询带分页的申请列表
	 * @param applyParam 包含申请状态
	 * @param session	获取发布人id
	 * @return applyList.jsp
	 */
	@RequestMapping(value = "/applyList")
	public ModelAndView applyList(Apply applyParam, PageConfig pageConfig, HttpSession session) {
		//chengq:默认评价状态为未评价
		if (applyParam.getAppraiseStatus() == null) {
			applyParam.setAppraiseStatus(0);
		}
		ModelAndView view = new ModelAndView("appraise/applyList");
		Users loginUser = (Users) session.getAttribute(Conts.USER_SESSION_KEY);
		
		Apply apply = new Apply();
		//apply.set发布人id
		apply.setPublisherId(loginUser.getId());
		//apply.set评价状态 0 未评价
		apply.setAppraiseStatus(applyParam.getAppraiseStatus());
		
		//apply.set任务状态 正常关闭
		apply.setTaskStatus(2);
		
		PageVo<Apply> pageVo = applyService.getApplyPageVO(apply, pageConfig);
		List<Apply> applyList = (List<Apply>) pageVo.getDataList();
		//添加其他属性
		view.addObject("page", pageVo);
		view.addObject("beans", applyList);
		view.addObject("searchParam", applyParam);
		return view;
	}
	
	/**
	 * 添加评价 评价表添加list.size()条记录，apply表修改评价状态
	 * @param appraiseList 一次提交队伍所有人评价，List方式，需要包含content,score，appraiseId,applyId
	 * @return json消息
	 */
	@RequestMapping(value = "/addAppraise")
	@ResponseBody
	public ExecResult addAppraise(@RequestBody ArrayList<DeveloperAppraise> appraiseList) {
		//后端验证  score不为空 且score大于等于0小于等于10
		for (DeveloperAppraise da : appraiseList) {
			if (da.getScore() == null) {
				ExecResult result = new ExecResult();
				result.setSuccess(false);
				result.setMsg("评分为必填项");
				return result;
			}
			if (da.getScore() > 10
			|| da.getScore() < 0) {
				ExecResult result = new ExecResult();
				result.setSuccess(false);
				result.setMsg("评分应该在给 0 到 10 之间");
				return result;
			}
		}
		
		/**
		 * chengq：此处对appraise表和apply表的修改应该在同一事务内进行，放在service层更好
		 * 注释内容最后两行代码没有作用
		 */
		developerAppraiseService.addTeamAppraise(appraiseList,appraiseList.get(0).getApplyId());
		/*
		developerAppraiseService.save(appraiseList);
		Apply apply = applyService.get(appraiseList.get(0).getApplyId());
		apply.setApplyStatus(1);
		apply.setAppraiseStatus(1);
		applyService.update(apply);
		
		Apply applyParam = new Apply();
		applyParam.setAppraiseStatus(0);
		*/
		
		ExecResult result = new ExecResult();
		result.setSuccess(true);
		result.setMsg("评价成功");
		return result;
	}
	
	@RequestMapping(value="/addAppraisePage")
	public ModelAndView addAppraisePage(Apply apply) {
		ModelAndView view = new ModelAndView("appraise/addAppraise");
		if(apply.getApplyId()==null) {
			return view;
		}
		List<DeveloperAppraise> appraiseList = developerAppraiseService.queryAppraiseByApplyIdAndDevIdList(apply);
		view.addObject("appraiseList", appraiseList);
		return view;
	}
	
	/**
	 * 获取一次任务中一个团队每个开发人员的评价
	 * @param apply 包含applyId,developerIdList
	 * @return json消息
	 */
	@RequestMapping(value = "/getAppraiseList")
	@ResponseBody
	public ModelAndView getAppraise(Apply apply) {
		ModelAndView view = new ModelAndView("appraise/viewAppraise");
		
		//chengq:没有意义的代码
		/*PageConfig pageConfig = new PageConfig();
		pageConfig.setPageNum(1);
		pageConfig.setPageSize(50);*/
		
		/**
		 * chengq:注释部分逻辑放到service
		 * queryAppraiseByApplyIdAndDevIdList(apply)中
		 * 其他地方复用
		 */
		List<DeveloperAppraise> appraiseList = developerAppraiseService.queryAppraiseByApplyIdAndDevIdList(apply);
		/*String[] devIdArray = apply.getDeveloperIdList().split(",");
		List<DeveloperAppraise> appraiseList = new ArrayList<>();
		for (String id : devIdArray) {
			Integer idToInt = Integer.valueOf(id);
			DeveloperAppraise appraise = new DeveloperAppraise();
			appraise.setApplyId(apply.getApplyId());
			appraise.setDeveloperId(idToInt);
			DeveloperAppraise a = developerAppraiseService.queryUniqueAppraise(appraise);
			if (a != null) {
				appraiseList.add(a);
			}
		}*/
		
		view.addObject("appraiseList",appraiseList);
		return view;
	}
	

	
}
