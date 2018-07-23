package com.eshore.nrms.sysmgr.dao;

import java.util.ArrayList;
import java.util.List;

import com.eshore.khala.core.data.api.dao.IBaseDao;
import com.eshore.nrms.sysmgr.pojo.UserInfo;
import com.eshore.nrms.sysmgr.pojo.Users;

public interface UsersDao extends IBaseDao<Users> {
    public Users queryUserByLoginName(String loginName);

	public List<Users> queryAllUsers();


    /**
     * 通过姓名查询用户
     * @param nameStr 姓名
     * @return 用户
     */
    Users getUserByName(String nameStr);

    /**
     * 通过id列表查询到对应的用户列表
     * @param ids id列表
     * @return  用户列表
     */
    List<Users> getUsersByIds(ArrayList<Integer> ids);
}
