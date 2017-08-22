package cn.max.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.max.vo.Article;
import cn.max.vo.CategoryMaster;
import cn.max.vo.Comment;
import cn.max.vo.Role;
import cn.max.vo.User;

@Controller
@RequestMapping("/comment")
public class CommentController extends BaseController {

	@RequestMapping("/add")
	public String add(HttpServletRequest request, Integer aid, String content,Integer pid) {
		Date date = new Date();
		User activeUser = getUser(request);
		Article article = articleService.selectByPrimaryKey(aid);
		article.setReplyCount(article.getReplyCount() + 1);
		article.setLastReplyTime(date);
		articleService.update(article);

		Comment comment = new Comment();
		comment.setArticleId(aid);
		comment.setContent(content);
		comment.setNum(article.getReplyCount() + 1);
		comment.setUserId(activeUser.getId());
		comment.setCommentTime(date);
		comment.setParentId(pid);
		commentService.save(comment);

		return "redirect:/show?aid=" + aid;
	}

	@RequestMapping("/delown")
	@ResponseBody
	public String delown(HttpServletRequest request, Integer aid, Integer id) {
		String msg = "";
		try {
			Article article = articleService.selectByPrimaryKey(aid);
			Comment comment = commentService.selectByPrimaryKey(id);
			if (article.getId() != comment.getArticleId()) {
				msg = "fail";
				return msg;
			}
			User user = getUser(request);
			if (user.getId() != comment.getUserId()) {
				msg = "fail";
				return msg;
			}
			commentService.deleteById(id);
			msg = "success";
		} catch (Exception e) {
			e.printStackTrace();
			msg = "fail";
		}
		return msg;
	}

	@RequestMapping("/delete")
	@ResponseBody
	public String delete(HttpServletRequest request, Integer aid, Integer id) {
		String msg = "";
		try {
			Comment comment = commentService.selectByPrimaryKey(id);
			if (aid != comment.getArticleId()) {
				msg = "fail";
				return msg;
			}
			
			User user = getUser(request);
			boolean isMaster = false;
			if(user.hasRole(Role.ADMIN)){
				isMaster = true;
			}else{
				Article article = articleService.selectByPrimaryKey(aid);
				List<CategoryMaster> masterIn = getMasterIn(request);
				for(CategoryMaster cm : masterIn){
					if(cm.getCategoryId() == article.getCategoryId()){		//判断是否是当前板块的版主,防止URL输入
						isMaster = true;
						break;
					}
				}
			}
		
			if(isMaster){
				commentService.deleteById(id);
				msg = "success";
			}else{
				msg = "fail";
			}
		} catch (Exception e) {
			e.printStackTrace();
			msg = "fail";
		}
		return msg;
	}
}
