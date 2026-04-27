<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
            <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../../include/header_nosearchbar.jsp" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>회원가입</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable.min.css" />
    <link rel="stylesheet" href="<c:url value="/resources/css/color_orange.css" />">
    
    <style>
    body {
        --bs-font-sans-serif:margin:0; padding:0;font-size:14px;line-height:1.6;font-family:'Pretendard','Noto Sans KR', 'Apple SD Gothic Neo', '돋움', Dotum, Arial, Sans-serif;color:#464646;letter-spacing:0;-webkit-text-size-adjust:none;font-weight: 400
    }
    section{
      width:1024px;
      margin:0 auto;
      margin-top:100px;
    }
    .login_form{
      margin:0 auto;
      width:512px;
    }
    span{
      display: inline-block;
    }
    </style>

    <script>
    let emailcheck = false;
    let pwcheck = false;
    let pwcheckcheck = false;
    let namecheck = false;
    let nicknamecheck = false;
    let phonecheck = false;
    let emailValid = false;
    
    function joincheckFn(){
    	
    	function validatePhone(phone) {
			// 숫자만 10~11자리 또는 010-xxxx-xxxx 형식 검사
			let phonePattern = /^(01[016789])[-]?(\d{3,4})[-]?(\d{4})$/;
			return phonePattern.test(phone);
		}
    	
    	// 이메일 유효성검사
		if($("input[name=email]").val() == ""){ 
			$("#emailspan").text("이메일을 입력해 주세요").css("color","red");
			return false;
		}else if(!/^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/.test($("input[name=email]").val())){
		$("#emailspan").text("이메일 주소 형식으로 입력해주세요.").css("color","red");
			return false;
		}else{
			$("#emailspan").text("");
		}

	  	 // 비밀번호 유효성검사
	     if($("input[name=pw]").val() == ""){ 
	       $("#pwspan").text("비밀번호를 입력해 주세요").css("color","red");
	       return false;
	     }else if($("input[name=pw]").val().length < 8){
	       $("#pwspan").text("비밀번호는 8~20자리입니다. ").css("color","red");
	       return false;
	     }else if($("input[name=pw]").val().length > 20){
	       $("#pwspan").text("비밀번호는 8~20자리입니다. ").css("color","red");
	       return false;
	     }else{
	       $("#pwspan").text("");
	     }
	  	 
	  	 // 비밀번호확인 유효성검사
	     if($("input[name=pwcheck]").val() == ""){ 
	       $("#pwcheckspan").text("사용할 비밀번호를 입력해 주세요.").css("color","red");
	       return false;
	     }else if($("input[name=pw]").val() != $("input[name=pwcheck]").val()){
	       $("#pwcheckspan").text("비밀번호가 일치하지 않습니다.").css("color","red");
	       return false;
	     }else{
	       $("#pwcheckspan").text("");
	     }
	  	 
	  	 // 핸드폰번호 유효성검사
	     if($("input[name=phone]").val() == ""){ 
	         $("#phonespan").text("핸드폰번호를 입력해 주세요").css("color","red");
	         return false;
	     }else if(!validatePhone($("input[name=phone]").val())){
	         $("#phonespan").text("유효한 핸드폰번호를 입력해 주세요").css("color","red");
	         return false;
	     }else{
	       $("#phonespan").text("");
	     }
	  	 
	  	 // 이름 유효성검사
	     if($("input[name=name]").val() == ""){ 
	       $("#namespan").text("이름을 입력해 주세요").css("color","red");
	       return false;
	     }else{
	       $("#namespan").text("");
	     }
	  	 
	  	 // 닉네임 유효성검사
	     if($("input[name=nickname]").val() == ""){ 
	       $("#nicknamespan").text("이름을 입력해 주세요").css("color","red");
	       return false;
	     }else if($("input[name=nickname]").val().length >= 20){
	       $("#nicknamespan").text("이름이 너무 깁니다").css("color","red");
	       return false;
	     }else{
	       $("#nicknamespan").text("");
	     }
	  	 
	     if (!emailValid) {
	    	    $("#emailspan").text("이미 등록된 이메일입니다.").css("color", "red");
	    	    return false;
    	 }
	     
	     return true;
    }
	     

	     $(document).ready(function() {
	       $("input[name=email]").on("blur", function() {
	         let email = $(this).val();
	         if (email === '') return;
	     
	     // 이메일 형식 검사 (정규식)
         let emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
         if (!emailPattern.test(email)) {
             $("#emailspan").text("유효한 이메일 형식이 아닙니다.").css("color", "red");
             emailValid = false;
             return;
         }

         $.ajax({
           url: "<c:url value='/user/join/form/emailCheck' />",
           method: "GET",
           data: { email: email },
           success: function(response) {
             if (!response) {
               $("#emailspan").text("이미 등록된 이메일입니다.").css("color", "red");
               emailValid = false;
             } else {
               $("#emailspan").text("사용 가능한 이메일입니다.").css("color", "green");
               emailValid = true;
             }
           },
           error: function() {
             $("#emailspan").text("이메일 확인 중 오류 발생").css("color", "red");
             emailValid = false;
           }
         });
		});
	});
    
    </script>
</head>


<body>
<section>
  <div class="login_form"><!--수직수평정렬용-->
    <h1 class="fw-bolder"> 회원가입 </h1>
    <form action="<c:url value='/user/join/form' />"
    onsubmit="return joincheckFn()" method="POST">
      <div class="form-floating">
        <input type="email" class="form-control" id="email"  name="email">
        <label for="floatingInput">이메일 주소 입력</label>
        <span id="emailspan"></span>
      </div>

      <div class="form-floating">
        <input type="password" class="form-control" id="pw" name="pw">
        <label for="floatingInput">사용할 비밀번호 입력</label>
        <span id="pwspan"></span>
      </div>
      
      <div class="form-floating">
        <input type="password" class="form-control" id="pwcheck" name="pwcheck">
        <label for="floatingInput">비밀번호 확인</label>
        <span id="pwcheckspan"></span>
      </div>

      <div class="form-floating">
        <input type="text" class="form-control" id="name" name="name">
        <label for="floatingInput">이름</label>
        <span id="namespan"></span>
      </div>

      <div class="form-floating">
        <input type="text" class="form-control" id="nickname" name="nickname">
        <label for="floatingInput">닉네임</label>
        <span id="nicknamespan"></span>
      </div>

      <div class="form-floating">
        <input type="text" class="form-control" id="phone" name="phone">
        <label for="floatingInput">전화번호</label>
        <span id="phonespan"></span>
      </div>

      <div class="d-grid gap-2"><!--버튼-->
        <button class="btn btn-primary " type="submit" style="height:50px;">회원가입</button><!--링크를 걸어야 합니다-->
      </div>
    </form>
    

  </div>
</section>
</body>
</html>