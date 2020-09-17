package kr.co.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.Board.BoardDTO;
import kr.co.Board.BoardService;
import kr.co.Member.MemberDTO;
import kr.co.Member.MemberService;
import kr.co.Order.OrderDTO;
import kr.co.Order.OrderSequenceDTO;
import kr.co.Order.OrderService;
import kr.co.Product.ProductDTO;
import kr.co.Product.ProductService;

@Controller
public class MemberController {

	private static final int HashMap = 0;

	@Inject
	public MemberService memberService;

	@Inject
	public BoardService boardService;

	@Inject
	private JavaMailSender mailSender; // 메일 서비스를 사용하기 위해 의존성을 주입함.

	@Inject
	private OrderService orderService;

	@Inject
	private ProductService productService;

	@Autowired
	public KakaoAPI kakao;

	// 모든 회원 보기
	@RequestMapping(value = "Member/memberList", method = RequestMethod.GET)
	public String memberList(Model model) {

		List<MemberDTO> list = memberService.memberList();
		model.addAttribute("memberList", list);

		return "Member/memberList";
	}

	// 로그인 폼이동 GET
	@RequestMapping(value = "Member/LoginForm", method = RequestMethod.GET)
	public String LoginForm(HttpServletRequest request,Model model) {
		System.out.println("로그인 폼으로 이동");
		String referer = request.getHeader("referer");
		System.out.println(referer);
		model.addAttribute("referer", referer);
		return "Member/LoginForm";
	}

	// 로그인 처리 POST
	@RequestMapping(value = "Member/LoginForm", method = RequestMethod.POST)
	public String LoginForm(@RequestParam Map<String, String> map, HttpServletRequest request,
			HttpServletResponse reponse, HttpSession session, String referer) throws Exception {

		Map<String, String> member = memberService.login(map);

		System.out.println("======================================" + referer);
		if (member == null) {
			System.out.println("로그인 실패");			
			return "redirect:LoginForm";
			
		} else {
			session.setAttribute("member", member);
			System.out.println("로그인 성공");
			if(referer.equals("http://localhost:8080/Bob/Member/SignUp2?"))
			{	
				return "redirect:/";
			}
			else if(referer.equals("http://localhost:8080/Bob/Member/NewPw") || referer.equals("http://localhost:8080/Bob/Member/FindId"))
			{
				return "redirect:/";
			}
			else {
				return "redirect:"+referer;
			}
		}
	}

	// 카카오
	@RequestMapping(value = "/kakaoLogin")
	public String kakaoLogin(@RequestParam("code") String code, HttpSession session) {
		String access_Token = kakao.getAccessToken(code);
		HashMap<String, Object> userInfo = kakao.getUserInfo(access_Token);
		System.out.println("login Controller : " + userInfo);

		// 클라이언트의 이메일이 존재할 때 세션에 해당 이메일과 토큰 등록
		if (userInfo.get("nickname") != null) {
			session.setAttribute("userId", userInfo.get("nickname"));
			session.setAttribute("access_Token", access_Token);
		}

		return "home";
	}

	// 카카오 로그아웃
	@RequestMapping(value = "/kakaoLogout")
	public String kakaoLogout(HttpSession session) {
		kakao.kakaoLogout((String) session.getAttribute("access_Token"));
//	    session.removeAttribute("access_Token");
//	    session.removeAttribute("userId");
		session.invalidate();
		return "home";
	}

