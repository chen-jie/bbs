package cn.max.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.max.mapper.PermissionMapper;
import cn.max.vo.Permission;
import cn.max.vo.Role;

@Service
public class PermissionService {


	@Autowired
	private PermissionMapper permissionMapper;
	public List<Permission> selectPermissionByRoles(List<Role> roles) {
		if (roles == null || roles.size() <= 0)
			return null;
		return permissionMapper.selectPermissions(roles);
	}
	public PermissionMapper getPermissionMapper() {
		return permissionMapper;
	}
	public void setPermissionMapper(PermissionMapper permissionMapper) {
		this.permissionMapper = permissionMapper;
	}

}
