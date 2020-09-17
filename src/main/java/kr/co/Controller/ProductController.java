package kr.co.Controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.Board.BoardDTO;
import kr.co.Board.BoardService;
import kr.co.Member.MemberDTO;
import kr.co.Member.MemberService;
import kr.co.Product.CartDTO;
import kr.co.Product.CartJoinDTO;
import kr.co.Product.ProductDTO;
import kr.co.Product.ProductService;

@Controller
public class ProductController {
	
	@Inject
	private ProductService productService;
	@Inject
	private MemberService memberService;
	@Inject
	private BoardService boardService;
	
	//상품 출력하기
	@RequestMapping(value="home", method=RequestMethod.GET)
	public String Home(Model model) {
		
		List<ProductDTO> list =productService.productList();
		
		model.addAttribute("ProductList", list);
		
		return "home";
	}
	
	//상품 출력하기
	@RequestMapping(value="Product/ProductList", method=RequestMethod.GET)
	public String ProductList(Model model) {
		
		List<ProductDTO> list =productService.productList();
		
		model.addAttribute("ProductList", list);
		
		return "Product/ProductList";
	}
	
	//상품 추가(하이퍼링크)
	@RequestMapping(value="Product/ProductInsert", method=RequestMethod.GET)
	public String ProductInsert() {
		return "Product/ProductInsert";
	}
	
	//상품 추가(서브밋)
	@RequestMapping(value="Product/ProductInsert", method=RequestMethod.POST)
	public String ProductInsert(MultipartHttpServletRequest mtf,ProductDTO productDTO) {
		// 파일 태그
		String fileTag = "up_upload";
		String str = productDTO.getPd_name();
	    // 업로드 파일이 저장될 경로
		String filePath = "J:\\2jy\\jspworkspace\\Babmorning_10.1(200826)\\src\\main\\webapp\\resources\\upload\\";
		
		// 파일 이름	
		MultipartFile file = mtf.getFile(fileTag);
		
		String fileName = "("+str+")"+file.getOriginalFilename();
		
		// 파일 전송
		try {
		    file.transferTo(new File(filePath + fileName));

		} catch(Exception e) {
		    System.out.println("업로드 오류");
		}
		productDTO.setPd_img(fileName);
		productService.productInsert(productDTO);

		return "redirect:ProductList";
	}
	
	//상품 상세정보 보기
	@RequestMapping(value="Product/ProductDetail", method=RequestMethod.GET)
	public String ProductDetail(Model model, int pd_number) {
		
		ProductDTO productDTO = productService.productGetDetail(pd_number);
		List<BoardDTO> list = boardService.boardReviewList(pd_number);
		
		int check = boardService.countpdnum(pd_number);	// 해당 pd_number에 대한 후기 게시판이 있나 없나 확인하는 메소드
		
		if(check>=0.1)	// 후기 게시판이 있는경우 0.1보다 크기때문에 if로 실행된다. 없으면 else 실행
			productDTO.setPd_avgstar(productService.pdavgstar(pd_number));	//pd_number로 불러온 product DB리스트를 productDTO.setPd_avgstar으로 들어가는 것
		else
			productDTO.setPd_avgstar(0);
		
		model.addAttribute("product",productDTO);
		model.addAttribute("list", list);
		
		System.out.println(list);
		
		return "Product/ProductDetail";
	}
	
	//상품 수정(하이퍼링크)
	@RequestMapping(value="Product/ProductUpdate", method=RequestMethod.GET)
	public String ProductUpdate(Model model, int pd_number) {
		
		ProductDTO productDTO = productService.productGetDetail(pd_number);
		
		model.addAttribute("product", productDTO);
		
		return "Product/ProductUpdate";
	}
	
	//상품 수정
	@RequestMapping(value="Product/ProductUpdate", method=RequestMethod.POST)
	public String ProductUpdate(MultipartHttpServletRequest mtf,ProductDTO productDTO) {
		// 파일 태그
		String fileTag = "up_upload";
		String str = productDTO.getPd_name();
	    // 업로드 파일이 저장될 경로
		String filePath = "C:\\Users\\1\\eclipse-workspace\\jspWorkspace\\Babmorning_09.51(200826)\\src\\main\\webapp\\resources\\upload\\";
		
		// 파일 이름	
		MultipartFile file = mtf.getFile(fileTag);
		
		String fileName = "("+str+")"+file.getOriginalFilename();
		
		// 파일 전송
		try {
		    file.transferTo(new File(filePath + fileName));

		} catch(Exception e) {
		    System.out.println("업로드 오류");
		}
		productDTO.setPd_img(fileName);
		productService.productUpdate(productDTO);
		
		return "redirect:ProductList";
	}

