drop database if exists kv_21;
create database kv_21;
use kv_21;


create table djevojka(
sifra int not null primary key auto_increment,
bojakose varchar(31),
maraka decimal(18,7),
indiferentno bit not null,
kratkamijica varchar(30),
ogrlica int not null,
mladic int not null
);

create table mladic(
sifra int not null primary key auto_increment,
modelnaocala varchar(40) not null,
treciputa datetime not null,
asocijalno bit not null,
maijca varchar(34) not null
);

create table svekrva(
sifra int not null primary key auto_increment,
treciputa datetime ,
jmbag char(11),
gustoca decimal(18,9) not null,
ostavljen int not null
);

create table ostavljen(
sifra int not null primary key auto_increment,
bojakose varchar(50),
ekstroventno bit not null,
kratkamajica varchar(34) not null,
kuna decimal(13,5) not null,
maraka decimal(18,9),
vesta varchar(38),
cura int
);


create table cura(
sifra int not null primary key auto_increment,
modelnaocala varchar(45),
bojakose varchar(35),
nausnica int not null,
ogrlica int,
dukserica varchar(43) not null,
stilfrizura varchar(39)not null,
zena int not null
);

create table zena(
sifra int not null primary key auto_increment,
kuna decimal(12,7) not null,
drugiputa datetime,
asocijalno bit not null,
jmbag char(11),
prviputa datetime,
maraka decimal(17,5)
);


create table zena_brat(
sifra int not null primary key auto_increment,
zena int not null,
brat int not null
);


create table brat(
sifra int not null primary key auto_increment,
gustoca decimal(14,10),
prviputa datetime not null,
hlace varchar(31) not null,
stilfrizura varchar(38) not null,
novcica decimal(13,5) ,
indiferentno bit
);


alter table zena_brat add foreign key (zena) references zena(sifra);
alter table zena_brat add foreign key (brat) references brat(sifra);
alter table cura add foreign key (zena) references zena(sifra);
alter table ostavljen add foreign key (cura) references cura(sifra);
alter table svekrva add foreign key (ostavljen) references ostavljen(sifra);
alter table djevojka add foreign key (mladic) references mladic(sifra);


#1. U tablice ostavljen, cura i zena_brat unesite po 3 retka. (7)

insert into brat (prviputa ,hlace ,stilfrizura ) values
('2020-02-02','crna','crna'),('2020-02-02','crna','crna'),('2020-02-02','crna','crna');
insert into zena(kuna ,asocijalno ) values
(100,true),(100,true),(100,true);
insert into zena_brat (zena ,brat ) values
(1,1),(2,2),(3,3);
insert into cura(nausnica ,dukserica ,stilfrizura ,zena ) values
(5,'crna','crna',1),(5,'crna','crna',1),(5,'crna','crna',1);
insert into ostavljen (ekstroventno ,kratkamajica ,kuna ) values
(false,'crna',100),(false,'crna',100),(false,'crna',100);


#2. U tablici djevojka postavite svim zapisima kolonu maraka na 
#vrijednost 15,74. (4)
update djevojka set maraka =15.74;

#3. U tablici svekrva obrišite sve zapise čija je vrijednost kolone jmbag 
#00000000007. (4)

delete from svekrva where jmbag =00000000007;

#4. Izlistajte nausnica iz tablice cura uz uvjet da vrijednost kolone 
#bojakose sadrže slova ana. (6)

select nausnica from cura where bojakose like '%ana%';

##5. Prikažite hlace iz tablice brat, ostavljen iz tablice svekrva te 
#ekstroventno iz tablice ostavljen uz uvjet da su vrijednosti kolone 
#bojakose iz tablice cura počinju slovom a te da su vrijednosti kolone 
#drugiputa iz tablice zena poznate. Podatke posložite po ekstroventno 
#iz tablice ostavljen silazno. (10)
select b.hlace,s.ostavljen,o.ekstroventno from svekrva s 
inner join ostavljen o on s.ostavljen =o.sifra 
inner join cura c on o.cura=c.sifra 
inner join zena z on c.zena =z.sifra 
inner join zena_brat zb on zb.zena =z.sifra 
inner join brat b on zb.brat=b.sifra 
where c.bojakose like 'a%' and z.drugiputa !=null
order by o.ekstroventno desc;

#6. Prikažite kolone drugiputa i asocijalno iz tablice zena čiji se 
#primarni ključ ne nalaze u tablici zena_brat. (5

select z.drugiputa,z.asocijalno from zena z
left join zena_brat zm on zm.zena =z.sifra 
where zm.zena =null;
