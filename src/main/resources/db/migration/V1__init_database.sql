create table attributes (
    attribute_id bigint not null auto_increment,
    category enum('COMPONENT','REGION','COUNTRY') not null,
    name varchar(255) not null,
    parent_id bigint null,
    primary key (attribute_id)
) engine=InnoDB;

create table teas (
    tea_id bigint not null auto_increment,
    code integer not null,
    name varchar(100) not null,
    description TEXT not null,
    type enum ('BLACK','GREEN','HERBAL','HIBISCUS','OOLONG','PU_ERH','RED','WHITE','YELLOW') not null,
    primary key (tea_id)
) engine=InnoDB;

create table tea_attributes (
    tea_id bigint not null,
    attribute_id bigint not null
) engine=InnoDB;

create table cities (
    city_id bigint not null auto_increment,
    name varchar(255) not null,
    primary key (city_id)
) engine=InnoDB;

create table shops (
    shop_id bigint not null auto_increment,
    name varchar(100) not null,
    address varchar(200) not null,
    city_id bigint,
    primary key (shop_id)
) engine=InnoDB;

create table users (
    user_id bigint not null auto_increment,
    first_name varchar(100) not null,
    last_name varchar(100) not null,
    email varchar(255) not null,
    password varchar(255) not null,
    role enum ('ADMIN','GUEST','LEVEL_ONE','LEVEL_THREE','LEVEL_TWO'),
    shop_id bigint,
    primary key (user_id)
) engine=InnoDB;

create table reviews (
    review_id bigint not null auto_increment,
    aroma     INT  not null,
    astringency INT  not null,
    strength  INT  not null,
    taste     INT  not null,
    comment   TEXT not null,
    tea_id    bigint,
    user_id   bigint,
    primary key (review_id)
) engine=InnoDB;

create table meetings (
    meeting_id bigint not null auto_increment,
    name varchar(150) not null,
    description TEXT,
    date date not null,
    is_online bit not null,
    is_completed bit not null default 0,
    primary key (meeting_id)
) engine=InnoDB;

create table meeting_resources (
    resource_id bigint not null auto_increment,
    file_name varchar(255),
    title varchar(255) not null,
    url TEXT not null,
    file_key varchar(255),
    type enum ('VIDEO', 'ARTICLE', 'LINK', 'BOOK', 'DOCUMENT', 'PRESENTATION', 'IMAGE', 'ARCHIVE', 'OTHER') not null,
    meeting_id bigint not null,
    primary key (resource_id)
) engine=InnoDB;

create table teams (
    team_id bigint not null auto_increment,
    name varchar(255) not null,
    topic varchar(255),
    status enum ('IN_PROGRESS','SUBMITTED','DONE') not null,
    meeting_id bigint,
    primary key (team_id)
) engine=InnoDB;

create table team_comments (
    id bigint not null auto_increment,
    team_id bigint not null,
    text TEXT not null,
    action_type varchar(50) not null,
    created_at datetime(6) not null,
    primary key (id)
) engine=InnoDB;

create table team_users (
    team_id bigint not null,
    user_id bigint not null,
    primary key (team_id, user_id)
) engine=InnoDB;

-- Видалено поле admin_feedback, оскільки тепер є стрічка історії в team_comments
create table submissions (
    submission_id bigint not null auto_increment,
    file_name varchar(255),
    file_link TEXT,
    file_key varchar(255),
    created_at datetime(6) not null,
    team_id bigint not null,
    primary key (submission_id)
) engine=InnoDB;

-- Таблиця для зберігання унікальних тегів (словник)
CREATE TABLE tags (
    tag_id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (tag_id),
    CONSTRAINT UK_tag_name UNIQUE (name)
) ENGINE=InnoDB;

-- Таблиця-зв'язка між зібраннями (meetings) та тегами (tags)
CREATE TABLE meeting_tags (
    meeting_id BIGINT NOT NULL,
    tag_id BIGINT NOT NULL,
    PRIMARY KEY (meeting_id, tag_id),
    CONSTRAINT FK_meeting_tags_meeting FOREIGN KEY (meeting_id) REFERENCES meetings (meeting_id) ON DELETE CASCADE,
    CONSTRAINT FK_meeting_tags_tag FOREIGN KEY (tag_id) REFERENCES tags (tag_id) ON DELETE CASCADE
) ENGINE=InnoDB;

alter table teas
    add constraint UK_teas_code unique (code);

alter table users
    add constraint UK_users_email unique (email);

alter table attributes
    add constraint FK_attr_parent foreign key (parent_id) references attributes (attribute_id);

alter table tea_attributes
    add constraint FK_tea_attr_attribute foreign key (attribute_id) references attributes (attribute_id);

alter table tea_attributes
    add constraint FK_tea_attr_tea foreign key (tea_id) references teas (tea_id);

alter table shops
    add constraint FK_shop_city foreign key (city_id) references cities (city_id);

alter table users
    add constraint FK_user_shop foreign key (shop_id) references shops (shop_id);

alter table reviews
    add constraint FK_review_user foreign key (user_id) references users (user_id);

alter table reviews
    add constraint FK_review_tea foreign key (tea_id) references teas (tea_id);

alter table meeting_resources
    add constraint FK_resource_meeting foreign key (meeting_id) references meetings (meeting_id);

alter table teams
    add constraint FK_team_meeting foreign key (meeting_id) references meetings (meeting_id);

alter table team_comments
    add constraint FK_comment_team foreign key (team_id) references teams (team_id) on delete cascade;

alter table team_users
    add constraint FK_team_user_team foreign key (team_id) references teams (team_id);

alter table team_users
    add constraint FK_team_user_user foreign key (user_id) references users (user_id);

alter table submissions
    add constraint FK_submission_team foreign key (team_id) references teams (team_id);