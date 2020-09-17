package kr.co.Board;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageMaker {

    private int totalCount;
    private int startPage;
    private int endPage;
    private boolean prev;
    private boolean next;
    //1~10까지 페이지 표시
	private int displayPageNum = 5;
    private Criteria criteria;

    public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public Criteria getCriteria() {
		return criteria;
	}

    public void setCriteria(Criteria criteria) {
        this.criteria = criteria;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
        calcData();
    }

    private void calcData() {

    	//페이징 열의 마지막 숫자
        endPage = (int) (Math.ceil(criteria.getPage() / (double) displayPageNum) * displayPageNum);

        //페이징 열의 처음 숫자
        startPage = (endPage - displayPageNum) + 1;

        //총 페이지의 끝번호
        int tempEndPage = (int) (Math.ceil(totalCount / (double) criteria.getPerPageNum()));

        //페이징 열의 마지막 숫자가 총 페이지의 끝번호 보다 크면 페이징 마지막 열은 = 총 페이지의 끝 번호
        if (endPage > tempEndPage) {
            endPage = tempEndPage;
        }

        prev = startPage == 1 ? false : true;

        next = endPage * criteria.getPerPageNum() >= totalCount ? false : true;
       

    }
    //검색조건과 검색 키워드 일치시키기
    public String makeSearch(int page) {
    	UriComponents uriComponents = UriComponentsBuilder.newInstance()
    			.queryParam("page", page)
    			.queryParam("perPageNum", criteria.getPerPageNum())
    			.queryParam("bcode_number", criteria.getBcode_number())
    			.build();
    	
    	return uriComponents.toString();
    }
    
    

	private String encoding(String keyword)
    {
    	if(keyword == null || keyword.trim().length() == 0)
    	{
    		return "";
    	}
    	
    	try {
    		return URLEncoder.encode(keyword, "UTF-8");
    	}catch(UnsupportedEncodingException e) {
    		return "";
    	}
    }
    
	public String makeQuery(int page) {
	    UriComponents uriComponents = UriComponentsBuilder.newInstance()
	            .queryParam("page", page)
	            .queryParam("perPageNum", criteria.getPerPageNum())
	            .build();

	    return uriComponents.toUriString();
	}
    
    
	@Override
	public String toString() {
		return "PageMaker [totalCount=" + totalCount + ", startPage=" + startPage + ", endPage=" + endPage + ", prev="
				+ prev + ", next=" + next + ", displayPageNum=" + displayPageNum + ", criteria=" + criteria + "]";
	}
    
    
    
}

