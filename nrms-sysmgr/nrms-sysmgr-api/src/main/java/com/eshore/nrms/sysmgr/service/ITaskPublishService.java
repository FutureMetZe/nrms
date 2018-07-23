package com.eshore.nrms.sysmgr.service;

import java.util.List;

import com.eshore.khala.common.model.PageConfig;
import com.eshore.khala.core.api.IBaseService;
import com.eshore.nrms.sysmgr.pojo.Task;
import com.eshore.nrms.vo.PageVo;
/***
 * 任务发布的接口
 * @author wh_zhangjx
 *
 */
public interface ITaskPublishService  extends IBaseService<Task> {
  /***
   * 
   * @param task 查询参数 用task封装
   * @param page 分页参数
   * @return 返回 PageVo对象
   */
  PageVo<Task> queryTaskByPage(Task task, PageConfig page);
  /***
   * 
   * @param taskId  任务id
   * @return 返回申请该任务的申请人id
   */
  List<Integer> queryApplyIdsByTaskId(String taskId);
  
  /**
   * 
   * @Description: 判断当前任务是否已被当前用户申请  
   * @param  taskId	任务id
   * @param  applyerId 当前用户id
   * @return int    返回类型  
   *
   */
  Integer AppliedWhetherOrNot(String taskId, Integer applyerId);
}
