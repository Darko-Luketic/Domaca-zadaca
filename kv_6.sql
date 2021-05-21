drop database if exists kv_6;
create database kv_6;
use kv_6;


create table decko(
sifra int not null primary key auto_increment,
prviputa datetime,
modelnaocala varchar(41),
nausnica int,
zena int not null
);


create table zena(
sifra int not null primary key auto_increment,
novcica decimal(14,8) not null,
narukvica int not null,
dukserica varchar(40) not null,
haljina varchar(30),
hlace varchar(32) ,
brat int not null
);


create table brat(
sifra int not null primary key auto_increment,
nausnica int not null,
treciputa datetime not null,
narukvica int not null,
hlace varchar(31),
prijatelj int
);

create table prijatelj(
sifra int not null primary key auto_increment,
haljina varchar(35),
prstena int not null,
introventno bit ,
stilfrizura varchar(36) not null
);

create table prijatelj_ostavljena(
sifra int not null primary key auto_increment,
prijatelj int not null,
ostavljena int not null
);

create table ostavljena(
sifra int not null primary key auto_increment,
prviputa datetime not null,
kratkamajica varchar(39) not null,
drugiputa datetime,
maraka decimal(14,10) 
);


create table punac(
sifra int not null primary key auto_increment,
ekstroventno bit not null,
suknja varchar(30) not null,
majica varchar(44) not null,
prviputa datetime not null
);

create table svekrva(
sifra int not null primary key auto_increment,
hlace varchar(48) not null,
suknja varchar(42) not null,
ogrlica int not null,
treciputa datetime not null,
dukserica varchar(32) not null,
narukvica int not null,
punac int
);

alter table svekrva add foreign key (punac) references punac(sifra);
alter table prijatelj_ostavljena add foreign key (prijatelj) references prijatelj(sifra);
alter table prijatelj_ostavljena add foreign key (ostavljena) references ostavljena(sifra);
alter table brat add foreign key (prijatelj) references prijatelj(sifra);
alter table zena add foreign key (brat) references brat(sifra);
alter table decko add foreign key (zena) references zena(sifra);




#1. U tablice zena, brat i prijatelj_ostavljena unesite po 3 retka. (7)

insert into ostavljena (prviputa ,kratkamajica ) values
('2020-02-02','crna'),('2020-02-02','crna'),('2020-02-02','crna');
insert into prijatelj (prstena ,stilfrizura ) values
(3,'crna'),(3,'crna'),(3,'crna');
insert into prijatelj_ostavljena (prijatelj ,ostavljena ) values
(1,1),(2,2),(3,3);
insert into brat (nausnica ,treciputa ,narukvica ) values
(5,'2020-02-02',1),(5,'2020-02-02',1),(5,'2020-02-02',1);
insert into zena (novcica ,narukvica ,dukserica ,brat ) values
(100,2,'plava',1),(100,2,'plava',1),(100,2,'plava',1);

#2. U tablici svekrva postavite svim zapisima kolonu suknja na 
#vrijednost Osijek. (4)

update svekrva set suknja ='Osijek';


#3. U tablici decko obrišite sve zapise čija je vrijednost kolone 
#modelnaocala manje od AB. (4)

delete from decko where modelnaocala>'AB';

#4. Izlistajte narukvica iz tablice brat uz uvjet da vrijednost kolone 
#treciputa nepoznate. (6)

select narukvica from brat where treciputa=null;

#5. Prikažite drugiputa iz tablice ostavljena, zena iz tablice decko te 
#narukvica iz tablice zena uz uvjet da su vrijednosti kolone treciputa iz 
#tablice brat poznate te da su vrijednosti kolone prstena iz tablice 
#prijatelj jednake broju 219. Podatke posložite po narukvica iz tablice 
#zena silazno. (10)
select o.drugiputa,d.zena,z.narukvica from ostavljena o
inner join prijatelj_ostavljena po on po.ostavljena =o.sifra 
inner join prijatelj p on po.prijatelj =p.sifra 
inner join brat b on b.prijatelj =p.sifra 
inner join zena z on z.brat=b.sifra 
inner join decko d on d.zena=z.sifra 
where b.treciputa is not null and p.prstena =219
order by z.narukvica desc;


#6. Prikažite kolone prstena i introvertno iz tablice prijatelj čiji se 
#primarni ključ ne nalaze u tablici prijatelj_ostavljena. (5

select p.prstena,p.introventno from prijatelj p
left join prijatelj_ostavljena po on po.prijatelj =p.sifra 
where prijatelj =null;