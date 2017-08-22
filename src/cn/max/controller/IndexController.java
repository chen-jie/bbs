package cn.max.controller;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.List;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.max.exception.NotFoundException;
import cn.max.util.Constant;
import cn.max.vo.Article;
import cn.max.vo.ArticleQuery;
import cn.max.vo.Category;
import cn.max.vo.Comment;
import cn.max.vo.User;

@Controller
public class IndexController extends BaseController {
	
	private int width = 90;//定义图片的width
	 private int height = 20;//定义图片的height
	 private int codeCount = 4;//定义图片上显示验证码的个数
	 private int xx = 15;
	 private int fontHeight = 18;
	 private int codeY = 16;
	 char[] codeSequence = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
	   'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
	   'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };

	@RequestMapping("/index")
	public String index(Model modelMap, Integer cid, Integer page,
			Integer pageSize) {
		if (page == null || page <= 0) {
			page = 1;
		}
		if (pageSize == null) {
			pageSize = 10;
		}
		int count = articleService.selectCountByCgId(cid);
		int totalPage = (count % pageSize == 0) ? count / pageSize : (count
				/ pageSize + 1);
		if (page > totalPage) {
			page = 1;
		}
		List<Category> cgList = categoryService.selectAll();
		Category ct = categoryService.selectById(cid);
		ArticleQuery aq = new ArticleQuery();
		aq.setCategoryId(cid);
		aq.setPage(page);
		aq.setPageSize(pageSize);
		List<Article> atList = articleService.selectByExample(aq);
		modelMap.addAttribute("cgList", cgList);
		modelMap.addAttribute("atList", atList);
		modelMap.addAttribute("ct", ct);
		modelMap.addAttribute("page", page);
		modelMap.addAttribute("total", count);
		modelMap.addAttribute("totalPage", totalPage);
		return "index";
	}
	@RequestMapping("/show")
	public String show(Model modelMap, Integer aid) {
		Article article = articleService.selectByPrimaryKey(aid);
		if (article != null) {
			article.setViewCount(article.getViewCount() + 1);
			articleService.update(article);
			List<Comment> ctList = commentService.selectByCaId(aid);
			Category category = categoryService.selectById(article.getCategoryId());
			User user = userService.selectById(article.getUserId());
			modelMap.addAttribute("ctList", ctList);
			modelMap.addAttribute("article", article);
			modelMap.addAttribute("category", category);
			modelMap.addAttribute("author", user);
			modelMap.addAttribute("content", ctList.get(0));
		}else{
			throw new NotFoundException("帖子不存在！或已被删除！");
		}
		
		return "show";
	}

	@RequestMapping("/create")
	public String create(Model modelMap) {
		List<Category> cgList = categoryService.selectAll();
		modelMap.addAttribute("ctList", cgList);
		return "create";
	}
	
	@RequestMapping("/search")
	public String search(Model modelMap,String keyword) {
		ArticleQuery aq = new ArticleQuery();
		aq.setTitle(keyword);
		Comment comment = new Comment();
		comment.setContent(keyword);
		List<Article> atList = articleService.selectByExample(aq);
		List<Comment> ctList = commentService.selectByExample(comment);
		modelMap.addAttribute("atList", atList);
		modelMap.addAttribute("ctList", ctList);
		modelMap.addAttribute("keyword",keyword);
		return "search";
	}
	@RequestMapping("/code")
	 public void getCode(HttpServletRequest req, HttpServletResponse resp)
	   throws IOException {

	  // 定义图像buffer
	  BufferedImage buffImg = new BufferedImage(width, height,
	    BufferedImage.TYPE_INT_RGB);
	//  Graphics2D gd = buffImg.createGraphics();
	  //Graphics2D gd = (Graphics2D) buffImg.getGraphics();
	  Graphics gd = buffImg.getGraphics();
	  // 创建一个随机数生成器类
	  Random random = new Random();
	  // 将图像填充为白色
	  gd.setColor(Color.WHITE);
	  gd.fillRect(0, 0, width, height);

	  // 创建字体，字体的大小应该根据图片的高度来定。
	  Font font = new Font("Fixedsys", Font.BOLD, fontHeight);
	  // 设置字体。
	  gd.setFont(font);

	  // 画边框。
	  gd.setColor(Color.BLACK);
	  gd.drawRect(0, 0, width - 1, height - 1);

	  // 随机产生40条干扰线，使图象中的认证码不易被其它程序探测到。
	  gd.setColor(Color.BLACK);
	  for (int i = 0; i < 40; i++) {
	   int x = random.nextInt(width);
	   int y = random.nextInt(height);
	   int xl = random.nextInt(12);
	   int yl = random.nextInt(12);
	   gd.drawLine(x, y, x + xl, y + yl);
	  }

	  // randomCode用于保存随机产生的验证码，以便用户登录后进行验证。
	  StringBuffer randomCode = new StringBuffer();
	  int red = 0, green = 0, blue = 0;

	  // 随机产生codeCount数字的验证码。
	  for (int i = 0; i < codeCount; i++) {
	   // 得到随机产生的验证码数字。
	   String code = String.valueOf(codeSequence[random.nextInt(36)]);
	   // 产生随机的颜色分量来构造颜色值，这样输出的每位数字的颜色值都将不同。
	   red = random.nextInt(255);
	   green = random.nextInt(255);
	   blue = random.nextInt(255);

	   // 用随机产生的颜色将验证码绘制到图像中。
	   gd.setColor(new Color(red, green, blue));
	   gd.drawString(code, (i + 1) * xx, codeY);

	   // 将产生的四个随机数组合在一起。
	   randomCode.append(code);
	  }
	  // 将四位数字的验证码保存到Session中。
	  HttpSession session = req.getSession();
	  session.setAttribute(Constant.SESSION_CODE, randomCode.toString());

	  // 禁止图像缓存。
	  resp.setHeader("Pragma", "no-cache");
	  resp.setHeader("Cache-Control", "no-cache");
	  resp.setDateHeader("Expires", 0);

	  resp.setContentType("image/jpeg");

	  // 将图像输出到Servlet输出流中。
	  ServletOutputStream sos = resp.getOutputStream();
	  ImageIO.write(buffImg, "jpeg", sos);
	  sos.close();
	 }
}
