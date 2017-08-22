package cn.max.vo;

import java.util.ArrayList;
import java.util.List;

public class User {
    private Integer id;

    private String username;

    private String password;

    private String iconUrl;

    private String email;
    
    
    private List<Role> roles = new ArrayList<Role>();
    
    public User(){
    	
    }
    public User(String username, String password, String email) {
		super();
		this.username = username;
		this.password = password;
		this.email = email;
	}

    public boolean hasRole(Integer roleId){
    	for(Role r : roles){
    		if(r.getId()==roleId)
    			return true;
    	}
    	return false;
    }
	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getIconUrl() {
        return iconUrl;
    }

    public void setIconUrl(String iconUrl) {
        this.iconUrl = iconUrl == null ? null : iconUrl.trim();
    }

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	public List<Role> getRoles() {
		return roles;
	}
	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}
	
}