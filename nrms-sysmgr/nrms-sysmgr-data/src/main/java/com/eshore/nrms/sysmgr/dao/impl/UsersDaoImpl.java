package com.eshore.nrms.sysmgr.dao.impl;


import com.eshore.khala.core.data.jpa.dao.impl.JpaDaoImpl;
import com.eshore.nrms.sysmgr.dao.UsersDao;
import com.eshore.nrms.sysmgr.pojo.Users;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

/**
 * 用户持久层实现类
 */
@Repository
public class UsersDaoImpl extends JpaDaoImpl<Users> implements
		UsersDao {


	@Override
	public Users queryUserByLoginName(String loginName) {
		String hql = "from Users u where u.login = ?";

		return this.getPojo(hql, new Object[]{loginName});
	}

	@Override
	public List<Users> queryAllUsers() {
		String hql = "from Users u";
		return this.query(hql, null);
	}

	@Override
	public Users getUserByName(String nameStr) {
		String hql = "from Users u where u.firstname = ? ";
		return this.getPojo(hql, new Object[]{nameStr});
	}

	@Override
	public List<Users> getUsersByIds(ArrayList<Integer> ids) {
		StringBuilder sb = new StringBuilder("from Users where id in ( ");
		Integer[] params = new Integer[ids.size()];
		for (int i = 0; i < ids.size(); i++) {
			params[i] = ids.get(i);
			if (i != (ids.size() - 1)) {
				sb.append("?,");
			} else {
				sb.append("?)");
			}
		}
		return this.query(sb.toString(), params);
	}
}
