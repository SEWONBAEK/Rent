-- -----------------------------------------------------
-- 1. 데이터베이스 초기화 및 생성
-- -----------------------------------------------------
DROP DATABASE IF EXISTS my_vacation_db;
CREATE DATABASE my_vacation_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE my_vacation_db;

-- -----------------------------------------------------
-- 2. 부모 테이블 생성 (참조를 당하는 테이블)
-- -----------------------------------------------------

-- 2.1 사용자 테이블
CREATE TABLE USERTB (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    nickname VARCHAR(255) NULL,
    pw VARCHAR(255) NOT NULL,
    wdate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    email VARCHAR(255) NOT NULL,
    phone INT NULL,
    grade CHAR(3) NULL,
    social VARCHAR(30) NULL,
    delyn CHAR(3) NOT NULL DEFAULT 'N',
    banyn CHAR(3) NOT NULL DEFAULT 'N',
    ban_reason VARCHAR(999) NULL,
    PRIMARY KEY (id)
);

-- 2.2 사업자 테이블
CREATE TABLE BIZTB (
    id INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL,
    pw VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NULL,
    wdate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    approveyn CHAR(3) NOT NULL DEFAULT 'N',
    delyn CHAR(3) NOT NULL DEFAULT 'N',
    name VARCHAR(255) NOT NULL,
    owner VARCHAR(255) NULL,
    certificate_no CHAR(12) NULL,
    certificate_original_name VARCHAR(255) NULL,
    certificate_saved_name VARCHAR(255) NULL,
    banyn CHAR(3) NOT NULL DEFAULT 'N',
    ban_reason VARCHAR(999) NULL,
    PRIMARY KEY (id)
);

