create table md_member (
	idx int not null auto_increment primary key,
	mid varchar(20) not null unique key,
	pwd varchar(100) not null,
	name varchar(20) not null,
	nickName varchar(20) not null unique key,
	tel varchar(20) not null unique key,
	email varchar(40) not null unique key,
	gender varchar(4),
	birthday varchar(10),
	address varchar(50) not null,
	level int not null default 3,
	memberDel char(3) not null default 'NO',
	lastVisitDate datetime default now(),
	point int not null default 2000,
	snsCheck char(3) default 'YES'
);

drop table md_member;