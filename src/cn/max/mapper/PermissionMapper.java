package cn.max.mapper;

import java.util.List;

import cn.max.vo.Permission;
import cn.max.vo.Role;

public interface PermissionMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Permission record);

    int insertSelective(Permission record);

    Permission selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Permission record);

    int updateByPrimaryKey(Permission record);

	List<Permission> selectPermissions(List<Role> roles);
}