package kr.co.Order;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.Member.MemberDTO;

@Repository
public class OrderDAOImpl implements OrderDAO{
   
   @Inject
   private SqlSession sqlSession;
   
   @Override
   public int orderInsert(OrderDTO orderDTO) {
      // TODO Auto-generated method stub
      return sqlSession.insert("Order.OrderInsert", orderDTO);
   }
   
   @Override
   public int sequenceInsert(OrderSequenceDTO orderSequenceDTO) {
      // TODO Auto-generated method stub
      return sqlSession.insert("Order.InsertSequence", orderSequenceDTO);
   }

   @Override
   public List<OrderDTO> getMyOrder(String mb_id) {
      // TODO Auto-generated method stub
      return sqlSession.selectList("Order.GetMyOrder", mb_id);
   }
   
   @Override
   public OrderDTO getOrderDetail(String od_id) {
      // TODO Auto-generated method stub
      return sqlSession.selectOne("Order.GetOrderDetail", od_id);
   }
   
   @Override
   public List<OrderSequenceDTO> getSeq(String od_id) {
      // TODO Auto-generated method stub
      return sqlSession.selectList("Order.GetSeq", od_id);
   }

   @Override
   public List<OrderDTO> orderList() {
      // TODO Auto-generated method stub
      return sqlSession.selectList("Order.OrderList");
   }
   
   @Override
   public int updateState(OrderDTO orderDTO) {
   	// TODO Auto-generated method stub
   	return sqlSession.update("Order.UpdateState", orderDTO);
   }
   
   @Override
   public int getOrderPrice(String date) {
      // TODO Auto-generated method stub
      return sqlSession.selectOne("Order.GetOrderPrice", date);
   }

   @Override
   public int getOrderCount(String date) {
      // TODO Auto-generated method stub
      return sqlSession.selectOne("Order.GetOrderCount", date);
   }
   
   @Override
   public int OrderSeqCount(String od_id) {
      // TODO Auto-generated method stub
      return sqlSession.selectOne("Order.OrderSeqCount",od_id);
   }
   
   @Override
   // 주문번호로 해당 Seq가져오기
   public OrderSequenceDTO getSeqDTO(String od_id) {
      // TODO Auto-generated method stub
      return sqlSession.selectOne("Order.OrderSequenceDTO",od_id);
   }
}