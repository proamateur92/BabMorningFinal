package kr.co.Board;

public class BoardDTO {

	private int b_number;
	private String b_title;
	private String b_content;
	private String b_id;
	private String b_regdate;
	private int b_readcnt;
	private String b_etc;
	private int b_del;
	private int bcode_number;
	private int b_like;
	private int b_likecnt;
	private int pd_number;
	private double pd_star;
	private double pdnum_star;	// 후기게시판에 있는 별점
	
	
	public int getB_like() {
		return b_like;
	}
	
	public void setB_like(int b_like) {
		this.b_like = b_like;
	}
	public int getB_likecnt() {
		return b_likecnt;
	}
	public void setB_likecnt(int b_likecnt) {
		this.b_likecnt = b_likecnt;
	}
	public int getB_number() {
		return b_number;
	}
	public void setB_number(int b_number) {
		this.b_number = b_number;
	}
	public String getB_title() {
		return b_title;
	}
	public void setB_title(String b_title) {
		this.b_title = b_title;
	}
	public String getB_content() {
		return b_content;
	}
	public void setB_content(String b_content) {
		this.b_content = b_content;
	}
	public String getB_id() {
		return b_id;
	}
	public void setB_id(String b_id) {
		this.b_id = b_id;
	}
	public String getB_regdate() {
		return b_regdate;
	}
	public void setB_regdate(String b_regdate) {
		this.b_regdate = b_regdate;
	}
	public int getB_readcnt() {
		return b_readcnt;
	}
	public void setB_readcnt(int b_readcnt) {
		this.b_readcnt = b_readcnt;
	}
	public String getB_etc() {
		return b_etc;
	}
	public void setB_etc(String b_etc) {
		this.b_etc = b_etc;
	}
	public int getB_del() {
		return b_del;
	}
	public void setB_del(int b_del) {
		this.b_del = b_del;
	}
	public int getBcode_number() {
		return bcode_number;
	}
	public void setBcode_number(int bcode_number) {
		this.bcode_number = bcode_number;
	}
	public int getPd_number() {
		return pd_number;
	}
	public void setPd_number(int pd_number) {
		this.pd_number = pd_number;
	}	
	
	public double getPd_star() {
		return pd_star;
	}
	public void setPd_star(double pd_star) {
		this.pd_star = pd_star;
	}
	
	public double getPdnum_star() {
		return pdnum_star;
	}
	public void setPdnum_star(double r) {
		this.pdnum_star = r;
	}	
	

	@Override
	public String toString() {
		return "BoardDTO [b_number=" + b_number + ", b_title=" + b_title + ", b_content=" + b_content + ", b_id=" + b_id
				+ ", b_regdate=" + b_regdate + ", b_readcnt=" + b_readcnt + ", b_etc=" + b_etc + ", b_del=" + b_del
				+ ", bcode_number=" + bcode_number + ", b_like=" + b_like + ", b_likecnt=" + b_likecnt + ", pd_number="
				+ pd_number + ", pd_star=" + pd_star + ", pdnum_star=" + pdnum_star + "]";
	}
	
}
