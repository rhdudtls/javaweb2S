create table md_like (
	idx int not null auto_increment primary key,
	mid varchar(20) not null,
	productIdx int not null,
	foreign key(mid) references md_member(mid)  on update cascade on delete cascade,
	foreign key(productIdx) references md_product(idx)  on update cascade on delete cascade
);