<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 관리</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">
    <script src="<c:url value='/resources/js/jquery-3.7.1.min.js' />"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable.min.css" />
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/color_orange.css" />">
    <style>
        .content{
            margin:30px 0 0 30px;
        }
        #active{
        	background-color:var(--bs-orange);
        	color:white;
        }
        .board{
			table-layout:auto;
			border-collapse:collapse;
        	text-align:center;
        }
        
        table th, table td{
        	white-space: nowrap;
        }
        
        .board th, .board td{
        	padding:6px 10px;
        }
        
        .board tbody tr{
        	border-bottom:1px solid #ccc;
        }
        
        .board tbody tr:last-child{
        	border-bottom:none;
        }
        
        .delyn, .banyn{
        	display:flex;
        	justify-content:center;
        	align-items:center;
        	height:100%;
        }
    </style>
    
</head>
<body>
    <section class="d-flex">
        <div><!--사이드바 시작-->
            <div class="d-flex" style="height:100vh;" >
                <div style="width: 280px;" class="d-flex flex-column flex-shrink-0 p-3 text-bg-dark" >
            <a class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
                <i class="bi bi-gear me-2" style="font-size:24px;"></i>
                <span class="fs-4" style="font-weight: bold;">관리자 페이지</span>
            </a>
            <hr>
            <ul class="nav nav-pills flex-column mb-auto">
                <li>
                <a href="${pageContext.request.contextPath}/admin/membership_management" id="active" class="nav-link"><!--객실 관리 페이지로 링크 걸어야 합니다-->
                    <i class="bi bi-people me-2"></i>회원 관리
                </a>
                </li>
                <li>
                <a href="${pageContext.request.contextPath}/admin/private_question" class="nav-link text-white"><!--예약자 관리 페이지로 링크 걸어야 합니다-->
                    <i class="bi bi-person-circle me-2"></i>문의 내역 관리
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
            <h2>회원 관리</h2>
            <table class="board">
                <thead>
                    <tr>
                    <th>회원이름</th>
                    <th>회원타입</th>
                    <th>이메일</th>
                    <th>연락처</th>
                    <th>차단여부</th>
                    <th>차단사유</th>
                    <th></th>
                    </tr>
                </thead>
                <tbody>
                	<c:forEach var="member" items="${members}">
	                    <tr>
		                    <td>${member.name}</td>
		                    <td>${member.memberType}</td>
		                    <td>${member.email}</td>
		                    <td>${member.phone}</td>
		                    <td>
			                    <div class="form-check banyn">
									<input class="form-check-input ban-checkbox"
									type="checkbox" data-member-id="${member.id}" disabled
									${member.banyn == 'Y' ? 'checked' : ''}>
									<label class="form-check-label" for="banyn-check"></label>
								</div>
							</td>
		                    <td>${member.banReason}</td>
		                    <td><button data-id="${member.id}" class="btn btn-primary apply-btn" type="button">적용</button></td>
	                    </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </section>
    
    <div class="modal fade" id="reasonModal" tabindex="-1" aria-hidden="true">
	    <div class="modal-dialog">
	    	<div class="modal-content">
	    		<div class="modal-header">
	    			<h5 class="modal-title">차단 사유 입력</h5>
	    			<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
	    		</div>
	    		<div class="modal-body">
	    			<textarea id="banReason" class="form-control" placeholder="차단 사유를 입력하세요."></textarea>
	    			<input type="hidden" id="modalMemberId">
	    		</div>
	    		<div class="modal-footer">
	    			<button type="button" id="submitReason" class="btn btn-primary">저장</button>
	    			<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	    		</div>
	    	</div>
	    </div>
    </div>
    
	<script>
		$(document).ready(function(){
	
		    let tempMemberId = null;
		    let tempCheckbox = null;
	
		    // 적용 버튼 클릭 시 처리
		    $(".apply-btn").on("click", function(){
	
		        let memberId = $(this).data("id");
	
		        // 해당 행의 체크박스 가져오기
		        tempCheckbox = $(this).closest("tr").find(".ban-checkbox");
		        tempMemberId = memberId;
	
		        // 체크박스 상태 확인
		        let isChecked = tempCheckbox.is(":checked");
	
		        if(!isChecked){
		            // 현재 차단 안됨 → 모달 띄우기
		            $("#reasonModal").modal("show");
		            return;
		        }
	
		        // 현재 차단된 상태(Y) → 차단 해제
		        $.ajax({
		            url: "${pageContext.request.contextPath}/admin/updateBanyn",
		            type: "POST",
		            data: { 
		                memberId: memberId,
		                banyn: "N",
		                banReason: ""
		            },
		            success: function(){
		                tempCheckbox.prop("checked", false);
		                tempCheckbox.closest("tr").find("td:eq(5)").text("");
		                alert("차단이 해제되었습니다.");
		            },
		            error: function(){
		                alert("오류 발생");
		            }
		        });
	
		    });
	
	
		    // 모달에서 저장 버튼 → 차단 적용
		    $("#submitReason").on("click", function(){
	
		        let reason = $("#banReason").val().trim();
	
		        if(reason === ""){
		            alert("차단 사유를 입력하세요!");
		            return;
		        }
	
		        $.ajax({
		            url: "${pageContext.request.contextPath}/admin/updateBanyn",
		            type: "POST",
		            data: { 
		                memberId: tempMemberId,
		                banyn: "Y",
		                banReason: reason
		            },
		            success: function(){
	
		                // → disabled 체크박스를 JS로 체크하게 만들기
		                tempCheckbox.prop("checked", true);
		                
						// 차단 사유 즉시 업데이트
		                tempCheckbox.closest("tr").find("td:eq(5)").text(reason);
		                
		                $("#reasonModal").modal("hide");
		                $("#banReason").val("");
	
		                alert("차단이 적용되었습니다.");
		            },
		            error: function(){
		                alert("오류 발생");
		            }
		        });
	
		    });
	
		});

	</script>


</body>
</html>