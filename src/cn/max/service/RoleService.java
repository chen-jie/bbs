package cn.max.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.max.mapper.RoleMapper;
import cn.max.vo.Role;

@Service
public class RoleService {

	@Autowired
	private RoleMapper roleMapper;

	public RoleMapper getRoleMapper() {
		return roleMapper;
	}

	public void setRoleMapper(RoleMapper roleMapper) {
		this.roleMapper = roleMapper;
	}

	public List<Role> selectRolesByUserId(Integer id) {
		if (id == null)
			return null;
		
		return roleMapper.selectRolesByUserId(id);
	}

}
