package kr.co.Member;

import java.sql.Date;

public class MemberDTO {
	private int mb_number;
	private String mb_id;
	private String mb_pw;
	private String mb_name;
	private String mb_email; 
	private String mb_ph; 
	private Date mb_signup; 
	private String mb_ad1;
	private String mb_ad2;
	private String mb_ad3;
	private int mb_del;
	
	public int getMb_number() {
		return mb_number;
	}
	public void setMb_number(int mb_number) {
		this.mb_number = mb_number;
	}
	public String getMb_id() {
		return mb_id;
	}
	public void setMb_id(String mb_id) {
		this.mb_id = mb_id;
	}
	public String getMb_pw() {
		return mb_pw;
	}
	public void setMb_pw(String mb_pw) {
		this.mb_pw = mb_pw;
	}
	public String getMb_name() {
		return mb_name;
	}
	public void setMb_name(String mb_name) {
		this.mb_name = mb_name;
	}
	public String getMb_email() {
		return mb_email;
	}
	public void setMb_email(String mb_email) {
		this.mb_email = mb_email;
	}
	public String getMb_ph() {
		return mb_ph;
	}
	public void setMb_ph(String mb_ph) {
		this.mb_ph = mb_ph;
	}
	public Date getMb_signup() {
		return mb_signup;
	}
	public void setMb_signup(Date mb_signup) {
		this.mb_signup = mb_signup;
	}
	public String getMb_ad1() {
		return mb_ad1;
	}
	public void setMb_ad1(String mb_ad1) {
		this.mb_ad1 = mb_ad1;
	}
	public String getMb_ad2() {
		return mb_ad2;
	}
	public void setMb_ad2(String mb_ad2) {
		this.mb_ad2 = mb_ad2;
	}
	public String getMb_ad3() {
		return mb_ad3;
	}
	public void setMb_ad3(String mb_ad3) {
		this.mb_ad3 = mb_ad3;
	}
	public int getMb_del() {
		return mb_del;
	}
	public void setMb_del(int mb_del) {
		this.mb_del = mb_del;
	}	
	
	
	@Override
	public String toString() {
		return "MemberDTO [mb_number=" + mb_number + ", mb_id=" + mb_id + ", mb_pw=" + mb_pw + ", mb_name=" + mb_name
				+ ", mb_email=" + mb_email + ", mb_ph=" + mb_ph + ", mb_signup=" + mb_signup + ", mb_ad1=" + mb_ad1
				+ ", mb_ad2=" + mb_ad2 + ", mb_ad3=" + mb_ad3 + ", mb_del=" + mb_del + ", mb_myboard="	+ "]";
	}
	
	
}
