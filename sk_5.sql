drop database if exists kv_5;
create database kv_5;
use kv_5;

create table mladic(
sifra int not null primary key auto_increment,
kratkamajica varchar(48) not null,
haljina varchar(30) not null,
asocijalno bit,
zarucnik int
);

create table zarucnik(
sifra int not null primary key auto_increment,
jmbag char(11),
lipa decimal(12,8),
indiferentno bit not null
);

create table ostavljena (
sifra int not null primary key auto_increment,
majica varchar(33),
ogrlica int not null,
carape varchar(44),
stilfrizura varchar(42),
punica int not null
);

create table punica(
sifra int not null primary key auto_increment,
hlace varchar(43) not null,
nausnica int not null,
ogrlica int,
vesta varchar(49) not null,
modelnaocala varchar(31) not null,
treciputa datetime not null,
punac int
);

create table punac(
sifra int not null primary key auto_increment,
dukserica varchar(33),
prviputa datetime not null,
majica varchar(36),
svekar int not null
);

create table svekar(
sifra int not null primary key auto_increment,
bojakose varchar(33) ,
majica varchar(31),
carape varchar(31) not null,
haljina varchar(43),
narukvica int ,
eura decimal(14,5) not null
);

create table svekar_cura(
sifra int not null primary key auto_increment,
svekar int not null,
cura int not null
);


create table cura(
sifra int not null primary key auto_increment,
carape varchar(41) not null,
maraka decimal(17,10) not null,
asocijalno bit,
vesta varchar(47) not null
);

alter table svekar_cura add foreign key (cura) references cura(sifra);
alter table svekar_cura add foreign key (svekar) references svekar(sifra);
alter table punac add foreign key (svekar) references svekar(sifra);
alter table punica add foreign key (punac) references punac(sifra);
alter table ostavljena add foreign key (punica) references punica(sifra);
alter table mladic add foreign key (zarucnik) references zarucnik(sifra);



#1. U tablice punica, punac i svekar_cura unesite po 3 retka. (7)

insert into cura (carape,maraka,vesta) values
('crna',100,'crna'),('crna',100,'crna'),('crna',100,'crna');
insert into svekar(carape,eura) values
('crna',100),('crna',100),('crna',100);
insert into svekar_cura (svekar,cura) values
(1,1),(2,2),(3,3);
insert into punac(prviputa,svekar) values
('2020-02-02',1),('2020-02-02',1),('2020-02-02',1);
insert into punica (hlace,nausnica,vesta,modelnaocala,treciputa,punac) values
('plava',5,+'crna','ljepe','2020-02-02',1),('plava',5,+'crna','ljepe','2020-02-02',1),('plava',5,+'crna','ljepe','2020-02-02',1);

#2. U tablici mladic postavite svim zapisima kolonu haljina na 
#vrijednost Osijek. (4)
update mladic set haljina ='Osijek';


#3. U tablici ostavljena obrišite sve zapise čija je vrijednost kolone 
#ogrlica jednako 17. (4)
delete from ostavljena where ogrlica=17;

#4. Izlistajte majica iz tablice punac uz uvjet da vrijednost kolone 
#prviputa nepoznate. (6)
select majica from punac where prviputa=null;


#5. Prikažite asocijalno iz tablice cura, stilfrizura iz tablice ostavljena te 
#nausnica iz tablice punica uz uvjet da su vrijednosti kolone prviputa iz 
#tablice punac poznate te da su vrijednosti kolone majica iz tablice 
#svekar sadrže niz znakova ba. Podatke posložite po nausnica iz tablice 
#punica silazno. (10)
select c.asocijalno,o.stilfrizura,p1.nausnica from ostavljena o
inner join punica p1 on o.punica=p1.sifra 
inner join punac p on p1.punac=p.sifra 
inner join svekar s on p.svekar=s.sifra 
inner join svekar_cura sc on sc.svekar=s.sifra 
inner join cura c on sc.cura=c.sifra
where p.prviputa is not null and s.majica like '%ba%'
order by p1.nausnica desc;

#6. Prikažite kolone majica i carape iz tablice svekar čiji se primarni 
#ključ ne nalaze u tablici svekar_cura. (5)
select s.majica,s.carape from svekar s
left join svekar_cura sc on sc.svekar =s.sifra
where svekar is null;

