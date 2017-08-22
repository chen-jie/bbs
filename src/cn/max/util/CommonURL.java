package cn.max.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Properties;

/**
 * 登录后 ，不用权限可以使用的通用URL
 * */
public class CommonURL {

	public static List<String> URLS = new ArrayList<String>();
	static{
		Properties p = new Properties();
		InputStream resource = CommonURL.class.getClassLoader().getResourceAsStream("commonurl.properties");
		try {
			p.load(resource);
			@SuppressWarnings("unchecked")
			Enumeration<String> propertyNames = (Enumeration<String>) p.propertyNames();
			while(propertyNames.hasMoreElements()){
				URLS.add(propertyNames.nextElement());
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
