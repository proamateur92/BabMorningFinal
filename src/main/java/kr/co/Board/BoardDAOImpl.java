package kr.co.Board;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Inject
	private SqlSession sqlSession;

	// Q&A게시판 전체 목록 조회
	@Override
	public List<BoardDTO> boardList() {
		return sqlSession.selectList("Board.boardList");
	}
	//공지사항 전체 리스트
	@Override
	public List<BoardDTO> noticeList(Criteria criteria) {
		return sqlSession.selectList("Board.noticeList", criteria);
	}
	//관리자 페이지 게시판
	@Override
	public List<BoardDTO> adminQna() {
		return sqlSession.selectList("Board.adminQna");
	}
	
	// 게시판 선택 조회
	@Override
	public BoardDTO getBoardDetail(int b_number) {
		return sqlSession.selectOne("Board.getDetail", b_number);
	}

	// 게시판 글쓰기
	@Override
	public int boardRegister(BoardDTO boardDTO) {
		return sqlSession.insert("Board.register", boardDTO);
	}

	// 게시판 글 수정
	@Override
	public void boardUpdate(BoardDTO boardDTO) {
		sqlSession.update("Board.update", boardDTO);

	}

	// 게시판 글 삭제
	@Override
	public void boardDelete(int b_number) {
		sqlSession.update("Board.delete", b_number);
	}

	// 조회수 증가
	@Override
	public void boardReadCnt(int b_number) {
		sqlSession.update("Board.readcnt", b_number);
	}

	////////////////////////////////////////////// 좋아요 기능

	// 좋아요 데이터 추가
	@Override
	public void insertLike(Map<Integer, String> map) {
		// TODO Auto-generated method stub

		sqlSession.insert("Board.insertlike", map);
	}

	// 좋아요 여부 확인
	@Override
	public LikeDTO getLike(LikeDTO likeDTO) {

		likeDTO = sqlSession.selectOne("Board.getlike", likeDTO);
		return likeDTO;
	}

	// 좋아요 취소
	@Override
	public void deleteLike(Map<Integer, String> map) {
		sqlSession.delete("Board.deletelike", map);
	}

	// 좋아요 카운트
	@Override
	public int likeCnt(int b_number) {
		return sqlSession.selectOne("Board.likecnt", b_number);
	}
	///////////////// 댓글////////////////////////////

	// 댓글 조회
	@Override
	public List<BoardReplyDTO> getReply(int b_number) {
		return sqlSession.selectList("Board.getreply", b_number);
	}

	// 댓글 쓰기
	@Override
	public int replyRegister(BoardReplyDTO boardReplyDTO) {
		return sqlSession.insert("Board.replyregister", boardReplyDTO);
	}

	// 댓글 수정
	@Override
	public void replyUpdate(BoardReplyDTO boardReplyDTO) {
		sqlSession.update("Board.replyupdate", boardReplyDTO);
	}

	// 댓글 삭제
	@Override
	public void replyDelete(int re_number) {
		sqlSession.delete("Board.replydelete", re_number);
	}

	///////// 페이징/////////////////////////////////////
	@Override
	public List<BoardDTO> listCriteria(Criteria criteria) throws Exception {
		return sqlSession.selectList("Board.listCriteria", criteria);
	}

	@Override
	public List<BoardDTO> listPaging(int page) throws Exception {
		if (page <= 0) {
			page = 1;
		}

		page = (page - 1) * 10;

		return sqlSession.selectList("Board.listPaging", page);
	}

	//////////////////////////////// 검색
	@Override
	public List<BoardDTO> listSearch(Criteria criteria) {
		return sqlSession.selectList("Board.listSearch", criteria);
	}

	@Override
	public int countSearchedBoard(Criteria criteria) {

		return sqlSession.selectOne("Board.countSearchedArticles", criteria);
	}

	// 별점
	@Override
	public double pdnumStar(BoardDTO boardDTO) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("Board.pdnumStar", boardDTO);
	}

	@Override
	public int countpdnum(int pd_number) {

		return sqlSession.selectOne("Board.countpdnum", pd_number);
	}

	@Override
	public List<BoardDTO> boardReviewList(int pd_number) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("Board.boardReviewList", pd_number);
	}

	// 마이페이지//////////////////////////////
	@Override
	public List<BoardDTO> myPageBoardList(String mb_id) {
		return sqlSession.selectList("Board.myPageBoardList", mb_id);
	}

	@Override
	public void myBoardMore(String mb_id) {
		sqlSession.update("myBoardMore", mb_id);
	}

	@Override
	public String boardCount(Map<String, String> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("Board.boardCount", map);
	}

	

	

}
