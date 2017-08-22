package cn.max.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.max.util.Constant;
import cn.max.vo.Category;
import cn.max.vo.CategoryMaster;
import cn.max.vo.Role;
import cn.max.vo.User;
import cn.max.vo.UserRole;

@Controller
@RequestMapping("/admin")
public class AdminController extends BaseController {

	@RequestMapping("user")
	public String user(Model modelMap) {
		List<User> users = userService.selectAll();
		modelMap.addAttribute("users", users);
		return "admin/user";
	}

	@RequestMapping("user/add")
	public String useradd(String username, String password, String email) {
		User user = new User();
		user.setEmail(email);
		user.setIconUrl(Constant.DEFAULT_ICON_URL);
		user.setUsername(username);
		user.setPassword(password);
		userService.save(user);
		return "redirect:/admin/user";
	}

	@RequestMapping("user/delete")
	@ResponseBody
	public String userdelete(Integer id) {
		try {
			userService.deleteById(id);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}

	@RequestMapping("category/master")
	public String categorymaster(HttpServletRequest request, Model modelMap,
			Integer cid) {
		if (cid == null) {
			List<Category> categories = categoryService.selectAll();
			modelMap.addAttribute("categories", categories);
			return "admin/master";
		} else {
			Category category = categoryService.selectById(cid);
			List<User> userList = userService.selectAll();
			@SuppressWarnings("unchecked")
			List<CategoryMaster> masters = (List<CategoryMaster>) request
					.getServletContext()
					.getAttribute(Constant.CATEGORY_MASTERS);
			List<Integer> ids = new ArrayList<Integer>();
			for (CategoryMaster cm : masters) {
				if (cm.getCategoryId() == cid) {
					ids.add(cm.getUserId());
				}
			}
			modelMap.addAttribute("category", category);
			modelMap.addAttribute("userList", userList);
			modelMap.addAttribute("ids", ids);
			return "admin/authorize";
		}
	}

	@RequestMapping("category/authorize")
	@ResponseBody
	public String categoryMasterAuthorize(HttpServletRequest request,Integer cid, Integer uid) {
		try {
			CategoryMaster categoryMaster = new CategoryMaster();
			categoryMaster.setCategoryId(cid);
			categoryMaster.setUserId(uid);
			categoryMasterService.save(categoryMaster);
			
			UserRole userRole = userRoleService.selectByUid(uid);
			userRole.setRoleId(Role.MANAGER);
			userRoleService.update(userRole);
			
			List<CategoryMaster> masters = categoryMasterService.selectAll();
			request.getServletContext().setAttribute(Constant.CATEGORY_MASTERS, masters);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}

	@RequestMapping("category/revoke")
	@ResponseBody
	public String categoryMasterRevoke(HttpServletRequest request,Integer cid, Integer uid) {
		if (cid == null || uid == null)
			return "fail";
		try {
			CategoryMaster categoryMaster = new CategoryMaster();
			categoryMaster.setCategoryId(cid);
			categoryMaster.setUserId(uid);
			List<CategoryMaster> list = categoryMasterService
					.selectByExample(categoryMaster);
			if (list != null && list.size() > 0) {
				categoryMasterService.delete(list.get(0).getId());
				UserRole userRole = userRoleService.selectByUid(uid);
				userRole.setRoleId(Role.USER);
				userRoleService.update(userRole);
				List<CategoryMaster> masters = categoryMasterService.selectAll();
				request.getServletContext().setAttribute(Constant.CATEGORY_MASTERS, masters);
			}
			
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}

	@RequestMapping("category")
	public String category(Model modelMap) {
		List<Category> categories = categoryService.selectAll();
		modelMap.addAttribute("categories", categories);
		return "admin/category";
	}

	@RequestMapping("category/add")
	public String categoryadd(String cname) {
		Category category = new Category();
		category.setCategoryName(cname);
		categoryService.save(category);
		return "redirect:/admin/category";
	}
	
	@RequestMapping("category/edit")
	public String categoryedit(String cname,Integer cid) {
		Category category = categoryService.selectById(cid);
		category.setCategoryName(cname);
		categoryService.update(category);
		return "redirect:/admin/category";
	}

	@RequestMapping("category/delete")
	@ResponseBody
	public String categorydelete(Integer id) {
		try {
			categoryService.deleteById(id);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}
}
