package kr.co.Member;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService{

	@Inject
	private MemberDAO memberDAO;
	
	// 로그인
	@Override
	public Map<String, String> login(Map<String, String> map) {
		// TODO Auto-generated method stub
		return memberDAO.login(map);
	}

	// 전체 회원 보기
	@Override
	public List<MemberDTO> memberList() {
		// TODO Auto-generated method stub
		return memberDAO.memberList();
	}

	// 회원 추가
	@Override
	public int memberInsert(MemberDTO memberDTO) {
		// TODO Auto-generated method stub
		return memberDAO.memberInsert(memberDTO);
	}

	// 아이디 유효성 검사
	@Override
	public int idChecking(String mb_id) {
		// TODO Auto-generated method stub
		return memberDAO.idChecking(mb_id);
	}
	
	// 회원 정보 디테일
	@Override
	public MemberDTO getMember(int mb_number) {
		// TODO Auto-generated method stub
		return memberDAO.getMember(mb_number);
	}

	// 회원 정보 수정
	@Override
	public int memberUpdate(MemberDTO memberDTO) {
		// TODO Auto-generated method stub
		return memberDAO.memberUpdate(memberDTO);
	}
	
	// 이메일 중복 검사
	@Override
	public int emailChecking(String mb_email) {
		// TODO Auto-generated method stub
		return memberDAO.emailChecking(mb_email);
	}

	// 회원 탈퇴
	@Override
	public int memberDelete(int mb_number) {
		// TODO Auto-generated method stub
		return memberDAO.memberDelete(mb_number);
	}

	// 해당 회원 번호, 비밀번호 일치 여부
	@Override
	public int pwChecking(MemberDTO memberDTO) {
		// TODO Auto-generated method stub
		return memberDAO.pwChecking(memberDTO);
	}

	// 관리자로 회원 삭제
	@Override
	public int adminDelete(MemberDTO memberDTO) {
		// TODO Auto-generated method stub
		return memberDAO.adminDelete(memberDTO);
	}
	
	@Override
   public String findIdByEmail(MemberDTO memberDTO) {
      // TODO Auto-generated method stub
      return memberDAO.findIdByEmail(memberDTO);
   }

   @Override
   public int newPw(MemberDTO memberDTO) {
      // TODO Auto-generated method stub
      return memberDAO.newPw(memberDTO);
   }
   
   @Override
   public int getMemberCount() {
      // TODO Auto-generated method stub
      return memberDAO.getMemberCount();
   }
   
   @Override
   public int getSignUpCount(String today) {
      // TODO Auto-generated method stub
      return memberDAO.getSignUpCount(today);
   }
}

