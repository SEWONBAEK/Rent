<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>비즈니스 회원 - 예약자관리</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">
    <script src="<c:url value='/resources/js/jquery-3.7.1.min.js' />"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/color_orange.css" />">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <style>
    body {
        --bs-font-sans-serif:margin:0; padding:0;font-size:14px;line-height:1.6;font-family:'Pretendard','Noto Sans KR', 'Apple SD Gothic Neo', '돋움', Dotum, Arial, Sans-serif;color:#464646;letter-spacing:0;-webkit-text-size-adjust:none;font-weight: 400
    }
    .active{
		--bs-nav-pills-link-active-bg:var(--bs-orange);
	}
	.form-control{
		width:150px;
		margin:0 5px 10px 0;
	}
	
	#datepicker1, #datepicker2 {
	    height: 24px; /* input 높이 */
	}
	
	/* 달력 버튼 이미지 크기 조정 */
	.ui-datepicker-trigger {
		display:inline-block;
		line-height:5px;
	    width: 24px;       /* 버튼 가로 크기 */
	    height: 24px;      /* 버튼 세로 크기 */
	    vertical-align: bottom; /* 입력창과 수직 정렬 */
	    cursor: pointer;    /* 마우스 커서 변경 */
	    border-radius: 6px; /* 둥근 모서리 */
	    border: 1px solid #ccc; /* 버튼 테두리 */
	    padding: 2px;       /* 안쪽 여백 */
	    margin-right:10px;
	}
	
	/* 버튼 hover 시 효과 */
	.ui-datepicker-trigger:hover {
	    border-color: #888;
	    box-shadow: 0 0 3px rgba(0,0,0,0.3);
	}
	
	.table{
		text-align:center;
	}
	
    </style>

	<script>
		$(function() {
		
			// 체크인 datepicker
			$("#datepicker1").datepicker({
			dateFormat: 'yy-mm-dd',
			showOtherMonths: true,
			showMonthAfterYear: true,
			changeYear: true,
			changeMonth: true,
			showOn: "both",
			buttonImage: "../resources/img/calendar.png",
			buttonImageOnly: true,
			buttonText: "선택",
			yearSuffix: "년",
			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			dayNamesMin: ['일','월','화','수','목','금','토'],
			dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
			minDate: "-5Y",
			maxDate: "+5Y"
			}).datepicker('setDate', 'today');
		
			// 체크아웃 datepicker
			$("#datepicker2").datepicker({
			dateFormat: 'yy-mm-dd',
			showOtherMonths: true,
			showMonthAfterYear: true,
			changeYear: true,
			changeMonth: true,
			showOn: "both",
			buttonImage: "../resources/img/calendar.png",
			buttonImageOnly: true,
			buttonText: "선택",
			yearSuffix: "년",
			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			dayNamesMin: ['일','월','화','수','목','금','토'],
			dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
			minDate: "+1D",
			maxDate: "+5Y"
			});
			
			var tomorrow = new Date();
			tomorrow.setDate(tomorrow.getDate() + 1);
			$("#datepicker2").datepicker("setDate", tomorrow);
		
			// 체크인 변경 시 체크아웃 최소 날짜 조정
			$("#datepicker1").on("change", function() {
				var checkinDate = $(this).datepicker('getDate');
				if(checkinDate){
					var checkoutMin = new Date(checkinDate);
					checkoutMin.setDate(checkoutMin.getDate() + 1);
					$("#datepicker2").datepicker("option", "minDate", checkoutMin);
			
					var currentCheckout = $("#datepicker2").datepicker('getDate');
					if(!currentCheckout || currentCheckout <= checkinDate){
					$("#datepicker2").datepicker("setDate", checkoutMin);
					}
				}
				updateReservationTitle();
			});
			
			// 제목 업데이트 함수
			function updateReservationTitle() {
				var startDate = $("#datepicker1").val();
				var endDate = $("#datepicker2").val();
				$("#reservation-title").text(startDate + " ~ " + endDate + " 예약자 조회");
			}
			
			// 초기 제목 반영
			updateReservationTitle();
			
			$("#searchBtn").on("click",function(){
				var startDate = $("#datepicker1").val();
				var endDate = $("#datepicker2").val();
				$.ajax({
					url : "<c:url value='/biz/biz_mypage_reserv/ajax' />",
					type : 'GET',
					data : {startDate : startDate, endDate : endDate},
					dataType : 'json',
					success : function(result){
						var tbody = '';
						$.each(result.list, function(i, r){
							tbody += '<tr>'+
									 '<td>' + r.cancelyn + '</td>' +
									 '<td>' + r.roomName + '</td>' +
									 '<td>' + r.email + '</td>' +
									 '<td>' + r.name + '</td>' +
									 '<td>' + r.phone + '</td>' +
									 '<td>' + r.adultNo + '</td>' +
									 '<td>' + r.childNo + '</td>' +
									 '<td>' + r.checkin + '</td>' +
									 '<td>' + r.checkout + '</td>' +
									 '<td>' + r.paymentStr + '</td>' +
									 '</tr>';
						});
						$("#reservation-table tbody").html(tbody);
						updateReservationTitle();
					},
					error : function(err){ console.log(err); }
				});
			});
			
		});
	</script>
    
    
