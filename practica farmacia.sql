create schema if not exists farmacia3;
show schemas;

use farmacia3;

select schema();

create table calle (
	idcalle int primary key,
    nombre varchar(45) not null
    );

create table localidad (
	idlocalidad int primary key,
    nombre varchar(45) not null
    );

   create table provincia(
	idprovincia int primary key,
    nombre varchar(45) not null
    ); 

    create table obra_social(
	codigo int primary key,
nombre varchar(45) not null,
    descripcion varchar(100)

);

create table laboratorio(
	codigo int primary key,
nombre varchar(45) 
 );

 create table producto (
	codigo int primary key,
    nombre varchar(45),
    descripcion varchar(45),
    precio decimal (10,2),
    laboratorio_codigo int,
    foreign key (laboratorio_codigo) references laboratorio(codigo)
);



 create table cliente(
	dni int primary key,
apellido varchar(45),
    nombre varchar(45),
    obra_social_codigo int,
numero_afiliado int,
    calle_idcalle int not null,
    localidad_idlocalidad int not null,
    provincia_idprovincia int not null,
    numero_calle int not null,
foreign key (obra_social_codigo) references obra_social(codigo),
foreign key (calle_idcalle) references calle(idcalle),
    foreign key (localidad_idlocalidad) references localidad(idlocalidad),
    foreign key (provincia_idprovincia) references provincia(idprovincia)
 );


  create table venta(
	numero int primary key,
    fecha date,
    ventacol varchar(45),
    cliente_dni int not null,
    foreign key (cliente_dni) references cliente(dni)
 );


 create table detalle_venta(
	venta_numero int,
    producto_codigo int,
    precio_unitario decimal(10,2) not null,
    cantidad int not null,
    primary key (venta_numero,producto_codigo),
    foreign key (venta_numero) references venta(numero),
    foreign key (producto_codigo) references producto(codigo)

    );


    /*---------------FIN  CREACION DE TABLAS--------------*/








insert into obra_social 
	values (1,"PAMI","Programa de Atención Médica Integral"),
    (2,"IOMA", "Instituto de Obra Medico Asistencial"),
    (3, "OSECAC","Obra Social de Empleados de Comercio");
select * from obra_social;
/*****************************************************************
Práctica:
Hacer lo mismo para tablas calle, localidad y provincia. 
Agregar en provincia: (1, Buenos Aires) y (2, CABA) 
Agregar en localidad: (1, Lanús), (2, Pompeya), (3, Avellaneda)
Agregar en calles: (1, 9 de Julio) , (2, Hipólito Yrigoyen) , (3, Mitre), 4 (Sáenz).
Para cada una  de ellas:
crearla, eliminarla, crearla nuevamente, 
cambiar el nombre y volver a cambiarlo al original.
cambiar el nombre de alguna columna y volver a cambiarlo al original,
agregar los datos especificados, 
consultar y verificar que los datos hayan ingresado.
******************************************************************/

insert into provincia values(1,"Buenos Aires"),
		(2,"CABA");
select * from provincia;
insert into localidad values
	(1,"Lanus"), (2,"Pompeya"), (3,"Avellaneda");
select * from localidad;

insert into calle values
	(1,"9 de Julio"),(2,"Hipolito Yrigoyen"),(3,"Mitre"),(4,"Sáenz");
select * from calle;

			update calle set calle.nombre = "hola" where calle.idcalle=3;
			update calle set nombre = "Mitre" where idcalle=3;

/*****************************************************************
Práctica:
Agregar Mariano Moreno con obra social 2
Agregar Larrea Juan, DNI 33333333, obra social 2, afiliado 33445566
Agregar Manuel Moreno con obra social 1, DNI 22222222, afiliado 11223344

Consultar por obra social 1
Consultar por obra social 2
Consultar por número de afiliado 87654321
Consultar por apellido Moreno
Consultar por nombre Manuel
Consultar por apellido Moreno y obra social 1 
(utilizar where apellido="Moreno" and obra_social_codigo=1)
******************************************************************/

insert into cliente values(12345678, "Belgrano", "Manuel", 1, 87654321,1,2,1,765);
insert into cliente values(23456789, "Saavedra", "Cornelio", null, null,2,2,2,555);

insert into cliente values(56734534,"Moreno","Mariano",2,123,4,2,1,111);
insert into cliente values(33333333,"Larrea","Juan",2,33445566,3,2,1,333);
insert into cliente values(22222222,"Moreno","Manuel",1,11223344,2,3,1,123);

 select * from cliente;  

