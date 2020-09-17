package kr.co.Product;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class ProductDAOImpl implements ProductDAO{
	
	@Inject
	private SqlSession sqlSession;
	
	@Override
	public List<ProductDTO> productList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("Product.ProductList");
	}

	@Override
	public ProductDTO productGetDetail(int productNumber) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("Product.ProductGetDetail", productNumber);
	}
	
	//상품 추가
	@Override
	public int productInsert(ProductDTO productDTO) {
		// TODO Auto-generated method stub
		return sqlSession.insert("Product.ProductRegister",productDTO);
	}

	@Override
	public int productUpdate(ProductDTO productDTO) {
		// TODO Auto-generated method stub
		return sqlSession.update("Product.ProductUpdate",productDTO);
	}

	@Override
	public int productDelete(int pd_number) {
		// TODO Auto-generated method stub
		return sqlSession.delete("Product.ProductDelete", pd_number);
	}
	
	////////////////////////장바구니 기능//////////////////////////
	//장바구니 추가
	@Override
	public int cartInsert(CartDTO cartDTO) {
		// TODO Auto-generated method stub
		System.out.println("장바구니 추가 DAO단");
		return sqlSession.insert("Product.CartInsert", cartDTO);
	}

	@Override
	public List<CartJoinDTO> cartDetail(int mb_number) {
		// TODO Auto-generated method stub
		System.out.println("장바구니 출력");
		return sqlSession.selectList("Product.CartCheck", mb_number);
	}

	@Override
	public CartJoinDTO cartGetDetail(int cart_number) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("Product.CartGetDetail", cart_number);
	}

	@Override
	   public int cartDelete(int cart_number) {
	      // TODO Auto-generated method stub
	      return sqlSession.delete("Product.CartDelete", cart_number);
	   }
	@Override
	public int cartDelOn(int cart_number) {
		// TODO Auto-generated method stub
		return sqlSession.update("Product.CartDelOn", cart_number);
	}

	@Override
	public int cartDelOff(int cart_number) {
		// TODO Auto-generated method stub
		return sqlSession.update("Product.CartDelOff", cart_number);
	}

	@Override
	public List<CartJoinDTO> orderCartList(int mb_number) {
		// TODO Auto-generated method stub
		System.out.println("dao단");
		return sqlSession.selectList("Product.OrderCartList", mb_number);
	}
	@Override
	public double pdavgstar(int pd_number) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("Product.pdavgstar", pd_number);
	}
	
	@Override
	   public int cartReset(int mb_number) {
	      // TODO Auto-generated method stub
	      return sqlSession.update("Product.CartDelZero", mb_number);
	   }
	
	@Override
	   public int buyInsert(CartDTO cartDTO) {
	      // TODO Auto-generated method stub
	      return sqlSession.insert("Product.BuyInsert", cartDTO);
	   }
}
