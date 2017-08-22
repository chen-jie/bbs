package junit;

import java.util.List;
import java.util.Stack;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import cn.max.mapper.CategoryMapper;
import cn.max.mapper.CommentMapper;
import cn.max.mapper.UserMapper;
import cn.max.service.ArticleService;
import cn.max.service.CategoryService;
import cn.max.service.UserService;
import cn.max.vo.Article;
import cn.max.vo.ArticleQuery;
import cn.max.vo.Category;
import cn.max.vo.Comment;
import cn.max.vo.User;

public class Junit {

	ApplicationContext ac;
	private UserService us;
	private ArticleService as;
	private UserMapper userMapper;
	private CommentMapper commentMapper;
	private CategoryService categoryService;
	private CategoryMapper categoryMapper;
	@Before
	public void before(){
		ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		us = (UserService) ac.getBean("userService");
		as = (ArticleService) ac.getBean("articleService");
		userMapper = (UserMapper) ac.getBean("userMapper");
		commentMapper = (CommentMapper) ac.getBean("commentMapper");
		categoryService = (CategoryService) ac.getBean("categoryService");
		categoryMapper = (CategoryMapper) ac.getBean("categoryMapper");
	}
	
	@Test
	public void test1(){
		User user = new User();
		user.setIconUrl("dsa");
		user.setUsername("zhangsna");
		user.setPassword("password");
		userMapper.insert(user);
	}
	
	@Test
	public void testTx(){
//		us.testTx();
	}
	
	@Test
	public void testSelectALL(){
		
		System.out.println(as.selectAll().size());
	}
	
	@Test
	public void testFindByExample(){
		List<Article> list = as.selectByCgId(1);
		System.out.println(list.get(0).getAuthorName());
	}
	
	@Test
	public void testAssocation(){
		List<Comment> list = commentMapper.selectByAid(12);
		System.out.println(list.get(0).getUser().getUsername());
	}
	@Test
	public void testFindCount(){
		System.out.println( as.selectCountByCgId(1));
	}
	@Test
	public void testSelectPage(){
		System.out.println(as.selectByCgId(1, 2, 5));
	}
	@Test
	public void testCheckCategoryName(){
		System.out.println(categoryService.checkCategoryname("Java专区"));
	}
	
	@Test
	public void testWithMastes(){
		List<Category> all = categoryMapper.selectAllwithMasters();
		for(Category c : all){
			for(User u :c.getMasters()){
				System.out.println("========================");
				System.out.println(u.getUsername());
				System.out.println(u.getId());
				System.out.println(u.getEmail());
				System.out.println(u.getIconUrl());
			}
		}
		System.out.println();
	}
	@Test
	public void testWithPages(){
		ArticleQuery aq = new ArticleQuery();
		aq.setCategoryId(1);
		aq.setPage(1);
		aq.setPageSize(5);
		List<Article> list = as.selectByExample(aq);
		for(Article a : list){
			System.out.println(a.getLastReplyTime());
		}
		System.out.println();
	}
	
	@Test
	public void testCount(){
		System.out.println(as.selectCountByCgId(null));
	}
	
	
	@Test
	public void testSelectparent(){
		List<Comment> list = commentMapper.selectByAid(12);
		Comment comment = list.get(2);
		Stack<Comment> s  = new Stack<>();
		s.push(comment);
		while(comment.getParent()!=null){
			comment = comment.getParent();
			s.push(comment);
		}
		while(!s.empty()){
			Comment c = s.pop();
			System.out.println(c.getId());
		}
		System.out.println();
	}
}
