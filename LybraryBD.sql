create database ABL
use ABL
create table author(author_id int identity (1,1) not null primary key, authorname varchar(70))
insert into [author] values ('�.�.��������'),('�.�.�����������'),('�.�.������')

create table reader(reader_id int identity (1,1) not null primary key, readername varchar(70))
insert into [reader] values ('������� �.�.'),('������� �.�.'),('���������� �.�.'),('����� �.�.'),('������ �.�.')

create table publishing(publish_id int identity (1,1) NOT NULL primary key, publushingname varchar(50))
insert into [publishing] values ('�����'),('��������'),('���')

create table book(book_id int identity(1,1) not null primary key, name varchar(50), publishid int foreign key references publishing(publish_id), year int, page int, pictures int, price money, exemplar int)
insert into [book] values 
('����� �������','2', 2017, 200, 20, '200.00', 5),
('������� ������','3', 2017, 200, 20, '200.00', 5),
('������ � ���������','2', 2017, 200, 20, '200.00', 5),
('�����','1', 2018, 210, 25, '220.00', 6),
('�������','3', 2018, 210, 25, '220.00', 6)

create table author_book(ab_id int identity (1,1) not null primary key, booksid int foreign key references book(book_id),authorid int foreign key references author(author_id))
insert into [author_book] values ('2','1'),('2','2'),('2','3'),('2','1'),('2','2')

create table issue(issue_id int identity(1,1) not null primary key,readerid int foreign key references reader(reader_id), bookid int foreign key references book(book_id),dateissue datetime,daterefund datetime)
insert into [issue] values
('1','1','2018-03-09 10:00:00','2018-03-09 11:30:00'),
('1','4','2018-04-09 12:00:00','2018-04-09 13:30:00'),
('2','3','2018-05-09 10:00:00','2018-05-09 12:30:00'),
('2','2','2018-06-09 12:00:00','2018-06-09 22:00:00'),
('3','3','2018-07-09 08:30:00','2018-07-09 13:00:00'),
('3','4','2018-10-09 17:00:00','2018-10-09 18:00:00'),
('3','3','2018-11-09 19:00:00','2018-11-09 19:40:00'),
('3','1','2018-12-09 08:30:00','2018-12-09 13:00:00'),
('3','2','2018-13-09 17:00:00','2018-13-09 18:00:00'),
('3','1','2018-14-09 19:00:00','2018-14-09 19:40:00'),
('1','1','2018-14-09 19:05:00.000',null),
('2','2','2018-14-09 19:20:00.000',null)

go
delete from issue where (dateissue) > (daterefund);
print '������������ ������ �������'

--������ ������� ����� ���������� ���������� ����
select name, COUNT(*) '�����'
from book,issue
where bookid=book_id
group by name

--������ ������� ���� ������ ���������� ���� �� ������ ������
select name, COUNT(*)'�� ������ ������'
from book,issue
where bookid=book_id and daterefund is null
group by name, exemplar

--������ ���������� ����������� ���������� ����� � �������
select name, (exemplar-COUNT(*)) '���������� ����������� ���� � �������'
from book,issue
where bookid=book_id and daterefund is null
--and daterefund NULL 
group by name, exemplar




--������ ����� �������� ���������
select readername, count(*) '���������� �������������� ����'
from reader,issue
where reader_id=readerid and daterefund is null
group by readername
order by count(*) DESC

--������ ����� ���������� ������� �� ���������� ����� �� ��������� ���� ���
select authorname, count(*) '����������'
from author,author_book, book,issue
where authorid=author_id and bookid=book_id and book_id=booksid and (dateissue between (GETDATE()-'1905-01-01 00:00:00.000') and GETDATE())
group by authorname
order by count(*) DESC