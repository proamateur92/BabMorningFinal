package kr.co.Product;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;

public interface ProductDAO {

	//전체 목록 불러오기
	public List<ProductDTO> productList();
	
	//선택한 상품 정보 가져오기
	public ProductDTO productGetDetail(int productNumber);
	
	//상품 추가
	public int productInsert(ProductDTO productDTO);
	
	//상품 수정
	public int productUpdate(ProductDTO productDTO);
	
	//상품 삭제
	public int productDelete(int pd_number);
	
	/////////////////////장바구니 기능//////////////////////
	//장바구니 추가
	public int cartInsert(CartDTO cartDTO);
	
	//장바구니 조회
	public List<CartJoinDTO> cartDetail(int mb_number);
	public List<CartJoinDTO> orderCartList(int mb_number);
	
	//장바구니 선택시 정보
	public CartJoinDTO cartGetDetail(int cart_number);
	
	//장바구니 초기화
	public int cartReset(int mb_number); 
	
	//장바구니 수정
	
	//장바구니 삭제
	
	public int cartDelete(int cart_number);
	//장바구니 cart_del on,off
	public int cartDelOn(int cart_number);
	
	//장바구니 cart_del on,off
	public int cartDelOff(int cart_number);	
		
	//BoardDTO의 pdnum_star값이 Product DB의 pd_avgstar컬럼으로 들어가는 메소드
	public double pdavgstar(int pd_number);
	
	//바로 구매 장바구니 추가
	   public int buyInsert(CartDTO cartDTO);
	
}
