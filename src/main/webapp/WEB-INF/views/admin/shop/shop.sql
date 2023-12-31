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


create table md_product (
    idx   int not null auto_increment,		/* 상품 고유번호 */
    categoryMainCode  char(1) not null,		/* 대분류코드를 외래키로 지정 */
    categorySubCode  char(3) not null,		/* 소분류코드를 외래키로 지정  */
	productCode  varchar(20) not null,		/* 상품고유코드(대분류코드+중분류코드+소분류코드+상품고유번호) 예: A 05 002 5) */
	productName  varchar(50) not null,		/* 상품명(상품모델명) - 세분류 */
	productPrice		int not null,							/* 상품의 기본가격 */
	fSName			varchar(200) not null,		/* 상품의 기본사진(1장이상 처리시에는 '/'로 구분 저장한다. */
	content			text not null,						/* 상품의 상세설명 - ckeditor를 이용한 이미지 1장으로 처리한다. */
	primary key(idx),
	unique  key(productCode,productName),
    foreign key(categoryMainCode) references md_categoryMain(categoryMainCode),
    foreign key(categorySubCode) references md_categorySub(categorySubCode)
);

/* 상품 옵션 */
create table md_option (
    idx    int not null auto_increment,	/* 옵션 고유번호 */
    productIdx int not null,				/* product테이블(상품)의 고유번호 - 외래키 지정 */
    optionName varchar(50) not null,/* 옵션 이름 */
    optionPrice int not null default 0, /* 옵션 가격 */
    primary key(idx),
    foreign key(productIdx) references md_product(idx)
);


select *, (select count(*) from md_categorySub as s where m.categoryMainCode = s.categoryMainCode) as cnt from md_categoryMain as m group by categoryMainCode;

select count(*) as cnt from md_categorySub group by categoryMainCode;

update md_categorySub set categoryMainCode = (select categoryMainCode from md_categoryMain where categoryMainName = '닭가슴살') where categorySubCode = '004';
select categoryMainCode from md_categoryMain where categoryMainName = '닭가슴살';

select product.*, (select categoryMainName from md_categoryMain where product.categoryMainCode = categoryMainCode) as categoryMainName, sub.categorySubName from md_product product, md_categoryMain main, md_categorySub sub where productName = '고기' limit 1;

select product.*, (select categoryMainName from md_categoryMain where product.categoryMainCode = categoryMainCode) as categoryMainName, (select categorySubName from md_categorySub where product.categorySubCode = categorySubCode) as categorySubName from md_product product, md_categoryMain main, md_categorySub sub where productName = '간식' limit 1;
  		
update md_product set productCode = replace(productCode, SUBSTR(productCode,1,4), 'C203') where categorySubCode = '404';
alter table md_product add rgDate datetime default now();		
drop table categoryMain;