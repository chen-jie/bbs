package cn.max.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.max.mapper.CategoryMasterMapper;
import cn.max.vo.CategoryMaster;

@Service
public class CategoryMasterService {

	@Autowired
	private CategoryMasterMapper categoryMasterMapper;

	public int save(CategoryMaster cm) {
		if (cm == null)
			return -1;
		return categoryMasterMapper.insert(cm);
	}

	public List<CategoryMaster> selectAll() {
		return categoryMasterMapper.selectAll();
	}

	public List<CategoryMaster> selectByExample(CategoryMaster cm) {
		if (cm == null)
			return null;
		return categoryMasterMapper.selectByExample(cm);
	}

	public int delete(Integer id) {
		if (id == null)
			return -1;
		return categoryMasterMapper.deleteByPrimaryKey(id);
	}

	public CategoryMasterMapper getCategoryMasterMapper() {
		return categoryMasterMapper;
	}

	public void setCategoryMasterMapper(
			CategoryMasterMapper categoryMasterMapper) {
		this.categoryMasterMapper = categoryMasterMapper;
	}

}
