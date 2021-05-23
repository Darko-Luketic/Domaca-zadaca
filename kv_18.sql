drop database if exists kv_18;
create database kv_18;
use kv_18;

create table zarucnica(
sifra int not null primary key auto_increment,
carape varchar(43),
treciputa datetime not null,
eura decimal(16,8),
sestra int
);


create table sestra(
sifra int not null primary key auto_increment,
eura decimal,
indiferentno bit,
maraka decimal(13,8),
ogrlica int,
haljina varchar(31) not null,
introvertno bit,
mladic int
);

create table mladic(
sifra int not null primary key auto_increment,
carape varchar(50) not null,
jmbag char(11),
hlace varchar(50) not null,
treciputa datetime,
drugiputa datetime not null,
muskarac int
);

create table muskarac(
sifra int not null primary key auto_increment,
trecipta datetime,
nausnica int not null,
drugiputa datetime not null,
prstena int not null,
modelnaocala varchar(34)
);

create table muskarac_prijatelj(
sifra int not null primary key auto_increment,
muskarac int not null,
prijatelj int not null
);

create table prijatelj(
sifra int not null primary key auto_increment,
novcica decimal(15,9),
ekstroventno bit not null,
bojakose varchar(30) not null,
haljina varchar(37) ,
narukvica int
);

create table djevojka(
sifra int not null primary key auto_increment,
bojaociju varchar(43) not null,
treciputa datetime not null,
carape varchar(32) not null
);

create table ostavljena(
sifra int not null primary key auto_increment,
novcica decimal(18,9),
drugiputa datetime not null,
dukserica varchar(35),
kratkamajica varchar(34),
djevojka int not null
);

alter table ostavljena add foreign key (djevojka) references djevojka(sifra);
alter table muskarac_prijatelj add foreign key (muskarac) references muskarac(sifra);
alter table muskarac_prijatelj add foreign key (prijatelj) references prijatelj(sifra);
alter table mladic add foreign key (muskarac) references muskarac(sifra);
alter table sestra add foreign key (mladic) references mladic(sifra);
alter table zarucnica add foreign key (sestra) references sestra(sifra);


#1. U tablice sestra, mladic i muskarac_prijatelj unesite po 3 retka. (7)

insert into prijatelj (ekstroventno ,bojakose ) values
(true,'crna'),(true,'crna'),(true,'crna');
insert into muskarac (nausnica ,drugiputa ,prstena ) values
(5,'2020-02-02',3),(5,'2020-02-02',3),(5,'2020-02-02',3);
insert into muskarac_prijatelj (muskarac ,prijatelj ) values
(1,1),(2,2),(3,3);
insert into mladic (carape ,hlace ,drugiputa ) values
('crna','crna','2020-02-02'),('crna','crna','2020-02-02'),('crna','crna','2020-02-02');
insert into sestra (haljina ) values
('crna'),('crna'),('crna');


#2. U tablici ostavljena postavite svim zapisima kolonu drugiputa na 
#vrijednost 7. travnja 2016. (4)

update ostavljena set drugiputa ='2016-04-07';

#3. U tablici zarucnica obrišite sve zapise čija je vrijednost kolone 
#treciputa 18. travnja 2015. (4)

delete from zarucnica where treciputa ='2015-04-18';

#4. Izlistajte hlace iz tablice mladic uz uvjet da vrijednost kolone jmbag 
#nepoznate. (6)

select hlace from mladic where jmbag =null;

#5. Prikažite bojakose iz tablice prijatelj, sestra iz tablice zarucnica te 
#indiferentno iz tablice sestra uz uvjet da su vrijednosti kolone jmbag 
##iz tablice mladic poznate te da su vrijednosti kolone nausnica iz 
#tablice muskarac jednake broju 213. Podatke posložite po 
#indiferentno iz tablice sestra silazno. (10)

select p.bojakose,z.sestra,s.indiferentno from zarucnica z 
inner join sestra s on z.sestra =s.sifra 
inner join mladic m on s.mladic =m.sifra 
inner join muskarac m1 on m.muskarac =m1.sifra 
inner join muskarac_prijatelj mp on mp.muskarac =m1.sifra 
inner join prijatelj p on mp.prijatelj =p.sifra
where m.jmbag =null and m1.nausnica =213
order by s.indiferentno desc;


#6. Prikažite kolone nausnica i drugiputa iz tablice muskarac čiji se 
#primarni ključ ne nalaze u tablici muskarac_prijatelj. (5

select m1.nausnica,m1.drugiputa from muskarac m1
left join muskarac_prijatelj mp on mp.muskarac =m1.sifra 
where mp.muskarac =null;