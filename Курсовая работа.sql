-- Создаю таблицу , магаин дверей
create database doorshop;

-- Каталог с дверьми
create table catalogs(
	id serial primary key,
	name varchar(255), 
	unique unique_name(name(10))
);

insert into catalogs values 
(null, 'Эко-шпон'), 
(null, 'Массив'), 
(null, 'Шпон натуральный'), 
(null, 'Эмаль');


-- Список производителей
drop table if exists manufacture;
create table manufacture(
	id serial primary key,
	name varchar(255)
);

insert into manufacture values 
(null, 'Bravo'), 
(null, 'Гарант'),
(null, 'Groff');


-- Двери производителей
create table manufacturers_doors(
	id serial primary key,
	door_id bigint unsigned,
	foreign key(door_id) references doors(id)
);

insert into manufacturers_doors values
(default, 1),
(default, 2),
(default, 2);


create table users(
	id serial primary key,
	firstname varchar(255) not null,
	lastname varchar(255) not null,
	birthday date not null,
	email varchar(255) not null unique,
	password_hash char(65) default null,
	created_at datetime not null default current_timestamp	
);

insert into users (id , firstname, lastname, birthday, email, password_hash)  values
(default, 'Тамара', 'Гавнадьевна', '1933-02-08', 'kakaha@mail.ru', default),
(default, 'Крошка', 'Кокошка', '1999-05-04', 'maliha@mail,ru', default),
(default, 'Генадий', 'Ополухович', '1986-11-12', 'ogorod@mail.ru', default);



create table comment(
	id serial primary key,
	user_id bigint unsigned,
	txt text not null,
	created_at datetime not null default now(),
	updated_at datetime default current_timestamp on update current_timestamp,
	foreign key (user_id) references users(id)
);

insert into comment (id, user_id, txt) values 
(default, 1, 'Кот обассал дверь и дверь вся вздулась'),
(default, 2, 'Вы меня извините конечно, но двери полное говно, да и вы все тоже. Спасибо за внимание'),
(default, 3, 'Не ну вот этот производитель просто лучший, всем советую.');


create table doors(
	id serial primary key,
	name varchar(255),
	manufacture_id bigint unsigned,
	price decimal (11,3),
	discount float unsigned,
	model text not null,
	weight text not null,
	sizes text not null,
	foreign key(manufacture_id) references manufacture(id)
);

insert into doors (id, name, manufacture_id, price, discount, model, weight, sizes) values
(default,'Борн', 1, '16.123', '12.999', 'Ral 3031', '45', '600х2000'),
(default,'TermoLight', 2, '110.842', '99.999', 'Tabacca Grey', '34', '900х2000'),
(default,'TermoWood', 3, '47.988', '43.784', 'Del Mare', '40', '900х2000');


-- Фурнитура
create table accessories(
	id serial primary key,
	name varchar(255),
	price decimal (11,3),
	discount float unsigned,
	model text not null,
	warranty text not null, -- гарантия в годах
	material text not null
);

insert into accessories (name, price, discount, model, warranty, material) values
('Дверная ручка', '5.821', '5.205', 'Onyx krystal premium', '10', 'Хрустальное стелко'),
('Задвижка', '1.593', '1.111', '101', '1', 'Металл'),
('Петля', '2.300', '1.898', 'Koblenz', '3', 'Цам' );


create table basket(
	id serial primary key,
	user_id bigint unsigned,
	door_id bigint unsigned,
	accessories_id bigint unsigned,
	created_at datetime default current_timestamp,
	foreign key(user_id) references users(id),
	foreign key(door_id) references doors(id),
	foreign key(accessories_id) references accessories(id)
);

insert into basket (user_id, door_id, accessories_id) values
(1, 2, 3),
(2, 1, 2),
(3, 1, 3);


create table new_products(
	id serial primary key,
	door_id bigint unsigned,
	accessories_id bigint unsigned,
	foreign key(door_id) references doors(id),
	foreign key(accessories_id) references accessories(id)
);

insert into new_products (door_id, accessories_id) values
(1, 3);



-- Пример выполненной работы: описание, фото
create table completed_works(
	id serial primary key,
	description text not null comment 'Описание выполненной работы' ,
	file_name varchar(255) not null  comment '/files/folder/img.jpg',
	file_size bigint unsigned,
	reated_at datetime not null default now(),
	updated_at datetime default current_timestamp on update current_timestamp
);

insert into completed_works (description, file_name, file_size) values
('Установка межкомнотной двери с расширением дверного проема', 'file1.jpg', '5432'),
('Демонтаж входной двери', 'file2.jpg', '7653'),
('Рестоврация двери с её установкой', 'file3.jpg', '4321');


	
	