create or replace package pete_convention_runner as

    --
    -- Convention over Configuration test runner
    -- do not call these methods directly - use Pete package instead
    --

    --
    -- Tests suite
    -- runs all UT% packages defined in user's schema
    --
    -- %param a_suite_name_in test suite name = USER
    -- %param a_description_in test suite description
    -- %param a_parent_run_log_id_in Specify parent run_log_id for recursive execution - used for testing of Pete
    --
    -- %return true - success, false - failure
    --
    function run_suite
    (
        a_suite_name_in        in pete_types.typ_object_name default user,
        a_description_in       in pete_types.typ_description default null,
        a_parent_run_log_id_in in pete_run_log.parent_id%type default null
    ) return pete_types.typ_execution_result;

    --
    -- Tests one package
    --
    -- %param a_package_in package name
    -- %param a_method_like_in filter for methods being run - if null, all methods would be run
    -- %param a_description_in test suite description
    -- %param a_parent_run_log_id_in Specify parent run_log_id for recursive execution - used for testing of Pete
    --
    -- %return true - success, false - failure
    --
    function run_package
    (
        a_package_name_in      in pete_types.typ_object_name,
        a_method_name_like_in  in pete_types.typ_object_name default null,
        a_description_in       in pete_types.typ_description default null,
        a_parent_run_log_id_in in pete_run_log.parent_id%type default null
    ) return pete_types.typ_execution_result;

    --
    -- Tests one method
    --
    -- %param a_package_in package name
    -- %param a_method_name_in method name
    -- %param a_object_type_in method type (METHOD|HOOK)
    -- %param a_description_in test suite description
    -- %param a_parent_run_log_id_in Specify parent run_log_id for recursive execution - used for testing of Pete
    --
    -- %return true - success, false - failure
    --
    function run_method
    (
        a_package_name_in      in pete_types.typ_object_name,
        a_method_name_in       in pete_types.typ_object_name,
        a_object_type_in       in pete_types.typ_object_type,
        a_description_in       in pete_types.typ_description default null,
        a_parent_run_log_id_in in pete_run_log.parent_id%type default null
    ) return pete_types.typ_execution_result;

end;
/
