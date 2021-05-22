drop database if exists kv_7;
create database kv_7;
use kv_7;


create table mladic(
sifra int not null primary key auto_increment,
prstena int,
lipa decimal(14,5) not null,
narukvica int not null,
drugiputa datetime not null
);

create table zarucnik_mladic(
sifra int not null primary key auto_increment,
zarucnik int not null,
mladic int not null
);

create table zarucnik(
sifra int not null primary key auto_increment,
vesta varchar(34),
asocijalno bit not null,
modelnaocala varchar(43),
narukvica int not null,
novcica decimal(15,5) not null
);

create table ostavljen(
sifra int not null primary key auto_increment,
introvertno bit not null,
kratkamajica varchar(38) not null,
prstena int not null,
zarucnik int
);

create table prijateljica(
sifra int not null primary key auto_increment,
haljina varchar(45),
gustoca decimal(15,10) not null,
ogrlica int,
novcica decimal(12,5),
ostavljen int 
);

create table sestra(
sifra int not null primary key auto_increment,
bojakose varchar(34) not null,
hlace varchar(36) not null,
lipa decimal(15,6),
stilfrizura varchar(40) not null,
maraka decimal(12,8) not null,
prijateljica int
);

create table cura(
sifra int not null primary key auto_increment,
lipa decimal(12,9) not null,
introventno bit,
modelnaocala varchar(40),
narukvica int,
treciputa datetime,
kuna decimal(14,9)
);

create table punica(
sifra int not null primary key auto_increment,
majica varchar(40),
eura decimal(12,6) not null,
prstena int,
cura int
);

alter table punica add foreign key (cura) references cura(sifra);
alter table sestra add foreign key (prijateljica) references prijateljica(sifra);
alter table prijateljica add foreign key (ostavljen) references ostavljen(sifra);
alter table ostavljen add foreign key (zarucnik) references zarucnik(sifra);
alter table zarucnik_mladic add foreign key (zarucnik) references zarucnik(sifra);
alter table zarucnik_mladic add foreign key (mladic) references mladic(sifra);


#1. U tablice prijateljica, ostavljen i zarucnik_mladic unesite po 3 
#retka. (7)

insert into mladic (lipa ,narukvica,drugiputa ) values
(100,2,'2020-02-02'),(100,2,'2020-02-02'),(100,2,'2020-02-02');
insert into zarucnik (asocijalno ,narukvica ,novcica ) values
(true,2,100),(true,2,100),(true,2,100);
insert into zarucnik_mladic (zarucnik ,mladic ) values
(1,1),(2,2),(3,3);
insert into ostavljen (introvertno ,kratkamajica ,prstena ) values
(false,'crna',5),(false,'crna',5),(false,'crna',5);
insert into prijateljica (gustoca ) values
(100),(22),(311);

#2. U tablici punica postavite svim zapisima kolonu eura na vrijednost 
#15,77. (4)
update punica set eura =15.77;


#3. U tablici sestra obrišite sve zapise čija je vrijednost kolone hlace 
#manje od AB. (4)

delete from sestra where hlace <'AB';

#4. Izlistajte kratkamajica iz tablice ostavljen uz uvjet da vrijednost 
#kolone introvertno nepoznate. (6)
select kratkamajica  from ostavljen where introvertno= null;

#5. Prikažite narukvica iz tablice mladic, stilfrizura iz tablice sestra te 
#gustoca iz tablice prijateljica uz uvjet da su vrijednosti kolone 
#introvertno iz tablice ostavljen poznate te da su vrijednosti kolone 
#asocijalno iz tablice zarucnik poznate. Podatke posložite po gustoca iz 
#tablice prijateljica silazno. (10)

select m.narukvica,s.stilfrizura ,p.gustoca from mladic m
inner join zarucnik_mladic zm on zm.mladic =m.sifra 
inner join zarucnik z on zm.zarucnik =z.sifra 
inner join ostavljen o on o.zarucnik =z.sifra 
inner join  prijateljica p on p.ostavljen =o.sifra 
inner join sestra s on s.prijateljica =p.sifra
where o.introvertno !=null and z.asocijalno !=null 
order by p.gustoca desc;


#6. Prikažite kolone asocijalno i modelnaocala iz tablice zarucnik čiji se 
#primarni ključ ne nalaze u tablici zarucnik_mladic. (5

select z.asocijalno,z.modelnaocala from zarucnik z
left join zarucnik_mladic zm on zm.zarucnik =z.sifra 
where zarucnik =null;