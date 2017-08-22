package cn.max.controller;

import java.io.File;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import cn.max.util.Constant;
import cn.max.vo.User;

@Controller
@RequestMapping("/user")
public class UserController extends BaseController{

	@RequestMapping("/info")
	public String index(Model modelMap){
		return "user/info";
	}
	
	@RequestMapping("/head")
	@ResponseBody
	public String head(HttpServletRequest request,MultipartFile file){
		
		if(file!=null&&!file.isEmpty()){
			User user = getUser(request);
			String upload = request.getServletContext().getRealPath("upload");
			//取得源文件名
			String originalFilename = file.getOriginalFilename();
			String type;
			if(originalFilename.equals("blob")){
				type = ".png";
			}else{
				type = originalFilename.substring(originalFilename.lastIndexOf("."));
			}
			//取得格式
			String newFileName = UUID.randomUUID().toString()+type;
			try {
				File newFile = new File(upload,newFileName);
				file.transferTo(newFile);
				String old_url = user.getIconUrl();
				
				if(!old_url.equals(Constant.DEFAULT_ICON_URL)){
					File oldFile = new File(upload,old_url);
					if(oldFile.exists()){
						oldFile.delete();
					}
				}
				user.setIconUrl("upload/"+newFileName);
				userService.update(user);
				request.getSession().setAttribute(Constant.SESSION_USER, user);
				return "success";
				
			} catch (Exception e) {
				e.printStackTrace();
			} 
		}
		return "fail";
		
	}
	
	@RequestMapping("/edit")
	public String edit(Model modelMap){
		return "user/edit";
	}
	
	@RequestMapping("/editSubmit")
	public String editSubmit(HttpServletRequest request,String old,String password){
		User user = getUser(request);
		if(user.getPassword().equals(old)){
			user.setPassword(password);
			userService.update(user);
			request.getSession().setAttribute(Constant.SESSION_USER, user);
			request.setAttribute("msg", "恭喜您，修改密码成功！");
		}
		else
		{
			request.setAttribute("msg", "原密码错误！");
		}
		return "user/edit";
	}
}
