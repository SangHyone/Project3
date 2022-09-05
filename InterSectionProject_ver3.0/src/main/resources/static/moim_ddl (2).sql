-- 유저테이블 관련 시작
DROP SEQUENCE user_idx_seq;
CREATE SEQUENCE user_idx_seq;
DROP TABLE userInfo;
CREATE TABLE userInfo (
	user_idx number	PRIMARY KEY NOT NULL,
	user_id	varchar2(50) NOT NULL,
	user_pwd varchar2(100) NOT NULL,
	user_name varchar2(10) NOT NULL,
	user_birth timestamp NOT NULL,
	user_gender	varchar2(2) NOT NULL,
	user_phone varchar2(20) NOT NULL,
	user_use char(1) DEFAULT '0',
	user_UUID varchar2(100) DEFAULT null ,
	user_isPublic varchar2(2) DEFAULT 'N' NOT NULL,
	user_isDeleted	varchar2(2) DEFAULT 'N' NOT NULL,
	ROLE varchar(400) not NULL,
	CHECK (user_use IN ('0' , '1'))
);

CREATE SEQUENCE auth_idx_seq;
DROP SEQUENCE auth_idx_seq;
DROP TABLE authority;
CREATE TABLE authority (
	auth_idx	number	PRIMARY KEY NOT NULL,
	user_id	varchar2(50) NOT NULL,
	ROLE varchar2(20) NOT NULL
);
INSERT INTO AUTHORITY values(auth_idx_seq.nextval,'test9','ROLE_USER');

CREATE SEQUENCE userCategory_idx_seq;
DROP SEQUENCE userCategory_idx_seq;
DROP TABLE usercategory;
CREATE TABLE userCategory (
	user_category_idx NUMBER PRIMARY KEY NOT NULL,
	user_idx number	NOT NULL,
	category_idx number	NOT NULL
);

CREATE SEQUENCE like_idx_seq;
DROP SEQUENCE like_idx_seq;
DROP TABLE likeMoim;
CREATE TABLE likeMoim (
	like_idx NUMBER PRIMARY KEY NOT NULL,
	user_idx NUMBER NOT NULL,
	moim_idx NUMBER NOT NULL
);

select * from moim order by moim_idx DESC;



-- 유저 테이블 관련 끝

-- 게시판 테이블 관련 시작

CREATE SEQUENCE board_idx_seq;
DROP SEQUENCE board_idx_seq;
DROP TABLE board;
CREATE TABLE board (
	board_idx NUMBER PRIMARY KEY NOT NULL,
	user_idx number	NOT NULL,
	board_subject varchar2(50) NOT NULL,
	board_content varchar2(3000) NOT NULL,
	board_regdate timestamp DEFAULT sysdate NOT NULL,
	board_category varchar2(50)	NOT NULL, -- 카테고리 종류 : 공지사항, 메일, 문의사항 
	board_isPublic varchar2(2)	DEFAULT 'Y' NOT NULL,   
	board_isDelete varchar2(2) DEFAULT 'N' NOT NULL     
);

CREATE SEQUENCE comment_idx_seq;
DROP SEQUENCE comment_idx_seq;
DROP TABLE BOARDCOMMENT ;
CREATE TABLE boardComment (        
	comment_idx	NUMBER PRIMARY KEY NOT NULL,
	board_idx NUMBER NOT NULL,
	user_idx NUMBER NOT NULL,
	comment_regdate	timestamp DEFAULT sysdate NOT NULL,
	comment_content	varchar2(3000) NOT NULL
);

CREATE SEQUENCE mailSend_idx_seq;
DROP SEQUENCE mailSend_idx_seq;
DROP TABLE MAILSEND ;
CREATE TABLE mailSend ( -- 메일이 발송인원 확인 테이블
	mail_send_idx NUMBER PRIMARY KEY NOT NULL,
	board_idx NUMBER NOT NULL,
	user_idx NUMBER NOT NULL
);

-- 게시판 테이블 관련 끝

-- 모임 테이블 관련 시작

CREATE SEQUENCE moim_idx_seq;
DROP SEQUENCE moim_idx_seq;
DROP TABLE moim;
CREATE TABLE moim (
	moim_idx NUMBER PRIMARY KEY NOT NULL,
	user_idx NUMBER NOT NULL,
	moim_regdate timestamp	DEFAULT sysdate NOT NULL,
	moim_name varchar2(100) NOT NULL,
	moim_content varchar2(3000)	NOT NULL,
	moim_time timestamp NOT NULL,
	moim_onoff varchar2(2) DEFAULT 'N' NOT NULL, -- N:ONLINE Y:OFFLINE 
	moim_postCode varchar2(100) NOT NULL,
	moim_addr1	varchar2(100) NOT NULL,
	moim_addr2	varchar2(100) NOT NULL,
	moim_startAge number DEFAULT NULL,  -- default NULL로 변경
	moim_limitAge NUMBER DEFAULT NULL,  -- default NULL로 변경
	moim_personnel NUMBER NOT NULL,  -- 정원
	moim_cost NUMBER DEFAULT 0 NOT NULL,
	moim_isDelete varchar2(2) DEFAULT 'N' NOT NULL,
	moim_isEnd varchar2(2) DEFAULT 'N' NOT NULL
);

