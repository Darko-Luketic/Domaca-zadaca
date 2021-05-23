drop database if exists kv_19;
create database kv_19;
use kv_19;

create table muskarac(
sifra int not null primary key auto_increment,
drugiputa datetime not null,
gustoca decimal(16,7),
maraka decimal(16,9),
ogrlica int not null,
svekrva int
);

create table svekrva(
sifra int not null primary key auto_increment,
ekstroventno bit,
carape varchar(42),
gustoca decimal(13,10) not null,
stilfrizura varchar(34) not null,
punac int not null
);

create table punac(
sifra int not null primary key auto_increment,
maraka decimal(12,7),
treciputa datetime,
ekstroventno bit,
hlace varchar(32),
punica int not null
);

create table punica(
sifra int not null primary key auto_increment,
stilfrizura varchar(39) not null,
maraka decimal(15,6) not null,
jmbag char(11) not null
);

create table punica_ostavljena(
sifra int not null primary key auto_increment,
punica int not null,
ostavljena int not null
);

create table ostavljena(
sifra int not null primary key auto_increment,
hlace varchar(41),
ekstroventno bit not null,
narukvica int,
eura decimal(17,6) not null,
kratkamajica varchar(46)
);


create table svekar(
sifra int not null primary key auto_increment,
nausnica int not null,
indiferentno bit not null,
suknja varchar(37) not null,
drugiputa datetime,
kuna decimal(13,6) not null,
decko int
);

create table decko(
sifra int not null primary key auto_increment,
modelnaocala varchar(42) not null,
gustoca decimal(16,10) not null,
dukserica varchar(47) not null,
stilfrizutra varchar(40),
novcica decimal(14,7) not null
);

alter table svekar add foreign key (decko) references decko(sifra);
alter table punica_ostavljena add foreign key (ostavljena) references ostavljena(sifra);
alter table punica_ostavljena add foreign key (punica) references punica(sifra);
alter table punac add foreign key (punica) references punica(sifra);
alter table svekrva add foreign key (punac) references punac(sifra);
alter table muskarac add foreign key (svekrva) references svekrva(sifra);

#1. U tablice svekrva, punac i punica_ostavljena unesite po 3 retka. (7)

insert into ostavljena (ekstroventno ,eura ) values
(true,100),(true,100),(true,100);
insert into punica (stilfrizura ,maraka ,jmbag ) values
('crna',100,12345678910),('crna',100,12345678910),('crna',100,12345678910);
insert into punica_ostavljena (punica ,ostavljena ) values
(1,1),(2,2),(3,3);
insert into punac(punica ) values
(1),(2),(3);
insert into svekrva (gustoca ,stilfrizura ,punac ) values
(100,'crna',1),(100,'crna',1),(100,'crna',1);


#2. U tablici svekar postavite svim zapisima kolonu indiferentno na 
#vrijednost false. (4)

update svekar set indiferentno =false;

#3. U tablici muskarac obrišite sve zapise čija je vrijednost kolone 
#gustoca jednako 14,92. (4)

delete from muskarac where gustoca =14.92;


#4. Izlistajte ekstroventno iz tablice punac uz uvjet da vrijednost 
#kolone treciputa nepoznate. (6)

select ekstroventno from punac where treciputa =null;



#5. Prikažite narukvica iz tablice ostavljena, ogrlica iz tablice muskarac 
#te carape iz tablice svekrva uz uvjet da su vrijednosti kolone treciputa 
#iz tablice punac poznate te da su vrijednosti kolone maraka iz tablice 
#punica različite od 21. Podatke posložite po carape iz tablice svekrva 
#silazno. (10)

select o.narukvica,m.ogrlica,s.carape from ostavljena o
inner join punica_ostavljena po on po.ostavljena =o.sifra 
inner join punica p1 on po.punica =p1.sifra 
inner join punac p on p.punica =p1.sifra 
inner join svekrva s on s.punac =p.sifra 
inner join muskarac m on m.svekrva =s.sifra 
where p.treciputa !=null and p1.maraka <>21
order by s.carape desc;


#6. Prikažite kolone maraka i jmbag iz tablice punica čiji se primarni 
#ključ ne nalaze u tablici punica_ostavljena. (5

select p1.maraka,p1.jmbag from punica p1
left join punica_ostavljena po on po.punica =p1.sifra 
where po.punica =null;


