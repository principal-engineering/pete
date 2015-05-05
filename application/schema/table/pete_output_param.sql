create table PETE_OUTPUT_PARAM
(
  id             INTEGER not null,
  test_script_id INTEGER,
  name           VARCHAR2(255) not null,
  value          XMLTYPE,
  description    VARCHAR2(255)
)
;
comment on table PETE_OUTPUT_PARAM
  is 'PLSQL block expected output parameters';
  
comment on column PETE_OUTPUT_PARAM.id
  is 'Output parameter surrogate key';
comment on column PETE_OUTPUT_PARAM.test_script_id
  is 'Test script identifier [deprecated?]';
comment on column PETE_OUTPUT_PARAM.name
  is 'Output parameter name';
comment on column PETE_OUTPUT_PARAM.value
  is 'XML for output parameter of PLSQL block';
comment on column PETE_OUTPUT_PARAM.description
  is 'Output parameter description';

create index PETE_OUTPUT_PARAM_FK01 on PETE_OUTPUT_PARAM (TEST_SCRIPT_ID);

alter table PETE_OUTPUT_PARAM
  add constraint PETE_OUTPUT_PARAM_PK primary key (ID);
alter table PETE_OUTPUT_PARAM
  add constraint PETE_OUTPUT_PARAM_UK01 unique (CODE, TEST_SCRIPT_ID);
alter table PETE_OUTPUT_PARAM
  add constraint PETE_OUTPUT_PARAM_FK01 foreign key (TEST_SCRIPT_ID)
  references PETE_TEST_SCRIPT (ID);