/* consultar por obra social 1 */
 select * from cliente where obra_social_codigo=1;

 select apellido,nombre from cliente where obra_social_codigo=2;

 select dni,apellido,nombre from cliente where numero_afiliado=87654321;

 select dni, nombre,apellido from cliente where apellido="Moreno";

select * from cliente where nombre="Manuel";

 select * from cliente where apellido="Moreno" and
obra_social_codigo=1;


-- actualizamos los clientes con calle
update cliente set calle_idcalle=1 where dni > 0;
update cliente set localidad_idlocalidad=2 where dni>0;
update cliente set provincia_idprovincia=1 where dni>0;
select dni,calle_idcalle from cliente; -- qué pasó? // me tira error el campo a consultar debe ser calle_idcalle
-- Asignamos calle a un cliente determinado
update cliente set calle_idcalle=3 where dni=23456789;
select dni,calle_idcalle,localidad_idlocalidad,provincia_idprovincia from cliente;

update calle set numero= 1757 where idcalle>=0;    


select * from cliente; 
update cliente set localidad_idlocalidad =  1
where dni = 12345678;
update cliente set localidad_idlocalidad= 3
where dni= 22222222;
update cliente set localidad_idlocalidad= 2 where dni= 33333333;

update cliente set provincia_idprovincia = 2 where dni >30000000;



/******************************************************************/
-- Consultas más complejas (joins)
-- Consultamos todos los clientes con su obra social usando alias de tabla
-- Inner join: todos los registros de una tabla con correlato en la otra
select c.dni, c.apellido, c.nombre, o.nombre from 
cliente c inner join obra_social o on c.obra_social_codigo=o.codigo;


/*EJEMPLOS DE INNER JOIN*/

SELECT * from cliente inner join obra_social where obra_social_codigo=1;

select * from cliente inner join obra_social where cliente.obra_social_codigo= obra_social.codigo;

select c.nombre , c.apellido , o.nombre, o.descripcion from cliente c inner join obra_social o where c.obra_social_codigo = o.codigo;

select cliente.nombre , cliente.apellido , o.nombre, o.descripcion from cliente  inner join obra_social o where cliente.obra_social_codigo = o.codigo;

select c.nombre , c.apellido , obra_social.nombre from cliente c inner join obra_social  where c.obra_social_codigo = obra_social.codigo;


/* definiendo un alias para un campo con AS */
select c.dni, c.apellido, c.nombre, o.nombre as o_social from cliente c 
	inner join obra_social o on c.obra_social_codigo=o.codigo;

 select c.dni, c.apellido, c.nombre, o.nombre as o_social from cliente c 
	inner join obra_social o where c.obra_social_codigo=o.codigo;   


/*EJEMPLOS DE LEFT JOIN*/
-- Left join: Todos los registros de la izquierda, y los de la derecha que 
-- participan en la relación.
select dni,apellido, c.nombre, o.nombre as o_social from cliente c 
	left join obra_social o on c.obra_social_codigo=o.codigo;

-- Right join: Todos los registros de la derecha y los de la izquierda que 
-- participan en la relación.
select dni,apellido, c.nombre, o.nombre as o_social from cliente c 
	right join obra_social o on c.obra_social_codigo=o.codigo;

-- inner join con filtro por nombre de obra social
select c.dni, c.apellido, c.nombre, o.nombre as o_social from cliente c 
	inner join obra_social o on c.obra_social_codigo=o.codigo
where o.nombre="PAMI";



-- inner join con filtro por nombre de obra social
select c.dni, c.apellido, c.nombre, o.nombre as o_social from cliente c 
	inner join obra_social o on c.obra_social_codigo=o.codigo
where o.nombre="PAMI";

/*****************************************************************
Práctica:
consultar por:
Todos los clientes de una misma calle (una consulta por calle)
Todos los clientes de una misma localidad (una consulta por localidad)
Todos los clientes de la calle 9 de Julio (consultar por "9 de julio")
Todos los clientes de CABA
******************************************************************/


select c.dni,c.nombre, c.apellido , calle.nombre as calle 
from cliente c inner join calle on c.calle_idcalle=calle.idcalle
where c.calle_idcalle =1;


select c.dni , c.apellido, c.nombre , calle.nombre as calle 
from cliente c inner join calle on c.calle_idcalle= calle.idcalle where c.calle_idcalle = 2;

