package cn.max.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.max.mapper.CategoryMapper;
import cn.max.vo.Category;

@Service
public class CategoryService {

	@Autowired
	private CategoryMapper categoryMapper;
	
	public List<Category> selectAll(){
		return categoryMapper.selectAll();
	}
	public Category checkCategoryname(String name) {
		return categoryMapper.checkCategoryname(name);
	}
	public int deleteById(Integer id){
		if(id == null)
			return -1;
		categoryMapper.deleteMasterByCid(id);
		return categoryMapper.deleteByPrimaryKey(id);
	}
	
	public List<Category> selectAllWithMasters(){
		return categoryMapper.selectAllwithMasters();
	}
	public int save(Category category) {
		if(category!=null)
			return categoryMapper.insert(category);
		return -1;
	}
	
	public int update(Category category){
		if(category == null)
			return -1;
		return categoryMapper.updateByPrimaryKey(category);
	}
	
	public CategoryMapper getCategoryMapper() {
		return categoryMapper;
	}


	public void setCategoryMapper(CategoryMapper categoryMapper) {
		this.categoryMapper = categoryMapper;
	}

	public Category selectById(Integer cid) {
		if(cid==null)
			return null;
		return categoryMapper.selectByPrimaryKey(cid);
	}
	
}
