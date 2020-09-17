package kr.co.Board;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO boardDAO;

	// 게시판 글 전체 목록 보기
	@Override
	public List<BoardDTO> boardList() {
		return boardDAO.boardList();
	}
	// 공지사항 게시판 글 전체 목록 보기
	@Override
	public List<BoardDTO> noticeList(Criteria criteria) {
		return boardDAO.noticeList(criteria);
	}
	//관리자 페이지 게시판 리스트
	@Override
	public List<BoardDTO> adminQna() {
		return boardDAO.adminQna();
	}
	
	// 게시판 글 선택 조회
	@Override
	public BoardDTO getBoardDetail(int b_number) {
		return boardDAO.getBoardDetail(b_number);
	}

	// 게시판글쓰기
	@Override
	public int boardRegister(BoardDTO boardDTO) {
		return boardDAO.boardRegister(boardDTO);
	}

	// 게시글 수정
	@Override
	public void boardUpdate(BoardDTO boardDTO) {
		boardDAO.boardUpdate(boardDTO);
	}

	// 게시글 삭제
	@Override
	public void boardDelete(int b_number) {
		boardDAO.boardDelete(b_number);
	}

	// 조회수 증가
	@Override
	public void boardReadCnt(int b_number) {
		boardDAO.boardReadCnt(b_number);
	}

	////////////////////////////////////////////////////////////// 좋아요 기능

	// 좋아요 활성화
	@Override
	public void insertLike(Map<Integer, String> map) {
		boardDAO.insertLike(map);
	}

	// 좋아요 여부 확인
	@Override
	public LikeDTO getLike(LikeDTO likeDTO) {
		likeDTO = boardDAO.getLike(likeDTO);
		return likeDTO;
	}

	// 좋아요 취소
	@Override
	public void deleteLike(Map<Integer, String> map) {
		boardDAO.deleteLike(map);
	}

	// 게시판 좋아요 카운트
	@Override
	public int likeCnt(int b_number) {
		return boardDAO.likeCnt(b_number);
	}

	////////////////////// 댓글//////////////////////////////

	// 댓글조회
	@Override
	public List<BoardReplyDTO> getReply(int b_number) {
		return boardDAO.getReply(b_number);
	}

	// 댓글 작성
	@Override
	public int replyRegister(BoardReplyDTO boardReplyDTO) {
		return boardDAO.replyRegister(boardReplyDTO);
	}

	// 댓글 수정
	@Override
	public void replyUpdate(BoardReplyDTO boardReplyDTO) {
		boardDAO.replyUpdate(boardReplyDTO);
	}

	// 댓글삭제
	@Override
	public void replyDelete(int re_number) {
		boardDAO.replyDelete(re_number);
	}

	////////////// 페이징///////////////////////////////////////
	@Override
	public List<BoardDTO> listCriteria(Criteria criteria) throws Exception {
		return boardDAO.listCriteria(criteria);
	}

	@Override
	public List<BoardDTO> listPaging(int page) throws Exception {
		return boardDAO.listPaging(page);
	}

	public List<BoardDTO> listSearch(Criteria criteria) {
		return boardDAO.listSearch(criteria);
	}

	public int countSearchedBoard(Criteria criteria) {
		return boardDAO.countSearchedBoard(criteria);
	}

	@Override
	public double pdnumStar(BoardDTO boardDTO) {
		// TODO Auto-generated method stub
		return boardDAO.pdnumStar(boardDTO);
	}

	@Override
	public int countpdnum(int pd_number) {

		return boardDAO.countpdnum(pd_number);
	}

	@Override
	public List<BoardDTO> boardReviewList(int pd_number) {
		// TODO Auto-generated method stub
		return boardDAO.boardReviewList(pd_number);
	}

	// 마이페이지/////////////////////////////////////////////////
	@Override
	public List<BoardDTO> myPageBoardList(String mb_id) {
		return boardDAO.myPageBoardList(mb_id);
	}

	@Override
	public void myBoardMore(String mb_id) {
		boardDAO.myBoardMore(mb_id);
	}

	@Override
	public String boardCount(Map<String, String> map) {
		// TODO Auto-generated method stub
		return boardDAO.boardCount(map);
	}
	

	

}
