package kr.co.Product;

public class ProductReplyDTO {
	private int pr_number;
	private String pr_name;
	private String pr_content;
	private String pr_date;
	private int pd_number;
	
	public int getPr_number() {
		return pr_number;
	}
	public void setPr_number(int pr_number) {
		this.pr_number = pr_number;
	}
	public String getPr_name() {
		return pr_name;
	}
	public void setPr_name(String pr_name) {
		this.pr_name = pr_name;
	}
	public String getPr_content() {
		return pr_content;
	}
	public void setPr_content(String pr_content) {
		this.pr_content = pr_content;
	}
	public String getPr_date() {
		return pr_date;
	}
	public void setPr_date(String pr_date) {
		this.pr_date = pr_date;
	}
	public int getPd_number() {
		return pd_number;
	}
	public void setPd_number(int pd_number) {
		this.pd_number = pd_number;
	}

}
