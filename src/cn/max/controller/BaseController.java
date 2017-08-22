package cn.max.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import cn.max.service.ArticleService;
import cn.max.service.CategoryMasterService;
import cn.max.service.CategoryService;
import cn.max.service.CommentService;
import cn.max.service.PermissionService;
import cn.max.service.RoleService;
import cn.max.service.UserRoleService;
import cn.max.service.UserService;
import cn.max.util.Constant;
import cn.max.vo.CategoryMaster;
import cn.max.vo.User;

@Controller
public class BaseController {
	@Autowired
	ArticleService articleService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	CategoryService categoryService;
	
	@Autowired
	CommentService commentService;
	
	@Autowired
	RoleService roleService;
	
	@Autowired
	PermissionService permissionService;
	
	@Autowired
	CategoryMasterService categoryMasterService;
	
	@Autowired
	UserRoleService userRoleService;
	
	
	public User getUser(HttpServletRequest request){
		User user = (User) request.getSession().getAttribute(Constant.SESSION_USER);
		return user;
	}
	
	public UserRoleService getUserRoleService() {
		return userRoleService;
	}

	public void setUserRoleService(UserRoleService userRoleService) {
		this.userRoleService = userRoleService;
	}

	public CategoryMasterService getCategoryMasterService() {
		return categoryMasterService;
	}

	public void setCategoryMasterService(CategoryMasterService categoryMasterService) {
		this.categoryMasterService = categoryMasterService;
	}

	@SuppressWarnings("unchecked")
	public List<CategoryMaster> getMasterIn(HttpServletRequest request){
		return (List<CategoryMaster>)request.getSession().getAttribute(Constant.MASTERIN);
	}
	public CategoryService getCategoryService() {
		return categoryService;
	}
	public void setCategoryService(CategoryService categoryService) {
		this.categoryService = categoryService;
	}
	public ArticleService getArticleService() {
		return articleService;
	}
	public void setArticleService(ArticleService articleService) {
		this.articleService = articleService;
	}
	public UserService getUserService() {
		return userService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	public CommentService getCommentService() {
		return commentService;
	}
	public void setCommentService(CommentService commentService) {
		this.commentService = commentService;
	}
	public RoleService getRoleService() {
		return roleService;
	}
	public void setRoleService(RoleService roleService) {
		this.roleService = roleService;
	}
	public PermissionService getPermissionService() {
		return permissionService;
	}
	public void setPermissionService(PermissionService permissionService) {
		this.permissionService = permissionService;
	}
	
	
}
