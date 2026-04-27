<!-- URL : /admin/QnA/answer/{noticeNo} -->
<%@page import="com.rent.vaca.notice.NoticeVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>문의내역 답변작성</title>
    <!-- fontawesome 아이콘 css -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">
    <script src="<c:url value='/resources/js/jquery-3.7.1.min.js' />"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable.min.css" />
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/color_orange.css" />">
	<style>
        section a{
            text-decoration:none;
            color:inherit;
        }
        section a:hover{
            text-decoration:underline;
        }
        .listTitle, form, input:not([type=file]), textarea{
            width:1024px;
            margin:10px auto;
        }
        textarea{
            height: 500px;
            resize:none;
        }
        .buttonGroup{
            float:right;
        }
        .con{
            margin:30px 0 0 30px;
        }
        #active{
        	background-color:var(--bs-orange);
        }
    </style>
    <script>
        let content;

        $(function(){
            title = $("[name=title]");
            content = $("[name=answerContent]");
            $("#register").on( "click", function() {
                if(content.val().trim()==""){
                    alert("내용을 입력하세요.");
                } else {
                    $(".write").submit();
                }
            } );
            
            $("#cancel").click(function(){
            	location.href="${pageContext.request.contextPath}/admin/private_question";
            });
        });/* document.ready 끝 */
    </script>
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
            <a href="${pageContext.request.contextPath}/admin/membership_management" class="nav-link text-white">
                <i class="bi bi-people me-2"></i>회원 관리
            </a>
            </li>
            <li>
            <a id="active" href="${pageContext.request.contextPath}/admin/private_question" class="nav-link active">
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

    <div class="con">
        <div class="listTitle">
            <h1>문의 내역 답변작성</h1>
        </div> <!-- end:listTitle -->
        <div style="margin-left:70px;">${question.title}</div>
        <div style="margin-left:70px;">${question.content}</div>
        <form class="write" action="" method="post" enctype="multipart/form-data">
            <div class="mb-3">
                <label for="exampleFormControlTextarea1" class="form-label">답변</label>
                <textarea name="answerContent" class="form-control" id="exampleFormControlTextarea1" rows="3" placeholder="답변을 입력해주세요."></textarea>
            </div>
            <div class="buttonGroup">
                <button type="button" class="btn btn-primary write-btn" id="cancel">취소</button>
                <button type="button" class="btn btn-primary write-btn" id="register">등록</button>
            </div>
        </form>
    </div>
</body>
</html>