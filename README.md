<div align="center">
  <img src="./images/Rent_Thumbnail.png" width="80%">
  <h3비대면 과제관리 시스템</h3>
</div>

## ⌨️ 기간

- **2025.08.25 ~ 2025.09.30(5주)**

<a name="tableContents"></a>

<br/>

## 🔎 목차

1. <a href="#subject">🎯 주제</a>
1. <a href="#mainContents">⭐️ 주요 기능</a>
1. <a href="#systemArchitecture">⚙ 시스템 아키텍쳐</a>
1. <a href="#skills">🛠️ 기술 스택</a>
1. <a href="#erd">💾 ERD</a>
1. <a href="#contents">🖥️ 화면 소개</a>
1. <a href="#developers">👥 팀원 소개</a>

<br/>

<!------- 주제 시작 -------->

## 🎯 주제

<a name="subject"></a>
**OAuth 2.0,** **REST API** 기반 간편 로그인 및 결제 숙소 예약 플랫폼<br />
<br />
**OAuth 2.0** 카카오/네이버 소셜 로그인 연동<br />
**REST API** 통신, 결제 승인/취소 로직
<br />
<br />


<br />

**주요 기능**

- OAuth 2.0 표준 인증 절차를 준수하여 사용자 편의성을 높였으며, 발급받은 Access Token을 통해 안전하게 사용자 정보를 획득했습니다.
- 카카오페이의 단건 결제 API를 활용하여 결제 준비(Ready), 승인(Approve) 프로세스를 설계하였습니다.
  
<div align="right"><a href="#tableContents">목차로 이동</a></div>

## ⭐️ 주요 기능

<a name="mainContents"></a>

### 공통

- 인터셉터를 통해 해당 페이지의 기능을 회원 등급에 맞게 제한합니다.

---

### 개인 회원

- 회원가입을 카카오톡, 네이버 소셜 로그인 또는 이메일로 회원가입이 가능합니다.
- 다양한 키워드에 맞는 숙소를 검색 가능합니다.
- 숙소 예약 시 다른 유저와 중복 예약을 방지하도록 설계하였습니다.
- 이용한 숙소에 대해 별점과 리뷰를 작성할 수 있습니다.
- 사용자가 원하는 숙소를 찜목록에 추가할 수 있습니다.
- 예약한 숙소정보를 확인할 수 있습니다.
- 관리자 또는 숙소에 문의를 남길 수 있습니다.

---

### 기업 회원

- 기업 회원은 회원가입 시 이메을 회원가입을 통해서만 가입이 가능합니다.
- 숙소 관리를 통해 숙소 정보 등록, 수정, 삭제할 수 있습니다.
- 숙소를 등록했다면 객실 관리를 통해 숙소에 있는 객실을 등록, 수정, 삭제할 수 있습니다.
- 예약자 관리를 통해 해당 날짜에 예약자 정보를 확인 및 취소 요청 시 취소할 수 있습니다.
- 계정설정을 통해 사업자 정보와 비밀번호를 수정할 수 있습니다.

---

### 관리자

- 회원 관리를 통해 회원의 사용을 제한 및 차단할 수 있습니다.
- 문의 내역 관리를 통해 회원들이 문의한 내용을 답변할 수 있습니다.
- 관리자만 공지사항을 작성할 수 있습니다.

---

<div align="right"><a href="#tableContents">목차로 이동</a></div>

<br/>


<!------- 시스템 아키텍쳐 시작 -------->

## ⚙ 시스템 아키텍쳐

<a name="systemArchitecture"></a>

<img src="./images/Rent_System Architecture.png">

- Frontend: HTML5, CSS3, JavaScript를 활용하여 깔끔하고 가독성 좋은 UI를 구축 
- Backend & DB: Spring 프레임워크를 사용하여 서버를 구현하였으며, MySQL을 통해 사용자, 숙소 정보 등 데이터를 관리

