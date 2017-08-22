package cn.max.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.max.mapper.ArticleMapper;
import cn.max.mapper.CommentMapper;
import cn.max.vo.Article;
import cn.max.vo.ArticleQuery;
import cn.max.vo.Comment;

@Service
public class ArticleService {

	@Autowired
	private ArticleMapper articleMapper;
	@Autowired
	private CommentMapper commentMapper;

	public List<Article> selectAll() {
		return articleMapper.selectAll();
	}

	public List<Article> selectByCgId(Integer cid) {
		if (cid == null)
			return null;
		Article article = new Article();
		article.setCategoryId(cid);
//		return articleMapper.selectByExample(article);
		return null;
	}

	public Article selectByPrimaryKey(Integer id) {
		if (id == null)
			return null;
		return articleMapper.selectByPrimaryKey(id);
	}

	public int save(Article article, String content) {
		int i = articleMapper.insert(article);
		Comment comment = new Comment();
		comment.setArticleId(article.getId());
		comment.setContent(content);
		comment.setUserId(article.getUserId());
		comment.setCommentTime(article.getPublishTime());
		comment.setNum(1);
		commentMapper.insert(comment);
		return i;
	}

	public void update(Article article) {
		articleMapper.updateByPrimaryKey(article);
	}

	public List<Article> selectByCgId(Integer cid, Integer page,
			Integer pageSize) {
		if (cid == null)
			return null;
		int first = (page - 1) * pageSize;
		return articleMapper.selectWithPage(cid, first, pageSize);
	}

	public int selectCountByCgId(Integer cid) {
			return articleMapper.selectCountByCgId(cid);
	}

	public int deleteById(Integer id) {
		if (id == null)
			return 0;
		return articleMapper.deleteByPrimaryKey(id);
	}
	public List<Article> selectByExample(ArticleQuery aq) {
		if (aq == null)
			return null;
		return articleMapper.selectByExample(aq);
	}

	public ArticleMapper getArticleMapper() {
		return articleMapper;
	}

	public void setArticleMapper(ArticleMapper articleMapper) {
		this.articleMapper = articleMapper;
	}

	public CommentMapper getCommentMapper() {
		return commentMapper;
	}

	public void setCommentMapper(CommentMapper commentMapper) {
		this.commentMapper = commentMapper;
	}


}
