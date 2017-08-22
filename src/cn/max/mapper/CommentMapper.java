package cn.max.mapper;

import java.util.List;

import cn.max.vo.Comment;

public interface CommentMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Comment record);

    int insertSelective(Comment record);

    Comment selectByPrimaryKey(Integer id);
    
    List<Comment> selectByAid(Integer aid);

    int updateByPrimaryKeySelective(Comment record);

    int updateByPrimaryKey(Comment record);
    
    List<Comment> selectByExample(Comment comment);
}