package cn.max.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.max.vo.Article;
import cn.max.vo.Comment;
import cn.max.vo.User;

@Controller
@RequestMapping("/article")
public class ArticleController extends BaseController {

	@RequestMapping("/publish")
	public String publish(HttpServletRequest request, Integer cid,
			String title, String content) {
		Date date = new Date();
		User activeUser = getUser(request);

		Article article = new Article();
		article.setCategoryId(cid);
		article.setTitle(title);
		article.setUserId(activeUser.getId());
		article.setPublishTime(date);
		article.setLastReplyTime(date);
		article.setViewCount(0);
		article.setReplyCount(0);

		articleService.save(article, content);
		return "redirect:/index";
	}

	@RequestMapping("/delete")
	@ResponseBody
	public String delete(Integer id) {
		String msg = "";
		try {
			articleService.deleteById(id);
			msg = "success";
		} catch (Exception e) {
			e.printStackTrace();
			msg = "fail";
		}
		return msg;
	}

	@RequestMapping("/delown")
	@ResponseBody
	public String delown(HttpServletRequest request, Integer id) {
		String msg = "";
		try {
			Article article = articleService.selectByPrimaryKey(id);
			User user = getUser(request);
			if (user.getId() != article.getUserId()) {
				msg = "fail";
				return msg;
			}
			articleService.deleteById(id);
			msg = "success";
		} catch (Exception e) {
			e.printStackTrace();
			msg = "fail";
		}
		return msg;
	}
	
	@RequestMapping("/delowncmt")
	@ResponseBody
	public String delowncmt(HttpServletRequest request, Integer id,Integer aid) {
		String msg = "";
		try {
			Article article = articleService.selectByPrimaryKey(aid);
			Comment comment = commentService.selectByPrimaryKey(id);
			if(article.getId()!=comment.getArticleId()){
				msg = "fail";
				return msg;
			}
			User user = getUser(request);
			if (user.getId() != article.getUserId()) {
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
}