본 프로젝트는 Spring MVC 아키텍처를 기반으로 설계된 숙소 예약 플랫폼입니다.<br />
Naver 및 Kakao OAuth 2.0을 연동하여 로그인 편의성을 높였고, Kakao Pay API를 통해 실전적인 결제 프로세스를 구현했습니다.<br />
또한, Spring Interceptor를 활용하여 사용자 인증 및 권한을 효율적으로 제어하도록 설계했습니다.

<div align="right"><a href="#tableContents">목차로 이동</a></div>

<br/>

<!------- 기술 스택 시작 -------->

## 🛠️ 기술 스택

<a name="skills"></a>

### 💻 FrontEnd

![HTML5](https://img.shields.io/badge/html5-%23E34F26.svg?style=for-the-badge&logo=html5&logoColor=white)
![CSS3](https://img.shields.io/badge/css3-%231572B6.svg?style=for-the-badge&logo=css3&logoColor=white)
![Ajax](https://img.shields.io/badge/Ajax-%23ffffff.svg?style=for-the-badge&logo=jquery&logoColor=black)
---

### ⚙️ BackEnd

![Java](https://img.shields.io/badge/java-%23ED8B00.svg?style=for-the-badge&logo=openjdk&logoColor=white)
![Spring](https://img.shields.io/badge/spring-%236DB33F.svg?style=for-the-badge&logo=spring&logoColor=white)
![Mysql](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mariadb&logoColor=white)
---

### 🤝 Collaboration

![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)
![Git](https://img.shields.io/badge/git-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white)
---

<div align="right"><a href="#tableContents">목차로 이동</a></div>

<br/>

<!------- ERD 시작 -------->

## 💾 ERD
<a name="erd"></a>
<img src="./images/Rent_ERD.png">

<div align="right"><a href="#tableContents">목차로 이동</a></div>

<br/>

<!------- 화면 소개 시작 -------->

<a name="contents"></a>

<br/>

## 🖥️ 화면 소개

### 1. 공통

<table>
    <tr>
        <td align="center" width="200">
            <h5>메인 페이지</h5>
            <img src="./images/main.png" alt="메인 페이지" width="100%" />  
        </td>
        <td align="center" width="200">
            <h5>숙소 검색</h5>
            <img src="./images/search_acco.png" alt="숙소 검색" width="100%" />
        </td>
        <td align="center" width="200">
            <h5>숙소 정보</h5>
            <img src="./images/acco_info.png" alt="숙소 정보" width="100%" />  
        </td> 
        <td align="center" width="200">
            <h5>이메일 찾기</h5>
            <img src="./images/email_find.png" alt="이메일 찾기" width="100%" />
        </td>
        <td align="center" width="200">
            <h5>비밀번호 찾기</h5>
            <img src="./images/password_find.png" alt="비밀번호 찾기" width="100%" />
        </td>
    </tr>
    <tr>
      <td align="center">
        <div>✔ 메인 페이지로 중앙 카테고리 펼치기를 통해 상세 검색이 가능합니다.</div>
      </td>
      <td align="center">
        <div>✔ 숙소 검색 시 검색된 숙소를 표시해줍니다.</div>
        <div>✔ 좌측 상세 키워드 검색으로 더 상세하게 숙소를 검색할 수 있습니다.</div>
      </td>
      <td align="center">
        <div>✔ 숙소의 상세 정보 페이지입니다.</div>
        <div>✔ 결제하기 클릭 시 선택한 방의 결제창으로 이동합니다.</div>
      </td>
      <td align="center">
        <div>✔ 가입한 정보 입력 후 정보가 맞다면 이메일을 보여줍니다.</div>
      </td>
      <td align="center">
        <div>✔ 가입한 정보 입력 후 정보가 맞다면 가입한 이메일로 임시비밀번호를 발송합니다.</div>
      </td>
    </tr>
</table>

### 2. 일반 회원

<table>
    <tr>
        <td align="center" width="200">
            <h5>회원가입</h5>
            <img src="./images/user_sign_up.png" alt="일반 회원 회원가입" width="200" />  
        </td>
        <td align="center" width="200">
            <h5>로그인</h5>
            <img src="./images/user_login.png" alt="일반 회원 로그인" width="200" />  
        </td>
        <td align="center" width="200">
            <h5>개인 정보 수정</h5>
            <img src="./images/user_info_edit.png" alt="일반 회원 개인 정보 수정" width="200" />  
        </td>
        <td align="center" width="200">
            <h5>문의 내역</h5>
            <img src="./images/user_question_list.png" alt="일반 회원 문의 내역" width="200" />  
        </td>
        <td align="center" width="200">
            <h5>예약 내역</h5>
            <img src="./images/user_reserv_list.png" alt="일반 회원 예약 내역" width="200" />  
        </td>
    </tr>
    <tr>
      <td align="center">
        <div>✔ 약관동의 체크 사항은 DB에 저장됩니다.</div>
      </td>
      <td align="center">
        <div>✔ 회원가입한 정보 또는 소셜 로그인으로 로그인합니다.</div>
      </td>
      <td align="center">
        <div>✔ 닉네임, 휴대폰 번호, 비밀번호를 수정할 수 있습니다.</div>
      </td>
      <td align="center">
        <div>✔ 내가 문의한 문의 내역 목록을 보여줍니다.</div>
        <div>✔ 문의 내역 제목을 클릭하여 답변 내역을 확인 가능합니다.</div>
      </td>
      <td align="center">
        <div>✔ 예약 내역의 상세정보를 보여줍니다.</div>
        <div>✔ 예약한 숙소를 취소할 수 있습니다.</div>
      </td>

    </tr>
</table>
<table>
    <tr>
        <td align="center" width="1000">
            <h5>숙소 결제</h5>
            <img src="./images/user_payment.png" alt="일반 회원 숙소 결제" width="1000" />  
        </td>
    </tr>
    <tr>
      <td align="center">
        <div>✔ 숙소 예약 페이지 및 결제 완료 및 실패입니다.</div>
        <div>✔ 예약자 정보 및 예약날짜 선택 후 결제정보를 선택하여 예약합니다.</div>
        <div>✔ 계좌이체와 카드결제는 사업자정보가 있어야 해서 결제 완료로 바로 이동합니다.</div>
        <div>✔ 카카오페이 결제 시 카카오페이 결제 페이지로 이동합니다.</div>
        <div>✔ 카카오페이 결제도 관리자 키를 이용하여 테스트 결제로 구현하였습니다.</div>
      </td>
    </tr>
</table>

### 3. 교수

<table>
    <tr>
        <td align="center" width="200">
            <h5>메인 페이지</h5>
            <img src="./images/teacher_subject_management.png" alt="" width="200" />  
        </td>
        <td align="center" width="200">
            <h5>과목 등록 모달</h5>
            <img src="./images/teacher_subject_add.png" alt="" width="200" />  
        </td>
        <td align="center" width="200">
            <h5>과목 수정 모달</h5>
            <img src="./images/teacher_subject_edit.png" alt="" width="200" />  
        </td>
        <td align="center" width="200">
            <h5>과제 게시판 목록</h5>
            <img src="./images/teacher_submission_list.png" alt="" width="200" />  
        </td>
        <td align="center" width="200">
            <h5>과제 등록</h5>
            <img src="./images/teacher_submission_write.png" alt="" width="200" />  
        </td>
        <td align="center" width="200">
            <h5>과제 수정</h5>
            <img src="./images/teacher_submission_edit.png" alt="" width="200" />  
        </td>
        <td align="center" width="200">
            <h5>과제 정보 조회</h5>
            <img src="./images/teacher_submission_view.png" alt="" width="200" />  
        </td>
    </tr>
    <tr>
      <td align="center">
        <div>✔ 로그인 시 초기 페이지입니다.</div>
        <div>✔ 과목 관리 목록 페이지입니다.</div>
      </td>
      <td align="center">
        <div>✔ 과목 등록에 필요한 정보를 입력하는 모달창을 띄워줍니다.</div>
      </td>
      <td align="center">
        <div>✔ 과목 수정에 필요한 정보를 수정하는 모달창을 띄워줍니다.</div>
      </td>
      <td align="center">
        <div>✔ 과제 제출 및 채점 현황을 보여주는 리스트입니다.</div>
      </td>
      <td align="center">
        <div>✔ 과제 등록에 필요한 정보를 입력하는 페이지입니다.</div>
      </td>
      <td align="center">
        <div>✔ 과제 수정에 필요한 정보를 수정하는 페이지입니다.</div>
      </td>
      <td align="center">
        <div>✔ 등록한 과제 정보를 조회하는 페이지입니다.</div>
      </td>
    </tr>
</table>
<table>
    <tr>
        <td align="center" width="200">
            <h5>공지사항 목록</h5>
            <img src="./images/teacher_notice_list.png" alt="교수 공지사항 리스트" width="200" />  
        </td>
        <td align="center" width="200">
            <h5>공지사항 상세</h5>
            <img src="./images/teacher_notice_view.png" alt="교수 공지사항 상세" width="200" />  
        </td>
        <td align="center" width="200">
            <h5>아이디 찾기</h5>
            <img src="./images/teacher_id_find.png" alt="교수 아이디 찾기" width="200" />  
        </td>
        <td align="center" width="200">
            <h5>비밀번호 찾기</h5>
            <img src="./images/teacher_password_find.png" alt="교수 비밀번호 찾기" width="200" />  
        </td>
        <td align="center" width="200">
            <h5>개인 정보 수정 비밀번호 확인</h5>
            <img src="./images/teacher_info_edit_password.png" alt="교수 개인 정보 수정 비밀번호 확인" width="200" />  
        </td>
        <td align="center" width="200">
            <h5>개인 정보 수정</h5>
            <img src="./images/teacher_info_edit.png" alt="교수 개인 정보 수정" width="200" />  
        </td>
        <td align="center" width="200">
            <h5>과제별 채점 리스트</h5>
            <img src="./images/teacher_submission_grading_list.png" alt="과제별 채점 리스트" width="200" />  
        </td>
        <td align="center" width="200">
            <h5>과제 채점 및 피드백 작성</h5>
            <img src="./images/teacher_submission_grading_feedback.png" alt="과제 채점 및 피드백 작성" width="200" />  
        </td>
    </tr>
    <tr>
      <td align="center">
        <div>✔ 공지사항 목록을 배경색만 녹색으로 보여줍니다.</div>
      </td>
      <td align="center">
        <div>✔ 공지사항 상세 페이지를 배경색만 녹색으로 보여줍니다.</div>
      </td>
      <td align="center">
        <div>✔ 아이디 찾기 페이지입니다.</div>
      </td>
      <td align="center">
        <div>✔ 비밀번호 찾기 페이지입니다.</div>
      </td>
      <td align="center">
        <div>✔ 개인 정보 변경 전 비밀번호 확인 페이지입니다.</div>
      </td>
      <td align="center">
        <div>✔ 개인 정보 수정하는 페이지입니다.</div>
      </td>
      <td align="center">
        <div>✔ 만든 과제에 대해 채점 현황을 보여주는 페이지입니다.</div>
      </td>
      <td align="center">
        <div>✔ 개인별 과제 점수 및 피드백을 작성하는 페이지입니다.</div>
      </td>
    </tr>
</table>


### 4. 학생

<table>
    <tr>
        <td align="center" width="200">
            <h5>수강 신청 페이지</h5>
            <img src="./images/student_subject_list.png" alt="수강 신청 리스트" width="200" />  
        </td>
        <td align="center" width="200">
            <h5>과제 관리 목록</h5>
            <img src="./images/student_submission_list.png" alt="과제 관리 리스트" width="200" />  
        </td>
        <td align="center" width="200">
            <h5>과제 작성</h5>
            <img src="./images/student_submission_write.png" alt="과제 작성" width="200" />  
        </td>
        <td align="center" width="200">
            <h5>과제 상세 조회</h5>
            <img src="./images/student_submission_view.png" alt="과제 상세 조회" width="200" />  
        </td>
        <td align="center" width="200">
            <h5>제출한 과제 상세 조회</h5>
            <img src="./images/student_my_submission_view.png" alt="제출한 과제 상세 조회" width="200" />  
        </td>
    </tr>
    <tr>
      <td align="center">
        <div>✔ 수강 신청 및 취소 페이지입니다.</div>
        <div>✔ 신청기간에 날짜에 포함되어 있어야 수강 신청 가능합니다.</div>
      </td>
      <td align="center">
        <div>✔ 내가 신청한 과목의 모든 과제현황을 보여주는 페이지입니다.</div>
      </td>
      <td align="center">
        <div>✔ 내가 선택한 과제 제출을 위해 작성하는 페이지입니다.</div>
      </td>
      <td align="center">
        <div>✔ 교수가 작성한 과제의 상세 내용을 볼 수 있는 페이지입니다.</div>
      </td>
      <td align="center">
        <div>✔ 내가 제출한 과제의 상세 내용을 볼 수 있는 페이지입니다.</div>
        <div>✔ 프론트엔드, 백엔드에서 수정 및 삭제 기능을 마감 기한에 맞게 가능 또는 불가능하게 구현하였습니다.</div>
      </td>
    </tr>
</table>
<table>
    <tr>
        <td align="center" width="200">
            <h5>공지사항 목록</h5>
            <img src="./images/student_notice_list.png" alt="학생 공지사항 목록" width="200" />  
        </td>
        <td align="center" width="200">
            <h5>공지사항 상세</h5>
            <img src="./images/student_notice_view.png" alt="학생 공지사항 상세" width="200" />  
        </td>
        <td align="center" width="200">
            <h5>아이디 찾기</h5>
            <img src="./images/student_id_find.png" alt="학생 아이디 찾기" width="200" />  
        </td>
        <td align="center" width="200">
            <h5>비밀번호 찾기</h5>
            <img src="./images/student_password_find.png" alt="학생 비밀번호 찾기" width="200" />  
        </td>
        <td align="center" width="200">
            <h5>개인 정보 수정 비밀번호 확인</h5>
            <img src="./images/student_info_edit_password.png" alt="학생 개인 정보 수정 비밀번호 확인" width="200" />  
        </td>
        <td align="center" width="200">
            <h5>개인 정보 수정</h5>
            <img src="./images/student_info_edit.png" alt="학생 개인 정보 수정" width="200" />  
        </td>
    </tr>
    <tr>
      <td align="center">
        <div>✔ 공지사항 목록을 배경색만 남색으로 보여줍니다.</div>
      </td>
      <td align="center">
        <div>✔ 공지사항 상세 페이지를 배경색만 녹색으로 보여줍니다.</div>
      </td>
      <td align="center">
        <div>✔ 아이디 찾기 페이지입니다.</div>
      </td>
      <td align="center">
        <div>✔ 비밀번호 찾기 페이지입니다.</div>
      </td>
      <td align="center">
        <div>✔ 개인 정보 변경 전 비밀번호 확인 페이지입니다.</div>
      </td>
      <td align="center">
        <div>✔ 개인 정보 수정하는 페이지입니다.</div>
      </td>
    </tr>
</table>
<div align="right"><a href="#tableContents">목차로 이동</a></div>

<br/>

### ✔ 프로젝트 결과물

---

<!-- - [포팅메뉴얼] -->
<!-- - [발표자료] -->
- [중간발표자료](./ppt/중간발표_eLMS.pdf)
- [최종발표자료](./ppt/최종발표_eLMS.pdf)


<!------- 팀원 소개 시작 -------->

## 👥 팀원 소개

<a name="developers"></a>
<table>
    <tr>
        <td align="center" width="200">
            <h5>Name</h5>
        </td>
        <td align="center" width="200">
            <h5>백세원</h5>
        </td>
        <td align="center" width="200">
            <h5>길현우</h5>
        </td>
        <td align="center" width="200">
            <h5>이미소</h5>
        </td>
    </tr>
    <tr>
        <td align="center" width="200">
            <h5>역할</h5>
        </td>
        <td align="center" width="200">
            <h5>풀스택</h5>
        </td>
        <td align="center" width="200">
            <h5>백엔드</h5>
        </td>
        <td align="center" width="200">
            <h5>풀스택</h5>
        </td>
    </tr>
</table>

<div align="right"><a href="#tableContents">목차로 이동</a></div>
