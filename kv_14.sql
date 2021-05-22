drop database if exists kv_14;
create database kv_14;
use kv_14;

create table ostavljena(
sifra int not null primary key auto_increment,
kuna decimal(17,7),
hlace varchar(45),
suknja varchar(36),
dukserica varchar(26),
kratkamajica varchar(47) not null,
gustoca decimal(12,10) not null,
ostavljen int
);

create table ostavljen(
sifra int not null primary key auto_increment,
majica varchar(39),
drugiputa datetime not null,
asocijalno bit not null,
brat int not null
);

create table brat(
sifra int not null primary key auto_increment,
eura decimal(15,10) not null,
gustoca decimal(14,5) not null,
kuna decimal(15,6),
haljina varchar(38) not null,
bojakose varchar(39),
prstena int,
neprijatelj int not null
);

create table neprijatelj (
sifra int not null primary key auto_increment,
prstena int not null,
gustoca decimal(17,7),
bojakose varchar(48) not null,
ogrlica int not null,
stilfrizura varchar(47) not null
);

create table neprijatelj_muskarac(
sifra int not null primary key auto_increment,
neprijatelj int not null,
muskarac int not null
);

create table muskarac(
sifra int not null primary key auto_increment,
carape varchar(36),
ogrlica int not null,
vesta varchar(44) not null,
ekstroventno bit
);

create table prijatelj(
sifra int not null primary key auto_increment,
stilfrizura varchar(39) not null,
kratkamajica varchar(32),
treciputa datetime,
modelnaocala varchar(32) not null,
prviputa datetime,
mladic int not null
);

create table mladic(
sifra int not null primary key auto_increment,
drugiputa datetime not  null,
narukvica int,
bojaociju varchar(49) not null,
modelnaocala varchar(41)
);


alter table prijatelj add foreign key (mladic) references mladic(sifra);
alter table neprijatelj_muskarac add foreign key (neprijatelj) references neprijatelj(sifra);
alter table neprijatelj_muskarac add foreign key (muskarac) references muskarac(sifra);
alter table brat add foreign key (neprijatelj) references neprijatelj(sifra);
alter table ostavljen add foreign key (brat) references brat(sifra);
alter table ostavljena add foreign key (ostavljen) references ostavljen(sifra);


#1. U tablice ostavljen, brat i neprijatelj_muskarac unesite po 3 retka. 
#(7)
insert into muskarac (ogrlica ,vesta ) values
(5,'crna'),(5,'crna'),(5,'crna');
insert into neprijatelj (prstena ,bojakose ,ogrlica ,stilfrizura ) values
(5,'crna',3,'bekemica'),(5,'crna',3,'bekemica'),(5,'crna',3,'bekemica');
insert into neprijatelj_muskarac (neprijatelj ,muskarac ) values
(1,1),(2,2),(3,3);
insert into brat (eura ,gustoca ,haljina ,neprijatelj ) values
(100,23,'ljepa',2),(100,23,'ljepa',2),(100,23,'ljepa',2);
insert into ostavljen (drugiputa ,asocijalno ,brat ) values
('2020-02-02',true,1),('2020-02-02',true,1),('2020-02-02',true,1);


#2. U tablici prijatelj postavite svim zapisima kolonu kratkamajica na 
#vrijednost Osijek. (4)

update prijatelj set kratkamajica ='Osijek';



#3. U tablici ostavljena obrišite sve zapise čija je vrijednost kolone 
#hlace veće od AB. (4)

delete from ostavljena where hlace<'AB';

#4. Izlistajte kuna iz tablice brat uz uvjet da vrijednost kolone gustoca 
#nije 6,10,16,25 ili 36. (6)

select kuna from brat where gustoca!=6 or 10 or 16 or 25 or 36;

#5. Prikažite vesta iz tablice muskarac, dukserica iz tablice ostavljena 
#te drugiputa iz tablice ostavljen uz uvjet da su vrijednosti kolone 
#gustoca iz tablice brat veće od 100 te da su vrijednosti kolone 
#gustoca iz tablice neprijatelj različite od 22. Podatke posložite po 
#drugiputa iz tablice ostavljen silazno. (10)

select m.vesta,o.dukserica,o1.drugiputa from ostavljena o
inner join ostavljen o1 on o.ostavljen =o1.sifra 
inner join brat b on o1.brat=b.sifra 
inner join neprijatelj n on b.neprijatelj 
inner join neprijatelj_muskarac nm on nm.neprijatelj =n.sifra 
inner join muskarac m on nm.muskarac =m.sifra 
where b.gustoca <100 and n.gustoca <>22
order by o1.drugiputa desc;

#6. Prikažite kolone gustoca i bojakose iz tablice neprijatelj čiji se 
#primarni ključ ne nalaze u tablici neprijatelj_muskarac. (5

select n.gustoca,n.bojakose from neprijatelj n
left join neprijatelj_muskarac nm on nm.neprijatelj =n.sifra 
where nm.neprijatelj =null;
