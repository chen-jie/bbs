package cn.max.vo;

import java.util.List;

public class Category {
    private Integer id;

    private String categoryName;

    private List<User> masters;
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName == null ? null : categoryName.trim();
    }

	public List<User> getMasters() {
		return masters;
	}

	public void setMasters(List<User> masters) {
		this.masters = masters;
	}
}