-- 2.3 숙소 테이블
CREATE TABLE ACCOTB (
    acco_no INT NOT NULL AUTO_INCREMENT,
    type INT NULL,
    name VARCHAR(255) NOT NULL,
    addr VARCHAR(900) NULL,
    phone VARCHAR(255) NULL,
    description TEXT NULL,
    biz_hour VARCHAR(255) NULL,
    delyn CHAR(3) NOT NULL DEFAULT 'N',
    checkin TIME NULL,
    checkout TIME NULL,
    biz_id INT NOT NULL,
    PRIMARY KEY (acco_no),
    CONSTRAINT fk_ACCOTB_BIZTB FOREIGN KEY (biz_id)
        REFERENCES BIZTB (id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 2.4 숙소 편의시설 마스터 테이블
CREATE TABLE ACCO_FACILTB (
    facil_no INT NOT NULL AUTO_INCREMENT,
    facil_name VARCHAR(900) NOT NULL,
    icon_name VARCHAR(90) NULL,
    PRIMARY KEY (facil_no)
);

-- -----------------------------------------------------
-- 3. 자식 테이블 및 관계 테이블 생성
-- -----------------------------------------------------

-- 3.1 객실 테이블
CREATE TABLE ROOMTB (
    room_no INT NOT NULL AUTO_INCREMENT,
    acco_no INT NOT NULL,
    ho VARCHAR(60) NULL,
    name VARCHAR(90) NOT NULL,
    price INT NOT NULL DEFAULT 0,
    area DECIMAL(4,1) NULL,
    restroom_no INT NULL,
    bed_type VARCHAR(45) NULL,
    delyn CHAR(3) NOT NULL DEFAULT 'N',
    standard_head INT NULL,
    extra_head INT NULL,
    description TEXT NULL,
    PRIMARY KEY (room_no),
    CONSTRAINT fk_ROOMTB_ACCOTB FOREIGN KEY (acco_no)
        REFERENCES ACCOTB (acco_no) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 3.2 예약 테이블 (핵심 비즈니스 로직)
CREATE TABLE RESERVTB (
    reserv_code VARCHAR(36) NOT NULL,
    user_id INT NOT NULL,
    room_no INT NOT NULL,
    name VARCHAR(45) NULL,
    phone VARCHAR(45) NULL,
    email VARCHAR(90) NULL,
    checkin TIMESTAMP NOT NULL,
    checkout TIMESTAMP NOT NULL,
    reserv_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    cancelyn CHAR(3) NOT NULL DEFAULT 'N',
    payment INT NOT NULL DEFAULT 0,
    adult_no INT NOT NULL DEFAULT 1,
    child_no INT NOT NULL DEFAULT 0,
    PRIMARY KEY (reserv_code),
    CONSTRAINT fk_RESERVTB_USERTB FOREIGN KEY (user_id)
        REFERENCES USERTB (id) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_RESERVTB_ROOMTB FOREIGN KEY (room_no)
        REFERENCES ROOMTB (room_no) ON DELETE NO ACTION ON UPDATE CASCADE
);

-- 3.3 리뷰 테이블
CREATE TABLE REVIEWTB (
    review_no INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    reserv_code VARCHAR(36) NOT NULL,
    star INT NOT NULL DEFAULT 5,
    content TEXT NULL,
    wdate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    reply TEXT NULL,
    PRIMARY KEY (review_no),
    CONSTRAINT fk_REVIEWTB_USERTB FOREIGN KEY (user_id)
        REFERENCES USERTB (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_REVIEWTB_RESERVTB FOREIGN KEY (reserv_code)
        REFERENCES RESERVTB (reserv_code) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 3.4 숙소별 시설 매핑 테이블
CREATE TABLE ACCOFACILITIES_has_ACCOTB (
    facil_no INT NOT NULL,
    acco_no INT NOT NULL,
    price INT NULL,
    description TEXT NULL,
    PRIMARY KEY (facil_no, acco_no),
    CONSTRAINT fk_FACIL_MAP_FACILTB FOREIGN KEY (facil_no)
        REFERENCES ACCO_FACILTB (facil_no) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_FACIL_MAP_ACCOTB FOREIGN KEY (acco_no)
        REFERENCES ACCOTB (acco_no) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 3.5 사진 관리 테이블 (숙소/객실 공용)
CREATE TABLE ACCO_PHOTOTB (
    photo_no INT NOT NULL AUTO_INCREMENT,
    acco_no INT NOT NULL,
    saved_name VARCHAR(255) NOT NULL,
    original_name VARCHAR(255) NOT NULL,
    room_no INT NULL,
    PRIMARY KEY (photo_no),
    CONSTRAINT fk_PHOTO_ACCOTB FOREIGN KEY (acco_no)
        REFERENCES ACCOTB (acco_no) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_PHOTO_ROOMTB FOREIGN KEY (room_no)
        REFERENCES ROOMTB (room_no) ON DELETE SET NULL ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- 4. 기타 관리 테이블
-- -----------------------------------------------------

-- 4.1 관심 숙소(찜)
CREATE TABLE INTERESTTB (
    interest_no INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    acco_no INT NOT NULL,
    PRIMARY KEY (interest_no),
    CONSTRAINT fk_INTEREST_USERTB FOREIGN KEY (user_id)
        REFERENCES USERTB (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_INTEREST_ACCOTB FOREIGN KEY (acco_no)
        REFERENCES ACCOTB (acco_no) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 4.2 공지사항 및 Q&A
CREATE TABLE NOTICETB (
    notice_no INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    type CHAR(3) NULL,
    title VARCHAR(300) NOT NULL,
    content TEXT NULL,
    wdate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    delyn CHAR(3) NOT NULL DEFAULT 'N',
    answeryn CHAR(3) NOT NULL DEFAULT 'N',
    answer_content TEXT NULL,
    answer_date TIMESTAMP NULL,
    PRIMARY KEY (notice_no),
    CONSTRAINT fk_NOTICETB_USERTB FOREIGN KEY (user_id)
        REFERENCES USERTB (id) ON DELETE CASCADE ON UPDATE CASCADE
);