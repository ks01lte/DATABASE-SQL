select sysdate() from dual;
select sysdate(), year(sysdate()), month(sysdate()), day(sysdate());
select now(), year(now()), month(now()), day(now()), hour(now()), minute(now()),second(now());
select sysdate(), date(sysdate()), time(sysdate());

use madang;

set @var1 :=1;
select @var1 :=@var1+2, name, address from customer;

set @tt = '2023/10/05';
set @tt := sysdate();
select year(@tt), month(@tt);
select sysdate(), adddate(sysdate(), 10), adddate(sysdate(), -10);
select sysdate(), subdate(sysdate(), -10), subdate(sysdate(), 10);
select curtime(), curdate();
select sysdate(), addtime(sysdate(), '10:10:10');
