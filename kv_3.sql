drop database if exists kv_3;
create database kv_3;
use kv_3;


create table svekar(
sifra int not null primary key auto_increment,
novcica decimal not null,
suknja varchar(44) not null,
bojakose varchar(36),
prstena int ,
narukvica int not null,
cura int not null
);

create table cura(
sifra int not null primary key auto_increment,
dukserica varchar(49),
maraka decimal(13,7),
drugiputa datetime,
majica varchar(49),
novcica decimal(15,8),
ogrlica int not null
);

create table punica(
sifra int not null primary key auto_increment,
asocijalno bit ,
kratkamajica varchar(44),
kuna decimal(13,8) not null,
vesta varchar(32) not null,
snasa int
);

create table snasa(
sifra int not null primary key auto_increment,
introventno bit ,
kuna decimal(18,6) not null,
eura decimal(12,9) not null,
treciputa datetime,
ostavljena int not null
);

create table ostavljena(
sifra int not null primary key auto_increment,
kuna decimal(17,5) ,
lipa decimal(15,6),
majica varchar(36),
modelnaocala varchar(31) not null,
prijatelj int
);

create table prijatelj(
sifra int not null primary key auto_increment,
kuna decimal(16,10),
haljina varchar(37) ,
lipa decimal(13,10),
dukserica varchar(31),
indiferentno bit not null
);

create table prijatelj_brat(
sifra int not null primary key auto_increment,
prijatelj int not null,
brat int not null
);

create table brat(
sifra int not null primary key auto_increment,
jmbag char(11),
ogrlica int not null,
ekstroventno bit not null
);

alter table prijatelj_brat add foreign key (brat) references brat(sifra);
alter table prijatelj_brat add foreign key (prijatelj ) references prijatelj(sifra);
alter table ostavljena add foreign key (prijatelj ) references prijatelj(sifra);
alter table snasa add foreign key (ostavljena ) references ostavljena(sifra);
alter table punica add foreign key (snasa ) references snasa(sifra);
alter table svekar add foreign key (cura ) references cura(sifra);


#1. U tablice snasa, ostavljena i prijatelj_brat unesite po 3 retka. (7)
insert into brat (jmbag ,ogrlica,ekstroventno ) values
(12345678910,1,true),(32165498710,2,true),(12378945610,3,true);
insert into prijatelj (indiferentno ) values
(true),(true),(false);
insert into prijatelj_brat (prijatelj ,brat ) values
(1,1),(2,2),(3,3);
insert into ostavljena (modelnaocala ) values
('lose'),
('lose'),
('lose');
insert into snasa(kuna ,eura ,ostavljena ) values
(100,100,1),(100,100,1),(100,100,1);



#2. U tablici svekar postavite svim zapisima kolonu suknja na 
#vrijednost Osijek. (4)
update svekar set suknja ='Osijek';


#3. U tablici punica obrišite sve zapise čija je vrijednost kolone 
#kratkamajica jednako AB. (4)
delete from punica where kratkamajica ='AB';

#4. Izlistajte majica iz tablice ostavljena uz uvjet da vrijednost kolone 
#lipa nije 9,10,20,30 ili 35. (6)
select majica from ostavljena where lipa!=9 and 10 and 20 and 30 and 35;

#5. Prikažite ekstroventno iz tablice brat, vesta iz tablice punica te 
#kuna iz tablice snasa uz uvjet da su vrijednosti kolone lipa iz tablice 
#ostavljena različito od 91 te da su vrijednosti kolone haljina iz tablice 
#prijatelj sadrže niz znakova ba. Podatke posložite po kuna iz tablice 
#snasa silazno. (10)
select b.ekstroventno,p.vesta,s.kuna from punica p
inner join snasa s on p.snasa =s.sifra
inner join  ostavljena o on s.ostavljena =o.sifra
inner join prijatelj p1 on o.prijatelj =p1.sifra
inner join prijatelj_brat pb on pb.prijatelj =p1.sifra
inner join brat b on pb.brat=b.sifra
where o.lipa <> '91.00' and
p1.haljina like '%ba%'
order by s.kuna desc;

#6. Prikažite kolone haljina i lipa iz tablice prijatelj čiji se primarni ključ 
#ne nalaze u tablici prijatelj_brat. (5

select p.haljina,p.lipa from prijatelj p
left join prijatelj_brat pb on pb.prijatelj =p.sifra 
where prijatelj is null;
