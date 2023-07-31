create table md_coupons (
	idx int not null auto_increment primary key,
	coupon_number int not null unique key,
	coupon_name varchar(100) not null unique key,
	coupon_type varchar(10) not null,
	coupon_price int not null,
	coupon_ratio int not null,
	max_value int not null,
	use_min_price int not null,
	coupon_content varchar(100) not null
);

create table md_memberCoupon (
	idx int not null auto_increment primary key,
	mid varchar(20) not null,
	couponIdx int not null,
	getTime datetime default now(),
	deadline datetime not null,
	foreign key(mid) references md_member(mid),
    foreign key(couponIdx) references md_coupons(idx)
);

select * from md_coupons c, md_memberCoupon m where m.mid='admin' and c.idx = m.couponIdx;

insert into md_coupons values(default, 12348915, '회원가입 무료배송쿠폰', '금액권', 3000, 0, 3000, 10000, '전체배송비할인');
drop table md_coupons;