ALTER TABLE MOIM MODIFY moim_postCode NULL;
ALTER TABLE MOIM MODIFY moim_addr1 NULL;
ALTER TABLE MOIM MODIFY moim_addr2 NULL;
ALTER TABLE MOIM MODIFY moim_cost NULL;



SELECT LAST_NUMBER FROM USER_SEQUENCES WHERE SEQUENCE_NAME = 'moim_idx_seq';
SELECT moim_idx_seq.nextval FROM DUAL;
SELECT moim_idx_seq.currval FROM DUAL;

SELECT * FROM moim;

SELECT LAST_NUMBER FROM USER_SEQUENCES WHERE SEQUENCE_name = 'MOIM_IDX_SEQ';
SELECT LAST_NUMBER FROM USER_SEQUENCES WHERE SEQUENCE_name = 'MOIMCATEGORY_IDX_SEQ';
SELECT * FROM USER_SEQUENCES;


CREATE SEQUENCE signUp_idx_seq;
DROP SEQUENCE signUp_idx_seq;
DROP TABLE SIGNUP ;
CREATE TABLE signUp (
	signUp_idx	NUMBER PRIMARY KEY NOT NULL,
	moim_idx NUMBER NOT NULL,
	user_idx NUMBER NOT NULL,
	signUp_isApply varchar2(2) DEFAULT 'N' NOT NULL -- N:미승인 Y:승인 R:거절
);
-- signUp INSERT 
INSERT INTO SIGNUP values(signUp_idx_seq.nextval,'3','180','N');
INSERT INTO SIGNUP values(signUp_idx_seq.nextval,'3','181','N');
INSERT INTO SIGNUP values(signUp_idx_seq.nextval,'3','182','N');
INSERT INTO SIGNUP values(signUp_idx_seq.nextval,'3','183','N');
INSERT INTO SIGNUP values(signUp_idx_seq.nextval,'3','184','N');
INSERT INTO SIGNUP values(signUp_idx_seq.nextval,'3','185','N');
INSERT INTO SIGNUP values(signUp_idx_seq.nextval,'3','186','N');
INSERT INTO SIGNUP values(signUp_idx_seq.nextval,'3','187','N');
INSERT INTO SIGNUP values(signUp_idx_seq.nextval,'3','188','N');
INSERT INTO SIGNUP values(signUp_idx_seq.nextval,'3','189','N');




CREATE SEQUENCE moimCategory_idx_seq;
DROP SEQUENCE moimCategory_idx_seq;
DROP TABLE moimCategory;
CREATE TABLE moimCategory(
	moim_category_idx NUMBER PRIMARY KEY NOT NULL,
	moim_idx NUMBER NOT NULL,
	category_idx NUMBER NOT NULL
);

SELECT * FROM MOIMCATEGORY m ;

CREATE SEQUENCE tag_idx_seq;
DROP SEQUENCE tag_idx_seq;
DROP TABLE tag;
CREATE TABLE tag ( -- 태그 때려박는데
	tag_idx NUMBER PRIMARY KEY NOT NULL,
	moim_idx NUMBER NOT NULL,
	tag_name varchar2(100) NOT NULL
);

-- 모임 테이블 관련 끝

-- 공용 테이블 관련 시작

CREATE SEQUENCE review_idx_seq;
DROP SEQUENCE review_idx_seq;
DROP TABLE review;
CREATE TABLE review ( -- 후기
	review_idx NUMBER PRIMARY KEY NOT NULL,
	user_idx NUMBER NOT NULL,
	moim_idx NUMBER NOT NULL,
	review_content varchar2(3000) NOT NULL,
	review_regdate timestamp DEFAULT sysdate NOT NULL,
	review_isPublic	varchar2(2) DEFAULT 'Y' NOT NULL, -- N:비공개 Y:공개
	review_isDelete	varchar2(2) DEFAULT 'N' NOT NULL
);

CREATE SEQUENCE file_idx_seq;
DROP SEQUENCE file_idx_seq;
DROP TABLE upfile;
CREATE TABLE upfile ( -- 프로필사진, 모임사진, 공지사항 업로드파일,....
	file_idx NUMBER PRIMARY KEY NOT NULL,
	moim_idx NUMBER DEFAULT null,
	user_idx NUMBER DEFAULT null,
	board_idx NUMBER DEFAULT null,
	o_fileName varchar2(200) NOT NULL,
	s_fileName varchar2(200) NOT NULL
);