	// 로그아웃
	@RequestMapping(value = "Member/Logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	// 이용약관
	@RequestMapping(value = "Member/SignUp1", method = RequestMethod.GET)
	public String signUp1() {

		return "Member/SignUp1";
	}

	// 회원가입 GET
	@RequestMapping(value = "Member/SignUp2", method = RequestMethod.GET)
	public String signUp() {

		return "Member/SignUp2";
	}

	// 회원가입 POST
	@RequestMapping(value = "Member/SignUp2", method = RequestMethod.POST)
	public String signUp(MemberDTO memberDTO, RedirectAttributes rttr) {

		int r = memberService.memberInsert(memberDTO);

		if (r > 0) {
			rttr.addFlashAttribute("msg", "회원가입되었습니다.");
		}

		return "redirect:LoginForm";
	}

	// 아이디 유효성 검사
	@RequestMapping(value = "Member/idChecking", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Map<Object, Object> idChecking(String id) {

		int count = 0;
		Map<Object, Object> map = new HashMap<Object, Object>();

		count = memberService.idChecking(id);
		map.put("cnt", count);

		return map;
	}

	// 이메일 중복 검사
	@RequestMapping(value = "Member/emailChecking", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> emailChecking(String email) {

		Map<Object, Object> map = new HashMap<Object, Object>();
		int count = 0;
		count = memberService.emailChecking(email);

		map.put("cnt", count);

		return map;
	}

	// 마이페이지 이동
	// 자기 게시글과 자기 장바구니 내역 및 주문내역 출력 해야됨
	@RequestMapping(value = "Member/Mypage", method = RequestMethod.GET)
	public String Mypage(Model model, HttpSession session) {

		Map map = (Map) session.getAttribute("member");
		int mb_number = (int) map.get("mb_number");
		String mb_id = (String) map.get("mb_id");

		List<BoardDTO> list = boardService.myPageBoardList(mb_id);
		List<OrderDTO> order_list = orderService.getMyOrder(Integer.toString(mb_number));
		List<OrderSequenceDTO> seq_list = new ArrayList();
		int payment_Price = 0;

		for (int i = 0; i < order_list.size(); i++) {
			int cnt = 0;
			String order_name = null;
			cnt = orderService.OrderSeqCount(order_list.get(i).getOd_id());
			seq_list.add(i, orderService.getSeqDTO(order_list.get(i).getOd_id()));
			ProductDTO pd_DTO = productService.productGetDetail(seq_list.get(i).getPd_number());
			payment_Price += order_list.get(i).getOd_price();
			if (cnt != 1) {
				order_name = pd_DTO.getPd_name() + " 외 " + (cnt - 1) + "건";
				order_list.get(i).setMypage_odname(order_name);
			} else {
				order_name = pd_DTO.getPd_name();
				order_list.get(i).setMypage_odname(order_name);
			}

		}

		model.addAttribute("boardList", list);
		model.addAttribute("orderList", order_list);
		return "Member/Mypage";
	}

	// 회원 수정 페이지
	@RequestMapping(value = "Member/UpdateForm", method = RequestMethod.GET)
	public String MemberUpdate(@RequestParam("mb_number") int mb_number, Model model) {
		// @RequestParam("mb_num")int mb_num,Model model

		MemberDTO memberDTO = memberService.getMember(mb_number);

		model.addAttribute("memberDetail", memberDTO);

		return "Member/UpdateForm";
	}

	// 회원 수정 완료 POST
	@RequestMapping(value = "Member/UpdateForm", method = RequestMethod.POST)
	public String MemberUpdate(MemberDTO memberDTO) {
		int r = memberService.memberUpdate(memberDTO);

		if (r > 0) {
			System.out.println("수정 완료");

			return "redirect:./Mypage?mb_number=" + memberDTO.getMb_number();
		}
		return "redirect:UpdateForm";
	}

	// 회원 탈퇴 Form 이동
	@RequestMapping(value = "Member/DeleteForm", method = RequestMethod.GET)
	public String delete() {

		return "Member/DeleteForm";
	}

	// 회원 탈퇴 처리 POST
	@RequestMapping(value = "Member/DeleteForm", method = RequestMethod.POST)
	public String delete(@RequestParam("mb_number1") int mb_number1, @RequestParam("mb_pw1") String mb_pw1,
			HttpSession session) {

		Map map = (Map) session.getAttribute("member");
		String str = (String) map.get("mb_pw");

		if (str.equals(mb_pw1)) {
			memberService.memberDelete(mb_number1);
			session.invalidate();
			return "redirect:/";
		} else {
			return "redirect:DeleteForm";
		}
	}

////////////////////////////////////////////////////////////////////////////관리자 기능

	// 관리자의 회원 수정 처리
	@RequestMapping(value = "Member/AdminUpdate", method = RequestMethod.GET)
	public String AdminUpdate(@RequestParam("mb_number") int mb_number, Model model) {

		MemberDTO memberDTO = memberService.getMember(mb_number);

		model.addAttribute("memberDetail", memberDTO);

		return "Member/AdminUpdate";
	}

	// 회원 수정 완료 POST
	@RequestMapping(value = "Member/AdminUpdate", method = RequestMethod.POST)
	public String AdminUpdate(MemberDTO memberDTO) {

		int r = memberService.memberUpdate(memberDTO);

		if (r > 0) {
			System.out.println("수정 완료");
		} else {
			System.out.println("수정안됌");
			return "redirect:Member/memberList";
		}
		return "redirect:memberList";
	}

	// 관리자의 회원 탈퇴 처리
	@RequestMapping(value = "Member/AdminDel", method = RequestMethod.GET)
	public String adminDel(@RequestParam("mb_number") int num, MemberDTO memberDTO) {

		MemberDTO member = memberService.getMember(num);

		System.out.println(member.getMb_number());
		System.out.println(member.getMb_del());

		if (member.getMb_del() == 0) {
			member.setMb_del(1);
		} else if (member.getMb_del() == 1) {
			member.setMb_del(0);
		}

		memberService.adminDelete(member);

		return "redirect:memberList";
	}

	// 아이디, 비밀번호 찾기 폼
	@RequestMapping(value = "Member/FindIdPw", method = RequestMethod.GET)
	public String FindIdPw() {
		return "Member/FindIdPw";
	}

	// 아이디 찾기
	@RequestMapping(value = "Member/FindId", method = RequestMethod.POST)
	public String FindId(MemberDTO memberDTO, Model model) {

		String mb_id = memberService.findIdByEmail(memberDTO);

		model.addAttribute("mb_id", mb_id);

		return "Member/InformIdPw";
	}

	// 비밀번호 찾기
	@RequestMapping(value = "Member/NewPw", method = RequestMethod.POST)
	public String NewPw(MemberDTO memberDTO, Model model) {

		Random r = new Random();
		int dice = r.nextInt(4589362) + 49311;
		String d = Integer.toString(dice);
		memberDTO.setMb_pw(d);

		int check = memberService.newPw(memberDTO);

		model.addAttribute("name", memberDTO.getMb_name());
		model.addAttribute("newPw", d);
		model.addAttribute("check", check);

		return "Member/InformIdPw";
	}

	// Mypage에서 주문 상세정보 누를 때 나타나는 메소드 - OrderDetail.jsp
	   @RequestMapping(value = "Member/OrderDetail", method = RequestMethod.GET)
	   public String OrderDetail(String od_id, Model model, HttpSession session) {
	      
	      Map map = (Map) session.getAttribute("member");
	      int mb_number = (int) map.get("mb_number");
	      
	      List<OrderSequenceDTO> list = orderService.getSeq(od_id);
	      OrderDTO orderdto = orderService.getOrderDetail(od_id);
	      ProductDTO productdto = new ProductDTO();
	      List list2 = new ArrayList();
	      for (int i = 0; i < list.size(); i++) {
	         productdto = productService.productGetDetail(list.get(i).getPd_number());
	         list.get(i).setProductDTO(productdto);
	      }

	      System.out.println(list2);
	      model.addAttribute("order_seq", list);
	      model.addAttribute("order", orderdto); // orderdto 안에 od_date값이 list로 들어오므로 따로 선언을 안해도 된다.
	      
	      List<OrderDTO> order_list = orderService.getMyOrder(Integer.toString(mb_number));
	      List<OrderSequenceDTO> seq_list = new ArrayList();
	      int payment_Price = 0;
	      
	      for (int i = 0; i < order_list.size(); i++) {
	         int cnt = 0;
	         String order_name = null;
	         cnt = orderService.OrderSeqCount(order_list.get(i).getOd_id());
	         seq_list.add(i, orderService.getSeqDTO(order_list.get(i).getOd_id()));
	         ProductDTO pd_DTO = productService.productGetDetail(seq_list.get(i).getPd_number());
	         payment_Price += order_list.get(i).getOd_price();
	         if (cnt != 1) {
	            order_name = pd_DTO.getPd_name() + " 외 " + (cnt - 1) + "건";
	            order_list.get(i).setMypage_odname(order_name);
	         } else {
	            order_name = pd_DTO.getPd_name();
	            order_list.get(i).setMypage_odname(order_name);
	         }

	      }
	      
	      model.addAttribute("orderList", order_list);

	      return "Order/OrderDetail";
	   }

	// 마이페이지 게시판 리스트
	@RequestMapping(value = "Member/BoardDetail", method = RequestMethod.GET)
	public String getBoardDetail(@RequestParam("b_number") int b_number, Model model) {

		boardService.boardReadCnt(b_number); // 조회수 증가

		BoardDTO boardDTO = boardService.getBoardDetail(b_number);

		System.out.println("=========================213======");
		double r = boardService.pdnumStar(boardDTO); // 별점 개수의 평균(mapper에서 계산이 다 됌)

		System.out.println("=======================" + r);
		boardDTO.setPdnum_star(r); // 해당 상품의 후기게시판의 별점을 불러온 것을 pdnum_star으로 집어넣어줌

		model.addAttribute("boardDetail", boardDTO);

		return "Board/BoardDetail";
	}

}
