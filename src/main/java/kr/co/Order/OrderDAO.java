package kr.co.Order;

import java.util.List;

import kr.co.Member.MemberDTO;

public interface OrderDAO {
   // 주문 추가
   public int orderInsert(OrderDTO orderDTO);
   
   // 주문 상세 추가
   public int sequenceInsert(OrderSequenceDTO orderSequenceDTO);
   
   // 회원(회원번호) 주문 확인
   public List<OrderDTO> getMyOrder(String od_id);

   // 회원(주문번호) 주문 확인
   public OrderDTO getOrderDetail(String od_id);

   // 주문번호로 주문 상세확인
   public List<OrderSequenceDTO> getSeq(String od_id);
   
   // 모든 주문 확인
   public List<OrderDTO> orderList();
   
   // 배송 상태 변경
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