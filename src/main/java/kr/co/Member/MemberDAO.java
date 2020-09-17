package kr.co.Member;

import java.util.List;
import java.util.Map;

public interface MemberDAO {
	
	// 로그인
	public Map<String, String> login(Map<String, String> map);

	// 전체 회원 조회
	public List<MemberDTO> memberList();
	
	// 회원 추가
	public int memberInsert(MemberDTO memberDTO);

	// 유효성 검사
	public int idChecking(String mb_id);
	
	// 회원 정보 디테일
	public MemberDTO getMember(int mb_number);
	
	// 회원 정보 수정
	public int memberUpdate(MemberDTO memberDTO);

	// 이메일 중복 검사
	public int emailChecking(String mb_email);
	
	// 회원 탈퇴
	public int memberDelete(int mb_number);
	
	// 해당 회원 번호, 비밀번호 일치 여부
	public int pwChecking(MemberDTO memberDTO);
	
	// 관리자로 회원 삭제
	public int adminDelete(MemberDTO memberDTO);
	
	// 이메일로 아이디 찾기
   public String findIdByEmail(MemberDTO memberDTO);

   // 전화번호로 비밀번호 찾기
   public int newPw(MemberDTO memberDTO);
   
 //총 회원수 구하기
   public int getMemberCount();
   
   //오늘 회원가입한 회원수 구하기
   public int getSignUpCount(String today);
   
   
}
