package kr.co.Board;

public class BoardReplyDTO {
	private int re_number;
	private String re_writer;
	private String re_content;
	private String re_date;
	private int b_number;
	private int b_like;
	
	public int getB_like() {
		return b_like;
	}
	public void setB_like(int b_like) {
		this.b_like = b_like;
	}
	public int getRe_number() {
		return re_number;
	}
	public void setRe_number(int re_number) {
		this.re_number = re_number;
	}
	public String getRe_writer() {
		return re_writer;
	}
	public void setRe_writer(String re_writer) {
		this.re_writer = re_writer;
	}
	
	public String getRe_content() {
		return re_content;
	}
	public void setRe_content(String re_content) {
		this.re_content = re_content;
	}
	public String getRe_date() {
		return re_date;
	}
	public void setRe_date(String re_date) {
		this.re_date = re_date;
	}
	public int getB_number() {
		return b_number;
	}
	public void setB_number(int b_number) {
		this.b_number = b_number;
	}
	
	@Override
	public String toString() {
		return "BoardReplyDTO [re_number=" + re_number + ", re_writer=" + re_writer + ", re_content=" + re_content
				+ ", re_date=" + re_date + ", b_number=" + b_number + ", b_like=" + b_like + "]";
	}
}
