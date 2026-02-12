create table components (
    components_id bigint not null auto_increment,
    name varchar(255),
    primary key (components_id)
) engine=InnoDB;

create table review (
    aroma bigint not null,
    astringency bigint not null,
    review_id bigint not null auto_increment,
    strength bigint not null,
    taste bigint not null,
    tea_id bigint,
    user_id bigint,
    comment TEXT not null,
    primary key (review_id)
) engine=InnoDB;

create table tea (
    code integer not null,
    tea_id bigint not null auto_increment,
    name varchar(100) not null,
    description TEXT not null,
    type enum ('BLACK','GREEN','OOLONG','PU_ERH','RED','WHITE','YELLOW') not null,
    primary key (tea_id)
) engine=InnoDB;

create table tea_components (
    components_id bigint not null,
    tea_id bigint not null
) engine=InnoDB;

create table users (
    id bigint not null auto_increment,
    first_name varchar(100) not null,
    last_name varchar(100) not null,
    email varchar(255) not null,
    password varchar(255) not null,
    role enum ('LEVEL_ONE','LEVEL_THREE','LEVEL_TWO'),
    primary key (id)
) engine=InnoDB;

alter table tea
    add constraint UK88moyvhhomrbu81sbf9cqp88k unique (code);

alter table users
    add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);

alter table review
    add constraint FK6cpw2nlklblpvc7hyt7ko6v3e foreign key (user_id) references users (id);

alter table review
    add constraint FKqd8dv1uv2of9ovv5gc1kor04n foreign key (tea_id) references tea (tea_id);

alter table tea_components
    add constraint FKouswtongxqp5lihb9cbomh2pe foreign key (components_id) references components (components_id);

alter table tea_components
    add constraint FKe30rr2j7pjwu0r0gi3r7ujsts foreign key (tea_id) references tea (tea_id)