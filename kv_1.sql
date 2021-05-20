drop database if exists kv_1;
create database kv_1;
use kv_1;


create table svekar(
sifra int not null primary key auto_increment,
bojaociju varchar(40) not null,
prstena int,
dukserica varchar (41),
lipa decimal(13,8),
eura decimal(12,7),
majica varchar(35)
);

create table sestra(
sifra int not null primary key auto_increment,
introventno bit ,
haljina varchar(31) not null,
maraka decimal(16,6),
hlace varchar(46) not null,
narukvica int not null
);

create table sestra_svekar(
sifra int not null primary key auto_increment,
sestra int not null,
svekar int not null
);


create table zena(
sifra int not null primary key auto_increment,
treciputa datetime,
hlace varchar(46),
kratkamajica varchar(31) not null,
jmbag char(11) not null,
bojaociju varchar(39) not null,
haljina varchar(44),
sestra int not null
);

create table muskarac(
sifra int not null primary key auto_increment,
bojaociju varchar(50) not null,
hlace varchar(30),
modelnaocala varchar(41),
maraka decimal(14,5) not null,
zena int not null
);

create table mladic(
sifra int not null primary key auto_increment,
suknja varchar(50) not null,
kuna decimal(16,8) not null,
drugiputa datetime ,
asocijalno bit,
ekstroventno bit not null,
dukserica varchar(48) not null,
muskarac int not null
);

create table punac(
sifra int not null primary key auto_increment,
ogrlica int,
gustoca decimal(14,9),
hlace varchar(41) not null
);

create table cura(
sifra int not null primary key auto_increment,
novcica decimal(16,5) not null,
gustoca decimal(18,6) not null,
lipa decimal(13,10),
ogrlica int not null,
bojakose varchar(38),
suknja varchar(36),
punac int
);

alter table cura add foreign key (punac) references punac(sifra);
alter table sestra_svekar add foreign key (svekar) references svekar(sifra);
alter table sestra_svekar add foreign key (sestra) references sestra(sifra);
alter table zena add foreign key (sestra ) references sestra(sifra);
alter table muskarac add foreign key (zena) references zena(sifra);
alter table mladic add foreign key (muskarac ) references muskarac(sifra);


#1. U tablice muskarac, zena i sestra_svekar unesite po 3 retka. (7)

insert into sestra (haljina ,hlace ,narukvica ) values
('crna','plava',1),
('plava','crna',2),
('crna','crvena',3);

insert into zena (kratkamajica ,jmbag ,bojaociju ,sestra ) values
('crna',12345678910,'plava',1),
('crna',12345678911,'plava',2),
('crna',12345678912,'plava',3);
insert into muskarac(bojaociju ,maraka ,zena ) values
('crna',123.20,1),
('crna',123.20,2),
('crna',123.20,3);
insert into svekar (bojaociju ) values
('plava'),
('plava'),
('plava');
insert into sestra_svekar (sestra ,svekar ) values
(1,1),(2,2),(3,3);


#2. U tablici cura postavite svim zapisima kolonu gustoca na vrijednost 
#15,77. (4)
insert into punac(hlace) values
('kratke'),('kratke'),('kratke');
insert into cura (novcica ,gustoca,ogrlica ,punac) values
(100,100,2,1),(100,100,2,1),(100,100,2,1);



update cura set gustoca =15.77 where novcica =100;
select * from cura;


#3. U tablici mladic obrišite sve zapise čija je vrijednost kolone kuna 
#veće od 15,78. (4)

delete from mladic where kuna<15.78;



#4. Izlistajte kratkamajica iz tablice zena uz uvjet da vrijednost kolone 
#hlace sadrže slova ana. (6)

select kratkamajica from zena where hlace='ana';


#5. Prikažite dukserica iz tablice svekar, asocijalno iz tablice mladic te 
#hlace iz tablice muskarac uz uvjet da su vrijednosti kolone hlace iz 
#tablice zena počinju slovom a te da su vrijednosti kolone haljina iz 
#tablice sestra sadrže niz znakova ba. Podatke posložite po hlace iz 
#tablice muskarac silazno. (10)

select s.dukserica ,m.asocijalno ,mu.hlace from mladic m
inner join muskarac mu on m.muskarac =mu.sifra 
inner join zena z on mu.zena =z.sifra 
inner join sestra s2 on z.sestra =s2.sifra 
inner join sestra_svekar ss on ss.sestra =s2.sifra 
inner join svekar s on ss.svekar =s.sifra
where z.hlace like 'a%' and s2.haljina like '%ba%'
order by mu.hlace desc;



#6. Prikažite kolone haljina i maraka iz tablice sestra čiji se primarni 
#ključ ne nalaze u tablici sestra_svekar. (5)
select s2.haljina,s2.maraka from sestra s2
left join sestra_svekar ss on ss.sestra =s2.sifra 
where s2.sifra is null;