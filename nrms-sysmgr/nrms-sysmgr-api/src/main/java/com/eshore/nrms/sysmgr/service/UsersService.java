package com.eshore.nrms.sysmgr.service;

import java.util.ArrayList;
import java.util.List;

import com.eshore.khala.core.api.IBaseService;
import com.eshore.nrms.sysmgr.pojo.Users;

public interface UsersService extends IBaseService<Users> {

	public Users userLogin(String loginName);

	public List<Users> getAllUsers();

	/**
	 * 通过id列表查询用户列表
	 * @param ids id列表
	 * @return 用户列表
	 */
    List<Users> getUsersByIds(ArrayList<Integer> ids);
}
