package kr.co.Board;


public class Criteria {

    private int page;
    private int perPageNum;
    private int num;
    private int bcode_number;
    private String searchType;
    private String keyword;
    private String mb_id;

    public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getBcode_number() {
		return bcode_number;
	}

	public void setBcode_number(int bcode_number) {
		this.bcode_number = bcode_number;
	}

	public Criteria() {
        this.page = 1;
        this.perPageNum = 10;
        setNum((page - 1) * (perPageNum));
    }

    public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num + perPageNum;
	}

	public void setPage(int page) {

        if (page <= 0) {
        	
            this.page = 1;
            setNum((page - 1) * (perPageNum));
            return;
        }
        
        this.page = page;
        setNum((page - 1) * (perPageNum));
    }

    public int getPage() {
        return page;
    }

    public void setPerPageNum(int perPageNum) {

        if (perPageNum <= 0 || perPageNum > 100) {
            this.perPageNum = 10 + perPageNum;
            return;
        }

        this.perPageNum = perPageNum;
    }

    public int getPerPageNum() {
        return this.perPageNum;
    }

    public int getPageStart() {
        return (this.page - 1) * perPageNum;
    }

	public String getMb_id() {
		return mb_id;
	}

	public void setMb_id(String mb_id) {
		this.mb_id = mb_id;
	}

    
}

