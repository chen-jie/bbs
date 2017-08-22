package cn.max.mapper;

import java.util.List;

import cn.max.vo.Category;

public interface CategoryMapper {
	
    int deleteByPrimaryKey(Integer id);

    int insert(Category record);

    int insertSelective(Category record);

    Category selectByPrimaryKey(Integer id);
    
    List<Category> selectAll();

    int updateByPrimaryKeySelective(Category record);

    int updateByPrimaryKey(Category record);

	Category checkCategoryname(String name);

	void deleteMasterByCid(Integer id);
	
	List<Category> selectAllwithMasters();

}