	//상품 삭제
	@RequestMapping(value="Product/ProductDelete", method=RequestMethod.GET)
	public String ProductDelete(int pd_number) {
		
		productService.productDelete(pd_number);
		
		return "redirect:ProductList";
	}
	
	////////////////////장바구니 기능//////////////////////////////
	//장바구니 추가
	@RequestMapping(value="Product/ProductDetail", method=RequestMethod.POST)
	public String CartInsert(CartDTO cartDTO, @RequestParam("mb_number") int mb_number) {
		
		System.out.println("장바구니 추가 컨트롤러");
		productService.cartInsert(cartDTO);
		
		return "redirect:ProductDetail?pd_number="+cartDTO.getPd_number();
	} 
	
	//장바구니 조회
	@RequestMapping(value="Product/CartView2", method=RequestMethod.GET)
	public String CartView2(HttpSession session, Model model) {
		
		return "Product/CartView2";
	}
	
	//장바구니 조회
	@RequestMapping(value="Product/CartView2", method=RequestMethod.POST)
	@ResponseBody
	public List<CartJoinDTO> CartView2(CartJoinDTO cartJoinDTO) {
		
		productService.cartDelZero(cartJoinDTO.getMb_number());
		
		return productService.cartDetail(cartJoinDTO.getMb_number());
	}
	
	
	// 오더페이지
	   // 오더페이지 불러오기
	   @RequestMapping(value = "Product/ProductOrderPage", method = RequestMethod.POST)
	   public String ProductOrderPage(Model model, HttpSession session, int pd_number,CartDTO cartDTO) {
	      Map map = (Map) session.getAttribute("member");
	      int mb_number = (int) map.get("mb_number");
	      
	      productService.buyInsert(cartDTO);
	      
	      String today = null;

	      Date date = new Date();
	      Calendar cal = Calendar.getInstance();

	      cal.setTime(date);

	      // 포맷변경 ( 년월일 시분초)
	      SimpleDateFormat sdformat = new SimpleDateFormat("yyyy/MM/dd");
	      today = sdformat.format(cal.getTime());

	      cal.add(Calendar.DATE, 3);

	      today = sdformat.format(cal.getTime());

	      model.addAttribute("deliveryDay", today);

	      
	      List<CartJoinDTO> list = productService.orderCartList(mb_number);
	      
	      ProductDTO productDTO = productService.productGetDetail(pd_number);
	      
	      model.addAttribute("orderCartlist", list);
	      model.addAttribute("product", productDTO);
	      session.setAttribute("cart", list);
	      return "Order/CartOrderPage";
	   }

		@RequestMapping(value = "Product/CartOrderPage", method = RequestMethod.GET)
		public String OrderPage(Model model, HttpSession session) {
			
			String today = null;

			Date date = new Date();
			Calendar cal = Calendar.getInstance();

			cal.setTime(date);

			// 포맷변경 ( 년월일 시분초)
			SimpleDateFormat sdformat = new SimpleDateFormat("yyyy/MM/dd");
			today = sdformat.format(cal.getTime());

			cal.add(Calendar.DATE, 3);

			today = sdformat.format(cal.getTime());

			model.addAttribute("deliveryDay", today);

			System.out.println("장바구니=========================================");
			Map map = (Map) session.getAttribute("member");
			int mb_number = (int) map.get("mb_number");
			List<CartJoinDTO> list = productService.orderCartList(mb_number);

			model.addAttribute("orderCartlist", list);
			session.setAttribute("cart", list);

			return "Order/CartOrderPage";
		}
	
	//장바구니 삭제
   @RequestMapping(value="Product/CartDelete", method=RequestMethod.GET)
   public String CartDelete(int cart_number) {
      
      productService.cartDelete(cart_number);
      
      return "redirect:CartView2";
   }
   
 //장바구니 cart_delOn
 	@ResponseBody
 	@RequestMapping(value="Product/CartDelOn", method=RequestMethod.POST)
 	public void CartDelOn(int cart_number) {
 		
 		productService.cartDelOn(cart_number);
 	}
 	
 	//장바구니 cart_delOff
 	@ResponseBody
 	@RequestMapping(value="Product/CartDelOff", method=RequestMethod.POST)
 	public void CartDelOff(int cart_number) {
 		
 		productService.cartDelOff(cart_number);
 	}   
   
   @RequestMapping(value="Product/Chart1", method=RequestMethod.POST)
   @ResponseBody
   public List<ProductDTO> Chart() {
      
      return productService.productList();
   }
   
   @RequestMapping(value="Product/Notice", method=RequestMethod.GET)
   public String Notice() {
	   
	   return "Product/Notice";
   }

}
