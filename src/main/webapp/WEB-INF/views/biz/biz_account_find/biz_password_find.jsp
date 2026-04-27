<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/include/header_nosearchbar.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>비즈니스 회원 비밀번호 찾기</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.slim.js" integrity="sha256-UgvvN8vBkgO0luPSUl2s8TIlOSYRoGFAX4jlCIm9Adc=" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable.min.css" />
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/color_orange.css" />">
    <script>
        
    </script>

    <style>
     body {
        --bs-font-sans-serif:margin:0; padding:0;font-size:14px;line-height:1.6;font-family:'Pretendard','Noto Sans KR', 'Apple SD Gothic Neo', '돋움', Dotum, Arial, Sans-serif;color:#464646;letter-spacing:0;-webkit-text-size-adjust:none;font-weight: 400
    }

    section{
      width:1024px;
      margin:0 auto;
      margin-top:200px;
    }

    .login_form{
      margin:0 auto;
      width:512px;
    }

	.login{
		padding-top:10px;
		width:512px;
		height:50px;
		margin:20px 0 20px 0;
	}
    
	</style>
	<script>
		function bizpasswordfindFn(){
			
			// 이메일
			var email = $("input[name=email]").val();
			
			// 사업자이름
			var name = $("input[name=name]").val();
			
			// 전화번호
			var phone = $("input[name=phone]").val().replace(/-/g,'');
			
			// 사업자번호
			var certificateNo = $("input[name=certificateNo]").val().replace(/-/g,'');
			
			var valid = true;
			
			// 이메일 유효성검사
			if(email == ""){
				$("#emailspan").text("이메일을 입력해 주세요").css("color","red");
				valid = false;
			} else if(!/^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/.test($("input[name=email]").val())){
				$("#emailspan").text("이메일 주소 형식으로 입력해주세요.").css("color","red");
			} else{
				$("#emailspan").text(" ").css("color","red");
			}
			
			// 사업자이름 유효성검사
			if(name == "") {
				$("#namespan").text("사업주 이름을 입력해 주세요").css("color","red");
				valid = false;
			} else {
				$("#namespan").text(" ");
			}
			
			// 전화번호 유효성검사
			if(phone == "" || !/^\d{11}$/.test(phone)) {
				$("#phonespan").text("올바른 전화번호를 입력해 주세요").css("color","red");
				valid = false;
			} else {
				$("#phonespan").text(" ");
			}
			
			// 사업자번호 유효성검사
			if(certificateNo === "" || !/^\d{10}$/.test(certificateNo)) {
				$("#certificateNospan").text("올바른 사업자등록번호를 입력해 주세요").css("color","red");
				valid = false;
			} else {
				$("#certificateNospan").text(" ");
			}
			
			if(!valid) {
				return false;
			}

		}
	</script>
</head>


<body>
<section>
  <div class="login_form"><!--수직수평정렬용-->
    <h1 class="fw-bolder"> 비즈니스 회원 비밀번호 찾기 </h1>
    <P>계정에 등록한 정보를 입력해 주세요</P>
	<form action="<c:url value='/biz/biz_account_find/biz_password_find' />"
		onsubmit="bizpasswordfindFn()" method="post">
	    <div class="form-floating">
	      <input type="email" class="form-control" id="email" name="email">
	      <label for="mail">이메일</label>
	      <span id="emailspan" style="display: inline-block;"></span>
	    </div>
	    
	    <div class="form-floating">
	      <input type="text" class="form-control" id="name" name="name">
	      <label for="mail">사업자이름</label>
	      <span id="emailspan" style="display: inline-block;"></span>
	    </div>
	
	    <div class="form-floating">
	      <input type="text" class="form-control" id="phone" name="phone">
	      <label for="phone">전화번호</label>
	      <span id="phonespan" style="display: inline-block;"></span>
	    </div>
	    
	    <div class="form-floating">
	      <input type="text" class="form-control" id="certificateNo" name="certificateNo">
	      <label for="certificateNo">사업자등록번호</label>
	      <span id="certificateNospan" style="display: inline-block;"></span>
	    </div>
	
	    <div class="d-grid gap-2">
	      <button class="btn btn-primary " type="submit" style="height:50px;">찾기</button>
	    </div>
    </form>
    
        	<div class="d-grid gap-2">
	      <a class="btn btn-primary login" href="<c:url value='/login/biz_login' />" 
	      >로그인페이지 이동</a>
	    </div>

    	<c:if test="${not empty message}">
		    <div class="alert alert-success mt-3">
		        <strong>${message}</strong>
		    </div>
		</c:if>
		
		<c:if test="${not empty errorMessage}">
		    <div class="alert alert-danger mt-3">
		        ${errorMessage}
		    </div>
		</c:if>
    
  </div>
</section>
</body>
</html>