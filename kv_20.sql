drop database if exists kv_20;
create database kv_20;
use kv_20;


create table neprijateljica(
sifra int not null primary key auto_increment,
introvertno bit not null,
nausnica int ,
gustoca decimal(17,8),
lipa decimal(17,8),
jmbag char(11) not null,
zena int
);


create table zena(
sifra int not null primary key auto_increment,
asocijalno bit not null,
nausnica int ,
jmbag char(11) not null,
bojaociju varchar(41),
kratkamajica varchar(30)
);

create table zarucnik(
sifra int not null primary key auto_increment,
suknja varchar (31),
prstena int not null,
modelnaocala varchar(46) not null,
novcica decimal(17,5) not null,
gustoca decimal(17,8)
);

create table mladic_zarucnik(
sifra int not null primary key auto_increment,
mladic int not null,
zarucnik int not null
);

create table mladic(
sifra int not null primary key auto_increment,
hlace varchar(47),
suknja varchar(50),
haljina varchar(50) not null,
prstena int not null,
treciputa datetime not null,
introvertno bit not null
);

create table punica(
sifra int not null primary key auto_increment,
ogrlica int,
prviputa datetime,
drugiputa datetime not null,
introvertno bit,
treciputa datetime,
mladic int not null
);

create table decko(
sifra int not null primary key auto_increment,
kuna decimal(14,5),
novcica decimal(15,7),
indiferentno bit not null,
maraka decimal(16,9) not null,
punica int not null
);

create table zarucnica(
sifra int not null primary key auto_increment,
modelnaocala varchar(50),
suknja varchar(49) not null,
prviputa datetime,
treciputa datetime,
decko int
);


alter table neprijateljica add foreign key (zena) references zena(sifra);
alter table mladic_zarucnik add foreign key (mladic) references mladic(sifra);
alter table mladic_zarucnik add foreign key (zarucnik) references zarucnik(sifra);
alter table punica add foreign key (mladic) references mladic(sifra);
alter table decko add foreign key (punica) references punica(sifra);
alter table zarucnica add foreign key (decko) references decko(sifra);

#1. U tablice decko, punica i mladic_zarucnik unesite po 3 retka. (7)

insert into zarucnik (prstena ,modelnaocala ,novcica ) values
(5,'rey',100),(5,'rey',100),(5,'rey',100);
insert into mladic (haljina ,prstena ,treciputa ,introvertno ) values
('crna',5,'2020-02-02',false),('crna',5,'2020-02-02',false),('crna',5,'2020-02-02',false);
insert into mladic_zarucnik (mladic ,zarucnik ) values
(1,1),(2,2),(3,3);


#2. U tablici neprijateljica postavite svim zapisima kolonu nausnica na 
#vrijednost 10. (4)

update neprijateljica set nausnica =10;

#3. U tablici zarucnica obrišite sve zapise čija je vrijednost kolone 
#suknja manje od AB. (4)

delete from zarucnik where suknja<'AB';

#4. Izlistajte drugiputa iz tablice punica uz uvjet da vrijednost kolone 
#prviputa nepoznate. (6)


select drugiputa from punica p2 where prviputa =null;
#5. Prikažite modelnaocala iz tablice zarucnik, treciputa iz tablice 
#zarucnica te novcica iz tablice decko uz uvjet da su vrijednosti kolone 
#prviputa iz tablice punica poznate te da su vrijednosti kolone suknja 
#iz tablice mladic sadrže niz znakova ba. Podatke posložite po novcica 
#iz tablice decko silazno. (10)

select z.modelnaocala,z1.treciputa,d.novcica from zarucnica z1
inner join decko d on z1.decko =d.sifra 
inner join punica p on d.punica =p.sifra 
inner join mladic m on p.mladic =m.sifra 
inner join mladic_zarucnik mz on mz.mladic =m.sifra 
inner join zarucnik z on mz.zarucnik =z.sifra
where p.prviputa !=null and m.suknja like '%ba%'
order by d.novcica desc;

#6. Prikažite kolone suknja i haljina iz tablice mladic čiji se primarni 
#ključ ne nalaze u tablici mladic_zarucnik. (5

select m.suknja,m.haljina from mladic m
left join mladic_zarucnik mz on mz.mladic=m.sifra 
where mz.mladic =null;