select c.dni, c.apellido, c.nombre , calle.nombre as calle from cliente c inner join calle on 
c.calle_idcalle = calle.idcalle where c.calle_idcalle = 3;

select c.nombre,c.apellido, c.dni, calle.nombre as calle from cliente c inner join calle 
on c.calle_idcalle=calle.idcalle where c.calle_idcalle=4;

select cli.dni,cli.apellido, cli.nombre, c.nombre from cliente cli
	inner join calle c on cli.calle_idcalle = c.idcalle;

select c.dni, c.nombre, c.apellido, l.nombre as localidad from cliente c 
inner join localidad l on c.localidad_idlocalidad= l.idlocalidad
where c.localidad_idlocalidad=1;

select c.nombre, c.apellido, l.nombre as localidad from cliente c 
inner join localidad l on c.localidad_idlocalidad=l.idlocalidad
where c.localidad_idlocalidad=2;


 select c.nombre, c.apellido, l.nombre as localidad from cliente c  
 inner join localidad l on c.localidad_idlocalidad=l.idlocalidad
 where c.localidad_idlocalidad=3;

 select c.nombre, c.apellido from cliente c inner join calle 
 on c.calle_idcalle= calle.idcalle where calle.nombre= "9 de Julio";

 select c.nombre, c.apellido from cliente c inner join provincia p on 
 c.localidad_idlocalidad = p.idprovincia where p.nombre= "CABA" ;
/***********************************************************************/

-- Consultas aún más complejas:
-- joins múltiples: Queremos consultar todos los clientes de IOMA de Lanús:

select c.dni, c.nombre, c.apellido, o.nombre as obra_social, l.nombre as localidad
from cliente c inner join obra_social o on c.obra_social_codigo = o.codigo
inner join localidad l on c.localidad_idlocalidad = l.idlocalidad
where o.nombre = "IOMA" and l.nombre = "Pompeya" ;


select cli.dni, cli.apellido, cli.nombre, c.nombre as calle, c.numero as numero , l.nombre as localidad, p.nombre as provincia
from cliente cli
inner join calle c on cli.calle_idcalle = c.idcalle
inner join localidad l on cli.localidad_idlocalidad = l.idlocalidad
inner join provincia p on cli.provincia_idprovincia = p.idprovincia;

/*****************************************************************
Práctica:
consultar por:
Todos los clientes con la siguiente forma:
dni, apellido,nombre,calle,numero,localidad,provincia :
12345678, Belgrano, Manuel, 9 de julio, 2345, Lanús, Buenos Aires
...etc.

Igual que la anterior pero sólo de la provincia de Buenos Aires
Igual que la primera pero sólo de la calle 9 de julio
Igual que la primera pero sólo el dni 33333333 
Igual que la primera pero sólo de Buenos Aires y con obra social PAMI, 
mostrando la descripcion de la obra social
Igual que la anterior pero para todas las obras sociales, tengan clientes o no.
(codigo obra social, dni, apellido,nombre,calle,numero,localidad,provincia)
****************************************************************************/

select c.dni, c.apellido, c.nombre, calle.nombre as calle, c.numero_calle, l.nombre as localidad , p.nombre as provincia
from cliente c 
inner join calle on c.calle_idcalle=calle.idcalle
inner join localidad l on c.localidad_idlocalidad= l.idlocalidad
inner join provincia p on c.provincia_idprovincia = p.idprovincia;

select c.dni, c.apellido, c.nombre, calle.nombre as calle, c.numero_calle ,l.nombre as localidad,p.nombre as provincia from cliente c 
inner join calle on c.calle_idcalle=calle.idcalle
inner join localidad l on l.idlocalidad= c.localidad_idlocalidad
inner join provincia p on c.provincia_idprovincia = p.idprovincia
where p.nombre="Buenos Aires";

select c.dni,c.apellido, c.nombre, calle.nombre as calle , c.numero_calle, l.nombre as localidad, p.nombre as provincia from cliente c 
inner join calle on c.calle_idcalle = calle.idcalle 
inner join localidad l on c.localidad_idlocalidad = l. idlocalidad
inner join provincia p on c.provincia_idprovincia = p.idprovincia
where calle.nombre ="9 de Julio";

