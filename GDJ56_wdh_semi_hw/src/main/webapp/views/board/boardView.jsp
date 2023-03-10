<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List,com.wdh.board.vo.*,com.wdh.member.vo.Member" %>
<%@ page import="java.util.Date" %>
<%
   Board b = (Board)request.getAttribute("board");
   List<BoardComment> comments = (List<BoardComment>)request.getAttribute("comments");
   List<ReviewBoard> reviews = (List<ReviewBoard>)request.getAttribute("reviews");
   List<WdJoin> wdJoins=(List<WdJoin>)request.getAttribute("wdJoins");
   List<WdJoin> wdJoinsW=(List<WdJoin>)request.getAttribute("boardsW");
   int result=0;
   String gender="";
%>

<%@ include file="/views/common/header.jsp" %>
<!-- innerheader에 없어서 스타일 일단 여기에 줌 -->
<!-- Load fonts style after rendering the layout styles -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/fontawesome.min.css">
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/post.css">

    <!-- Open Content -->
    <section class="bg-light">
        <div class="container pb-5">
            <div class="row">
                <div class="col-lg-7 mt-5 container py-1">
                	
                	
                    <div class="card">
                        <div class="card-body">
                        <div><h1 class="h2"><%=b.getWdTitle() %></h1></div>
                        <div class="star">
                             <%int scoreSum=0; %>
                            <!-- 후기 별점 모두 더하기 -->
                            <%for(ReviewBoard rb : reviews){ 
                            	scoreSum+=rb.getReviewScore();
                            }
                            if(scoreSum!=0){             
	                            for(int i=1;i<6;i++){
	                            	if(scoreSum/(reviews.size())>=i){%>
	                            		<i class="fa fa-star text-warning"></i>
	                            	<%}else{ %>
	                            		<i class="fa fa-star text-secondary"></i>
	                            	<%} 
	                            }
                            }%>  
                        </div>    
                        <div id="memberNic"><span class="list-inline-item text-dark"><%=b.getMember().getMember_nickname()%>(<%=b.getMember().getMember_id() %>) | <%=b.getWdTime() %></span></div>                   
                        <div class="select">
                        	<h6 class="text-muted"><strong>종목 - <%=b.getWdCategory() %></strong></h6>
                           <h6 class="text-muted"><strong>모임날짜 - <%=b.getWdDate() %></strong></h6>
                           <h6 class="text-muted"><strong>지역 - <%=b.getWdLocation() %></strong></h6>
                           <h6 class="text-muted"><strong>성별 - 
                            <%if(b.getWdGender().equals("F")) gender="여";
                              else if(b.getWdGender().equals("M")) gender="남";
                              else gender="무관";%>
                              <%=gender %>
                           </strong></h6>
                           <h6 class="text-muted"><strong>모집인원 - <%=b.getWdCount() %></strong></h6>
                           <h6 class="text-muted"><strong>목적 - <%=b.getWdPurpose() %></strong></h6>
                        </div>
                            <p class="content"><%=b.getWdContent() %></p>

                            <form action="" method="GET" id="">
                                <input type="hidden" name="product-title" value="Activewear">
                                    <div class="col-auto">
                                        <ul class="list-inline pb-3">
                                            <li class="list-inline-item text-right">
                                                <input type="hidden" name="product-quanity" id="product-quanity" value="1">
                                            </li>
                                            <%for(WdJoin wj : wdJoins) {
                                               if(wj.getWdNo()==b.getWdNo()) {
                                                  result=1;
                                               }
                                            }%>   
                                            <%for(WdJoin wj : wdJoins) {
                                               if(wj.getWdNo()==b.getWdNo()) {
                                                  result=1;
                                               }
                                            }%>   
                                          <% Date dt=new Date(); 
                                              long timeInMilliSeconds=dt.getTime();
                                             java.sql.Date sqlDate=new java.sql.Date(timeInMilliSeconds); //util -> sql변환 
                                             System.out.println(b.getWdDate().after(sqlDate)); //날짜비교(오늘이 bDate이후이면 true반환)%>                         
                                          <div class="joinCount"><li class="list-inline-item"><span class="badge bg-secondary" id="var-value">참여현황 : <%=wdJoinsW.size() %> / <%=b.getWdCount() %></span></li></div>
                                 <li class="list-inline-item"><span class="btn btn-success"
                                 onclick="window.open('<%=request.getContextPath() %>/board/wdjoinlistopen.do?memberNo=<%=loginMember.getMember_no()%>&wdNo=<%=b.getWdNo()%>','joinList','width=350, height=500');">참가리스트</span></li>
                                 <!-- 참가/날짜마감전(참가한 사람이 날짜 마감 전엔 취소할 수 있어야함) -->
                                 <%if(result==1 &&b.getWdDate().after(sqlDate)){ %>
                                             <li class="list-inline-item"><span class="btn btn-success" id="btn-minus"
                                    onclick="location.href='<%=request.getContextPath()%>/board/wdcancel.do?memberNo=<%=loginMember.getMember_no()%>&wdNo=<%=b.getWdNo()%>';">참가취소</span></li>
                                 <!-- 미참가/인원마감전/날짜마감전 -->
                                          <%}else if(result==0&&wdJoinsW.size()<b.getWdCount()&&b.getWdDate().after(sqlDate)){ %>
                                             <li class="list-inline-item"><span class="btn btn-success" id="btn-plus" 
                                    onclick="location.href='<%=request.getContextPath()%>/board/wdjoin.do?memberNo=<%=loginMember.getMember_no()%>&wdNo=<%=b.getWdNo()%>';">참가하기</span></li>
                                 <!-- 이외(마감) -->
                                 <%}else{ %>
                                    <li class="list-inline-item"><span class="btn btn-success">동행마감</span></li>
                                          <%} %>
	                                 			
                                        </ul>
                                    </div>
                              </form>

                        </div>                    
                    </div>           
                </div>
                <%if(loginMember.getMember_no()==b.getMemberNo()) {%>
			         <div style="text-align:center;">
			            <input type="button" id="button1" name="update" value="수정" onclick="location.href='<%=request.getContextPath()%>/board/boardupdate.do?boardNo=<%=b.getWdNo()%>';">
			            <input type="button" id="button1" name="delete" value="삭제" onclick="delete1()">
						<input type="hidden" name="delete" onclick="location.href='<%=request.getContextPath()%>/board/boarddelete.do?wd_no=<%=b.getWdNo()%>';">
			         </div>  
			    <%} %>
			    
			    <script>
			    	const delete1=()=> {
			    		if(confirm("삭제하시겠습니까?")==true){
			    			//확인버튼 누르면 hidden된 주소 이동시켜주는 input 실행시켜주기 (다른방법?)
			    			document.getElementsByName("delete")[1].click();
			    		}
			    	}
			    </script>

            </div>
        </div>
    </section>
    <!-- Close Content -->

    <!-- 댓글&작성자후기 중 택1 -->     
    <div class="card-body">
    	<div class="col-lg-7 mt-5 container py-1">
    		<div class="row pb-3">
    		<div class="col d-grid">
    			<a class="btn btn-success btn-lg" href="#boardView_c1" id="boardView_c1">댓글보기</a>
    			<!-- <button type="submit" class="btn btn-success btn-lg" name="submit" value="boardView_c1" onclick="change();">댓글보기</button> -->
            </div>
        	<div class="col d-grid">
        		<a class="btn btn-success btn-lg" href="#boardView_c2">작성자후기보기</a>
            </div>
    	</div>
    	</div>
     </div>
     
     <%-- <%@ include file="/views/board/boardView_c1.jsp" %> --%>
    
    <div class="col-lg-7 mt-5 container py-1">                            
	<!-- 댓글&작성자후기 중 댓글 -->                        
    <section class="py-5">
        <div class="container">
            <!-- <div class="row text-left p-2 pb-3">
                <h4 id="boardView_c1">댓글</h4>
            </div> -->

			<!--Start comment_댓글작성-->
            <div id="comment-container">
            
		   		<div class="comment-editor" id="comment-editor">
		   			<form action="<%=request.getContextPath() %>/board/commentWrite.do?memberNo=<%=loginMember.getMember_no()%>&boardNo=<%=b.getWdNo()%>" method="post">
		   				<div class="input-group mb-2">
	                    	<textarea class="form-control" name="content" placeholder="Message" rows="2" style="margin-left: 50px"></textarea>
	                    
			   				<input type="hidden" name="boardref" value="<%=b.getWdNo() %>">
			   				<input type="hidden" name="level" value="1"/>
			   				<input type="hidden" name="commentref" value="0"/>
			   				<input type="hidden" name="commentWriter" value="<%=loginMember!=null?loginMember.getMember_no():""%>"> <!-- getMember_id->getMember_no로변경 -->
			   				<button	type="submit" id="btn-insert" class="input-group-text">댓글달기</button>
			   			</div>
		   			</form>
		   		</div>
		   		
			   	
			   		<table id="tbl-comment">
				   			<%if(comments.isEmpty()){ %>
				   				<h6 style="margin-left:500px;">아직 작성된 댓글이 없습니다</h6>
				   				
					   		<%} else {
					   			for(BoardComment bc : comments){
					   				if(bc.getWdCommentLev()==1){%>
					   				<tr class="level1">
					   					<td>
					   						<sub class="comment-writer"><%=bc.getMember().getMember_nickname()%>(<%=bc.getMember().getMember_id() %>)</sub>
					   						<sub class="comment-date"><%=bc.getWcDate() %>게시시간</sub>
					   						<br>
					   						<%=bc.getWcContent() %>
					   					</td>
					   					<td>
					   						<form id="commentDmlFrm" action="<%=request.getContextPath() %>/board/commentDelete.do?memberNo=<%=loginMember.getMember_no()%>&boardNo=<%=b.getWdNo()%>" method="post">
						   						<%if(loginMember!=null&&
										   							(loginMember.getMember_id().equals("admin")||
										   							loginMember.getMember_no()==bc.getMemberNo())) {%>
										   				<input type="hidden" name="boardcomment" value="<%=bc.getCommentNo()%>">
										   				<input type="hidden" name="boardref" value="<%=b.getWdNo() %>">
<!-- 여기	 -->				   							<button	type="submit" class="btn-delete input-group-text btn-insert2" value="<%=bc.getCommentNo()%>">삭제</button> <!-- 댓글의 PK를 넘겨줘야함 -->
						   							<!-- <input type="button" value="삭제" onclick="fn_deleteMember();"/> -->
						   						<%} %>
					   						</form>
					   						<%if(loginMember!=null){ %>
					   							<button class="btn-reply input-group-text btn-insert2" value="<%=bc.getCommentNo() %>">답글</button> <!-- 댓글의 PK를 넘겨줘야함 -->
					   						<%} %>
					   					</td>
					   				</tr>
					   			<%} else{%>
					   				<tr class="level2">
					   					<td>
					   						<sub class="comment-writer"><%=bc.getMember().getMember_nickname()%>(<%=bc.getMember().getMember_id() %>)</sub>
					   						<sub class="comment-date"><%=bc.getWcDate() %>게시시간</sub>
					   						<br>
					   						<%=bc.getWcContent() %>
					   					</td>
					   					
					   					
					   					<!-- 리댓 삭제 -->
					   					<td>
					   						<form id="commentDmlFrm" action="<%=request.getContextPath() %>/board/commentDelete.do?memberNo=<%=loginMember.getMember_no()%>&boardNo=<%=b.getWdNo()%>" method="post">
						   						<%if(loginMember!=null&&
										   							(loginMember.getMember_id().equals("admin")||
										   							loginMember.getMember_no()==bc.getMemberNo())) {%>
										   				<input type="hidden" name="boardcomment" value="<%=bc.getCommentNo()%>">
										   				<input type="hidden" name="boardref" value="<%=b.getWdNo() %>">
<!-- 여기	 -->				   							<button	type="submit" class="btn-delete input-group-text btn-insert2" value="<%=bc.getCommentNo()%>">삭제</button> <!-- 댓글의 PK를 넘겨줘야함 -->
						   							<!-- <input type="button" value="삭제" onclick="fn_deleteMember();"/> -->
						   						<%} %>
					   						</form>
					   						<%if(loginMember!=null){ %>
					   							<button class="btn-reply input-group-text btn-insert2" value="<%=bc.getCommentNo() %>">답글</button> <!-- 댓글의 PK를 넘겨줘야함 -->
					   						<%} %>
					   					</td>
					   					
					   					
					   					
					   				</tr>
					   			<% }
					   			}//for
				   		}//if%>
			   		</table>
