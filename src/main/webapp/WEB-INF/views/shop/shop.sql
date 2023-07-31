create table md_cart (
	idx   int not null auto_increment,			/* 장바구니 고유번호 */
	cartDate datetime default now(),				/* 장바구니에 상품을 담은 날짜 */
	mid   varchar(20) not null,	/* 장바구니를 사용한 사용자의 아이디 - 로그인한 회원 아이디이다. */
	productIdx  int not null,								/* 장바구니에 구입한 상품의 고유번호 */
	productName varchar(50) not null,				/* 장바구니에 담은 구입한 상품명 */
	productPrice   int not null,								/* 메인상품의 기본 가격 */
	thumbImg		varchar(100) not null,			/* 서버에 저장된 상품의 메인 이미지 */
	optionIdx	  varchar(50)	 not null,			/* 옵션의 고유번호리스트(여러개가 될수 있기에 문자열 배열로 처리한다.) */
	optionName  varchar(100) not null,			/* 옵션명 리스트(배열처리) */
	optionPrice varchar(100) not null,			/* 옵션가격 리스트(배열처리) */
	optionNum		varchar(50)  not null,			/* 옵션수량 리스트(배열처리) */
	totalPrice  int not null,								/* 구매한 모든 항목(상품과 옵션포함)에 따른 총 가격 */
	primary key(idx,mid),
	/* unique key(mid), */
	foreign key(productIdx) references md_product(idx) on update cascade on delete restrict
	/* foreign key(mid) references member2(mid) on update cascade on delete cascade */
);

/* 주문 테이블 -  */
create table md_order (
  idx         int not null auto_increment, /* 고유번호 */
  orderIdx    varchar(15) not null,   /* 주문 고유번호(새롭게 만들어 주어야 한다.) */
  mid         varchar(20) not null,   /* 주문자 ID */
  productIdx  int not null,           /* 상품 고유번호 */
  orderDate   datetime default now(), /* 실제 주문을 한 날짜 */
  productName varchar(50) not null,   /* 상품명 */
  mainPrice   int not null,				    /* 메인 상품 가격 */
  thumbImg    varchar(100) not null,   /* 썸네일(서버에 저장된 메인상품 이미지) */
  optionName  varchar(100) not null,  /* 옵션명    리스트 -배열로 넘어온다- */
  optionPrice varchar(100) not null,  /* 옵션가격  리스트 -배열로 넘어온다- */
  optionNum   varchar(50)  not null,  /* 옵션수량  리스트 -배열로 넘어온다- */
  totalPrice  int not null,					  /* 구매한 상품 항목(상품과 옵션포함)에 따른 총 가격 */
  /* cartIdx     int not null,	*/		/* 카트(장바구니)의 고유번호 */ 
  primary key(idx, orderIdx),
  foreign key(mid) references md_member(mid),
  foreign key(productIdx) references md_product(idx)  on update cascade on delete cascade
);


/* 배송테이블 */
create table md_baesong (
  idx     int not null auto_increment,
  oIdx    int not null,								/* 주문테이블의 고유번호를 외래키로 지정함 */
  orderIdx    varchar(15) not null,   /* 주문 고유번호 */
  orderTotalPrice int     not null,   /* 주문한 모든 상품의 총 가격 */
  mid         varchar(20) not null,   /* 회원 아이디 */
  name				varchar(20) not null,   /* 배송지 받는사람 이름 */
  address     varchar(100) not null,  /* 배송지 (우편번호)주소 */
  tel					varchar(15),						/* 받는사람 전화번호 */
  message     varchar(100),						/* 배송시 요청사항 */
  payment			varchar(10)  not null,	/* 결재도구 */
  payMethod   varchar(50)  not null,  /* 결재도구에 따른 방법(카드번호) */
  orderStatus varchar(10)  not null default '결제완료', /* 주문순서(결제완료->배송중->배송완료->구매완료) */
  primary key(idx),
  foreign key(oIdx) references md_order(idx) on update cascade on delete cascade
);

select o.*, b.orderStatus, (select count(*) from md_order where orderIdx = b.orderIdx group by orderIdx)as cnt from md_order o, md_baesong b where o.mid = 'admin' and o.orderIdx = b.orderIdx order by idx desc;

select o.*, b.orderStatus, (select count(*) from md_order where orderIdx = b.orderIdx group by orderIdx)as cnt from md_order o, md_baesong b where o.mid = 'admin' and o.orderIdx = b.orderIdx and orderDate between date_sub('2023-07-27', interval 90 DAY) and '2023-07-27' order by idx desc;