select c.dni, c.nombre, c.apellido, calle.nombre as calle, c.numero_calle , l.nombre as localidad, p.nombre as provincia from cliente c 
inner join calle on c.calle_idcalle = calle.idcalle
inner join localidad l on c.localidad_idlocalidad = l.idlocalidad
inner join provincia p on c.provincia_idprovincia = p. idprovincia
where c.dni = 33333333;

select c.dni, c. nombre, c.apellido , calle.nombre as calle,c.numero_calle, l. nombre as localidad , p.nombre as provincia , o.nombre as obra_social, o.descripcion from cliente c 
inner join calle on c.calle_idcalle= calle.idcalle
inner join localidad l on l.idlocalidad= c.localidad_idlocalidad
inner join provincia p on c.provincia_idprovincia= p.idprovincia
inner join obra_social o on c.obra_social_codigo = o.codigo
where p.nombre= "Buenos Aires" and o.nombre="PAMI";

-- no
select c.dni, c. nombre, c.apellido , calle.nombre as calle,c.numero_calle, l. nombre as localidad , p.nombre as provincia , o.descripcion from cliente c 
inner join calle on c.calle_idcalle= calle.idcalle
inner join localidad l on l.idlocalidad= c.localidad_idlocalidad
inner join provincia p on c.provincia_idprovincia= p.idprovincia
left join obra_social o on c.obra_social_codigo = o.codigo;
select o.nombre, c.nombre, c.apellido from cliente c
left join obra_social o on c.obra_social_codigo=o.codigo;


-- ultimo join
select c.dni, c.nombre, c.apellido, calle.nombre, c.numero_calle, l.nombre as localidad, p.nombre as provincia, o.nombre as obra_social
from cliente c inner join calle on c.calle_idcalle=calle.idcalle
inner join localidad l on l.idlocalidad=c.localidad_idlocalidad
inner join provincia p on p.idprovincia=c.provincia_idprovincia
right join obra_social o on c.obra_social_codigo=o.codigo;

/*Igual que la anterior pero para todas las obras sociales, tengan clientes o no.
(codigo obra social, dni, apellido,nombre,calle,numero,localidad,provincia)*/

select  o.nombre as obra_social, c.dni, c.apellido, c.nombre, calle.nombre as calle, c.numero_calle, l.nombre as localidad,p.nombre as provincia
from cliente c 
inner join calle on c.calle_idcalle=calle.idcalle
inner join localidad l on c.localidad_idlocalidad=l.idlocalidad
inner join provincia p on c.provincia_idprovincia=p.idprovincia
right join obra_social o on c.obra_social_codigo=o.codigo;





/*Crear las tablas laboratorio, producto, y venta 
insertar los siguientes datos:
laboratorio:
# codigo, nombre
1, 'Bayer'
2, 'Roemmers'
3, 'Farma'

producto:
# codigo, nombre, descripcion, precio, laboratorio_codigo
1, 'Bayaspirina', 'Aspirina por tira de 10 unidades', 10, 1
2, 'Ibuprofeno', 'Ibuprofeno por tira de 6 unidades', 20, 3
3, 'Amoxidal 500', 'Antibiótico de amplio espectro', 300, 2
4, 'Redoxon', 'Complemento vitamínico', 120, '1'
5, 'Atomo', 'Crema desinflamante', 90, 3


venta:
# numero, fecha, cliente_dni
1, '18-04-20', 12345678
2, '18-04-20', 33333333
3, '18-04-22', 22222222
4, '18-04-22', 44444444
5, '18-04-22', 12456789
6, '18-04-23', 12345678
******************************************************************/
insert into  laboratorio values 
(1,"Bayer"),(2,"Roemmers"),(3,"Farma");

insert into producto values
(1, 'Bayaspirina', 'Aspirina por tira de 10 unidades', 10, 1),
(2,"Ibuprofeno",'Ibuprofeno por tira de 6 unidades', 20, 3),
(3, 'Amoxidal 500', 'Antibiótico de amplio espectro', 300, 2),
(4, 'Redoxon', 'Complemento vitamínico', 120, '1'),
(5, 'Atomo', 'Crema desinflamante', 90, 3);

insert into venta (numero,fecha, cliente_dni) values
(1, '18-04-20', 12345678);
insert into venta (numero,fecha, cliente_dni) values(2, '18-04-20', 33333333);
insert into venta (numero,fecha, cliente_dni) values(3, '18-04-22', 22222222);
insert into venta (numero,fecha, cliente_dni) values(4, '18-04-22', 44444444);-- estos dni no existen
insert into venta (numero,fecha, cliente_dni) values(5, '18-04-22', 12456789);-- tira error
insert into venta (numero,fecha, cliente_dni) values(6, '18-04-23', 12345678);
select * from venta;

