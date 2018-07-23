package com.eshore.nrms.sysmgr.service.impl;

import com.eshore.khala.core.data.api.dao.IBaseDao;
import com.eshore.khala.core.service.impl.BaseServiceImpl;
import com.eshore.nrms.sysmgr.dao.UsersDao;
import com.eshore.nrms.sysmgr.pojo.Users;
import com.eshore.nrms.sysmgr.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 用户业务层实现类
 */
@Service
@Transactional(propagation = Propagation.REQUIRED)
public class UsersServiceImpl extends BaseServiceImpl<Users> implements
		UsersService {

	@Autowired
	private UsersDao usersDao;
	@Override
	public IBaseDao<Users> getDao() {
		return usersDao;
	}
	
	
	@Override
	@Transactional(readOnly = true)
	public Users userLogin(String loginName) {
		Users userInfo = this.usersDao.queryUserByLoginName(loginName);
		return userInfo;
	}


	@Override
	public List<Users> getAllUsers() {
		return this.usersDao.queryAllUsers();
	}

/*    @Override
    public List<Users> getUsersByIds(ArrayList<Integer> ids) {
		ArrayList<Users> users = new ArrayList<Users>();
		for (Integer id : ids) {
			Users user = usersDao.get(id);
			users.add(user);
		}
        return users;
    }*/

	@Override
	public List<Users> getUsersByIds(ArrayList<Integer> ids) {
		return usersDao.getUsersByIds(ids);
	}


}
