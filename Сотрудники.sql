create database SSAR1
--use SSAR1

create table fio(fio_id int identity(1,1) not null primary key, fio1 varchar(50))
insert into [fio] values ('Андреев Андрей Андреевич'),('Петров Петр Петрович'),('Сергеев Сергей Сергеевич')
create table ee1(ss_id int identity(1,1) not null primary key,FIOid int foreign key references fio(fio_id),vhod datetime,vihod datetime)
insert into [ee1] values
('1','2018-03-09 10:00:00','2018-03-09 11:30:00'),
('1','2018-04-09 12:00:00','2018-04-09 13:30:00'),
('2','2018-05-09 10:00:00','2018-05-09 12:30:00'),
('2','2018-06-09 12:00:00','2018-06-09 22:00:00'),
('3','2018-07-09 08:30:00','2018-07-09 13:00:00'),
('3','2018-10-09 17:00:00','2018-10-09 18:00:00'),
('3','2018-11-09 19:00:00','2018-11-09 19:40:00'),
('3','2018-12-09 08:30:00','2018-12-09 13:00:00'),
('3','2018-13-09 17:00:00','2018-13-09 18:00:00'),
('3','2018-14-09 19:00:00','2018-14-09 19:40:00')

go
delete from ee1 where datename(weekday,vhod) = 'Saturday' or datename(weekday,vhod) = 'Sunday' or CONVERT(time, vhod)='23:59:59'or CONVERT(time, vihod)='23:59:59' or ((vhod) > (vihod));
print 'Недопустимые записи удалены'


select fio1,vhod,vihod,CONVERT(time, vihod-vhod) 'chasi' from fio,ee1 where FIOid=fio_id


select fio1, COUNT(fio_id) 'Количестов опозданий'
from ee1,fio
where FIOid=fio_id
and (((CONVERT(time, vhod)>'09:00:00.000') and (CONVERT(time, vhod)<'13:00:00.000'))
or ((CONVERT(time, vhod)>'14:00:00.000') and (CONVERT(time, vhod)<'18:00:00.000')))
--and convert(date, vhod)>='2018-09-03' and convert(date, vhod)<='2018-09-07'
and convert(date, vhod) between '2018-09-03' and '2018-09-07'
group by fio1

select fio1, COUNT(fio_id) 'Количестов опозданий'
from ee1,fio
where FIOid=fio_id
and (((CONVERT(time, vhod)>'09:00:00.000') and (CONVERT(time, vhod)<'13:00:00.000'))
or ((CONVERT(time, vhod)>'14:00:00.000') and (CONVERT(time, vhod)<'18:00:00.000')))
--and convert(date, vhod)>='2018-09-10'
and (convert(date, vhod) between '2018-09-10' and '2018-09-14')
group by fio1


