<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/views/common/header.jsp" %>
    

    <!-- Start Banner Hero -->
    <div id="template-mo-zay-hero-carousel" class="carousel slide" data-bs-ride="carousel">
        <ol class="carousel-indicators">
            <li data-bs-target="#template-mo-zay-hero-carousel" data-bs-slide-to="0" class="active"></li>
            <li data-bs-target="#template-mo-zay-hero-carousel" data-bs-slide-to="1"></li>
            <li data-bs-target="#template-mo-zay-hero-carousel" data-bs-slide-to="2"></li>
        </ol>
        
		<div class="carousel-inner">
            <div class="carousel-item active">
            	<div class="container">
	            	<div class="row p-5">
	                	<img class="img-fluid" src="<%=request.getContextPath()%>/images/ad2.png" alt="" width="100%">
	                </div>
                </div>
            </div>
            <div class="carousel-item">
            	<div class="container">
	            	<div class="row p-5">
						<img class="img-fluid" src="<%=request.getContextPath()%>/images/ad1.png" alt="" width="100%">
					</div>
				</div>
            </div>
            <div class="carousel-item">
            	<div class="container">
	            	<div class="row p-5">
						<img class="img-fluid" src="<%=request.getContextPath()%>/images/ad3.png" alt="" width="100%">
					</div>
				</div>
            </div>
        </div>
       
        <a class="carousel-control-prev text-decoration-none w-auto ps-3" href="#template-mo-zay-hero-carousel" role="button" data-bs-slide="prev">
            <i class="fas fa-chevron-left"></i>
        </a>
        <a class="carousel-control-next text-decoration-none w-auto pe-3" href="#template-mo-zay-hero-carousel" role="button" data-bs-slide="next">
            <i class="fas fa-chevron-right"></i>
        </a>
    </div>
    <!-- End Banner Hero -->


    <!-- Start Categories of The Month -->
    <section class="container py-5">
        <div class="row text-center pt-3">
            <div class="col-lg-6 m-auto">
                <h1 class="h1">No pain, No gain</h1>
                <p>
                    "????????? ?????? ????????? ?????? ??????"<br>
                    "????????? ????????? ?????? ?????? ???????????????,
                    ??????????????? <b>??????</b>??? ???????????????!"
                </p>
            </div>
        </div>
        <div class="row">
           
        </div>
    </section>
    <!-- End Categories of The Month -->


    <!-- Start Featured Product -->
    <section class="bg-light">
        <div class="container py-5">
            <div class="row text-center py-3">
                <div class="col-lg-6 m-auto">
                    <h1 class="h1">Together, Do Gather</h1>
                    <p>
                        "?????? ?????? ????????? ?????? STOP!"<br>
                        "?????? ??????, ?????? ??????, ?????? ????????????
                        ????????? ?????? ??????<br> ????????? ?????? ?????????."
                    </p>
                </div>
            </div>
            <div class="row">
                <div class="col-12 col-md-4 mb-4">
                    <div class="card h-100">
                        <a href="shop-single.html">
                            <img src="<%=request.getContextPath() %>/images/main1.jpg" class="card-img-top" alt="...">
                        </a>
                        <div class="card-body">
                            <a href="shop-single.html" class="h2 text-decoration-none text-dark">ALWAYS WITH YOU</a>
                            <p class="card-text"><br>
                                ???????????? ??????,<br>
                                ???????????? ??????,<br>
                                ???????????? ??????.
                            </p>
                            
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-4 mb-4">
                    <div class="card h-100">
                        <a href="shop-single.html">
                            <img src="<%=request.getContextPath() %>/images/main3.jpg" class="card-img-top" alt="...">
                        </a>
                        <div class="card-body">
                            <a href="shop-single.html" class="h2 text-decoration-none text-dark">HEY, JOIN</a>
                            <p class="card-text"><br>
                          
                            ????????????<br>?????????<br>??? ?????????<br>?????????<br>???????????? ??????
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-4 mb-4">
                    <div class="card h-100">
                        <a href="shop-single.html">
                            <img src="<%=request.getContextPath() %>/images/main4.jpg" class="card-img-top" alt="...">
                        </a>
                        <div class="card-body">
                            <a href="shop-single.html" class="h2 text-decoration-none text-dark">START CHALLENGE</a>
                            <p class="card-text"><br>
                                      ????????? ??? ??? ??? ???????<br> 
                                ???????????? ????????? ????????? ^^
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- End Featured Product -->
    
<%@ include file="/views/common/footer.jsp" %>

    