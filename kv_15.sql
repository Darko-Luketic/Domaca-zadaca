drop database if exists kv_15;
create database kv_15;
use kv_15;

create table decko(
sifra int not null primary key auto_increment,
vesta varchar(37) not null,
bojakose varchar(45),
gustoca decimal(18,7),
prijatelj int not null
);

create table prijatelj(
sifra int not null primary key auto_increment,
majica varchar(41) not null,
vesta varchar(30) ,
narukvica int not null,
zarucnica int
);

create table zarucnica(
sifra int not null primary key auto_increment,
prviputa datetime not null,
bojaociju varchar(31) not null,
modelnaocala varchar(40) ,
zarucnik int
);

create table zarucnik(
sifra int not null primary key auto_increment,
kratkamajica varchar(30) not null,
jmbag char(11) not null,
dukserica varchar(45) not null,
indiferentno bit,
treciputa datetime not null
);

create table zarucnik_ostavljena(
sifra int not null primary key auto_increment,
zarucnik int not null,
ostavljena int not null
);

create table ostavljena(
sifra int not null primary key auto_increment,
gustoca decimal(16,7),
stilfrizura varchar(31) not null,
ogrlica int,
maraka decimal
);

create table prijateljica(
sifra int not null primary key auto_increment,
kratkamajica varchar(30) not null,
bojakose varchar(45),
asocijalno bit not null,
treciputa datetime not null,
jmbag char(11) not null,
vesta varchar(42) not null,
brat int
);

create table brat(
sifra int not null primary key auto_increment,
bojakose varchar(49) not null,
majica varchar(36),
maraka decimal(17,9),
vesta varchar(30) not null
);

alter table prijateljica add foreign key (brat) references brat(sifra);
alter table decko add foreign key (prijatelj) references prijatelj(sifra);
alter table prijatelj add foreign key (zarucnica) references zarucnica(sifra);
alter table zarucnica add foreign key (zarucnik) references zarucnik(sifra);
alter table zarucnik_ostavljena add foreign key (zarucnik) references zarucnik(sifra);
alter table zarucnik_ostavljena add foreign key (ostavljena) references ostavljena(sifra);


#1. U tablice prijatelj, zarucnica i zarucnik_ostavljena unesite po 3 
#retka. (7)

insert into ostavljena (stilfrizura ) values
('crna'),('crna'),('crna');
insert into zarucnik (kratkamajica ,jmbag ,dukserica ,treciputa ) values
('crna',12345678910,'crna','2020-02-02'),('crna',12345678910,'crna','2020-02-02'),('crna',12345678910,'crna','2020-02-02');
insert into zarucnik_ostavljena (zarucnik ,ostavljena ) values
(1,1),(2,2),(3,3);
insert into zarucnica (prviputa ,bojaociju ) values
('2020-02-02','crna'),('2020-02-02','crna'),('2020-02-02','crna');
insert into prijatelj (majica ,narukvica ) values
('crna',2),('crna',2),('crna',2);

#2. U tablici prijateljica postavite svim zapisima kolonu bojakose na 
#rijednost Osijek. (4)

update prijateljica set bojakose ='Osijek';

#3. U tablici decko obrišite sve zapise čija je vrijednost kolone 
#bojakose jednako AB. (4)

delete from decko where bojakose ='AB';

#4. Izlistajte modelnaocala iz tablice zarucnica uz uvjet da vrijednost 
#kolone bojaociju sadrže slova ana. (6)
select modelnaocala from zarucnica where bojaociju like '%ana%';

#5. Prikažite ogrlica iz tablice ostavljena, prijatelj iz tablice decko te 
#vesta iz tablice prijatelj uz uvjet da su vrijednosti kolone bojaociju iz 
#tablice zarucnica počinju slovom a te da su vrijednosti kolone jmbag 
#iz tablice zarucnik poznate. Podatke posložite po vesta iz tablice 
#prijatelj silazno. (10)

select o.ogrlica,d.prijatelj,p.vesta from decko d 
inner join prijatelj p on d.prijatelj =p.sifra 
inner join zarucnica z on p.zarucnica =z.sifra 
inner join zarucnik z1 on z.zarucnik=z1.sifra 
inner join zarucnik_ostavljena zo on zo.zarucnik =z1.sifra 
inner join ostavljena o on zo.ostavljena =o.sifra 
where z.bojaociju like 'a%' and z1.jmbag!=null 
order by p.vesta desc;

#6. Prikažite kolone jmbag i dukserica iz tablice zarucnik čiji se 
#primarni ključ ne nalaze u tablici zarucnik_ostavljena. (5)

select z.jmbag,z.dukserica from zarucnik z
left join zarucnik_ostavljena zo on zo.zarucnik =z.sifra 
where zo.zarucnik =null;
