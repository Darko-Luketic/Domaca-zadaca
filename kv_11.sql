drop database if exists kv_11;
create database kv_11;
use kv_11;


create table punica(
sifra int not null primary key auto_increment,
carape varchar(33) not null,
drugiputa datetime,
majica varchar(40) not null,
haljina varchar(30) not null,
bojakose varchar(37) not null,
djevojka int not null
);


create table djevojka(
sifra int not null primary key auto_increment,
kratkamajica varchar(45) not null,
prstena int,
ekstroventno bit not null,
majica varchar(42) not null,
introventno bit not null,
svekrva int
);

create table svekrva(
sifra int not null primary key auto_increment,
narukvica int not null,
carape varchar(39) not null,
haljina varchar(31),
punac int not null
);

create table punac(
sifra int not null primary key auto_increment,
jmbag char(11),
kuna decimal(16,5) not null,
vesta varchar(45) not null
);

create table punac_mladic(
sifra int not null primary key auto_increment,
punac int not null,
mladic int not null
);

create table mladic(
sifra int not null primary key auto_increment,
ogrlica int not null,
stilfriziura varchar(35),
drugiputa datetime not null,
hlace varchar(41) not null
);

create table muskarac(
sifra int not null primary key auto_increment,
maraka decimal(16,5),
novcica decimal(13,10),
nausnica int,
narukvica int not null,
gustoca decimal(12,6),
neprijatelj int not null
);

create table neprijatelj(
sifra int not null primary key auto_increment,
narukvica int not null,
novcica decimal(12,8) not null,
bojakose varchar(39) not null,
gustoca decimal(14,10),
introvertno bit not null,
asocijalno bit
);

alter table muskarac add foreign key(neprijatelj) references neprijatelj(sifra);
alter table punac_mladic add foreign key(punac) references punac(sifra);
alter table punac_mladic add foreign key(mladic) references mladic(sifra);
alter table svekrva add foreign key(punac) references punac(sifra);
alter table djevojka add foreign key(svekrva) references svekrva(sifra);
alter table punica add foreign key(djevojka) references djevojka(sifra);



#1. U tablice djevojka, svekrva i punac_mladic unesite po 3 retka. (7)

insert into mladic (ogrlica,drugiputa,hlace) values
(5,'2020-02-02','crna'),(5,'2020-02-02','crna'),(5,'2020-02-02','crna');
insert into punac(kuna,vesta) values
(100,'crna'),(100,'crna'),(100,'crna');
insert into punac_mladic(punac,mladic) values
(1,1),(2,2),(3,3);
insert into svekrva(narukvica,carape,punac) values
(5,'crna',1),(5,'crna',1),(5,'crna',1);
insert into djevojka(kratkamajica,ekstroventno,majica, introventno) values 
('crna',true,'crna',false),('crna',true,'crna',false),('crna',true,'crna',false);

#2. U tablici muskarac postavite svim zapisima kolonu novcica na 
#vrijednost 15,70. (4)

update muskarac set novcica=15.70;

#3. U tablici punica obrišite sve zapise čija je vrijednost kolone 
#drugiputa 8. travnja 2019. (4)

delete from punica where drugiputa ='2020-04-08';
#4. Izlistajte haljina iz tablice svekrva uz uvjet da vrijednost kolone 
#carape sadrže slova ana. (6)
select haljina from svekrva where carape like '%ana%';

#5. Prikažite drugiputa iz tablice mladic, haljina iz tablice punica te 
#prstena iz tablice djevojka uz uvjet da su vrijednosti kolone carape iz 
#tablice svekrva počinju slovom a te da su vrijednosti kolone kuna iz 
#tablice punac različite od 21. Podatke posložite po prstena iz tablice 
#djevojka silazno. (10)

select m.drugiputa,p.haljina,d.prstena from punica p
inner join djevojka d on p.djevojka=d.sifra
inner join svekrva s on d.svekrva =s.sifra 
inner join punac p1 on s.punac=p1.sifra 
inner join punac_mladic pm on pm.punac=p.sifra 
inner join mladic m on pm.mladic =m.sifra
where s.carape like 'a%' and p1.kuna <>21
order by d.prstena desc;
#6. Prikažite kolone kuna i vesta iz tablice punac čiji se primarni ključ 
#ne nalaze u tablici punac_mladic. (5

select p1.kuna,p1.vesta from punac p1
left join punac_mladic pm on pm.punac=p1.sifra 
where pm.punac =null;