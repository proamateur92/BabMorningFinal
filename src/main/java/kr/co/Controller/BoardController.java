package kr.co.Controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.Board.BoardDTO;
import kr.co.Board.BoardReplyDTO;
import kr.co.Board.BoardService;
import kr.co.Board.Criteria;
import kr.co.Board.LikeDTO;
import kr.co.Board.PageMaker;
import kr.co.Order.OrderDTO;
import kr.co.Order.OrderSequenceDTO;
import kr.co.Order.OrderService;
import kr.co.Product.ProductDTO;
import kr.co.Product.ProductService;

@Controller
public class BoardController {
	@Inject
	private BoardService boardService;
	
	@Inject
	private OrderService orderService;
	@Inject
	private ProductService productService;
	
	//게시판 전체 목록 보기
	@RequestMapping(value = "board/QNAList", method = RequestMethod.GET )
	public String boardList(Model model,int bcode_number)
	{
		List<BoardDTO> list = boardService.boardList();
		
		model.addAttribute("boardList", list);
		return "Board/QNAList";
	}	
	
	//게시판 선택 조회
	@RequestMapping(value = "board/BoardDetail", method = RequestMethod.GET)
	public String getBoardDetail(@RequestParam("b_number") int b_number, Model model)
	{
		
		boardService.boardReadCnt(b_number);	//조회수 증가
		
		BoardDTO boardDTO = boardService.getBoardDetail(b_number);
		
		double r = boardService.pdnumStar(boardDTO);  //별점 개수의 평균(mapper에서 계산이 다 됌) 
			
		boardDTO.setPdnum_star(r); // 해당 상품의 후기게시판의 별점을 불러온 것을 pdnum_star으로 집어넣어줌
		
		model.addAttribute("boardDetail",boardDTO);
				
		return "Board/BoardDetail";
	}
	
	//게시판 글쓰기
	@RequestMapping(value = "board/BoardRegister", method = RequestMethod.GET)
	public String boardRegister(int bcode_number,Model model,int pd_number)
	{
		model.addAttribute("pd_number", pd_number);
		model.addAttribute("list_number", bcode_number);
		return "Board/BoardRegister";
	}
	
	//게시판 글쓰기
	@RequestMapping(value = "board/BoardRegister", method = RequestMethod.POST)
	public String boardRegister(int boardstate, BoardDTO boardDTO, RedirectAttributes rttr, Model model, int pd_number )
	{
		int bcode_number = boardDTO.getBcode_number();
		if(bcode_number == 9) {
			bcode_number = boardstate;
		}
		boardDTO.setBcode_number(boardstate);
		
		int r = boardService.boardRegister(boardDTO);
		
		if(r > 0)
		{
			rttr.addFlashAttribute("msg","추가에 성공하셨습니다.");
		}
		model.addAttribute("bcode_number", boardDTO);
		if(bcode_number == 1)
		{
			return "redirect:../Product/ProductDetail?pd_number="+pd_number;
		}
		
		return "redirect:list_paging?bcode_number="+bcode_number;
	}
	
	//게시판 글 수정
	@RequestMapping(value = "board/BoardUpdate", method = RequestMethod.GET)
	public String boardUpdate(int b_number, Model model)
	{
		BoardDTO boardDTO = boardService.getBoardDetail(b_number);
		model.addAttribute("b_Update",boardDTO);
		return "Board/BoardUpdate";
	}
	
	//게시판 글 수정
	@RequestMapping(value = "board/BoardUpdate", method = RequestMethod.POST)
	public String boardUpdate(BoardDTO boardDTO)
	{		
		boardService.boardUpdate(boardDTO);
		return "redirect:BoardDetail?b_number="+boardDTO.getB_number();
	}
	
	//게시판 글 삭제
	@RequestMapping(value = "board/BoardDelete", method = RequestMethod.GET)
	public String boardDelete(@RequestParam("b_number") int b_number,int bcode_number)
	{
		boardService.boardDelete(b_number);		
		return "redirect:list_paging?bcode_number="+bcode_number;
	}
	
	///////////////////////////////////////////////좋아요 기능
	
	//게시판 좋아요 활성화
	@ResponseBody
	@RequestMapping(value = "board/BoardLike", method = RequestMethod.POST)
	public String boardLike(@RequestParam Map<Integer, String> map, HttpSession session)
	{	
		String str = "success";
		boardService.insertLike(map);
		return str;
	}
	
	//게시판 좋아요 취소
	@ResponseBody
	@RequestMapping(value = "board/DeleteLike", method = RequestMethod.POST)
	public String deleteLike(@RequestParam Map<Integer, String> map)
	{	
		boardService.deleteLike(map);		
		return "success";
	}
		