<%-- 		   				<input type="hidden" name="boardref" value="<%=b.getWdNo() %>">
		   				<input type="hidden" name="level" value="1"/>
		   				<input type="hidden" name="commentref" value="0"/>
		   				<input type="hidden" name="commentWriter" value="<%=loginMember!=null?loginMember.getMember_no():""%>"> <!-- getMember_id->getMember_no로변경 --> --%>
			   		
			   	
		   	</div>
        </div>
    </section>

    <script>

    	$(() =>{
    		$(".btn-reply").click(e=>{
    			const tr=$("<tr>");
    			const form=$(".comment-editor>form").clone(); //만들어놓았던 FORM태그 생성해서 사용하기
    			form.find("textarea").attr({"rows":"1"}); //ROWS만 1로 바꾸기 
    			form.find("input[name=level]").val("2"); //VAL값을 2로 바꾸기
    			form.find("input[name=commentref]").val($(e.target).val()); //클릭한 댓글의 PK값을 가져와서 값에 넣어줘야 한다
    			form.find("button").removeAttr("id").addClass("btn-insert2");
    			
    			const td=$("<td>").attr("colspan","2").append(form); //만든 FORM 태그를 TD를 만들어 넣고 
    			tr.append(td); //TD를  TR에 넣음
    			
    			//답글창
    			tr.find("td").css("display","none"); //안보이게 하고
    			tr.insertAfter($(e.target).parents("tr")).children("td").slideDown(100);//$(e.target).parents("tr"):버튼의 부모들중에 TR 뒤에INSERTAFTER
    			$(e.target).off("click");
    			

    		});
<%--      		$(".btn-delete").click(e=>{
    			
    			//삭제 
    			form.find("input[name=commentref]").val($(e.target).val()); //클릭한 댓글의 PK값을 가져와서 값에 넣어줘야 한다
    			//값넘겨주고 삭제하는 로직 만들기 
    			
/*     			const tr=$("<tr>");
    			const form=$(".comment-editor>form").clone(); //만들어놓았던 FORM태그 생성해서 사용하기
    			form.find("textarea").attr({"rows":"1"}); //ROWS만 1로 바꾸기 
    			form.find("input[name=level]").val("2"); //VAL값을 2로 바꾸기
    			form.find("input[name=commentref]").val($(e.target).val()); //클릭한 댓글의 PK값을 가져와서 값에 넣어줘야 한다
    			form.find("button").removeAttr("id").addClass("btn-insert2");
    			
    			const td=$("<td>").attr("colspan","2").append(form); //만든 FORM 태그를 TD를 만들어 넣고 
    			tr.append(td); //TD를  TR에 넣음
    			
    			tr.find("td").css("display","none"); //안보이게 하고
    			tr.insertAfter($(e.target).parents("tr")).children("td").slideDown(800);//$(e.target).parents("tr"):버튼의 부모들중에 TR 뒤에INSERTAFTER
    			$(e.target).off("click"); */
    		});
     		 		
    		const fn_commentDelete = ()=>{
    			$("#commentDmlFrm").attr("action","<%=request.getContextPath()%>/board/commentDelete.do");
    			$("#commentDmlFrm").submit();
    		} --%>
    	})
    </script>
    <!-- End 댓글&작성자후기 중 댓글 -->
    
	<!-- 댓글&작성자후기 중 작성자후기 -->                 
    <section class="py-5">
        <div class="container">
            <div class="row text-left p-2 pb-3" >
                <h4 id="boardView_c2"><%=b.getMember().getMember_nickname()%>(<%=b.getMember().getMember_id() %>)님에 달린 후기</h4>
                <button id="addLocbtn"
                onclick="window.open('<%=request.getContextPath() %>/board/boardViewReviewAll.do?Review=all&BoardWriterNo=<%=b.getMember().getMember_no() %>','전체 후기 더보기' ,'width=700, height=600', left='600', top='500');">작성자후기더보기</button>
            </div>

            <!--Start comment_작성자후기-->
            <div id="carousel-related-product">
            	<%if(reviews.isEmpty()){ %>
            		<h6 style="margin-left:50px;">해당 게시글에는 아직 작성된 작성자 후기가 없습니다</h6>
            	
            	<%} else {
            	
		   				for(ReviewBoard rb : reviews){%>
		   					
				                <div class="p-2 pb-3">
				                    <div class="product-wap card rounded-0">
				                        <div class="card-body">	
				                        	<div style="display: flex; justify-content:space-between;">
				                        		<div style="display: flex;">
													<h6 style="text-align: left;">[ <%=rb.getReviewTitle() %> ]</h6>
													<!-- 5번 for문.. rb score만큼 warning -->
													<%for(int i=1;i<6;i++){ 
														if(rb.getReviewScore()>=i){%>
															<i class="fa fa-star text-warning"></i>
														<%}else{ %>
															<i class="fa fa-star text-secondary"></i>
														<%} 
													}%>
												</div>
												<div>
													<%if(rb.getMemberNo()==loginMember.getMember_no()){ %>
														<a href="<%=request.getContextPath()%>/board.gradeupdate.do?boardNo=<%=b.getWdNo()%>&reviewNo=<%=rb.getReviewSeq()%>">수정</a>
														<a href="<%=request.getContextPath()%>/board/reviewdelete.do?
														reviewboardNo=<%=rb.getReviewSeq()%>&memberNo=<%=loginMember.getMember_no()%>&boardNo=<%=b.getWdNo()%>" style="margin-left:10px;">삭제</a>
													<%} %>
												</div>
											</div>
											<div style="display: flex; justify-content:flex-start; margin-top: 20px;">
												<%if(rb.getImg()!=null){ %>
													<img src="<%=request.getContextPath()%>/reviewImg/<%=rb.getImg()%>" alt="" style="width:80px; height:80px;">	
												<%} %>	                            
					                            <p style="margin-left:30px;"><%=rb.getReviewContent()%></p>
					                       	</div>
				                            <ul class="w-100 list-unstyled d-flex justify-content-between mb-0">
				                                <li></li>
				                            	<li class="text-center mb-0 primary"><%=rb.getReviewDate()%>게시시간</li>
				                            </ul>
				                        </div>
				                        
				                    </div>
				                </div>
				                

		   				<%}//for
		   			}//for밖 if%>
                


                
			</div>
        </div>
    </section>
    <!-- End 댓글&작성자후기 중 작성자후기 -->
   </div>
   
   
    <style>
    	      /* 글 */
       .h2{text-align:center;margin-top:10%;font-weight: bold;}
       #memberNic{text-align:center;}
       .select{margin:8%; margin-bottom:2% !important; padding:8%;border:1px solid lightgray;border-radius:15px;}
       .star{margin-top:20px;text-align:center;}
       .content{margin-left:11%;margin-right:11%}
       .col-auto{text-align:center; margin-top:50px;}
       .joinCount{margin-bottom:1px;}
       p{margin-left:11%;margin-right:11%}
       h6{margin-top:20px;}
    
    
    
	     /*댓글테이블*/
	    div>div#comment-editor{width:600px; margin:0 auto; border-collapse:collapse; clear:both; } 
	    table#tbl-comment{width:600px; margin:0 auto; border-collapse:collapse; clear:both; } 
	    table#tbl-comment tr td{/* border-bottom:1px solid;  border-top:1px solid; */padding:5px; text-align:left; line-height:150%;}
	    table#tbl-comment tr td:first-of-type{padding: 5px 5px 5px 50px;}
	    table#tbl-comment tr td:last-of-type {text-align:right; width: 100px;}
	/*     table#tbl-comment button.btn-reply{display:none;}
	    table#tbl-comment button.btn-delete{display:none;}
	/*   table#tbl-comment tr:hover {background:lightgray;}*/
	/*    table#tbl-comment tr:hover button.btn-reply{display:inline;}
	/*     table#tbl-comment tr:hover button.btn-delete{display:inline;}
	    table#tbl-comment tr.level2 {color:gray; font-size: 14px;} */
	    table#tbl-comment sub.comment-writer { font-size:14px}
	    table#tbl-comment sub.comment-date {color:grey; font-size:10px}
	    table#tbl-comment tr.level2 td:first-of-type{padding-left:100px;}
	    table#tbl-comment tr.level2 sub.comment-writer { font-size:14px}
	    table#tbl-comment tr.level2 sub.comment-date {color:grey; font-size:10px}
	    /*답글관련*/
	    table#tbl-comment textarea{margin: 4px 0 0 0;}
	   /*  table#tbl-comment button.btn-insert2{width:60px; height:23px; color:white; background:#3300ff; position:relative; top:-5px; left:10px;} */
	   
	   .btn-delete input-group-text btn-insert2{
		   color : #e62e2e;
	   }
	   #addLocbtn {
	   		border: 1px solid lightgray;
	   }
	</style>
    
    
<%@ include file="/views/common/footer.jsp" %>