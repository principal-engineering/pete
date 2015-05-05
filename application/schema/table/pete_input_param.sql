create table PETE_INPUT_PARAM
(
  id             INTEGER not null,
  test_script_id INTEGER,
  name           VARCHAR2(255) not null,
  value          XMLTYPE,
  description    VARCHAR2(255)
)
;
comment on table PETE_INPUT_PARAM
  is 'PLSQL block input parameters';
  
comment on column PETE_INPUT_PARAM.id
  is 'Input parameter surrogate key';
comment on column PETE_INPUT_PARAM.test_script_id
  is 'Test script identifier [deprecated?]';
comment on column PETE_INPUT_PARAM.name
  is 'Input parameter name';
comment on column PETE_INPUT_PARAM.value
  is 'XML for input parameter of PLSQL block';
comment on column PETE_INPUT_PARAM.description
  is 'Input parameter description';
  
create index PETE_INPUT_PARAM_FK01 on PETE_INPUT_PARAM (TEST_SCRIPT_ID);

alter table PETE_INPUT_PARAM
  add constraint PETE_INPUT_PARAM_PK primary key (ID);
alter table PETE_INPUT_PARAM
  add constraint PETE_INPUT_PARAM_UK01 unique (NAME, TEST_SCRIPT_ID);
alter table PETE_INPUT_PARAM
  add constraint PETE_INPUT_PARAM_FK01 foreign key (TEST_SCRIPT_ID)
  references PETE_TEST_SCRIPT (ID);