	//게시판 좋아요	여부 확인
	@ResponseBody
	@RequestMapping(value = "board/GetLike", method = RequestMethod.POST)
	public LikeDTO getLike(@RequestParam int b_number, String mb_id){
		LikeDTO likeDTO = new LikeDTO();
		likeDTO.setB_number(b_number);
		likeDTO.setMb_id(mb_id);
			
		likeDTO = boardService.getLike(likeDTO);
		int like_number = likeDTO.getLike_number();
			
		return likeDTO;
	}
	
	//게시판 좋아요	여부 확인
	@ResponseBody
	@RequestMapping(value = "board/LikeCnt", method = RequestMethod.POST)
	public int likeCnt(@RequestParam int b_number){
		int a = boardService.likeCnt(b_number);
	
		return a;
	}
		
	///////////////////////////댓   글///////////////////////////////////////////////////
	
	//댓글 조회
	@ResponseBody
	@RequestMapping(value = "board/getReply", method=RequestMethod.POST)
	public List<BoardReplyDTO> getReply(@RequestParam("b_number") int b_number) {
		
		return boardService.getReply(b_number);
	}
	 
	//댓글추가
	@ResponseBody
	@RequestMapping(value = "board/replyRegister", method=RequestMethod.POST)
	public Map<String,Object> replyRegister(BoardReplyDTO boardReplyDTO) {
		
		Map<String,Object> result = new HashMap<String, Object>();
		try {
			boardService.replyRegister(boardReplyDTO);
			result.put("status", "ok");
		}catch(Exception e){
			e.printStackTrace();
			result.put("status", "ok");
		}
		return result;
	}
	
	//댓글수정
	@ResponseBody
	@RequestMapping(value = "board/replyUpdate", method=RequestMethod.POST)
	public void replyUpdate(BoardReplyDTO boardReplyDTO) {
		
		boardService.replyUpdate(boardReplyDTO);		
	}
	
	//댓글 삭제
	@ResponseBody
	@RequestMapping(value = "board/deleteReply", method=RequestMethod.POST)
	public Map<String,Object> deleteReply(int re_number) {
		
		Map<String,Object> result = new HashMap<String, Object>();
		try {
			boardService.replyDelete(re_number);			
			result.put("status", "ok");
		}catch(Exception e){
			e.printStackTrace();
			result.put("status", "ok");
		}	
		
		return result;
	}
	
	//페이징/////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping(value = "board/listCriteria", method = RequestMethod.GET)
	public String listCriteria(Model model, Criteria criteria) throws Exception {
		
	    model.addAttribute("list", boardService.listSearch(criteria));
	    return "listCriteria";
	}
	
	//게시판 페이징 + 검색
	@RequestMapping(value = "board/list_paging", method = RequestMethod.GET)
	public String listPaging(@RequestParam("bcode_number") int bcode_number, 
			Model model, Criteria criteria, HttpSession session) throws Exception{
				
		String boardName ="";
		int mb_number = 0;
		String mb_id ="";
		
		if(session.getAttribute("member") != null)
		{
			Map map = (Map) session.getAttribute("member");
			mb_number = (int)map.get("mb_number");
			mb_id = (String)map.get("mb_id");		
		}
		
		//어느 게시판인지 번호 넣어주기
		criteria.setBcode_number(bcode_number);			
		criteria.setMb_id(mb_id);
		
		//공지사항불러오기
		List<BoardDTO> noticeList = boardService.noticeList(criteria);
		//게시판 글 총 갯수 가져오기
		List<BoardDTO> boardList = boardService.listSearch(criteria);
		int search = boardService.countSearchedBoard(criteria);	 
		
		
		
		if(bcode_number == 1){
			boardName = "ReviewList";
		}else if(bcode_number == 2) {
			boardName = "QNAList";
		}else if(bcode_number == 6) {
			boardName = "FreeBoard";
		}else if(bcode_number == 7) {
			boardName = "MyBoardList";
		}else if(bcode_number == 8) {
			boardName = "MyOrderList";
			
			//사용자 주문리스트
			List<OrderDTO> order_list = orderService.getMyOrder(Integer.toString(mb_number));
			List<OrderSequenceDTO> seq_list= new ArrayList();			
			search = order_list.size();			
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
		}else if(bcode_number == 9) {
			boardName = "NoticeList";
		}
		
	
		PageMaker pageMaker = new PageMaker();
	    //pageMaker = 하단에 페이징 갯수
	    
	    //총 게시글 갯수에 맞춰서 페이징 출력 갯수 정하기
	    //생성된 criteria 객체를 pageMaker에 등록
	    pageMaker.setCriteria(criteria);
	    pageMaker.setTotalCount(search);
	    
	    //공지사항
	    model.addAttribute("notice", noticeList);
	    //게시글
	    model.addAttribute("boardList", boardList);
	    //페이징
	    model.addAttribute("pageMaker", pageMaker);
	    //해당 게시글 갯수	    
	    model.addAttribute("searchCnt", search);
	    
	    
	    return "Board/"+boardName;
	}
}















