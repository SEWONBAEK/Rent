<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>비즈니스 약관동의</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">
    <script src="<c:url value='/resources/js/jquery-3.7.1.min.js' />"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable.min.css" />
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/color_orange.css" />">
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
    
    .accordion-item{
    	border-color:#dee2e6;
    }
    
    input[type="checkbox"].form-check-input{
    	margin:0 0 0 15px;
    	width:16px;
    	height:16px;
    	border-radius:3px;
    }
    
    </style>
      
    <script>
    
    function termscheckFn(){
    	if(!$("#termsover0").is(":checked") ||
    	   !$("#termsover1").is(":checked") ||
    	   !$("#termsover2").is(":checked")) {
    		alert("필수 약관에 동의해주세요.");
    		return false;
    	}
    	return true;
    }
      
	function termsallcheckFn(){
		let isChecked = $('#termsall').is(':checked');
		
		$('#termsover0').prop('checked', isChecked);
		$('#termsover1').prop('checked', isChecked);
		$('#termsover2').prop('checked', isChecked);
		$('#termsover3').prop('checked', isChecked);
		$('#termsover4').prop('checked', isChecked);
		$('#termsover5').prop('checked', isChecked);
	}
      
      // 하나라도 체크 해제되면 전체 약관 동의 체크 해제
	$(document).ready(function(){
		$('#termsover0, #termsover1, #termsover2, #termsover3, #termsover4, #termsover5').on('change', function() {
	    	let allChecked = $('#termsover0').is(':checked') &&
	                      $('#termsover1').is(':checked') &&
	                      $('#termsover2').is(':checked') &&
	                      $('#termsover3').is(':checked') &&
	                      $('#termsover4').is(':checked') &&
	                      $('#termsover5').is(':checked');
	
			$('#termsall').prop('checked', allChecked);
		});
	});
</script>
</head>

<body>
<section>
  <div class="login_form">
    <h1 class="fw-bolder">비즈니스 회원 약관 동의하기 </h1>
    <p>비즈니스 회원 약관에 동의해주세요</p>
	<c:if test="${param.error != null and param.error eq 'missing'}">
		<div class="alert alert-warning mt-2">
		  필수 약관에 모두 동의해주세요.
		</div>
	</c:if>
    <form action="<c:url value="/join/biz_join_terms" />" method="post" onsubmit="return termscheckFn();">
    <div class="d-flex mb-3 align-items-center" style="background-color: rgb(214, 214, 214); border-radius: 6px; height:55px;"><!--전체동의니까 좀 눈에 잘 띄게 수정할 필요가 있습니다.-->
      <input class="form-check-input me-2" type="checkbox" value=""  id="termsall" onclick="termsallcheckFn()">
      <p class="p-2 my-auto" style="font-size: 18px; font-weight: bold;">약관 전체동의(선택항목 포함)</p>
    </div>
	<div class="accordion" id="accordionExample">		
		<div class="accordion-item">
		  <h2 class="accordion-header d-flex align-items-center">
		  	<input class="form-check-input me-2" type="checkbox" name="terms" value="1" id="termsover0">
		    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseTwo">
		      (필수)이용약관
		    </button>
		  </h2>
		  <div id="collapseOne" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
		    <div class="accordion-body">
		      <strong>홈페이지 필수 이용약관 동의입니다.</strong> 필수 이용약관에 대한 동의를 위한 예제입니다. 이 예제에 동의해야 홈페이지에 가입할 수 있습니다.
		    </div>
		  </div>
		</div>
		
		<div class="accordion-item">
		  <h2 class="accordion-header d-flex align-items-center">
		  	<input class="form-check-input me-2" type="checkbox" name="terms" value="2" id="termsover1">
		    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
		      (필수)만 14세 이상 확인
		    </button>
		  </h2>
		  <div id="collapseTwo" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
		    <div class="accordion-body">
		      <strong>만 14세 이상 확인 동의입니다.</strong> 만 14세 이상 가입을 위한 약관 동의입니다. 이 약관에 동의를 필수로 해야합니다.
		    </div>
		  </div>
		</div>
		
		<div class="accordion-item">
		  <h2 class="accordion-header d-flex align-items-center">
		  	<input class="form-check-input me-2" type="checkbox" name="terms" value="3" id="termsover2">
		    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseTwo">
		      (필수)개인정보 수집 및 이용 동의
		    </button>
		  </h2>
		  <div id="collapseThree" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
		    <div class="accordion-body">
		      <strong>개인정보 수집 및 이용에 대한 동의입니다.</strong> 개인정보 수집 및 이용에 대한 동의를 원할 경우 체크를 하면 되고 이 부분은 필수 동의를 해야 가입할 수 있습니다.
		    </div>
		  </div>
		</div>
		
		<div class="accordion-item">
		  <h2 class="accordion-header d-flex align-items-center">
		  	<input class="form-check-input me-2" type="checkbox" name="terms" value="4" id="termsover3">
		    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseTwo">
		      (선택)개인정보 수집 및 이용 동의
		    </button>
		  </h2>
		  <div id="collapseFour" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
		    <div class="accordion-body">
		      <strong>선택적 개인정보 수집 및 이용 동의에 관한 약관입니다.</strong> 선택적 개인정보 수집 및 이용 동의에 관한 약관이고 이 약관은 동의하지 않아도 홈페이지 가입은 가능합니다. 해당 부분을 동의 하지 않으면 홈페이지 이용하는데 일부 기능이 제한될 수 있습니다.
		    </div>
		  </div>
		</div>
		
		<div class="accordion-item">
		  <h2 class="accordion-header d-flex align-items-center">
		  	<input class="form-check-input me-2" type="checkbox" name="terms" value="5" id="termsover4">
		    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFive" aria-expanded="false" aria-controls="collapseTwo">
		      (선택)마케팅 알림 수신 동의
		    </button>
		  </h2>
		  <div id="collapseFive" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
		    <div class="accordion-body">
		      <strong>선택적 마케팅 알림 수신 동의에 관한 약관입니다.</strong> 마케팅 알림 수신 동의에 관한 약관이고 이벤트나 혜택과 같은 알림을 수신할 수 있는 동의사항 입니다. 동의하지 않아도 홈페이지 가입이 가능합니다.
		    </div>
		  </div>
		</div>
		
		<div class="accordion-item">
		  <h2 class="accordion-header d-flex align-items-center">
		  	<input class="form-check-input me-2" type="checkbox" name="terms" value="6" id="termsover5">
		    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseSix" aria-expanded="false" aria-controls="collapseTwo">
		      (선택)위치기반 서비스 이용약관 동의
		    </button>
		  </h2>
		  <div id="collapseSix" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
		    <div class="accordion-body">
		      <strong>선택적 위치기반 서비스 이용약관에 동의사항입니다.</strong> 위치기반 서비스 이용약관으로 해당 위치기반 서비스를 활용하여 좀 더 주변 숙소에 관한 정보를 얻을 수 있습니다.
		    </div>
		  </div>
		</div>
	</div>
    <div class="d-grid gap-2">
   		<button class="btn btn-primary " type="submit" style="height:50px; margin-top:20px;">다음</button><!--링크를 걸어야 합니다-->
    </div>
    </form>
  </div>
</section>
</body>
</html>