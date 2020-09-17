package kr.co.Order;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.co.Member.MemberDTO;

@Service
public class OrderServiceImpl implements OrderService{
   
   @Inject
   OrderDAO orderDAO;
   
   @Override
   public int orderInsert(OrderDTO orderDTO) {
      // TODO Auto-generated method stub
      return orderDAO.orderInsert(orderDTO);
   }

   @Override
   public int sequenceInsert(OrderSequenceDTO orderSequenceDTO) {
      // TODO Auto-generated method stub
      return orderDAO.sequenceInsert(orderSequenceDTO);
   }

   @Override
   public List<OrderDTO> getMyOrder(String mb_id) {
      // TODO Auto-generated method stub
      return orderDAO.getMyOrder(mb_id);
   }

   @Override
   public OrderDTO getOrderDetail(String od_id) {
      // TODO Auto-generated method stub
      return orderDAO.getOrderDetail(od_id);
   }

   @Override
   public List<OrderSequenceDTO> getSeq(String od_id) {
      // TODO Auto-generated method stub
      return orderDAO.getSeq(od_id);
   }

   @Override
   public List<OrderDTO> orderList() {
      // TODO Auto-generated method stub
      return orderDAO.orderList();
   }
   
   @Override
   public int updateState(OrderDTO orderDTO) {
   	// TODO Auto-generated method stub
   	return orderDAO.updateState(orderDTO);
   }
   
   @Override
   public int getOrderPrice(String date) {
      // TODO Auto-generated method stub
      return orderDAO.getOrderPrice(date);
   }

   @Override
   public int getOrderCount(String date) {
      // TODO Auto-generated method stub
      return orderDAO.getOrderCount(date);
   }
   
   @Override
   public int OrderSeqCount(String od_id) {
      // TODO Auto-generated method stub
      return orderDAO.OrderSeqCount(od_id);
   }
   
   @Override
   //주문번호로 해당 Seq가져오기
   public OrderSequenceDTO getSeqDTO(String od_id) {
      // TODO Auto-generated method stub
      return orderDAO.getSeqDTO(od_id);
   }
}