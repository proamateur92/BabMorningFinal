package kr.co.Product;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class ProductServiceImpl implements ProductService{
	
	@Inject
	private ProductDAO productDAO;

	@Override
	public List<ProductDTO> productList() {
		// TODO Auto-generated method stub
		return productDAO.productList();
	}

	@Override
	public ProductDTO productGetDetail(int productNumber) {
		// TODO Auto-generated method stub
		return productDAO.productGetDetail(productNumber);
	}

	@Override
	public int productInsert(ProductDTO productDTO) {
		// TODO Auto-generated method stub
		return productDAO.productInsert(productDTO);
	}

	@Override
	public int productUpdate(ProductDTO productDTO) {
		// TODO Auto-generated method stub
		return productDAO.productUpdate(productDTO);
	}

	@Override
	public int productDelete(int pd_number) {
		// TODO Auto-generated method stub
		return productDAO.productDelete(pd_number);
	}
	
	///////////////////장바구니 기능//////////////////////
	//장바구니 추가
	@Override
	public int cartInsert(CartDTO cartDTO) {
		// TODO Auto-generated method stub
		System.out.println("장바구니 추가 서비스");
		return productDAO.cartInsert(cartDTO);
	}
	//별점
	@Override
	public double pdavgstar(int pd_number) {
		// TODO Auto-generated method stub
		return productDAO.pdavgstar(pd_number);
	}
	
	//장바구니 조회
	@Override
	public List<CartJoinDTO> cartDetail(int mb_number) {
		// TODO Auto-generated method stub
		System.out.println("장바구니 조회 서비스");
		return productDAO.cartDetail(mb_number);
	}

	@Override
	public CartJoinDTO cartGetDetail(int cart_number) {
		// TODO Auto-generated method stub
		return productDAO.cartGetDetail(cart_number);
	}

	@Override
	   public int cartDelete(int cart_number) {
	      // TODO Auto-generated method stub
	      return productDAO.cartDelete(cart_number);
	   }   
	
	@Override
	public int cartDelOn(int cart_number) {
		// TODO Auto-generated method stub
		return productDAO.cartDelOn(cart_number);
	}

	@Override
	public int cartDelOff(int cart_number) {
		// TODO Auto-generated method stub
		return productDAO.cartDelOff(cart_number);
	}

	@Override
	public List<CartJoinDTO> orderCartList(int mb_number) {
		// TODO Auto-generated method stub
		System.out.println("서비스단");
		return productDAO.orderCartList(mb_number);
	}	
	
	@Override
	   public int cartDelZero(int mb_number) {
	      // TODO Auto-generated method stub
	      System.out.println("장바구니 초기화");
	      return productDAO.cartReset(mb_number);
	   }
	
	@Override
	   public int buyInsert(CartDTO cartDTO) {
	      // TODO Auto-generated method stub
	      return productDAO.buyInsert(cartDTO);
	   }
}
