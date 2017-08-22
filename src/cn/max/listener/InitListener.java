package cn.max.listener;

import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.context.ServletContextAware;

import cn.max.service.CategoryMasterService;
import cn.max.util.Constant;
import cn.max.vo.CategoryMaster;

@Controller
public class InitListener implements InitializingBean, ServletContextAware {

	private ServletContext context;
	@Autowired
	private CategoryMasterService categoryMasterService;

	public InitListener() {
	}

	public void afterPropertiesSet() throws Exception {
		List<CategoryMaster> masters = categoryMasterService.selectAll();
		context.setAttribute(Constant.CATEGORY_MASTERS, masters);
	}
	public void setServletContext(ServletContext context) {
		this.context = context;
	}

	public CategoryMasterService getCategoryMasterService() {
		return categoryMasterService;
	}

	public void setCategoryMasterService(
			CategoryMasterService categoryMasterService) {
		this.categoryMasterService = categoryMasterService;
	}

	

}
