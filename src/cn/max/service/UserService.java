package cn.max.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.max.mapper.UserMapper;
import cn.max.mapper.UserRoleMapper;
import cn.max.util.StringUtil;
import cn.max.vo.Role;
import cn.max.vo.User;
import cn.max.vo.UserRole;

@Service
public class UserService {

	@Autowired
	private UserMapper userMapper;

	@Autowired
	private UserRoleMapper userRoleMapper;
	public User checkUsername(String username) {
		return userMapper.selectByUsername(username);
	}

	public int save(User user) {
		userMapper.insertSelective(user);
		UserRole userRole = new UserRole();
		userRole.setRoleId(Role.USER);		//默认普通用户是3
		userRole.setUserId(user.getId());
		return userRoleMapper.insert(userRole);
	}

	public UserMapper getUserMapper() {
		return userMapper;
	}

	public void setUserMapper(UserMapper userMapper) {
		this.userMapper = userMapper;
	}

	public User login(String username, String password) {
		if(StringUtil.isNullOrEmpty(username)||StringUtil.isNullOrEmpty(password))
			return null;
		User user = userMapper.selectByUsername(username);
		if(user!=null&&user.getPassword().equals(password))
			return user;
		return null;
	}
	public User selectById(Integer id) {
		if(id == null)
			return null;
		return userMapper.selectByPrimaryKey(id);
	}
	public int deleteById(Integer id) {
		userRoleMapper.deleteByUserId(id);
		return userMapper.deleteByPrimaryKey(id);
	}
	public List<User> selectAll() {
		return userMapper.selectAll();
	}


	public void update(User user) {
		userMapper.updateByPrimaryKey(user);
	}

	public UserRoleMapper getUserRoleMapper() {
		return userRoleMapper;
	}

	public void setUserRoleMapper(UserRoleMapper userRoleMapper) {
		this.userRoleMapper = userRoleMapper;
	}

}
