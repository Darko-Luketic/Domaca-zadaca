drop database if exists kv_8;
create database kv_8;
use kv_8;

create table cura(
sifra int not null primary key auto_increment,
nausnica int not null,
indiferentno bit,
ogrlica int not null,
gustoca decimal(12,6),
drugiputa datetime,
vesta varchar(33),
prijateljica int
);

create table prijateljica (
sifra int not null primary key auto_increment,
vesta varchar(50),
nausnica int not null,
introventno bit not null
);

create table decko(
sifra int not null primary key auto_increment,
kuna decimal(12,10),
lipa decimal(17,10),
bojakose varchar(44),
treciputa datetime not null,
ogrlica int not null,
ekstroventno bit not null
);

create table muskarac_decko(
sifra int not null primary key auto_increment,
muskarac int not null,
decko int not null
);

create table muskarac(
sifra int not null primary key auto_increment,
halina varchar(47),
drugiputa datetime not null,
treciputa datetime
);

create table becar(
sifra int not null primary key auto_increment,
eura decimal(15,10) not null,
treciputa datetime,
prviputa datetime,
muskarac int not null
);

create table neprijatelj(
sifra int not null primary key auto_increment,
kratkamajica varchar(44),
introventno bit,
indiferentno bit,
ogrlica int not null,
becar int not null
);


create table brat(
sifra int not null primary key auto_increment,
introventno bit ,
novcica decimal(14,7) not null,
treciputa datetime,
neprijatelj int
);

alter table cura add foreign key (prijateljica) references prijateljica(sifra);
alter table brat add foreign key (neprijatelj) references neprijatelj(sifra);
alter table neprijatelj add foreign key (becar) references becar(sifra);
alter table becar add foreign key (muskarac) references muskarac(sifra);
alter table muskarac_decko add foreign key (muskarac) references muskarac(sifra);
alter table muskarac_decko add foreign key (decko) references decko(sifra);


#1. U tablice neprijatelj, becar i muskarac_decko unesite po 3 retka. 
#(7)

insert into decko(treciputa ,ogrlica ,ekstroventno ) values
('2020-02-02',5,false),('2020-02-02',5,false),('2020-02-02',5,false);
insert into muskarac (drugiputa ) values
('2020-02-02'),('2020-02-02'),('2020-02-02');
insert into muskarac_decko (muskarac ,decko ) values
(1,1),(2,2),(3,3);
insert into becar (eura ,muskarac ) values
(100,1),(200,2),(300,3);
insert into neprijatelj (ogrlica ,becar) values
(1,1),(2,2),(3,3);


#2. U tablici cura postavite svim zapisima kolonu indiferentno na 
#vrijednost false. (4)

update cura set indiferentno =false ;

#3. U tablici brat obrišite sve zapise čija je vrijednost kolone novcica 
#različito od 12,75. (4)

delete from brat where novcica <>12.75;

#4. Izlistajte prviputa iz tablice becar uz uvjet da vrijednost kolone 
#treciputa nepoznate. (6)
select prviputa from becar where prviputa =null;


#5. Prikažite bojakose iz tablice decko, neprijatelj iz tablice brat te 
#introvertno iz tablice neprijatelj uz uvjet da su vrijednosti kolone 
#treciputa iz tablice becar poznate te da su vrijednosti kolone 
#drugiputa iz tablice muskarac poznate. Podatke posložite po 
#introvertno iz tablice neprijatelj silazno. (10)

select d.bojakose,b.neprijatelj,n.introventno from decko d
inner join muskarac_decko md on md.decko =d.sifra 
inner join muskarac m on md.muskarac =m.sifra 
inner join becar b1 on b1.muskarac =m.sifra 
inner join neprijatelj n on n.becar =b1.sifra 
inner join brat b on b.neprijatelj =n.sifra 
where b1.treciputa !=null and m.drugiputa !=null 
order by n.introventno desc;


#6. Prikažite kolone drugiputa i treciputa iz tablice muskarac čiji se 
#primarni ključ ne nalaze u tablici muskarac_decko. (5

select m.drugiputa,m.treciputa from muskarac m
left join muskarac_decko md on md.muskarac =m.sifra 
where muskarac =null;

