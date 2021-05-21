drop database if exists kv_4;
create database kv_4;
use kv_4;

create table punac(
sifra int not null primary key auto_increment,
treciputa datetime,
majica varchar(46),
jmbag char(11) not null,
novcica decimal(18,7) not null,
maraka decimal(12,6) not null,
ostavljen int not null
);

create table ostavljen(
sifra int not null primary key auto_increment,
modelnaocala varchar(43),
introventno bit ,
kuna decimal(14,10)
);

create table prijatelj(
sifra int not null primary key auto_increment,
eura decimal(16,9),
prstena int not null,
gustoca decimal(16,5),
jmbag char(11) not null,
suknja varchar(47) not null,
becar int not null
);

create table becar(
sifra int not null primary key auto_increment,
novcica decimal(14,8),
kratkamajica varchar(48) not null,
bojaociju varchar(36) not null,
snasa int not null
);

create table snasa(
sifra int not null primary key auto_increment,
introventno bit,
treciputa datetime,
haljina varchar(44) not null,
zena int not null
);

create table zena(
sifra int not null primary key auto_increment,
suknja varchar(39) not null,
lipa decimal(18,7) ,
prstena int not null
);

create table zena_mladic(
sifra int not null primary key auto_increment,
zena int not null,
mladic int not null
);

create table mladic(
sifra int not null primary key auto_increment,
kuna decimal(15,9),
lipa decimal(18,5),
nausnica int,
stilfrizura varchar(49),
vesta varchar(34) not null
);

alter table punac add foreign key (ostavljen) references ostavljen(sifra);
alter table zena_mladic add foreign key (mladic) references mladic(sifra);
alter table zena_mladic add foreign key (zena) references zena(sifra);
alter table snasa add foreign key (zena) references zena(sifra);
alter table becar add foreign key (snasa) references snasa(sifra);
alter table prijatelj add foreign key (becar) references becar(sifra);


#1. U tablice becar, snasa i zena_mladic unesite po 3 retka. (7)

insert into mladic (vesta) values
('crna'),('crna'),('crna');
insert into zena (suknja,prstena ) values
('crna',1),('crna',1),('crna',2);
insert into zena_mladic (zena ,mladic ) values
(1,1),(2,2),(3,3);
insert into snasa (haljina ,zena ) values
('crna',1),('crna',1),('crna',2);
insert into becar (kratkamajica ,bojaociju ,snasa ) values
('crna','crna',1),('crna','crna',1),('crna','crna',1);


#2. U tablici punac postavite svim zapisima kolonu majica na 
#vrijednost Osijek. (4)
update punac set majica ='Osijek';



#3. U tablici prijatelj obrišite sve zapise čija je vrijednost kolone 
#prstena veće od 17. (4)

delete from prijatelj where prstena>=17;


#4. Izlistajte haljina iz tablice snasa uz uvjet da vrijednost kolone 
#treciputa nepoznate. (6)
select haljina from snasa where treciputa=null;


#5. Prikažite nausnica iz tablice mladic, jmbag iz tablice prijatelj te 
#kratkamajica iz tablice becar uz uvjet da su vrijednosti kolone 
#treciputa iz tablice snasa poznate te da su vrijednosti kolone lipa iz 
#tablice zena različite od 29. Podatke posložite po kratkamajica iz 
#tablice becar silazno. (10)

select m.nausnica,p.jmbag,b.kratkamajica from prijatelj p 
inner join becar b on p.becar=b.sifra 
inner join snasa s on b.snasa =s.sifra 
inner join zena z on s.zena=z.sifra 
inner join zena_mladic zm on zm.zena=z.sifra 
inner join mladic m on zm.mladic =m.sifra
where s.treciputa is not null and  z.lipa <>29
order by b.kratkamajica desc;



#6. Prikažite kolone lipa i prstena iz tablice zena čiji se primarni ključ 
#ne nalaze u tablici zena_mladic. (5)

select z.lipa,z.prstena from zena z
left join zena_mladic zm on zm.zena=z.sifra 
where zena is not null;