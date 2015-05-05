CREATE OR REPLACE PACKAGE pete_convention_runner AS

    --
    -- Convention over Configuration test runner
    -- TODO: change this
    -- do not call these methods directly - use pete package instead
    --

    --
    -- Tests suite
    -- runs all UT% packages defined in users schema
    --
    -- %param a_suite_name_in test suite name = USER
    --
    -- %return true - success, false - failure
    --
    FUNCTION run_suite
    (
        a_suite_name_in        IN pete_core.typ_object_name DEFAULT USER,
        a_description_in       IN pete_core.typ_description DEFAULT NULL,
        a_parent_run_log_id_in IN pete_run_log.parent_id%TYPE DEFAULT NULL
    ) RETURN pete_core.typ_is_success;

    --
    -- Tests one package
    --
    -- %param a_package_in package name 
    -- %param a_method_like_in filter for methods being run - if null, all methods would be run
    -- %param a_description_in description
    --
    -- %return true - success, false - failure
    --
    FUNCTION run_package
    (
        a_package_name_in      IN pete_core.typ_object_name,
        a_method_name_like_in  IN pete_core.typ_object_name DEFAULT NULL,
        a_description_in       IN pete_core.typ_description DEFAULT NULL,
        a_parent_run_log_id_in IN pete_run_log.parent_id%TYPE DEFAULT NULL
    ) RETURN pete_core.typ_is_success;

    --
    -- Tests one method
    --
    -- %param a_package_in package name 
    -- %param a_method_name_in method name
    -- %param a_description_in description
    --
    -- %return true - success, false - failure
    --
    FUNCTION run_method
    (
        a_package_name_in      IN pete_core.typ_object_name,
        a_method_name_in       IN pete_core.typ_object_name,
        a_description_in       IN pete_core.typ_description DEFAULT NULL,
        a_parent_run_log_id_in IN pete_run_log.parent_id%TYPE DEFAULT NULL
    ) RETURN pete_core.typ_is_success;

END;
/
