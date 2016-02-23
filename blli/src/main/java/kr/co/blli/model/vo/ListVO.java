package kr.co.blli.model.vo;

import java.util.List;


public class ListVO {
	private List list;
	private BlliPagingBean pagingBean;
	//2016.02.23 추가
	private int totalPage;

	public ListVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ListVO(List list, BlliPagingBean pagingBean) {
		super();
		this.list = list;
		this.pagingBean = pagingBean;
	}

	public ListVO(List list, int totalPage) {
		super();
		this.list = list;
		this.totalPage = totalPage;
	}

	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

	public BlliPagingBean getPagingBean() {
		return pagingBean;
	}

	public void setPagingBean(BlliPagingBean pagingBean) {
		this.pagingBean = pagingBean;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

}