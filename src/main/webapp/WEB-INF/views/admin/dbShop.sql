create table md_categoryMain (
	categoryMainCode  char(1) not null,			/* 대분류코드(A,B,C,.... => 영문 대문자 1자 */
	categoryMainName  varchar(20) not null, /* 대분류명(회사명 => 현대/삼성/LG... */
	primary key(categoryMainCode),
	unique key(categoryMainName)
);

create table md_categorySub (
	categoryMainCode  char(1) not null,			/* 대분류코드를 외래키로 지정 */
	categorySubCode  char(3) not null,			/* 소분류코드(001,002,003,... =>숫자(문자형식의) 3자리)  */
	categorySubName  varchar(20) not null, 	/* 소분류명(상품구분 => 중분류가 '전자제품'이라면? 냉장고/에어컨/오디오/TV...  */
	primary key(categorySubCode),
	foreign key(categoryMainCode) references md_categoryMain(categoryMainCode)
);


select *, (select count(*) from md_categorySub as s where m.categoryMainCode = s.categoryMainCode) as cnt from md_categoryMain as m group by categoryMainCode;

select count(*) as cnt from md_categorySub group by categoryMainCode;
insert into md_categoryMain values('A', '닭가슴살');
insert into md_categoryMain values('B', '간편밥류');
insert into md_categoryMain values('C', '닭가슴살 간식');
insert into md_categoryMain values('D', '소고기');

insert into md_categorySub values('A', '001', '스팀 / 슬라이스');
insert into md_categorySub values('A', '002', '스테이크 / 치킨');
insert into md_categorySub values('B', '003', '한끼 도시락');
insert into md_categorySub values('C', '004', '크리스피칩');
drop table categoryMain;