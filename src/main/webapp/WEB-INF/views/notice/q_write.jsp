<!-- URL : /customer/question -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header_nosearchbar.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>1대1 문의</title>
    
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
        .pageTitle, .writeFrm, .writeFrm input:not([type=file]), .writeFrm textarea{
            width:1024px;
            margin:10px auto;
        }
        .writeFrm textarea{
            height: 500px;
            resize:none;
        }
        .writeFrm .buttonGroup{
            float:right;
            margin-right:10px;
        }
	    footer{
	    	margin-top:150px;
	    }
	    .reverse{
	    	margin-right:5px;
	    	color:var(--bs-orange);
	    	background-color:white;
	    	borde:2px solid var(--bs-orange);
	    }
    </style>
    <script>
        let title;
        let content;

        $(function(){
            title = $("[name=title]");
            content = $("[name=content]");
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
            	location.href="<c:url value="/customer/faq" />";
            });
        });
    </script>
</head>
<body>
    <section>
    <div class="pageTitle">
        <h2>1대1 문의</h2>
    </div> <!-- end:pageTitle -->
    <br>
    <form class="writeFrm" action="<c:url value='/customer/question' />" method="post" enctype="multipart/form-data">
        <div class="title">
            <input class="form-control" type="text" name="title">
        </div>
        <div class="content">
            <textarea class="form-control" name="content"></textarea>
        </div>
        <br>
        <div class="attachment">
            <input class="form-control" type="file" name="attachment" multiple>
        </div>
        <br>
        <div class="buttonGroup">
            <button type="button" class="btn btn-primary write-btn reverse" id="cancel">취소</button>
            <button type="button" class="btn btn-primary write-btn" id="register">등록</button>
        </div>
    </form>
    </section>
</body>
</html>
<%@include file="../include/footer.jsp" %>