create table PETE_TEST_SCRIPT
(
  id          INTEGER not null,
  name        VARCHAR2(255) not null,
  description VARCHAR2(255)
)
;
comment on table PETE_TEST_SCRIPT
  is 'Test script';
  
comment on column PETE_TEST_SCRIPT.id
  is 'Test script surrogate identifier';
comment on column PETE_TEST_SCRIPT.name
  is 'Test script name';
comment on column PETE_TEST_SCRIPT.description
  is 'Test script description';
  
alter table PETE_TEST_SCRIPT
  add constraint PETE_TEST_SCRIPT_PK primary key (ID);
alter table PETE_TEST_SCRIPT
  add constraint PETE_TEST_SCRIPT_UK1 unique (NAME);
