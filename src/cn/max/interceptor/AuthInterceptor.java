package cn.max.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import cn.max.util.AnonymousURL;
import cn.max.util.CommonURL;
import cn.max.util.Constant;
import cn.max.util.StringUtil;
import cn.max.vo.Permission;

public class AuthInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {

		String url = request.getRequestURI();
		//匿名URL，不需要用户登录
		
		for (String u : AnonymousURL.URLS) {

			if (url.indexOf(u) > 0)
				return true; // 若是匿名url，放行
		}
		// USER为空 跳转登录页面
		Object user = request.getSession().getAttribute(Constant.SESSION_USER);
		if (user == null) {
			String param = request.getQueryString();
			if (!StringUtil.isNullOrEmpty(param))
				url = url + "?" + param;

			request.getSession().setAttribute("msg", "您需要登录后才能执行操作！");
			request.getSession().setAttribute("lasturl", url);
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return false;
		}

		// 登录后，都可以使用的URL
		for (String u : CommonURL.URLS) {

			if (url.indexOf(u) > 0)
				return true; // 若是公用url，放行
		}
		// 权限不够 跳转无权页面

		@SuppressWarnings("unchecked")
		List<Permission> permissions = (List<Permission>) request.getSession()
				.getAttribute(Constant.PERMISSIONS);
		for (Permission p : permissions) {
			// 有权， 放行
			if (url.indexOf(p.getUrl()) > 0)
				return true;
		}
		// 无权，跳转
//		response.sendRedirect(request.getContextPath() + "/noauth.jsp");
		request.getRequestDispatcher("/WEB-INF/jsp/error/noauth.jsp").forward(request, response);
		return false;
	}

}
