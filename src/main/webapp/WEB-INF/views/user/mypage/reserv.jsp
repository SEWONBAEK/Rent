<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="com.rent.vaca.reserv.ReservVO"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예약 내역</title>
    <script src="<c:url value='/resources/js/jquery-3.7.1.min.js' />"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable.min.css" />
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/color_orange.css" />">
    <style>
        section{
            margin:0 auto;
        }
        .content{
            margin:30px 0 0 50px;
        }
        .cancel{
            margin-left:350px;
        }
        .mb-3{
            width:300px;
        }
        button{
            margin-left:10px;
        }
        .active{
			--bs-nav-pills-link-active-bg:var(--bs-orange);
		}
		.table{
			line-height:2;
			width:1300px;
			text-align:center;
		}
		.table th, .table td{
			white-space:nowrap;
		}
    </style>
    
    <script>
    	$(document).ready(function(){
    		$(".cancel-btn").click(function(){
    			const reservCode = $(this).data("reserv");
    			const $btn = $(this);
    		
    			if(!confirm("정말로 예약을 취소하시겠습니까?")) return;	
    			
    			$.ajax({
    				url : '/user/cancelReserv',
    				method : 'POST',
    				data:{ reservCode : reservCode },
    				success : function(response){
    					if(response == 'success'){
    						$btn.replaceWith('<span>취소완료</span>');
    					}else{
    						alert('취소 실패!');
    					}
    				},
    				error : function(){
    					alert('서버 오류 발생!');
    				}
    			});
    		});
    	});
    	
    </script>
    
</head>
<body>
	<c:if test="${not empty msg}">
	    <script>alert('${msg}');</script>
	</c:if>
    <section class="d-flex">
        <div><!--사이드바 시작-->
            <div class="d-flex" style="height:100vh;" >
                <div style="width: 280px;" class="d-flex flex-column flex-shrink-0 p-3 text-bg-dark" >
                <a class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
                <i class="bi bi-gear me-2" style="font-size:24px;"></i>
                <span class="fs-4" style="font-weight: bold;">일반 회원</span>
                </a>
                <hr>
                <ul class="nav nav-pills flex-column mb-auto">
                <li class="nav-item"> 
                    <a href="${pageContext.request.contextPath}/user/mypage/reserv" class="nav-link active" aria-current="page"><!--숙소 관리 페이지로 링크 걸어야 합니다--> <!--aria current가 현재 표시되는 페이지를 강조합니다-->
                    <i class="bi bi-house me-2  "></i>예약 내역
                    </a>
                </li>
                <c:if test="${user.social == 'N'}">
                <li>
		            <a href="${pageContext.request.contextPath}/user/mypage/pwchange" class="nav-link text-white"><!--객실 관리 페이지로 링크 걸어야 합니다-->
		            <i class="bi bi-file me-2"></i>비밀번호 변경
		            </a>
	            </li>
	            </c:if>
                <li>
                    <a href="${pageContext.request.contextPath}/user/mypage/wishlist" class="nav-link text-white"><!--객실 관리 페이지로 링크 걸어야 합니다-->
                    <i class="bi bi-file me-2"></i>찜 목록
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/user/mypage/account" class="nav-link text-white"><!--예약자 관리 페이지로 링크 걸어야 합니다-->
                    <i class="bi bi-people me-2"></i>내 정보 관리
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/user/mypage/question" class="nav-link text-white"><!--계정 설정 페이지로 링크 걸어야 합니다-->
                    <i class="bi bi-person-circle me-2"></i>내 문의 내역
                    </a>
                </li>
                </ul>
                <hr>
                <div class="dropdown">
                <a href="${pageContext.request.contextPath}" class="nav-link text-white">
                    <i class="bi bi-house-fill"></i><!--홈으로 이동하는 페이지로 링크 걸어야 합니다-->
                    홈으로
                    </a>
                </div>
                </div>
                </div>
        </div><!--사이드바 끝-->
        <div class="content">
            <h2 style="font-weight:bold; font-size:32px; margin-bottom:30px;">예약 내역</h2>
		         <table class="table">
	                <thead>
	                    <tr>
		
	                        <th>예약코드</th>
	                        <th>예약객실명</th>
	                        <th>이름</th>
	                        <th>전화번호</th>
	                        <th>이메일</th>
	                        <th>체크인</th>
	                        <th>체크아웃</th>
	                        <th>예약일</th>
	                        <th>결제방식</th>
	                        <th>성인</th>
	                        <th>아이</th>
	                        <th>예약취소</th>
	                    </tr>
	                </thead>
	                <tbody>
	                	<c:forEach items="${reserv}" var="reserv">
						    <tr>
						        <td>${reserv.reservCode}</td>
						        <td>${reserv.roomName}</td>
						        <td>${reserv.name}</td>
						        <td>${reserv.phone}</td>
						        <td>${reserv.email}</td>
						        <td><fmt:formatDate value="${reserv.checkin}" pattern="yyyy-MM-dd" /></td>
						        <td><fmt:formatDate value="${reserv.checkout}" pattern="yyyy-MM-dd" /></td>
						        <td>${reserv.reservDate}</td>
						        <td>${reserv.payment}</td>
						        <td>${reserv.adultNo}</td>
						        <td>${reserv.childNo}</td>
						        <td>
						        	<button class="btn btn-primary cancel-btn"
						        		data-reserv="${reserv.reservCode}">
						        		취소하기
						        	</button>
						        </td>
						    </tr>
						</c:forEach>
	                </tbody>
	            </table>
        </div>
    </section>
</body>
</html>