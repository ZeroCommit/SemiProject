package com.wdh.qs.model.dao;

import static com.wdh.common.JDBCTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.wdh.member.dao.MemberDao;
import com.wdh.member.vo.Member;
import com.wdh.qs.model.vo.QsComment;
import com.wdh.qs.model.vo.Question;

public class QsDao {
	public Properties sql=new Properties();
	
	public QsDao() {
		String path=QsDao.class.getResource("/sql/qs/qssql.properties").getPath();
		try {
			sql.load(new FileReader(path));
		}catch(IOException e) {
			e.printStackTrace();
		}
	}
	public List<Question> searchQs(Connection conn, int cPage, int numPerpage){
		PreparedStatement pstmt=null;;
		ResultSet rs=null;
		List<Question> result=new ArrayList();
		try {
			pstmt=conn.prepareStatement(sql.getProperty("searchQsList"));
			pstmt.setInt(1, (cPage-1)*numPerpage+1);
			pstmt.setInt(2, cPage*numPerpage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
					Question q=getQs(rs);
				q.setMember(MemberDao.getMember(rs));
				result.add(q);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return result;
	}
	public int selectQsCount(Connection conn) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("selectQsCount"));
			rs=pstmt.executeQuery();
			if(rs.next()) {
				count=rs.getInt("cnt");
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally{
			close(rs);
			close(pstmt);
		}return count;
	}
	
	public int insertQs(Connection conn, Question qs, Member m) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("insertQs"));
			pstmt.setString(1, qs.getQsTitle());
			pstmt.setString(2, qs.getQsContent());
			pstmt.setString(3, qs.getQsHeadTitle());
			pstmt.setInt(4, m.getMember_no());
			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}return result;
	}
	public Question selectQs(Connection conn, int no) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		Question qs=null;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("selectQs"));
			pstmt.setInt(1, no);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				qs=getQs(rs);
				qs.setMember(MemberDao.getMember(rs));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return qs;
	}
	public int deleteQs(Connection conn, int no) {
		PreparedStatement pstmt =null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("deleteQs"));
			pstmt.setInt(1, no);
			result=pstmt.executeUpdate();
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}return result;
	}
	
	public List<QsComment> selectQsComment(Connection conn, int no){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<QsComment> list=new ArrayList();
		try {
			pstmt=conn.prepareStatement(sql.getProperty("selectQsComment"));
			pstmt.setInt(1, no);
			rs=pstmt.executeQuery();
			while(rs.next()) list.add(getQsComment(rs));
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return list;
	}
	
	public int insertQsComment(Connection conn, QsComment qsc) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("insertQsComment"));
			pstmt.setInt(1, qsc.getQsCommentLevel());
			pstmt.setString(2, qsc.getQsCommentWriter());
			pstmt.setString(3, qsc.getQsCommentContent());
			pstmt.setInt(4, qsc.getQsRef());
//			pstmt.setString(5, qsc.getQsCommentRef()==0? null:String.valueOf(qsc.getQsCommentRef()));
			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}return result;
	}
	public int updateQsResult(Connection conn, int qsNo) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("updateQsResult"));
			pstmt.setInt(1, qsNo);
			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}return result;
	}
	public int deleteQsc(Connection conn, QsComment qsc) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("deleteQsc"));
			pstmt.setInt(1, qsc.getQsCommentNo());
			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}return result;
	}
	
	
	private QsComment getQsComment(ResultSet rs) throws SQLException{
		return QsComment.builder()
				.qsCommentNo(rs.getInt("qs_comment_no"))
				.qsCommentLevel(rs.getInt("qs_comment_level"))
				.qsCommentWriter(rs.getString("qs_comment_writer"))
				.qsCommentContent(rs.getString("qs_comment_content"))
				.qsRef(rs.getInt("qs_ref"))
//				.qsCommentRef(rs.getInt("qs_comment_ref"))
				.qsCommentDate(rs.getDate("qs_comment_date"))
				.build();
	}
	
	
	
	public static Question getQs(ResultSet rs) throws SQLException{
		return Question.builder()
				.qsNo(rs.getInt("qs_no"))
				.qsTitle(rs.getString("qs_title"))
				.qsContent(rs.getString("qs_content"))
				.qsDate(rs.getDate("qs_date"))
				.qsHeadTitle(rs.getString("qs_headtitle"))
				.qsResult(rs.getString("qs_result").charAt(0))
				.memberNo(rs.getInt("member_no"))
				.build();
	}
	
}