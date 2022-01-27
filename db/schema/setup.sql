drop table if exists haulage_capabilities;
drop table if exists performance_scores;
drop table if exists mechanism_scores;
drop table if exists quality_scores;
drop table if exists value_scores;
drop table if exists reviews;
drop table if exists models;
drop table if exists liveries;
drop table if exists scores;
drop table if exists coaches;
drop table if exists scales;
drop table if exists locomotive_classes;
drop table if exists manufacturers;
drop table if exists operators;


create table scores (
	id serial,
	score real not null,
	primary key (id)
);
create table coaches (
	id serial,
	number int not null,
	primary key (id)
);
create table scales (
	id serial,
	name varchar(20) not null,
	primary key (id)
);
create table locomotive_classes (
	id serial,
	name varchar(20) not null,
	nickname varchar(30) not null,
	wikidata_id varchar(20) not null,
	primary key (id)
);
create table manufacturers (
	id serial,
	name varchar(30) not null,
	wikidata_id varchar(20) not null,
	primary key (id)
);
create table operators (
	id serial,
	name varchar(20) not null,
	full_name varchar(50) not null,
	is_fictional boolean default false,
	wikidata_id varchar(20) not null,
	primary key (id)
);
create table liveries (
	id serial,
	name varchar(30) not null,
	is_fictional boolean default false,
	operator_id int not null,
	constraint fk_operator foreign key (operator_id) references operators(id),
	primary key (id)
);
create table models (
	id serial,
	livery_id int not null,
	locomotive_class_id int not null,
	manufacturer_id int not null,
	operator_id int not null,
	scale_id int not null,
	constraint fk_livery foreign key (livery_id) references liveries(id),
	constraint fk_locomotive_class foreign key (locomotive_class_id) references locomotive_classes(id),
	constraint fk_manufacturer foreign key (manufacturer_id) references manufacturers(id),
	constraint fk_operator foreign key (operator_id) references operators(id),
	constraint fk_scale foreign key (scale_id) references scales(id),
	primary key (id)
);
create table reviews (
	id serial,
	score real not null,
	published_on date not null,
	reviewed_as_part_of_trainset boolean default false,
	youtube_url varchar(255) not null,
	model_id int not null,
	constraint fk_model foreign key (model_id) references models(id),
	primary key (id)
);
create table performance_scores (
	id serial,
	review_id int not null,
	score_id int not null,
	constraint fk_review foreign key (review_id) references reviews(id),
	constraint fk_score foreign key (score_id) references scores(id),
	primary key (id)
);
create table mechanism_scores (
	id serial,
	review_id int not null,
	score_id int not null,
	constraint fk_review foreign key (review_id) references reviews(id),
	constraint fk_score foreign key (score_id) references scores(id),
	primary key (id)
);
create table quality_scores (
	id serial,
	review_id int not null,
	score_id int not null,
	constraint fk_review foreign key (review_id) references reviews(id),
	constraint fk_score foreign key (score_id) references scores(id),
	primary key (id)
);
create table value_scores (
	id serial,
	review_id int not null,
	score_id int not null,
	constraint fk_review foreign key (review_id) references reviews(id),
	constraint fk_score foreign key (score_id) references scores(id),
	primary key (id)
);
create table haulage_capabilities (
	id serial,
	review_id int not null,
	coach_id int not null,
	constraint fk_review foreign key (review_id) references reviews(id),
	constraint fk_coach foreign key (coach_id) references coaches(id),
	primary key (id)
);