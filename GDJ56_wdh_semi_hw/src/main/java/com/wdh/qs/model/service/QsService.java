package com.wdh.qs.model.service;

import static com.wdh.common.JDBCTemplate.close;
import static com.wdh.common.JDBCTemplate.commit;
import static com.wdh.common.JDBCTemplate.getConnection;
import static com.wdh.common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import com.wdh.member.vo.Member;
import com.wdh.qs.model.dao.QsDao;
import com.wdh.qs.model.vo.QsComment;
import com.wdh.qs.model.vo.Question;

public class QsService {
	private QsDao dao=new QsDao();
	
	public List<Question> searchQs(int cPage, int numPerpage){
		Connection conn=getConnection();
		List<Question> result=dao.searchQs(conn,cPage,numPerpage);
		close(conn);
		return result;
	}
	public int selectQsCount() {
		Connection conn=getConnection();
		int result=dao.selectQsCount(conn);
		close(conn);
		return result;
	}
	public Question selectQs(int no) {
		Connection conn=getConnection();
		Question qs=dao.selectQs(conn, no);
		close(conn);
		return qs;
	}
	public int insertQs(Question qs, Member m) {
		Connection conn=getConnection();
		int result=dao.insertQs(conn, qs, m);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
		}
	public int deleteQs(int no) {
		Connection conn=getConnection();
		int result=dao.deleteQs(conn,no);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	public List<QsComment> selectQsComment(int qsNo){
		Connection conn=getConnection();
		List<QsComment> list=dao.selectQsComment(conn,qsNo);
		close(conn);
		return list;
	}
	public int insertQsComment(QsComment qsc) {
		Connection conn=getConnection();
		int result=dao.insertQsComment(conn,qsc);
		if(result>0) {
			result=dao.updateQsResult(conn, qsc.getQsRef());
			if(result>0) commit(conn);
			else rollback(conn);
		}
		close(conn);
		return result;
	}
	public int deleteQsc(QsComment qsc) {
		Connection conn=getConnection();
		int result=dao.deleteQsc(conn,qsc);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
}
