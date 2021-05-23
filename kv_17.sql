drop database if exists kv_17;
create database kv_17;
use kv_17;


create table becar(
sifra int not null primary key auto_increment,
narukvica int,
asocijalno bit not null,
vesta varchar(48),
kuna decimal(13,10),
krtkamajica varchar(30) not null
);

create table brat_becar(
sifra int not null primary key auto_increment,
brat int not null,
becar int not null
);

create table brat(
sifra int not null primary key auto_increment,
asocijalno bit not null,
dukserica varchar(35),
novcica decimal(15,6) not null,
intrvertno bit not null
);


create table ostavljen(
sifra int not null primary key auto_increment,
bojaociju varchar(45),
bojakose varchar(33),
novcica decimal(16,7) not null,
brat int not null
);

create table cura(
sifra int not null primary key auto_increment,
ogrlica int,
kuna decimal(16,8) ,
indiferentno bit,
jmbag char(11),
maraka decimal(12,7) not null,
ostavljen int not null
);

create table prijateljica(
sifra int not null primary key auto_increment,
lipa decimal(12,7),
haljina varchar(37),
maraka decimal(13,8) not null,
modelnaocala varchar(41) not null,
cura int
);

create table punica(
sifra int not null primary key auto_increment,
indiferentno bit,
narukvica int,
gustoca decimal(18,10) not null,
prijatelj int
);

create table prijatelj(
sifra int not null primary key auto_increment,
maraka decimal(13,6),
narukvica int,
nausnica int,
lipa decimal(15,10),
carape varchar(33) not null,
stilfrizura varchar(35)
);

alter table brat_becar add foreign key (becar) references becar(sifra);
alter table brat_becar add foreign key (brat) references brat(sifra);
alter table ostavljen add foreign key (brat) references brat(sifra);
alter table cura add foreign key (ostavljen) references ostavljen(sifra);
alter table prijateljica add foreign key (cura) references cura(sifra);
alter table punica add foreign key (prijatelj) references prijatelj(sifra);


#1. U tablice cura, ostavljen i brat_becar unesite po 3 retka. (7)

insert into becar (asocijalno ,krtkamajica ) values
(false,'crna'),(false,'crna'),(false,'crna');
insert into brat(asocijalno ,novcica ,intrvertno ) values
(true,100,false),(true,100,false),(true,100,false);
insert into brat_becar (brat ,becar ) values
(1,1),(2,2),(3,3);
insert into ostavljen (novcica ,brat ) values
(100,1),(200,2),(300,3);
insert into cura(maraka ,ostavljen ) values
(100,1),(200,2),(300,3);


#2. U tablici punica postavite svim zapisima kolonu narukvica na 
#vrijednost 11. (4)

update punica set narukvica =11;

#3. U tablici prijateljica obrišite sve zapise čija je vrijednost kolone 
#haljina različito od AB. (4)


delete from prijateljica where haljina <>'AB';

#4. Izlistajte novcica iz tablice ostavljen uz uvjet da vrijednost kolone 
#bojakose sadrže slova ana. (6)

select novcica from ostavljen where bojakose like '%ana%';

#5. Prikažite vesta iz tablice becar, modelnaocala iz tablice prijateljica 
#te kuna iz tablice cura uz uvjet da su vrijednosti kolone bojakose iz 
#tablice ostavljen počinju slovom a te da su vrijednosti kolone 
#dukserica iz tablice brat sadrže niz znakova ba. Podatke posložite po 
#kuna iz tablice cura silazno. (10)

select b.vesta,p.modelnaocala,c.kuna from becar b
inner join brat_becar bb on bb.becar =b.sifra 
inner join brat b1 on bb.brat =b1.sifra 
inner join ostavljen o on o.brat =b1.sifra 
inner join cura c on c.ostavljen =o.sifra 
inner join prijateljica p on p.cura=c.sifra 
where o.bojakose like 'a%' and b1.dukserica like '%ba%'
order by c.kuna desc;



#6. Prikažite kolone dukserica i novcica iz tablice brat čiji se primarni 
#ključ ne nalaze u tablici brat_becar. (5

select b1.dukserica,b1.novcica from brat b1
left join brat_becar bb on bb.brat=b1.sifra 
where bb.becar =null;