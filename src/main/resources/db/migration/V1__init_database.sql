create table attributes (
    attribute_id bigint not null auto_increment,
    category enum('COMPONENT','REGION','COUNTRY') not null,
    name varchar(255) not null,
    parent_id bigint null,
    primary key (attribute_id)
) engine=InnoDB;

create table tea (
    tea_id bigint not null auto_increment,
    code integer not null,
    name varchar(100) not null,
    description TEXT not null,
    type enum ('BLACK','GREEN','OOLONG','PU_ERH','RED','WHITE','YELLOW','HIBISCUS','HERBAL') not null,
    primary key (tea_id)
) engine=InnoDB;

create table tea_attributes (
    tea_id bigint not null,
    attribute_id bigint not null
) engine=InnoDB;

create table users (
    id bigint not null auto_increment,
    first_name varchar(100) not null,
    last_name varchar(100) not null,
    email varchar(255) not null,
    password varchar(255) not null,
    role enum ('ADMIN','LEVEL_ONE','LEVEL_THREE','LEVEL_TWO'),
    primary key (id)
) engine=InnoDB;

create table review (
    review_id bigint not null auto_increment,
    aroma bigint not null,
    astringency bigint not null,
    strength bigint not null,
    taste bigint not null,
    comment TEXT not null,
    tea_id bigint,
    user_id bigint,
    primary key (review_id)
) engine=InnoDB;

alter table tea
    add constraint UK_tea_code unique (code);

alter table users
    add constraint UK_users_email unique (email);

alter table review
    add constraint FK_review_user foreign key (user_id) references users (id);

alter table review
    add constraint FK_review_tea foreign key (tea_id) references tea (tea_id);

alter table tea_attributes
    add constraint FK_tea_attr_attribute foreign key (attribute_id) references attributes (attribute_id);

alter table tea_attributes
    add constraint FK_tea_attr_tea foreign key (tea_id) references tea (tea_id);

alter table attributes
    add constraint FK_attr_parent foreign key (parent_id) references attributes (attribute_id);