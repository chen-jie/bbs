package cn.max.vo;

public class Role {
	public static int ADMIN = 1;
	public static int MANAGER = 2;
	public static int USER = 3;
    private Integer id;

    private String name;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }
}