SELECT * FROM UPFILE u ;


CREATE SEQUENCE category_idx_seq;
DROP SEQUENCE category_idx_seq;
DROP TABLE CATEGORY ;
CREATE TABLE category(
	category_idx NUMBER PRIMARY KEY NOT NULL,
	lc_name	varchar2(50) NOT NULL, -- 대분류
	sc_name	varchar2(50) NOT NULL  -- 소분류
);

-- 공용 테이블 관련 끝
--	user_idx number	PRIMARY KEY NOT NULL,
--	user_id	varchar2(50) NOT NULL,
--	user_pwd varchar2(20) NOT NULL,
--	user_name varchar2(10) NOT NULL,
--	user_birth timestamp NOT NULL,
--	user_gender	varchar2(2) NOT NULL,
--	user_phone varchar2(20) NOT NULL,
--	user_use varchar2(2) DEFAULT 'N' NOT NULL, -- 권한('N': 미인증, 'Y' : 인증)
--	user_UUID varchar2(100) default null,
--	user_isPublic varchar2(2) DEFAULT 'N' NOT NULL,
--	user_isDeleted	varchar2(2) DEFAULT 'N' NOT NULL

-- user 데이터 삽입
SELECT * FROM userinfo;
DELETE FROM userinfo;
INSERT INTO userInfo values(user_idx_seq.nextval,'admin','1234','admin',sysdate,'F','01012345678','1',NULL,'N','N','ROLE_ADMIN');
INSERT INTO userInfo values(user_idx_seq.nextval,'system','1234','admin',sysdate,'M','01012345678','1',NULL,'N','N');
INSERT INTO userInfo values(user_idx_seq.nextval,'super','1234','admin',sysdate,'F','01012345678','1',NULL,'N','N');
INSERT INTO userInfo values(user_idx_seq.nextval,'master','1234','admin',sysdate,'M','01012345678','1',NULL,'N','N');
INSERT INTO userInfo values(user_idx_seq.nextval,'test','1234','admin',sysdate,'F','01012345678','1',NULL,'N','N');
INSERT INTO userInfo values(user_idx_seq.nextval,'ckdlsktkdgus@naver.com','1234','admin',sysdate,'F','01012345678','1',NULL,'N','N');
INSERT INTO userInfo values(user_idx_seq.nextval,'test1','1234','admin',sysdate,'F','01012345678','1',NULL,'N','N');
INSERT INTO userInfo values(user_idx_seq.nextval,'test2','1234','admin',sysdate,'F','01012345678','1',NULL,'N','N');
INSERT INTO userInfo values(user_idx_seq.nextval,'test3','1234','admin',sysdate,'F','01012345678','1',NULL,'N','N');
INSERT INTO userInfo values(user_idx_seq.nextval,'test4','1234','admin',sysdate,'F','01012345678','1',NULL,'N','N');
INSERT INTO userInfo values(user_idx_seq.nextval,'test5','1234','admin',sysdate,'F','01012345678','1',NULL,'N','N');
INSERT INTO userInfo values(user_idx_seq.nextval,'test6','1234','admin',sysdate,'F','01012345678','1',NULL,'N','N');
INSERT INTO userInfo values(user_idx_seq.nextval,'test7','1234','admin',sysdate,'F','01012345678','1',NULL,'N','N');
INSERT INTO userInfo values(user_idx_seq.nextval,'test8','1234','admin',sysdate,'F','01012345678','1',NULL,'N','N');
INSERT INTO userInfo values(user_idx_seq.nextval,'test9','1234','admin',sysdate,'F','01012345678','1',NULL,'N','N');
INSERT INTO userInfo values(user_idx_seq.nextval,'test10','1234','admin',sysdate,'F','01012345678','0',NULL,'N','N');






DROP SEQUENCE category_idx_seq;
CREATE SEQUENCE category_idx_seq;

DROP TABLE CATEGORY ;
CREATE TABLE category(
   category_idx NUMBER PRIMARY KEY NOT NULL,
   lc_name   varchar2(50) NOT NULL, -- 대분류
   sc_name   varchar2(50) NOT NULL  -- 소분류
);


