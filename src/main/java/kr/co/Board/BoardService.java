package kr.co.Board;

import java.util.List;
import java.util.Map;

import kr.co.Board.BoardDTO;

public interface BoardService {
	// 게시글 전체 출력
	public List<BoardDTO> boardList();
	
	//공지사항 전체 게시판
	public List<BoardDTO> noticeList(Criteria criteria);
	
	//관리자 페이지  게시판
	public List<BoardDTO> adminQna();
	
	// 게시글 선택 조회
	public BoardDTO getBoardDetail(int b_number);

	// 게시판 글 쓰기
	public int boardRegister(BoardDTO boardDTO);

	// 게시판 글 수정
	public void boardUpdate(BoardDTO boardDTO);

	// 게시판 글 삭제
	public void boardDelete(int b_number);

	// 게시판 조회수 증가
	public void boardReadCnt(int b_number);

	// 게시판 좋아요 여부 확인
	public LikeDTO getLike(LikeDTO likeDTO);

	// 좋아요 데이터 추가
	public void insertLike(Map<Integer, String> map);

	// 좋아요 데이터 삭제
	public void deleteLike(Map<Integer, String> map);

	// 게시판 좋아요 카운트
	public int likeCnt(int b_number);

	/////////// 댓글//////////////////////////////////////
	// 댓글 조회
	public List<BoardReplyDTO> getReply(int b_number);

	// 댓글 작성
	public int replyRegister(BoardReplyDTO boardReplyDTO);

	// 댓글 수정
	public void replyUpdate(BoardReplyDTO boardReplyDTO);

	// 댓글 삭제
	public void replyDelete(int re_number);

	// 페이징/////////////////////////////////////////////
	public List<BoardDTO> listCriteria(Criteria criteria) throws Exception;

	public List<BoardDTO> listPaging(int page) throws Exception;

	////////////////// 검색

	public List<BoardDTO> listSearch(Criteria criteria);

	public int countSearchedBoard(Criteria criteria);

	// 해당 상품에 대한 별점 총점 평균 반올림
	public double pdnumStar(BoardDTO boardDTO);

	public int countpdnum(int pd_number);

	// productDetail.jsp의 탭에 구매후기를 띄우기 위한 메소드
	public List<BoardDTO> boardReviewList(int pd_number);

	// 게시판 디테일 선택 조회
	public List<BoardDTO> myPageBoardList(String mb_id);

	// mypage 게시글 더보기
	public void myBoardMore(String mb_id);

	////// admin////////////////////////////////////////
	// 게시판 갯수 출력
	public String boardCount(Map<String, String> map);
}
