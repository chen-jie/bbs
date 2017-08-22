package cn.max.mapper;

import java.util.List;

import cn.max.vo.CategoryMaster;

public interface CategoryMasterMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CategoryMaster record);

    int insertSelective(CategoryMaster record);

    CategoryMaster selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CategoryMaster record);

    int updateByPrimaryKey(CategoryMaster record);

	List<CategoryMaster> selectAll();
	
	List<CategoryMaster> selectByExample(CategoryMaster categoryMaster);
}