</head>


<body>
<section class="d-flex">
  <div><!--사이드바 시작-->
  <div class="d-flex" style="height:100vh;" >
      <div style="width: 280px;" class="d-flex flex-column flex-shrink-0 p-3 text-bg-dark" >
    <a class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
      <i class="bi bi-gear me-2" style="font-size:24px;"></i>
      <span class="fs-4" style="font-weight: bold;">비즈니스 회원</span>
    </a>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
      <li class="nav-item"> 
        <a href="<c:url value="/biz/biz_mypage_acco" />" class="nav-link text-white"><!--숙소 관리 페이지로 링크 걸어야 합니다--> <!--aria current가 현재 표시되는 페이지를 강조합니다-->
          <i class="bi bi-house me-2  "></i>숙소 관리
        </a>
      </li>
      <li>
        <a href="<c:url value="/biz/biz_mypage_room" />" class="nav-link text-white" ><!--객실 관리 페이지로 링크 걸어야 합니다-->
          <i class="bi bi-file me-2"></i>
          객실 관리
        </a>
      </li>
      <li>
        <a href="<c:url value="/biz/biz_mypage_reserv" />" class="nav-link active"><!--예약자 관리 페이지로 링크 걸어야 합니다-->
          <i class="bi bi-people me-2"></i>
          예약자 관리
        </a>
      </li>
      <li>
        <a href="<c:url value="/biz/biz_mypage_account" />" class="nav-link text-white"><!--계정 설정 페이지로 링크 걸어야 합니다-->
          <i class="bi bi-person-circle me-2"></i>
          계정 설정
        </a>
      </li>
    </ul>
    <hr>
    <div class="dropdown">
      <a href="<c:url value='/'/>" class="nav-link text-white">
          <i class="bi bi-house-fill"></i><!--홈으로 이동하는 페이지로 링크 걸어야 합니다-->
          홈으로
        </a>
    </div>
    </div>
    </div>
  </div><!--사이드바 끝-->

	<div class="d-flex mx-3 my-3"><!--내용 시작입니다. 이곳에 내용을 작성하면 됩니다-->
          
		<div><!--숙소 정보 글로 수정하기-->
			<div class="my-2">
				<h3 class="fw-bold">예약자 관리</h3>
				<h5>기간 선택하기</h5>
				<div class="d-flex" style="font-size:large;">
					<form class="d-flex align-items-center" action="<c:url value='/biz/biz_mypage_reserv' />" method="get">
						<input class="form-control me-2" type="text" id="datepicker1" style="width:150px;" name="startDate" value="${startDate}"> 
						<input class="form-control me-2" type="text" id="datepicker2" style="width:150px;" name="endDate" value="${endDate}">
						<button id="searchBtn" class="btn btn-primary" type="button">조회</button> 		
					</form>
				</div> 
			</div>

          <h5 id="reservation-title"></h5><!--선택한 날짜 , 예약자 수 불러오기-->
          <div>
            <table id="reservation-table" class="table" style="width:1000px;">
		    	<thead>        
		            <tr>
		              <th>예약여부</th>
		              <th>객실</th>
		              <th>이메일</th>
		              <th>이름</th>
		              <th>전화번호</th>
		              <th>어른수</th>
		              <th>아이수</th>
		              <th>입실날짜</th>
		              <th>퇴실날짜</th>
		              <th>결제방식</th>
		            </tr>
                  </thead>
                  <tbody>
                  </tbody>
            </table>
          </div>
        </div><!--숙소 정보 글로 수정하기-->
  </div><!--내용 끝-->
</section>
</body>
</html>