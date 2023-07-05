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

INSERT INTO `md_member` (`idx`, `mid`, `pwd`, `name`, `nickName`, `tel`, `email`, `gender`, `birthday`, `address`, `level`, `memberDel`, `lastVisitDate`, `point`, `snsCheck`) VALUES
	(1, 'admin', '$2a$10$cCjJGSHjUKbnfjZHNm6di.AEH08OusD/E6xqmEvaRXuLYzz7QFPHu', '관리자', '관리자', '010-1234-1234', 'dudtls8846@naver.com', NULL, '2023-07-03', '28799 /충북 청주시 서원구 분평로 18 /705동 1201호 / (분평동, 분평주공7단지아파트) /', 0, 'NO', '2023-07-05 12:14:00', 2000, 'YES'),
	(3, 'ys8846', '$2a$10$rAJfGhEG0ikgIYU02Gfi1ujvRytrSnkEhi0YC0bJawG5pffxP3926', '고영신', '영시니', '010-5745-8846', 'ehfrl64@naver.co', '여자', '2000-04-25', '06711 /서울 서초구 반포대로 3 / / (서초동) /', 3, 'NO', '2023-07-04 12:00:27', 2000, 'YES'),
	(5, 'hkd1234', '$2a$10$exaZivLsrQFOscxpWk8bYeDmYjrVWmsk2UTV.OsNmyuvUP6psGbf2', '홍길동', '길동길동', '010-1547-1635', 'hkd1234@ttttt', '남자', '2023-07-19', '04501 /서울 중구 만리재로 193 / / (만리동1가) /', 3, 'NO', '2023-07-05 12:45:56', 2000, 'YES'),
	(6, 'admin11', '$2a$10$hcHW0qUjCC4u.yUFstUswOCislYtFpIw82.k7cBkFjIl/9YHp67by', '멀더', '미미미', '010-7484-5163', 'asdfqwer123@ajfaoe', '여자', '2023-07-12', '07371 /서울 영등포구 경인로 702 / / (문래동1가) /', 3, 'NO', '2023-07-05 12:47:02', 2000, 'NO'),
	(7, 'asdf456', '$2a$10$VUkTAZd0LH5QwspPQWtAWekDNMRQfhFnov71sKyPwbvnAcM/jnDUO', '고냥이', '고냥이', '010-1896-3849', 'kkk5555@5616', NULL, '2023-07-05', '55600 /전북 장수군 계북면 파파실길 14-28 / / /', 3, 'NO', '2023-07-05 12:48:24', 2000, 'YES'),
	(8, 'ave156', '$2a$10$r3N5sG9KxfXwtNT9Ri0T8.S5gTi.w.eQz.7V429LSGJA6lvjuWoxC', '나나나', '나나나', '010-1657-4968', 'avef156@25864', '남자', '2023-07-05', '03900 /서울 마포구 상암동 1566-1 / / /', 3, 'NO', '2023-07-05 12:49:42', 2000, 'YES');
/*!40000 ALTER TABLE `md_member` ENABLE KEYS */;