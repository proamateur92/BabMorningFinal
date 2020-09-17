package kr.co.Order;

import java.util.List;

import kr.co.Member.MemberDTO;

public interface OrderService {
   public int orderInsert(OrderDTO orderDTO);
   public int sequenceInsert(OrderSequenceDTO orderSequenceDTO);
   public List<OrderDTO> getMyOrder(String mb_id);
   public OrderDTO getOrderDetail(String od_id);
   public List<OrderSequenceDTO> getSeq(String od_id);
   public List<OrderDTO> orderList();
   public int updateState(OrderDTO orderDTO);
   //매출표 가져오기
   public int getOrderPrice(String date);
   
   //판매 건수 가져오기
   public int getOrderCount(String date);
   
   //한번에 두개이상 주문했을때 상품개수 카운팅 해주기
   public int OrderSeqCount(String od_id);
   
// 주문번호로 해당 Seq가져오기
   public OrderSequenceDTO getSeqDTO(String od_id);
}