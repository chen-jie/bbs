package cn.max.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.max.vo.Article;
import cn.max.vo.ArticleQuery;

public interface ArticleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Article record);

    int insertSelective(Article record);

    Article selectByPrimaryKey(Integer id);

    List<Article> selectAll();

    List<Article> selectByExample(ArticleQuery aq);
    
    int updateByPrimaryKeySelective(Article record);

    int updateByPrimaryKey(Article record);

	int selectCountByCgId(Integer cid);

	List<Article> selectWithPage(@Param("cid")Integer cid, @Param("first")Integer first, @Param("size")Integer pageSize);
    
}