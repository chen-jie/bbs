package cn.max.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.max.mapper.ArticleMapper;
import cn.max.mapper.CommentMapper;
import cn.max.vo.Comment;

@Service
public class CommentService {

	@Autowired
	private ArticleMapper articleMapper;
	@Autowired
	private CommentMapper commentMapper;

	public List<Comment> selectByCaId(Integer aid) {
		if (aid == null)
			return null;
		return commentMapper.selectByAid(aid);
	}

	public Comment selectByPrimaryKey(Integer id) {
		if (id == null)
			return null;
		return commentMapper.selectByPrimaryKey(id);
	}
	public void deleteById(Integer id) {
		if (id != null)
			commentMapper.deleteByPrimaryKey(id);
	}
	
	public List<Comment> selectByExample(Comment comment) {
		if(comment == null)
			return null;
		return commentMapper.selectByExample(comment);
	}

	public int save(Comment comment) {
		return commentMapper.insert(comment);
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
