drop database if exists kv_10;
create database kv_10;
use kv_10;

create table zarucnica(
sifra int not null primary key auto_increment,
treciputa datetime,
prviputa datetime,
suknja varchar(32) not null,
eura decimal(16,10)
);

create table sestra(
sifra int not null primary key auto_increment,
suknja varchar(36) not null,
bojaociju varchar(49) ,
indiferentno bit,
dukserica varchar(32) not null,
drugiputa datetime,
prviputa datetime not null,
zarucnica int
);

create table zena(
sifra int not null primary key auto_increment,
bojaociju varchar(49) not null,
maraka decimal(13,9) not null,
majica varchar(45) ,
indiferentno bit ,
prviputa datetime,
mladic int
);

create table mladic(
sifra int not null primary key auto_increment,
hlace varchar(48) not null,
lipa decimal(18,6),
stilfrizura varchar(35) not null,
prstena int,
maraka decimal(12,6) not null,
svekrva int
);

create table svekrva(
sifra int not null primary key auto_increment,
eura decimal(17,9),
carape varchar(43),
kuna decimal(13,9),
majica varchar(30),
introvertno bit not null,
punac int
);

create table punac(
sifra int not null primary key auto_increment,
lipa decimal(15,9),
eura decimal(15,10) not null,
stilfrizura varchar(37)
);

create table punac_neprijatelj(
sifra int not null primary key auto_increment,
punac int not null,
neprijatelj int not null
);

create table neprijatelj(
sifra int not null primary key auto_increment,
gustoca decimal(15,10) not null,
dukserica varchar(32) not null,
maraka decimal(15,7),
stilfrizura varchar(49) not null
);

alter table punac_neprijatelj add foreign key (punac) references punac(sifra);
alter table punac_neprijatelj add foreign key (neprijatelj) references neprijatelj(sifra);
alter table svekrva add foreign key (punac) references punac(sifra);
alter table mladic add foreign key (svekrva) references svekrva(sifra);
alter table zena add foreign key (mladic) references mladic(sifra);
alter table sestra add foreign key (zarucnica) references zarucnica(sifra);


#1. U tablice mladic, svekrva i punac_neprijatelj unesite po 3 retka. (7)
insert into neprijatelj (gustoca ,dukserica ,stilfrizura ) values
(15.00,'crna','crna'),(15.00,'crna','crna'),(15.00,'crna','crna');
insert into punac (eura ) values
(100),(200),(300);
insert into punac_neprijatelj (punac ,neprijatelj ) values
(1,1),(2,2),(3,3);
insert into svekrva (introvertno ) values
(false),(false),(false);
insert into mladic (hlace ,stilfrizura ,maraka ) values
('plave','crna',100),('plave','crna',100),('plave','crna',100);

#. U tablici sestra postavite svim zapisima kolonu bojaociju na 
#vrijednost Osijek. (4)

update sestra set bojaociju ='Osijek';

##3. U tablici zena obrišite sve zapise čija je vrijednost kolone maraka 
#različito od 14,81. (4)

delete from zena where maraka <>14.81;

#4. Izlistajte kuna iz tablice svekrva uz uvjet da vrijednost kolone 
#carape sadrže slova ana. (6)

select kuna from svekrva where carape like '%ana%';
##5. Prikažite maraka iz tablice neprijatelj, indiferentno iz tablice zena 
#te lipa iz tablice mladic uz uvjet da su vrijednosti kolone carape iz 
#tablice svekrva počinju slovom a te da su vrijednosti kolone eura iz 
#tablice punac različite od 22. Podatke posložite po lipa iz tablice 
#mladic silazno. (10)

select n.maraka,z.indiferentno,m.lipa from neprijatelj n
inner join punac_neprijatelj pn on pn.neprijatelj =n.sifra 
inner join punac p on pn.punac =p.sifra 
inner join svekrva s on s.punac=p.sifra 
inner join mladic m on m.svekrva =s.sifra 
inner join zena z on z.mladic =m.sifra 
where s.carape like 'a%' and p.eura !=22
order by m.lipa desc;

#6. Prikažite kolone eura i stilfrizura iz tablice punac čiji se primarni 
#ključ ne nalaze u tablici punac_neprijatelj. (5


select p.eura,p.stilfrizura from punac p
left join punac_neprijatelj pn on pn.punac =p.sifra 
where pn.punac =null;