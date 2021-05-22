drop database if exists kv_12;
create database kv_12;
use kv_12;

create table zena(
sifra int not null primary key auto_increment,
eura decimal(16,6) not null,
indiferentno bit,
novcica decimal(15,5)
);

create table decko(
sifra int not null primary key auto_increment,
hlace varchar(46),
asocijalno bit,
stilfrizura varchar(43) not null,
indiferentno bit not null,
ogrlica int,
zena int not null
);


create table sestra(
sifra int not null primary key auto_increment,
lipa decimal(15,9),
ogrlica int ,
kratkamajica varchar(43) not null
);

create table zarucnica_sestra(
sifra int not null primary key auto_increment,
zarucnica int not null,
sestra int not null
);

create table zarucnica(
sifra int not null primary key auto_increment,
hlace varchar(48) not null,
kratkamajica varchar(46) not null,
jmbag char(11),
nausnica int
);

create table svekrva(
sifra int not null primary key auto_increment,
maraka decimal(14,7),
kuna decimal(15,8),
vesta varchar(44),
asocijalno bit not null,
ekstroventno bit,
zarucnica int
);

create table djevojka(
sifra int not null primary key auto_increment,
modelnaocala varchar(34) not null,
vesta varchar(40) not null,
kratkamajica varchar(39) not null,
suknja varchar(36) not null,
bojaociju varchar(32) not null,
prstena int not null,
svekrva int not null
);


create table prijatelj(
sifra int not null primary key auto_increment,
lipa decimal(16,10),
asocijalno bit,
stilfrizura varchar(37),
kuna decimal(14,6),
modelnaocala varchar(38),
djevojka int
);


alter table prijatelj add foreign key (djevojka) references djevojka(sifra);
alter table djevojka add foreign key (svekrva) references svekrva(sifra);
alter table svekrva add foreign key (zarucnica) references zarucnica(sifra);
alter table zarucnica_sestra add foreign key (zarucnica) references zarucnica(sifra);
alter table zarucnica_sestra add foreign key (sestra) references sestra(sifra);
alter table decko add foreign key (zena) references zena(sifra);


#1. U tablice djevojka, svekrva i zarucnica_sestra unesite po 3 retka. 
#(7)
insert into sestra (kratkamajica ) values
('crna'),('crna'),('crna');
insert into zarucnica (hlace ,kratkamajica ) values
('crna','plava'),('crna','plava'),('crna','plava');
insert into zarucnica_sestra (zarucnica ,sestra ) values
(1,1),(2,2),(3,3);
insert into svekrva (asocijalno ) values
(true),(true),(true);
insert into djevojka (modelnaocala ,vesta ,kratkamajica ,suknja ,bojaociju ,prstena ,svekrva ) values
('levis','crna','crna','plava','plava',1,1),('levis','crna','crna','plava','plava',1,1),('levis','crna','crna','plava','plava',1,1);

#2. U tablici decko postavite svim zapisima kolonu asocijalno na 
#vrijednost false. (4)
update decko set asocijalno =false;

#3. U tablici prijatelj obrišite sve zapise čija je vrijednost kolone 
#asocijalno false. (4)
delete from prijatelj where asocijalno =false ;

#4. Izlistajte vesta iz tablice svekrva uz uvjet da vrijednost kolone kuna 
#nije 8,13,20,28 ili 35. (6)

select vesta from svekrva where kuna !=8 or 13 or 20 or 28 or 35;

#5. Prikažite kratkamajica iz tablice sestra, kuna iz tablice prijatelj te 
#vesta iz tablice djevojka uz uvjet da su vrijednosti kolone kuna iz 
#tablice svekrva veće od 87 te da su vrijednosti kolone kratkamajica iz 
#tablice zarucnica sadrže niz znakova ba. Podatke posložite po vesta iz 
#tablice djevojka silazno. (10)

select s1.kratkamajica,p.kuna,d.vesta from prijatelj p 
inner join djevojka d on p.djevojka =d.sifra 
inner join svekrva s on d.svekrva =s.sifra 
inner join zarucnica z on s.zarucnica =z.sifra 
inner join zarucnica_sestra zs on zs.zarucnica =z.sifra 
inner join sestra s1 on zs.sestra =s1.sifra
where s.kuna>87 and z.kratkamajica like '%ba%'
order by d.vesta desc;

#6. Prikažite kolone kratkamajica i jmbag iz tablice zarucnica čiji se 
#primarni ključ ne nalaze u tablici zarucnica_sestra. (5
select z.kratkamajica,z.jmbag from zarucnica z 
left join zarucnica_sestra zs on zs.zarucnica =z.sifra 
where zs.zarucnica =null;
