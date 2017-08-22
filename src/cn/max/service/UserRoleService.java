package cn.max.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.max.mapper.UserRoleMapper;
import cn.max.vo.UserRole;

@Service
public class UserRoleService {

	@Autowired
	private UserRoleMapper userRoleMapper;

	public UserRole selectByUid(Integer uid) {
		if (uid == null) {
			return null;
		}
		return userRoleMapper.selectByUid(uid);
	}
	
	public int update(UserRole us){
		if(us == null)
			return -1;
		return userRoleMapper.updateByPrimaryKey(us);
	}

	public UserRoleMapper getUserRoleMapper() {
		return userRoleMapper;
	}

	public void setUserRoleMapper(UserRoleMapper userRoleMapper) {
		this.userRoleMapper = userRoleMapper;
	}

}
