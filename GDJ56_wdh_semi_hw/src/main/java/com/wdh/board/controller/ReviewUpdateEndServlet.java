package com.wdh.board.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.wdh.board.service.BoardService1;
import com.wdh.board.service.BoardService2;
import com.wdh.board.vo.Board;
import com.wdh.board.vo.ReviewBoard;

/**
 * Servlet implementation class ReviewUpdateEndServlet
 */
@WebServlet("/board/reviewupdateend.do")
public class ReviewUpdateEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewUpdateEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String oriImg=request.getParameter("oriFile"); //기존 이미지
		
		//파일업로드
		if(!ServletFileUpload.isMultipartContent(request)) {
			response.sendRedirect(request.getContextPath());
		}else {
			String path=request.getServletContext().getRealPath("/reviewImg");
			MultipartRequest mr=new MultipartRequest(request,path,1024*1024*10,"UTF-8",new DefaultFileRenamePolicy());
			String img=mr.getFilesystemName("reviewImg"); //새로운 이미지

			System.out.println("oriImg : " + oriImg);
			System.out.println("img : " + img);

			//oriFile 값을 추가로 첨기고, img 값이 null이라면 ReviewBoard.builder 에 img 값을 oriImg값으로 넣고, 아니라면 img 값을 넣으면 된다
			String insertImg = "";
			if(img == null || img.isEmpty()) {
				insertImg = oriImg;
			} else {
				insertImg = img;
			}
			
			int memberNo=Integer.parseInt(mr.getParameter("memberNo"));
			int boardNo=Integer.parseInt(mr.getParameter("boardNo"));
			String title=mr.getParameter("review_title");
			String content=mr.getParameter("review_content");
			double grade=(Integer.parseInt(mr.getParameter("grade")))/6.0;
			System.out.println(grade);
			int reviewNo=Integer.parseInt(mr.getParameter("reviewNo"));
			
//			ReviewBoard rb=ReviewBoard.builder().reviewTitle(title).reviewContent(content).reviewScore(grade).reviewSeq(reviewNo).img(img).build();
			ReviewBoard rb=ReviewBoard.builder().reviewTitle(title).reviewContent(content).reviewScore(grade).reviewSeq(reviewNo).img(insertImg).build();
			//System.out.println(rb);
			int result=new BoardService1().updateReview(rb);
	
			String msg="", loc="/board/wdjoinlist.do?memberNo="+memberNo+"&boardNo="+boardNo;
			if(result>0) {
				msg="수정성공!";
				//사진을 업로드 하지 않으면 사진이 삭제가 되지 않아야 하므로 img 값이 비어있지 않았을 경우가 업로드 하지 않은 조건값이니, 아래 조건으로 이미지 삭제여부 파악
				if(img != null && !img.isEmpty()) {
					String deletePath=getServletContext().getRealPath("/reviewImg/");
					File delFile=new File(deletePath+oriImg);
					if(delFile.exists()) delFile.delete();				
				}
			}else {
				msg="수정 실패!";
			}
			request.setAttribute("msg", msg);
			request.setAttribute("loc", loc);
			request.getRequestDispatcher("/views/common/msgch.jsp").forward(request, response);
			
			//회원레벨
			Board b=new BoardService2().selectBoard(boardNo);
			new BoardService1().updateGrade(b);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
