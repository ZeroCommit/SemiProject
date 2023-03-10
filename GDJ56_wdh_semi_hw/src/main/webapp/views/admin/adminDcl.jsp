<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.wdh.del.model.vo.Declaration" %>
    
    
<%
	List<Declaration> declaration=(List<Declaration>)request.getAttribute("declaration");
%>    

<%@ include file="/views/common/adminHeader.jsp" %>

	<style>
        #test_btn1{
            border-top-left-radius: 5px;
            border-bottom-left-radius: 5px;
            /* margin-right:-4px; */
        }
        #test_btn2{
            border-top-right-radius: 5px;
            border-bottom-right-radius: 5px;    
            /* margin-left:-3px; */
        }
        #btn_group button{
            border: 1px solid skyblue;
            background-color: rgba(0,0,0,0);
            color: skyblue;
            padding: 5px;
        }
        #btn_group button:hover{
            color:white;
            background-color: cornflowerblue;
        }
    </style>

				<div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">신고 접수 관리</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">신고가 접수된 글을 관리 합니다.</li>
                        </ol>

                       <hr class="one"> 
                       <hr class="one">

                        <div class="row">
                            
                        <section id="board-container">
			            <table id="datatablesSimple">
			            <thead>
			                <tr>
			                    <th>번호</th>
			                    <th>말머리</th>
			                    <th>제목</th>
			                    <th>작성자</th>
			                    <th>작성일</th>
			                    <th>첨부파일</th>
			                    <th>처리</th>
			                    <th>답변</th>
			                    <th>삭제</th>
			                </tr>
			                </thead>
							<% if(declaration.isEmpty()){ %>
							<tr>
								<td colspan="9"><h3>조회된 게시판이 없습니다.</h3></td>
							</tr>	
							<%}else{ 
								for(Declaration d : declaration){
							%>
							 <tr>
                				<td><%=d.getDclNo() %></td>
                				<td><%=d.getDclHeadTitle() %></td>
	                			<td><a href="<%=request.getContextPath()%>/cs/dclView.do?dclNo=<%=d.getDclNo()%>"><%=d.getDclTitle()%></a></td>
		                		<td><%=d.getMember().getMember_id() %></td>
		                		<td><%=d.getDclDate() %></td>
		                		<td>
		                       		<%if(d.getFilePath()!=null){ %>
                						<img src="<%=request.getContextPath() %>/images/file.png" width="20" height="20">
                					<%}else{ %>
                						첨부파일 없음
                					<%} %>
                				</td>
		                		<td><%=d.getDclResult() %></td>
		                		<td><input type="button" value="답변" onclick="location.replace('<%=request.getContextPath()%>/cs/dclView.do?dclNo=<%=d.getDclNo()%>')"></td>
		                		<td><input type="button" value="삭제" onclick="fn_deleteDcl(<%=d.getDclNo()%>,'<%=d.getFilePath()%>');"></td>
		                		<%} 
               	 			}%>
                			</tr>	
                			</table>
                			<br>
			            </section>
			            <br>
			        </div>
  <script>
    	const fn_deleteDcl=(dclNo,fileName)=>{
    		//삭제하기 스크립트
    		location.replace("<%=request.getContextPath()%>/cs/deleteDcl.do?no="+dclNo+"&fileName="+fileName);
    	}
    </script>