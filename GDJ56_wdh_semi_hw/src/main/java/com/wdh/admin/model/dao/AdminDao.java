package com.wdh.admin.model.dao;

import static com.wdh.common.JDBCTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import com.wdh.challenge.model.vo.Challenge;
import com.wdh.member.vo.Member;

public class AdminDao {
	
	private Properties sql=new Properties();
	
	public AdminDao() {
		String path=AdminDao.class.getResource("/sql/admin/admin_sql.properties")
				.getPath();
		try {
			sql.load(new FileReader(path));
		}catch(IOException e) {
			e.printStackTrace();
		}
	}
	
	public List<Member> searchMemberList(Connection conn){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Member> result=new ArrayList();
		
		try {
			pstmt=conn.prepareStatement(sql.getProperty("searchMemberList"));
			rs=pstmt.executeQuery();
			while(rs.next()) {
				result.add(AdminDao.getMember(rs));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return result;
	}
	
	public List<Member> adminMemberList(Connection conn) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Member> result=new ArrayList();
		//System.out.println("테스트 : " + sql.getProperty("adminMemberList"));
		try {
			pstmt=conn.prepareStatement(sql.getProperty("adminMemberList"));
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				result.add(AdminDao.getMember(rs));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return result;
	}
	
	
	
	
	
	public int selectMemberCount(Connection conn) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("selectMemberCount"));
			rs=pstmt.executeQuery();
			if(rs.next()) count=rs.getInt(1);//rs.getInt("cnt");
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return count;
	}
	
	
	
	public int selectMemberCount(Connection conn, String type, 
			String keyword) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int result=0;
		String query=sql.getProperty("selectMemberCountKeyword");
		query=query.replace("$COL", type);
		try {
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1,"%"+keyword+"%");
			rs=pstmt.executeQuery();
			if(rs.next()) result=rs.getInt(1);
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return result;
	}
	

	public int insertChallenge(Connection conn, Map<String,Object> param) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("insertChallenge"));
			pstmt.setInt(1, (Integer)param.get("challengeNo"));
			pstmt.setString(2, (String)param.get("fileName"));
			pstmt.setInt(3, (Integer)param.get("day"));
			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}return result;
	}
	
	
	public int deleteMember(Connection conn, int memberNo) {
		PreparedStatement pstmt=null;
		int result=0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("deleteMember"));
			pstmt.setInt(1, memberNo);
			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}return result;
		
	}
	
	public static Member getMember(ResultSet rs) throws SQLException {
		Member m = new Member();
		
		m.setMember_no(rs.getInt("MEMBER_NO"));
		m.setMember_id(rs.getString("MEMBER_ID"));
		m.setMember_nickname(rs.getString("MEMBER_NICKNAME"));
		m.setName(rs.getString("MEMBER_NAME"));
		m.setPassword(rs.getString("MEMBER_PASSWORD"));
		m.setGender(rs.getString("GENDER").charAt(0));
		m.setBirth(rs.getDate("BIRTH"));
		m.setEmail(rs.getString("EMAIL"));
		m.setPhone(rs.getString("PHONE"));
		m.setAddress(rs.getString("ADDRESS"));
		m.setGrade(rs.getInt("GRADE"));
		return m;
	}
	
	public List<Member> challengeAttanceMember(Connection conn, int no){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Member> result=new ArrayList();
		try {
			pstmt=conn.prepareStatement(sql.getProperty("challengeAttanceMember"));
			rs=pstmt.executeQuery();
			while(rs.next()) {
				result.add(AdminDao.getMember(rs));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}return result;
	}

	

	
	
	
	
}
