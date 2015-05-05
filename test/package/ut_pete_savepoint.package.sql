CREATE OR REPLACE PACKAGE ut_pete_savepoint AS

    description pete_core.typ_description := 'Savepoint in convention test packages should not be modified by Pete';

    PROCEDURE cross_method_savepoint_before(d VARCHAR2 := 'Should create savepoint');

    PROCEDURE cross_method_savepoint(d VARCHAR2 := 'Should pass');

    PROCEDURE cross_method_savepoint_after(d VARCHAR2 := 'Should rollback to savepoint');

END ut_pete_savepoint;
/
CREATE OR REPLACE PACKAGE BODY ut_pete_savepoint AS

    PROCEDURE cross_method_savepoint_before(d VARCHAR2) IS
    BEGIN
        --log
        pete_logger.log_method_description(d);
        --test
        SAVEPOINT ut_pete_savepoint_sp1;
    END;

    PROCEDURE cross_method_savepoint(d VARCHAR2) IS
    BEGIN
        --log
        pete_logger.log_method_description(d);
        --assert
        pete_assert.pass;
    END;

    PROCEDURE cross_method_savepoint_after(d VARCHAR2) IS
    BEGIN
        --log
        pete_logger.log_method_description(d);
        --
        ROLLBACK TO SAVEPOINT ut_pete_savepoint_sp1;
    END;

END ut_pete_savepoint;
/
