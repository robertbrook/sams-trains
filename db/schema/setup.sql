drop table if exists reviews;
drop table if exists haulage_capabilities;
drop table if exists detail_scores;
drop table if exists performance_scores;
drop table if exists mechanism_scores;
drop table if exists quality_scores;
drop table if exists value_scores;
drop table if exists models;
drop table if exists liveries;
drop table if exists scales;
drop table if exists locomotive_classes;
drop table if exists manufacturers;
drop table if exists operators;


create table scales (
	id serial,
	name varchar(20) not null,
	primary key (id)
);
create table locomotive_classes (
	id serial,
	name varchar(50) not null,
	nickname varchar(50),
	wikidata_id varchar(20),
	primary key (id)
);
create table manufacturers (
	id serial,
	name varchar(30) not null,
	wikidata_id varchar(20),
	primary key (id)
);
create table operators (
	id serial,
	name varchar(50) not null,
	full_name varchar(50),
	is_fictional boolean default false,
	wikidata_id varchar(20),
	primary key (id)
);
create table liveries (
	id serial,
	name varchar(30) not null,
	is_fictional boolean default false,
	operator_id int,
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
create table detail_scores (
	id serial,
	score real not null,
	primary key (id)
);
create table performance_scores (
	id serial,
	score real not null,
	primary key (id)
);
create table mechanism_scores (
	id serial,
	score real not null,
	primary key (id)
);
create table quality_scores (
	id serial,
	score real not null,
	primary key (id)
);
create table value_scores (
	id serial,
	score real not null,
	primary key (id)
);
create table haulage_capabilities (
	id serial,
	number_of_coaches int not null,
	primary key (id)
);
create table reviews (
	id serial,
	score real,
	published_on date not null,
	reviewed_as_part_of_trainset boolean default false,
	youtube_url varchar(255) not null,
	model_id int not null,
	detail_score_id int,
	performance_score_id int,
	mechanism_score_id int,
	quality_score_id int,
	value_score_id int,
	haulage_capability_id int,
	constraint fk_model foreign key (model_id) references models(id),
	constraint fk_detail_score foreign key (detail_score_id) references detail_scores(id),
	constraint fk_performance_score foreign key (performance_score_id) references performance_scores(id),
	constraint fk_mechanism_score foreign key (mechanism_score_id) references mechanism_scores(id),
	constraint fk_quality_score foreign key (quality_score_id) references quality_scores(id),
	constraint fk_value_score foreign key (value_score_id) references value_scores(id),
	primary key (id)
);