create table PETE_TEST_CASE_IN_SCRIPT
(
  id              INTEGER not null,
  test_script_id  INTEGER not null,
  test_case_id    INTEGER not null,
  script_order    INTEGER not null,
  description     varchar2(4000)
)
;

comment on table PETE_TEST_CASE_IN_SCRIPT
  is 'Test case in Test script';
comment on column PETE_TEST_CASE_IN_SCRIPT.id
  is 'Test case in Test script surrogate identifier';
comment on column PETE_TEST_CASE_IN_SCRIPT.test_script_id
  is 'Test script identifier';
comment on column PETE_TEST_CASE_IN_SCRIPT.test_case_id
  is 'Test case identifier';
comment on column PETE_TEST_CASE_IN_SCRIPT.script_order
  is 'Defines order of test cases in test script';
comment on column PETE_TEST_CASE_IN_SCRIPT.description
  is 'Description';
  
create index PETE_TEST_CASE_IN_SCRIPT_FK01 on PETE_TEST_CASE_IN_SCRIPT (TEST_CASE_ID);
create index PETE_TEST_CASE_IN_SCRIPT_FK02 on PETE_TEST_CASE_IN_SCRIPT (TEST_SCRIPT_ID);


alter table PETE_TEST_CASE_IN_SCRIPT
  add constraint PETE_TEST_CASE_IN_SCRIPT_PK primary key (ID);
alter table PETE_TEST_CASE_IN_SCRIPT
  add constraint PETE_TEST_CASE_IN_SCRIPT_FK01 foreign key (TEST_CASE_ID)
  references PETE_TEST_CASE (ID);
alter table PETE_TEST_CASE_IN_SCRIPT
  add constraint PETE_TEST_CASE_IN_SCRIPT_FK02 foreign key (TEST_SCRIPT_ID)
  references PETE_TEST_SCRIPT (ID);
  
