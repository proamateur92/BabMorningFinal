package kr.co.Controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.javassist.expr.NewArray;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.Member.MemberDTO;
import kr.co.Member.MemberService;
import kr.co.Order.OrderDAO;
import kr.co.Order.OrderDTO;
import kr.co.Order.OrderSequenceDTO;
import kr.co.Order.OrderService;
import kr.co.Product.CartDTO;
import kr.co.Product.ProductDTO;
import kr.co.Product.ProductService;

@Controller
public class OrderController {

   @Inject
   private ProductService productService;
   @Inject
   private MemberService memberService;
   @Inject
   private OrderService orderService;

   @RequestMapping(value = "Order/CartOrderComplete", method = RequestMethod.POST)
   public String CartOrderInsert(MemberDTO memberDTO, Model model, int od_price, int od_delivery,String mb_memo, HttpSession session) {
      
      List<CartDTO> list = (List) session.getAttribute("cart");
      Map map = (Map) session.getAttribute("member");
      map.get(memberDTO);

      String id = null;
      String today = null;
      Date date = new Date();
      Calendar cal = Calendar.getInstance();
      cal.setTime(date);
      SimpleDateFormat sdformat = new SimpleDateFormat("yyyyMMddHHmmss");
      today = sdformat.format(cal.getTime());

      int mb_number = (int) map.get("mb_number");
      id = "BAB" + (String) today + mb_number;

      OrderDTO orderDTO = new OrderDTO();
      OrderSequenceDTO orderSequenceDTO = new OrderSequenceDTO();

      orderDTO.setOd_id(id);
      orderDTO.setOd_name(memberDTO.getMb_name());
      orderDTO.setOd_ph(memberDTO.getMb_ph());
      orderDTO.setOd_ad1(memberDTO.getMb_ad1());
      orderDTO.setOd_ad2(memberDTO.getMb_ad2());
      orderDTO.setOd_ad3(memberDTO.getMb_ad3());
      orderDTO.setOd_memo(mb_memo);
      orderDTO.setOd_price(od_price);
      orderDTO.setOd_delivery(od_delivery);
      orderDTO.setOd_memo(mb_memo);
      orderDTO.setMb_number(mb_number);

      orderService.orderInsert(orderDTO);

      for (int i = 0; i < list.size(); i++) {
         orderSequenceDTO.setOd_id(id);
         orderSequenceDTO.setOd_amount(list.get(i).getCart_amount());
         orderSequenceDTO.setPd_number(list.get(i).getPd_number());

         orderService.sequenceInsert(orderSequenceDTO);
         productService.cartDelete(list.get(i).getCart_number());
      }

      session.setAttribute("order", orderDTO);
      session.setAttribute("order_seq", orderSequenceDTO);

      if(orderDTO.getOd_date()==null) {
         SimpleDateFormat sdformat1 = new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm:ss");
         today = sdformat1.format(cal.getTime());
         model.addAttribute("payDate", today);
      }
      
      return "Order/CartOrderComplete";
   }

   @RequestMapping(value = "Order/ProductOrderComplete", method = RequestMethod.POST)
   public String orderInsert(MemberDTO memberDTO, Model model, int od_price, int od_delivery, String mb_memo, HttpSession session,
         int pd_number) {
      
      
      List<CartDTO> list = (List) session.getAttribute("cart");
      Map map = (Map) session.getAttribute("member");
      map.get(memberDTO);

      String id = null;
      String today = null;
      Date date = new Date();
      Calendar cal = Calendar.getInstance();
      cal.setTime(date);
      SimpleDateFormat sdformat = new SimpleDateFormat("yyyyMMddHHmmss");
      today = sdformat.format(cal.getTime());

      int mb_number = (int) map.get("mb_number");
      id = "BAB" + (String) today + mb_number;

      OrderDTO orderDTO = new OrderDTO();
      OrderSequenceDTO orderSequenceDTO = new OrderSequenceDTO();
      ProductDTO product = productService.productGetDetail(pd_number);
      
      orderDTO.setOd_id(id);
      orderDTO.setOd_name(memberDTO.getMb_name());
      orderDTO.setOd_ph(memberDTO.getMb_ph());
      orderDTO.setOd_ad1(memberDTO.getMb_ad1());
      orderDTO.setOd_ad2(memberDTO.getMb_ad2());
      orderDTO.setOd_ad3(memberDTO.getMb_ad3());
      orderDTO.setOd_memo(mb_memo);
      orderDTO.setOd_price(od_price);
      orderDTO.setOd_delivery(od_delivery);
      orderDTO.setMb_number(mb_number);


      orderSequenceDTO.setOd_id(id);
      orderSequenceDTO.setOd_amount(1);
      orderSequenceDTO.setPd_number(pd_number);

      orderService.orderInsert(orderDTO);
      orderService.sequenceInsert(orderSequenceDTO);
      
      session.setAttribute("order", orderDTO);
      session.setAttribute("order_seq", orderSequenceDTO);
      
      if(orderDTO.getOd_date()==null) {
         SimpleDateFormat sdformat1 = new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm:ss");
         today = sdformat1.format(cal.getTime());
         model.addAttribute("payDate", today);
      }

      model.addAttribute("product", product);
      
      return "Order/ProductOrderComplete";
   }
   
   @RequestMapping(value="Order/OrderList", method=RequestMethod.GET)
   public String OrderList(Model model, int od_state) {

      List<OrderDTO> list = orderService.orderList();

      model.addAttribute("state", od_state);
      model.addAttribute("orderList", list);
      return "Order/OrderList";
   }
   
   @RequestMapping(value = "Order/OrderUpdateState", method = RequestMethod.POST)
   @ResponseBody
   public String orderUpdateState(int od_state, String od_id) {
      
      OrderDTO order = orderService.getOrderDetail(od_id);
      int check = order.getOd_state();
      if(od_state==order.getOd_state()) {
         return "../Order/OrderList?od_state="+od_state;

      } else {
         System.out.println("배송상태 같음");
         order.setOd_state(od_state);
         int r = orderService.updateState(order);
         
         if(r>=0) {
            System.out.println("배송상태 변경 완료");
            
            if(order.getOd_state()==0) {
               return "../Order/OrderList?od_state="+check;
            } else if(order.getOd_state()==1) {
               return "../Order/OrderList?od_state="+check;
            } else {
               return "../Order/OrderList?od_state="+check;
            }
         } else {
            System.out.println("배송상태 변경 실패");
            
            return "../Order/OrderList?od_state="+od_state;
         }
      }
      
   }
}