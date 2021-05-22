drop database if exists kv_16;
create database kv_16;
use kv_16;

create table zarucnik (
sifra int not null primary key auto_increment,
novcica decimal(13,9) not null,
bojakose varchar(41) not null,
kuna decimal(16,8) not null,
prstena int not null,
kratkamajica varchar(44) not null,
nausnica int not null
);

create table punac_zarucnik(
sifra int not null primary key auto_increment,
punac int not null,
zarucnik int not null
);

create table punac(
sifra int not null primary key auto_increment,
kratkamajica varchar(45),
bojakose varchar(41),
novcica decimal(16,8),
treciputa datetime not null
);

create table brat(
sifra int not null primary key auto_increment,
vesta varchar(44) not null,
dukserica varchar(34),
prstena int,
majica varchar (36) not null,
punac int not null
);

create table mladic(
sifra int not null primary key auto_increment,
haljina varchar(30),
lipa decimal(12,8),
kratkamajica varchar(33),
kuna decimal(12,10),
treciputa datetime not null,
brat int not null
);

create table svekrva(
sifra int not null primary key auto_increment,
jmbag char(11),
ogrlica int,
bojakose varchar(40) not null,
drugiputa datetime not null,
mladic int not null
);

create table zena(
sifra int not null primary key auto_increment,
gustoca decimal(12,8),
lipa decimal(16,6),
ogrlica int ,
carape varchar(32),
nausnica int not null,
modelaocala varchar(46) not null,
prijatelj int
);


create table prijatelj(
sifra int not null primary key auto_increment,
treciputa datetime,
majica varchar(49),
asocijalno bit not null,
hlace varchar(42)
);

alter table zena add foreign key (prijatelj) references prijatelj(sifra);
alter table punac_zarucnik add foreign key (punac) references punac(sifra);
alter table punac_zarucnik add foreign key (zarucnik) references zarucnik(sifra);
alter table brat add foreign key (punac) references punac(sifra);
alter table mladic add foreign key (brat) references brat(sifra);
alter table svekrva add foreign key (mladic) references mladic(sifra);


#1. U tablice mladic, brat i punac_zarucnik unesite po 3 retka. (7)
insert into zarucnik (novcica ,bojakose ,kuna ,prstena ,kratkamajica ,nausnica ) values
(100,'crna',100,2,'crna',2),(100,'crna',100,2,'crna',2),(100,'crna',100,2,'crna',2);
insert into punac (treciputa ) values
('2020-02-02'),('2020-02-02'),('2020-02-02');
insert into punac_zarucnik (punac ,zarucnik ) values
(1,1),(2,2),(3,3);
insert into brat(vesta ,majica ,punac ) values
('crna','crna',2),('crna','crna',2),('crna','crna',2);
insert into brat (vesta ,majica ,punac ) values
('crna','crna',3),('crna','crna',3),('crna','crna',3);



#2. U tablici zena postavite svim zapisima kolonu lipa na vrijednost 
#13,77. (4)

update zena set lipa =13.77;
#3. U tablici svekrva obrišite sve zapise čija je vrijednost kolone ogrlica 
#različito od 18. (4)

delete from svekrva where ogrlica<>18;

#4. Izlistajte prstena iz tablice brat uz uvjet da vrijednost kolone 
#dukserica sadrže slova ana. (6)

select prstena from brat where dukserica like '%ana%';
#5. Prikažite kuna iz tablice zarucnik, drugiputa iz tablice svekrva te 
#lipa iz tablice mladic uz uvjet da su vrijednosti kolone dukserica iz 
#tablice brat počinju slovom a te da su vrijednosti kolone bojakose iz 
#tablice punac sadrže niz znakova ba. Podatke posložite po lipa iz 
#tablice mladic silazno. (10)
select z.kuna,s.drugiputa,m.lipa from svekrva s 
inner join mladic m on s.mladic =m.sifra 
inner join brat b on m.brat=b.sifra 
inner join punac p on b.punac=p.sifra 
inner join punac_zarucnik pz on pz.punac=p.sifra 
inner join zarucnik z on pz.zarucnik =z.sifra
where b.dukserica like 'a%' and p.bojakose like '%ba%'
order by m.lipa desc;


#6. Prikažite kolone bojakose i novcica iz tablice punac čiji se primarni 
#ključ ne nalaze u tablici punac_zarucnik. (5)

select p.bojakose,p.novcica from punac p
left join punac_zarucnik pz on pz.punac =p.sifra 
where pz.punac =null;