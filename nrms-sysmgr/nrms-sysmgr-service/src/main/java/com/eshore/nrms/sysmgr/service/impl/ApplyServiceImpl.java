package com.eshore.nrms.sysmgr.service.impl;

import java.util.Date;
import java.util.List;

import com.eshore.nrms.util.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.eshore.khala.common.model.PageConfig;
import com.eshore.khala.core.data.api.dao.IBaseDao;
import com.eshore.khala.core.service.impl.BaseServiceImpl;
import com.eshore.nrms.sysmgr.dao.IApplyDao;
import com.eshore.nrms.sysmgr.dao.TaskDao;
import com.eshore.nrms.sysmgr.pojo.Apply;
import com.eshore.nrms.sysmgr.pojo.Task;
import com.eshore.nrms.sysmgr.pojo.Users;
import com.eshore.nrms.sysmgr.service.IApplyService;
import com.eshore.nrms.util.PageUtil;
import com.eshore.nrms.vo.PageVo;
/**
 * 
 * @Description: 我的申请模块service层接口实现类 
 * @author xx
 * @date 2018年5月25日   
 *
 */
@Service
@Transactional(propagation = Propagation.REQUIRED)
public class ApplyServiceImpl extends BaseServiceImpl<Apply> implements IApplyService {
	@Autowired
	private IApplyDao applyDao;
	
	@Autowired
	private TaskDao taskDao;
	
	@Override
	public IBaseDao<Apply> getDao() {
		return applyDao;
	}
	
	@Override
    public PageVo<Apply> getApplyPageVO(Apply apply, PageConfig page) {
        List<Apply> appliedList = applyDao.queryApplyPageList(apply, page);
        return PageUtil.getPageList(page, appliedList);
    }

	@Override
	public void confirmApplyTask(Apply apply, Task task) {
		applyDao.save(apply);
		taskDao.update(task);
	}

}
