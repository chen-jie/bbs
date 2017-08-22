package cn.max.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;

import cn.max.exception.NotFoundException;

/**
 * 异常处理类
 * @author outofmemory.cn
 *
 */
public class CommonExceptionResolver extends SimpleMappingExceptionResolver implements HandlerExceptionResolver {


    @Override
    public ModelAndView resolveException(HttpServletRequest request,
            HttpServletResponse response, Object handler, Exception ex) {

    	ex.printStackTrace();
    	if(ex instanceof NotFoundException){
    		return super.getModelAndView("/error/404", ex);
    	}
    	return super.getModelAndView("/error/500", ex);
    }

}