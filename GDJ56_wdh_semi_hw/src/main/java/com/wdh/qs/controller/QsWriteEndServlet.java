package com.wdh.qs.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wdh.member.service.MemberService;
import com.wdh.member.vo.Member;
import com.wdh.qs.model.service.QsService;
import com.wdh.qs.model.vo.Question;

/**
 * Servlet implementation class QsWriteEndServlet
 */
@WebServlet("/cs/writeEndQs.do")
public class QsWriteEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    //1대1문의글 작성하기 서블릿   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QsWriteEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String title=request.getParameter("qs_title");
		String content=request.getParameter("qs_content");
		String headTitle=request.getParameter("qs_headtitle");
		
		Question qs=Question.builder()
				.qsTitle(title)
				.qsContent(content)
				.qsHeadTitle(headTitle)
				.build();
		
		//세션을 가져옴
		String id=((Member)request.getSession().getAttribute("loginMember")).getMember_id();
		Member m=new MemberService().memberView(id);
		
		int result=new QsService().insertQs(qs, m);
		String msg="",loc="";
		if(result>0) {
			msg="1대1문의글 작성 성공";
			loc="/cs/qsAlert.do";
			//문의 글 작성 성공 시 넘어갈 jsp 생성
		}else {
			msg="1대1문의글 작성 실패";
			loc="/cs/writeQs.do";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		request.getRequestDispatcher("/views/common/msgm.jsp").forward(request, response);
	
	
	
	
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
