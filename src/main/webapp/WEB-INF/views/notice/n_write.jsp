<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include/header_nosearchbar.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지 작성</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/color_orange.css" />">
    <style>
        header{
        	margin-bottom:50px;
        }
        section a{
            text-decoration:none;
            color:inherit;
        }
        section a:hover{
            text-decoration:underline;
        }
        .pageTitle, form, input:not([type=file]), textarea{
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
	    footer{
	    	margin-top:150px;
	    }
    </style>
    <script>
        let title;
        let content;

        $(function(){
            title = $("[name=title]");
            content = $("[name=content]");
            
            //등록버튼 클릭
            $("#register").on( "click", function() {
                if(title.val().trim()==""){
                    alert("제목을 입력하세요.");
                } else if(content.val().trim()==""){
                    alert("내용을 입력하세요.");
                } else {
                    $(".writeFrm").submit();
                }
            } );

			//취소버튼 클릭
            $("#cancel").on("click", function(){
            	location.href="<c:url value="/notice/list" />";
            });
        });
    </script>
</head>
<body>
    <section>
    <div class="pageTitle">
        <h1>공지사항</h1>
    </div> <!-- end:pageTitle -->
    <form class="writeFrm" action="" method="post" enctype="multipart/form-data">
        <div class="title">제목
            <input class="form-control" type="text" name="title">
        </div>
        <div class="content">본문
            <textarea class="form-control" name="content"></textarea>
        </div>
		
<!-- 		<div class="attachment">
            <input type="file" name="attachment" multiple>
        </div> -->
        <div class="buttonGroup">
            <button type="button" class="btn btn-primary write-btn" id="cancel">취소</button>
            <button type="button" class="btn btn-primary write-btn" id="register">등록</button>
        </div>
    </form>
    </section>
</body>
</html>
<%@ include file="../include/footer.jsp"%>