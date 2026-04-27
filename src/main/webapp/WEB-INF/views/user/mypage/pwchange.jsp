<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>개인 회원 - 비밀번호 변경</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">
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
    </style>
	<script>
		function pwChangeFn(){
			
			if($("#currentPw").val() == ""){
				$("#currentPwSpan").text("현재 비밀번호를 입력해 주세요").css("color","red");
				return false;
			}else{
				$("#currentPwSpan").text("").css("color","red");
			}
			
			if($("#newPw").val() == ""){
				$("#newPwSpan").text("변경할 비밀번호를 입력해주세요.").css("color", "red");
				return false;
			}else if($("#newPw").val() < 8){
				$("#newPwSpan").text("비밀번호는 8자리 이상입니다.").css("color", "red");
				return false;
			}else{
				$("#newPwSpan").text("").css("color", "red");
			}
			
			if($("#confirmPw").val() == ""){
				$("#confirmPwSpan").text("변경할 비밀번호 확인을 입력해주세요.").css("color", "red");
				return false;
			}else if($("#confirmPw").val() < 8){
				$("#confirmPwSpan").text("비밀번호 확인은 8자리 이상입니다.").css("color", "red");
				return false;
			}else if($("#newPw").val() != $("#confirmPw").val()){
				$("#confirmPwSpan").text("변경할 비밀번호와 다릅니다.").css("color", "red");
			}else{
				$("#confirmPwSpan").text("").css("color", "red");
			}
			
			if($("#newPw").val() == $("#confirmPw").val()){
				return true;
			}
			
			
		}
	</script>    
</head>
<body>
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
                    <a href="${pageContext.request.contextPath}/user/mypage/reserv" class="nav-link text-white"><!--숙소 관리 페이지로 링크 걸어야 합니다--> <!--aria current가 현재 표시되는 페이지를 강조합니다-->
                    <i class="bi bi-house me-2  "></i>예약 내역
                    </a>
                </li>
                <c:if test="${user.social == 'N'}">
                <li>
		            <a href="${pageContext.request.contextPath}/user/mypage/pwchange" class="nav-link active" style="background-color:#fd7e14;"><!--객실 관리 페이지로 링크 걸어야 합니다-->
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
                    <a href="${pageContext.request.contextPath}/user/mypage/question" class="nav-link text-white" aria-current="page"><!--계정 설정 페이지로 링크 걸어야 합니다-->
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
        <div class="content"><!--내용 시작입니다. 이곳에 내용을 작성하면 됩니다-->
        <form action="<c:url value='pwchange' />" method="post">
            <h2 style="font-weight:bold; font-size:32px; margin-bottom:30px;">비밀번호 변경</h2>
            <div class="mb-3">
                <label for="exampleFormControlInput1" class="form-label">현재 비밀번호</label>
                <input name="currentPw" type="password" class="form-control" id="currentPw">
                <span id="currentPwSpan"></span>
            </div>
            <div class="mb-3">
                <label for="exampleFormControlInput1" class="form-label">변경할 비밀번호</label>
                <input name="newPw" type="password" class="form-control" id="newPw">
                <span id="newPwSpan"></span>
            </div>
            <div class="mb-3">
                <label for="exampleFormControlInput1" class="form-label">변경할 비밀번호 확인</label>
                <input name="confirmPw" type="password" class="form-control" id="confirmPw">
                <span id="confirmPwSpan"></span>
            </div>


            <button style="margin-bottom:20px;" type="submit" class="btn btn-primary" onclick="return pwChangeFn()">수정</button>
           
           <c:if test="${param.pwChange == 'success'}">
			    <div class="alert alert-success">
			        비밀번호가 성공적으로 변경되었습니다!
			    </div>
			</c:if>
			<c:if test="${param.pwChange == 'fail'}">
			    <div class="alert alert-danger">
			        비밀번호변경에 실패하였습니다!
			    </div>
			</c:if>
           
           </form>     
           
        </div><!--내용 끝-->
    </section>
</body>
</html>