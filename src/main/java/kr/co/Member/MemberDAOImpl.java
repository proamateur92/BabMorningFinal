package kr.co.Member;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAOImpl implements MemberDAO{

	@Inject
	private SqlSession sqlSession;
	
	//로그인
	@Override
	public Map<String, String> login(Map<String, String> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("Member.login", map);
	}
		
	//회원전체 보기
	@Override
	public List<MemberDTO> memberList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("Member.memberList");
	}

	//회원 추가	
	@Override
	public int memberInsert(MemberDTO memberDTO) {
		// TODO Auto-generated method stub
		return sqlSession.insert("Member.insert", memberDTO);
	}

	// 아이디 중복 확인
	@Override
	public int idChecking(String mb_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("Member.idChecking", mb_id);
	}

	// 회원 정보 디테일
	@Override
	public MemberDTO getMember(int mb_number) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("Member.getMember", mb_number);
	}
	
	// 회원 정보 수정
	@Override
	public int memberUpdate(MemberDTO memberDTO) {
		// TODO Auto-generated method stub
		return sqlSession.update("Member.update", memberDTO);
	}
	
	// 이메일 중복확인
	@Override
	public int emailChecking(String mb_email) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("Member.emailChecking", mb_email);
	}

	// 회원 탈퇴
	@Override
	public int memberDelete(int mb_number) {
		// TODO Auto-generated method stub
		return sqlSession.update("Member.delete", mb_number);
	}

	// 비밀번호 체크
	@Override
	public int pwChecking(MemberDTO memberDTO) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("Member.pwChecking", memberDTO);
	}

	// 관리자로 회원 탈퇴
	@Override
	public int adminDelete(MemberDTO memberDTO) {
		// TODO Auto-generated method stub
		return sqlSession.update("Member.adminDelete", memberDTO);
	}
	
	@Override
	public String findIdByEmail(MemberDTO memberDTO) {
      // TODO Auto-generated method stub
      return sqlSession.selectOne("Member.findIdByEmail", memberDTO);
   }

	@Override
   	public int newPw(MemberDTO memberDTO) {
      // TODO Auto-generated method stub
      return sqlSession.update("Member.newPw", memberDTO);
   }
	
	@Override
	   public int getMemberCount() {
	      // TODO Auto-generated method stub
	      return sqlSession.selectOne("Member.getMemberCount");
	   }

	   @Override
	   public int getSignUpCount(String today) {
	      // TODO Auto-generated method stub
	      return sqlSession.selectOne("Member.getSignUpCount", today);
	   }

}
