package kr.co.Order;

public class OrderDTO {
	private int od_number;
	private String od_id;
	private String od_name;
	private int od_price;
	private String od_ph;
	private String od_ad1;
	private String od_ad2;
	private String od_ad3;
	private String od_date;
	private int od_state;
	private String od_memo;
	private int mb_number;
	private int od_delivery;
	private String mypage_odname;

	public String getMypage_odname() {
		return mypage_odname;
	}

	public void setMypage_odname(String mypage_odname) {
		this.mypage_odname = mypage_odname;
	}

	public int getOd_number() {
		return od_number;
	}

	public void setOd_number(int od_number) {
		this.od_number = od_number;
	}

	public String getOd_id() {
		return od_id;
	}

	public void setOd_id(String od_id) {
		this.od_id = od_id;
	}

	public String getOd_name() {
		return od_name;
	}

	public void setOd_name(String od_name) {
		this.od_name = od_name;
	}

	public int getOd_price() {
		return od_price;
	}

	public void setOd_price(int od_price) {
		this.od_price = od_price;
	}

	public String getOd_ph() {
		return od_ph;
	}

	public void setOd_ph(String od_ph) {
		this.od_ph = od_ph;
	}

	public String getOd_ad1() {
		return od_ad1;
	}

	public void setOd_ad1(String od_ad1) {
		this.od_ad1 = od_ad1;
	}

	public String getOd_ad2() {
		return od_ad2;
	}

	public void setOd_ad2(String od_ad2) {
		this.od_ad2 = od_ad2;
	}

	public String getOd_ad3() {
		return od_ad3;
	}

	public void setOd_ad3(String od_ad3) {
		this.od_ad3 = od_ad3;
	}

	public String getOd_date() {
		return od_date;
	}

	public void setOd_date(String od_date) {
		this.od_date = od_date;
	}

	public int getOd_state() {
		return od_state;
	}

	public void setOd_state(int od_state) {
		this.od_state = od_state;
	}

	public String getOd_memo() {
		return od_memo;
	}

	public void setOd_memo(String od_memo) {
		this.od_memo = od_memo;
	}

	public int getMb_number() {
		return mb_number;
	}

	public void setMb_number(int mb_number) {
		this.mb_number = mb_number;
	}

	public int getOd_delivery() {
		return od_delivery;
	}

	public void setOd_delivery(int od_delivery) {
		this.od_delivery = od_delivery;
	}

}