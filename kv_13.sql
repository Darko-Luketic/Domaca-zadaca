drop database if exists kv_13;
create database kv_13;
use kv_13;

create table cura (
sifra int not null primary key auto_increment,
ogrlica int,
hlace varchar(42),
vesta varchar(31) not null,
majica varchar(50),
mladic int
);

create table mladic(
sifra int not null primary key auto_increment,
drugiputa datetime not null,
carape varchar(48) not null,
ogrlica int,
kratkamajica varchar(42) not null,
introvertno bit not null,
asocijalno bit not null,
ostavljen int
);

create table ostavljen(
sifra int not null primary key auto_increment,
kratkamajica varchar(34),
drugiputa datetime,
asocijalno bit not null,
stilfrizura varchar(40),
svekrva int not null
);

create table svekrva(
sifra int not null primary key auto_increment,
hlace varchar(35),
ogrlica int,
ekstroventno bit not null,
narukvica int
);

create table svekrva_svekar(
sifra int not null primary key auto_increment,
svekrva int not null,
svekar int not null
);

create table svekar(
sifra int not null primary key auto_increment,
suknja varchar(40),
stilfrizura varchar(34) not null,
gustoca decimal(15,10) not null,
carape varchar(35) not null
);

create table neprijatelj(
sifra int not null primary key auto_increment,
bojakose varchar(32),
novcica decimal(12,6) not null,
prviputa datetime,
indiferentno bit not null,
suknja varchar(44),
jmbag char(11),
muskarac int not null
);

create table muskarac(
sifra int not null primary key auto_increment,
dukserica varchar(34),
gustoca decimal(13,10) ,
haljina varchar(42) not null,
majica varchar(39),
suknja varchar(50) not null,
kuna decimal(17,9) not null
);


alter table neprijatelj add foreign key (muskarac) references muskarac(sifra);
alter table cura add foreign key (mladic) references mladic(sifra);
alter table mladic add foreign key (ostavljen) references ostavljen(sifra);
alter table ostavljen add foreign key (svekrva) references svekrva(sifra);
alter table svekrva_svekar add foreign key (svekrva) references svekrva(sifra);
alter table svekrva_svekar add foreign key (svekar) references svekar(sifra);




#1. U tablice mladic, ostavljen i svekrva_svekar unesite po 3 retka. (7)

insert into svekar (stilfrizura ,gustoca ,carape ) values
('crna',100,'crna'),('crna',100,'crna'),('crna',100,'crna');
insert into svekrva (ekstroventno ) values
(false),(true),(false);
insert into svekrva_svekar (svekrva ,svekar ) values
(1,1),(2,2),(3,3);
insert into ostavljen (asocijalno ,svekrva ) values
(false,1),(false,1),(false,1);
insert into mladic (drugiputa ,carape ,kratkamajica ,introvertno ,asocijalno ) values
('2020-02-02','crna','crna',true,false),('2020-02-02','crna','crna',true,false),('2020-02-02','crna','crna',true,false);

#2. U tablici neprijatelj postavite svim zapisima kolonu novcica na 
#rijednost 13,77. (4)


update neprijatelj set novcica =13.77;


#3. U tablici cura obrišite sve zapise čija je vrijednost kolone hlace 
#različito od AB. (4)

delete from cura where hlace <>'AB';

#4. Izlistajte asocijalno iz tablice ostavljen uz uvjet da vrijednost 
#kolone drugiputa nepoznate. (6)

select asocijalno from ostavljen where drugiputa =null;

#5. Prikažite gustoca iz tablice svekar, majica iz tablice cura te carape 
#iz tablice mladic uz uvjet da su vrijednosti kolone drugiputa iz tablice 
#ostavljen poznate te da su vrijednosti kolone ogrlica iz tablice svekrva 
#jednake broju 193. Podatke posložite po carape iz tablice mladic 
#silazno. (10)

select s.gustoca,c.majica,m.carape from svekar s
inner join svekrva_svekar ss on ss.svekar=s.sifra 
inner join svekrva s1 on ss.svekrva =s1.sifra 
inner join ostavljen o on o.svekrva =s1.sifra 
inner join mladic m on m.ostavljen =o.sifra 
inner join cura c on c.mladic =m.sifra
where o.drugiputa !=null and s1.ogrlica =193
order by m.carape desc;

#6. Prikažite kolone ogrlica i ekstroventno iz tablice svekrva čiji se 
#primarni ključ ne nalaze u tablici svekrva_svekar. (5

select s.ogrlica,s.ekstroventno from svekrva s
left join svekrva_svekar ss on ss.svekrva =s.sifra 
where ss.svekrva =null;

