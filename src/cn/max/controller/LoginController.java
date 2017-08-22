package cn.max.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.max.util.Constant;
import cn.max.util.StringUtil;
import cn.max.vo.Category;
import cn.max.vo.CategoryMaster;
import cn.max.vo.Permission;
import cn.max.vo.Role;
import cn.max.vo.User;

@Controller
public class LoginController extends BaseController {

	@RequestMapping("/login")
	public String login(HttpServletRequest request,
			HttpServletResponse response, String username, String password,String code) {
		String lastUrl = (String) request.getSession().getAttribute("lasturl");
		String session_code = (String) request.getSession().getAttribute(Constant.SESSION_CODE);
		if(!session_code.equalsIgnoreCase(code)){
			try {
				request.setAttribute("msg", "验证码错误!");
				request.getRequestDispatcher("login.jsp").forward(request,
						response);
				return null;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		User user = userService.login(username, password);
		if (user == null) {
			String msg = "";
			msg = "用户名或密码错误！";
			try {
				request.setAttribute("msg", msg);
				request.getRequestDispatcher("login.jsp").forward(request,
						response);
				return null;
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			List<Role> roles = roleService.selectRolesByUserId(user.getId());
			List<Permission> permissions = permissionService
					.selectPermissionByRoles(roles);
			@SuppressWarnings("unchecked")
			List<CategoryMaster> masters = (List<CategoryMaster>) request
					.getServletContext()
					.getAttribute(Constant.CATEGORY_MASTERS);
			List<CategoryMaster> masterIn = new ArrayList<CategoryMaster>();
			for (CategoryMaster cm : masters) {
				if (cm.getUserId() == user.getId())
					masterIn.add(cm);
			}
			user.setRoles(roles);
			request.getSession().setAttribute(Constant.MASTERIN, masterIn);
			request.getSession().setAttribute(Constant.SESSION_USER, user);
			request.getSession().setAttribute(Constant.ROLES, roles);
			request.getSession().setAttribute(Constant.PERMISSIONS, permissions);
		}

		if (!StringUtil.isNullOrEmpty(lastUrl)) {
			request.getSession().removeAttribute("lasturl");
			try {
				response.sendRedirect(lastUrl);
			} catch (IOException e) {
				e.printStackTrace();
			}
			return null;
		}
		return "redirect:/index";
	}

	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute(Constant.SESSION_USER);
		session.invalidate();
		return "redirect:/index";
	}

	@RequestMapping("/register")
	public void register(HttpServletRequest request,
			HttpServletResponse response, String username, String password,
			String email,String code) {
		String session_code = (String) request.getSession().getAttribute(Constant.SESSION_CODE);
		String msg;
		if(!session_code.equalsIgnoreCase(code)){
			msg = "验证码错误!";
		}else{
			User user = new User(username, password, email);
			try {
				userService.save(user);
				msg = "恭喜你，注册成功！";
			} catch (Exception e) {
				msg = "注册失败！";
			}
		}
		try {
			request.setAttribute("msg", msg);
			request.getRequestDispatcher("register.jsp").forward(request,response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("/checkusername")
	@ResponseBody
	public String checkUsername(String username) {

		User user = userService.checkUsername(username);
		if (user != null)
			return "true";
		return "false";
	}

	@RequestMapping("/checkcategoryname")
	@ResponseBody
	public String checkCategoryname(String cname) {

		Category category = categoryService.checkCategoryname(cname);
		if (category != null)
			return "true";
		return "false";
	}
}