insert into detalle_venta values(1, 2, 20.00, 3);
insert into detalle_venta values(1, 3, 300.00, 1);
insert into detalle_venta values(2, 1, 10.00, 2);
insert into detalle_venta values(2, 4, 120.00, 1);
insert into detalle_venta values(3, 2, 20.00, 3);
insert into detalle_venta values(3, 5, 90.00, 2);
insert into detalle_venta values(4, 2, 20.00, 2); -- no existe la venta 4
insert into detalle_venta values(6, 2, 20.00, 2);
insert into detalle_venta values(6, 3, 300.00, 1);
insert into detalle_venta values(6, 4, 120.00, 1);


 


select * from venta;
use farmacia3;
-- Consultas con operaciones y agregación
-- Total facturado para un item determinado de una venta (venta 1 y prod 2)
select v.numero as num_venta,dv.producto_codigo as producto, dv.precio_unitario*dv.cantidad as total from venta v 
inner join detalle_venta dv on  v.numero=dv.venta_numero
where dv.venta_numero=1 and dv.producto_codigo=2;

select precio_unitario*cantidad as total from detalle_venta
where venta_numero= 1 and producto_codigo=2;

-- Total facturado por venta (sum):
select venta_numero, sum(precio_unitario*cantidad) as total from detalle_venta
group by venta_numero;
select * from detalle_venta;

-- Total facturado para una venta determinada (sum con group by):
select venta_numero, sum(precio_unitario*cantidad) as total from detalle_venta
 where venta_numero=1 group by venta_numero;
 
 -- Total facturado por día: (inner join, sum, group by)
select v.fecha, sum(dv.precio_unitario*dv.cantidad) as total from detalle_venta dv
inner join venta v on dv.venta_numero=v.numero
group by v.fecha;

-- cantidad de ventas total (count)
select count(numero) as cant_ventas from venta;

-- cantidad de ventas por dia total (count con group by)
select fecha, count(numero) as cant_ventas from venta group by fecha;
select* from venta;

-- precio promedio de productos vendidos por producto (inner join, avg, group by)
select p.nombre, avg(dv.precio_unitario) as precio_promedio from detalle_venta dv 
inner join producto p on dv.producto_codigo= p.codigo
group by dv.producto_codigo;

-- articulos vendidos más baratos que el precio de lista
select dv.venta_numero, p.nombre, p.precio as precio_lista, dv.precio_unitario as precio_venta
from detalle_venta dv inner join producto p
on dv.producto_codigo = p.codigo
where dv.precio_unitario<p.precio;

select * from venta;
insert into venta values (8,"2018/04/21",null,22222222);
select * from producto;
insert into detalle_venta values (8,3,280.50,1);

/*****************************************************************
Modificamos (update) registros
******************************************************************/

-- agregamos 20% al precio de todos los productos
update producto set precio=precio*1.2 where codigo>0;

select * from producto;

-- agregamos 15% al precio de los productos Bayer
update producto set precio=precio*1.15 where laboratorio_codigo=1;
select * from producto;

-- agregamos 10% a un producto determinado
update producto set precio=precio*1.1 where nombre="Amoxidal 500" and codigo=3;
select * from producto;

-- agregamos 10% a los productos cuyo precio sea >150
update producto p set p.precio=(p.precio*1.1) where p.precio>150 and p.codigo>0;

select * from producto;

-- podemos actualizar varios campos a la vez separando con comas.
-- aquí utilizamos una función de MySQL para concatenar dos strings
-- year, sum, count, avg también lo son. 
-- Listado de funciones de MySQL:
-- https://dev.mysql.com/doc/refman/5.7/en/func-op-summary-ref.html
update producto set descripcion= concat(descripcion," nueva formula")
where codigo=3;

select * from producto;

/*****************************************************************
Eliminamos (delete) registros
******************************************************************/

-- damos de alta una obra social para luego eliminarla
insert into obra_social (codigo, nombre, descripcion) 
	values(4,"OSPAPEL","Obra Social del personal del papel");

select * from obra_social;

-- la eliminamos
delete from obra_social where codigo=4; 

select * from obra_social;
