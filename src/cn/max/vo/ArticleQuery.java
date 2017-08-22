package cn.max.vo;

public class ArticleQuery extends Article{

	private Integer page;
	private Integer pageSize;
	private Integer first;
	
	public Integer getFirst() {
		if(this.getPage() == null || this.getPage()<=0){
			this.setPage(1);
		}
		if(this.getPageSize() == null || this.getPageSize() <=0)
			this.setPageSize(10);
		this.first = (this.page - 1) * this.pageSize;
		return first;
	}
	public void setFirst(Integer first) {
		this.first = first;
	}
	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	
}