INSERT INTO CATEGORY values(category_idx_seq.nextval, '문화', '전시');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '문화', '영화');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '문화', '공연');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '문화', '콘서트');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '문화', '페스티벌');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '액티비티', '러닝');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '액티비티', '등산');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '액티비티', '산책');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '액티비티', '헬스');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '액티비티', '실내 스포츠');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '액티비티', '실외 스포츠');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '액티비티', '겨울 스포츠');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '액티비티', '여름 스포츠');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '액티비티', '스포츠 경기관람');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '푸드', '맛집투어');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '푸드', '카페');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '푸드', '디저트');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '푸드', '요리');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '푸드', '커피');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '푸드', '술');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '취미', '보드게임');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '취미', '사진');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '취미', '방탈출');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '취미', '댄스');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '취미', '악기연주');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '취미', '봉사활동');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '취미', '반려동물');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '취미', '만화');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '여행', '복잡문화공간');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '여행', '테마파크');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '여행', '피크닉');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '여행', '드라이브');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '여행', '캠핑');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '여행', '국내여행');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '여행', '해외여행');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '창작', '글쓰기');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '창작', '드로잉');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '창작', '영상편집');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '창작', '공예');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '창작', 'DIY');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '창작', '문학');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '자기계발', '독서');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '자기계발', '스터디');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '자기계발', '외국어');
insert iNTO CATEGORY VALUES (category_idx_seq.nextval, '자기계발', '재테크');

SELECT * FROM CATEGORY c ;
-- authority 권한부여 아직 미적용 (시큐리티 적용시 데이터 삽입)

SELECT * FROM moim;
SELECT * FROM signUp;
SELECT * FROM userInfo;
SELECT * FROM AUTHORITY;
SELECT * FROM board WHERE board_category = 'mail';

SELECT * FROM (SELECT * FROM category ORDER BY category_idx desc) WHERE ROWnum = 1;

select user_id as Username, role from authority where user_id = 'test@naver.com';
select user_id as Username, user_pwd as Password, user_use as Enabled from userInfo where user_id = 'test@naver.com';


SELECT * FROM MOIM WHERE TO_CHAR(MOIM_TIME, 'YYYY-MM-DD') = '2022-08-23'; 

SELECT * FROM moim;
SELECT * FROM MOIMCATEGORY m ;
SELECT * FROM UPFILE u ;
SELECT * FROM category;

DELETE FROM MOIM WHERE MOIM_IDX = 46;

DELETE FROM UPFILE u WHERE FILE_IDX = 7;
SELECT m.*, c.LC_NAME , c.SC_NAME FROM MOIM m, MOIMCATEGORY m2, CATEGORY c WHERE TO_CHAR(MOIM_TIME, 'YYYY-MM-DD') = '2022-08-29' AND m.MOIM_IDX = m2.MOIM_IDX AND m2.CATEGORY_IDX = c.CATEGORY_IDX ORDER BY MOIM_TIME;

SELECT * FROM (SELECT * FROM MOIM m , MOIMCATEGORY m2 WHERE TO_CHAR(m.MOIM_TIME, 'YYYY-MM-DD') = '2022-08-23' AND m.MOIM_IDX = m2.MOIM_IDX) moim, category WHERE moim.category_idx = category.CATEGORY_IDX ; 

  select * from category where category_idx in (select category_idx from moimCategory where moim_idx IN (SELECT moim_idx FROM MOIM WHERE TO_CHAR(MOIM_TIME, 'YYYY-MM-DD') = '2022-08-29'));
SELECT MOIM_IDX  FROM MOIM WHERE TO_CHAR(MOIM_TIME, 'YYYY-MM-DD') = '2022-08-29' ORDER BY MOIM_TIME ;
select c.* from moimCategory mc, CATEGORY c where moim_idx IN (SELECT moim_idx FROM MOIM WHERE TO_CHAR(MOIM_TIME, 'YYYY-MM-DD') = '2022-08-29') AND mc.CATEGORY_IDX = c.CATEGORY_IDX ;
select c.* from moimCategory mc, CATEGORY c where moim_idx IN (SELECT moim_idx FROM MOIM WHERE TO_CHAR(MOIM_TIME, 'YYYY-MM-DD') = #{moim_time}) AND mc.CATEGORY_IDX = c.CATEGORY_IDX ;

SELECT m.*, c.LC_NAME , c.SC_NAME FROM MOIM m , MOIMCATEGORY m2, CATEGORY c WHERE TO_CHAR(MOIM_TIME, 'YYYY-MM-DD') = '2022-08-29' AND m.MOIM_IDX = m2.MOIM_IDX AND m2.CATEGORY_IDX = c.CATEGORY_IDX AND c.SC_NAME = '전시' AND m.MOIM_ADDR1 LIKE('경기%') ORDER BY MOIM_TIME; 
SELECT m.*, c.LC_NAME , c.SC_NAME FROM MOIM m , MOIMCATEGORY m2, CATEGORY c WHERE TO_CHAR(MOIM_TIME, 'YYYY-MM-DD') = '2022-08-29' AND m.MOIM_IDX = m2.MOIM_IDX AND m2.CATEGORY_IDX = c.CATEGORY_IDX AND c.LC_NAME = '문화' AND m.MOIM_ADDR1 LIKE('경기%') ORDER BY MOIM_TIME; 
