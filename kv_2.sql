drop database if exists kv_2;
create database kv_2;
use kv_2;



create table brat(
sifra int not null primary key auto_increment,
suknja varchar(47),
ogrlica int not null,
asocijalno bit not null,
neprijatelj int not null
);

create table neprijatelj(
sifra int not null primary key auto_increment,
majica varchar(32),
haljina varchar(43) not null,
lipa decimal (16,8),
modelnaocala varchar(49) not null,
kuna decimal(12,6) not null,
jmbag char(11),
cura int
);




create table cura(
sifra int not null primary key auto_increment,
haljina varchar(33) not null,
drugiputa datetime not null,
suknja varchar(38),
narukvica int,
intoventno bit,
majica varchar(40) not null,
decko int
);

create table decko(
sifra int not null primary key auto_increment,
indiferentno bit,
vesta varchar(34),
asocijalno bit not null
);

create table decko_zarucnica(
sifra int not null primary key auto_increment,
decko int not null,
zarucnica int not null
);

create table zarucnica(
sifra int not null primary key auto_increment,
narukvica int,
bojakose varchar(37) not null,
novcica decimal(15,9),
lipa decimal (15,8) not null,
indiferentno bit 
);

create table svekar(
sifra int not null primary key auto_increment,
stilfrizura varchar(48),
ogrlica int not null,
asocijalno bit not null
);

create table prijatelj(
sifra int not null primary key auto_increment,
modelnaocala varchar(37),
treciputa datetime not null,
ekstroventno bit not null,
prviputa datetime,
svekar int not null
);


alter table prijatelj add foreign key (svekar) references svekar(sifra);
alter table brat add foreign key (neprijatelj ) references neprijatelj(sifra);
alter table neprijatelj add foreign key (cura) references cura(sifra);
alter table cura add foreign key (decko) references decko(sifra);
alter table decko_zarucnica add foreign key (decko) references decko(sifra);
alter table decko_zarucnica add foreign key (zarucnica) references zarucnica(sifra);


#1. U tablice neprijatelj, cura i decko_zarucnica unesite po 3 retka. (7)
insert into zarucnica (bojakose ,lipa) values
('crna',100),('crna',100),('crna',100);
insert into decko (asocijalno) values
(true),(false),(true);
insert into decko_zarucnica (decko ,zarucnica ) values
(1,1),(2,2),(3,3);
insert into cura (haljina ,drugiputa ,majica ) values
('crna','2021-08-01','plava'),
('crna','2021-08-01','plava'),
('crna','2021-08-01','plava');
insert into neprijatelj (haljina,modelnaocala ,kuna) values
('ljepa','jos ljepse',1),
('ljepa','jos ljepse',1),
('ljepa','jos ljepse',1);

#2. U tablici prijatelj postavite svim zapisima kolonu treciputa na 
#vrijednost 30. travnja 2020. (4)

update prijatelj set treciputa ='2020-04-30';


#3. U tablici brat obrišite sve zapise čija je vrijednost kolone ogrlica 
#različito od 14. (4)

delete from brat where ogrlica!=14;

#4. Izlistajte suknja iz tablice cura uz uvjet da vrijednost kolone 
#drugiputa nepoznate. (6)

select suknja from cura where drugiputa=null;


#5. Prikažite novcica iz tablice zarucnica, neprijatelj iz tablice brat te 
#haljina iz tablice neprijatelj uz uvjet da su vrijednosti kolone 
#drugiputa iz tablice cura poznate te da su vrijednosti kolone vesta iz 
#tablice decko sadrže niz znakova ba. Podatke posložite po haljina iz 
#tablice neprijatelj silazno. (10)

select z.novcica,b.neprijatelj,ne.haljina from zarucnica z
inner join decko_zarucnica dz on dz.zarucnica =z.sifra 
inner join decko d on dz.decko =d.sifra 
inner join cura c on c.decko=d.sifra 
inner join neprijatelj ne on ne.cura=c.sifra 
inner join brat b on b.neprijatelj =ne.sifra
where c.drugiputa is not null and d.vesta like '%ba%'
order by ne.haljina desc;


#6. Prikažite kolone vesta i asocijalno iz tablice decko čiji se primarni 
#ključ ne nalaze u tablici decko_zarucnica. (5)

select d.vesta,d.asocijalno from decko d
left join decko_zarucnica dz on dz.decko=d.sifra 
where dz.decko is null;

