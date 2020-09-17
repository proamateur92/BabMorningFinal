package kr.co.Controller;

import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import kr.co.Board.BoardDTO;
import kr.co.Board.BoardService;
import kr.co.Board.Criteria;
import kr.co.Member.MemberDTO;
import kr.co.Member.MemberService;
import kr.co.Order.OrderDTO;
import kr.co.Order.OrderService;
import kr.co.Product.ProductDTO;
import kr.co.Product.ProductService;


@Controller
public class AdminController {
   @Inject
   private ProductService productService;
   @Inject
   public MemberService memberService;
   @Inject
   public BoardService boardService;
   @Inject
   public OrderService orderService;
   
   @RequestMapping(value="Admin/adminPage", method=RequestMethod.GET)
      public String AdminPage(Model model, OrderDTO orderDTO) {
	   	Criteria criteria = new Criteria();
         List<BoardDTO> noticeList = boardService.noticeList(criteria);
         List<BoardDTO> boardList = boardService.adminQna();
         List<OrderDTO> orderList = orderService.orderList();
         
         String today = null;
         String today2 = null;
           
         Date date = new Date();
         
         Calendar cal = Calendar.getInstance();
          
         cal.setTime(date);
          
         // 포맷변경 ( 년월일 시분초)
         SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd");
         SimpleDateFormat sdformat2 = new SimpleDateFormat("yyyyMMdd");
         
         int price[] = new int[7];
         int count[] = new int[7];
         String time[] = new String[7];
         int signUpCount[] = new int[7];
         String boardCount[][] = new String[7][6];
         
         Map<String, String> map = new HashMap<String, String>();
         
         for(int i=0; i<7; i++) {
            today = sdformat.format(cal.getTime());
            today2 = sdformat2.format(cal.getTime());
                        
            price[i] = orderService.getOrderPrice(today);            
            
            count[i] = orderService.getOrderCount(today);

            time[i] = today;

            signUpCount[i] = memberService.getSignUpCount(today);
            
            map.put("today", today2);
               for(int j=3; j<6; j++) {
                  String k = Integer.toString(j);
                  
                  map.put("bcode", k);
                  boardCount[i][j] = boardService.boardCount(map);
               }
            
            cal.add(Calendar.DATE, -1);
         }
         model.addAttribute("time", time);
         model.addAttribute("price", price);
         model.addAttribute("count", count);
         model.addAttribute("signUpCount", signUpCount);
         
         model.addAttribute("boardCount", boardCount);
         
         int memberCount = memberService.getMemberCount();
         model.addAttribute("memberCount", memberCount);
         
         
         String map2 = boardService.boardCount(map);
         
         model.addAttribute("boardList", boardList);
         model.addAttribute("noticeList", noticeList);
         model.addAttribute("orderList", orderList);
         
         return "Admin/adminPage";
      }
   
}