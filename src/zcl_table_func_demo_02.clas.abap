CLASS zcl_table_func_demo_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
  INTERFACES if_amdp_marker_hdb.
  CLASS-METHODS get_emp_sal FOR TABLE FUNCTION
  zi_table_func_demo_02.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_table_func_demo_02 IMPLEMENTATION.
  METHOD get_emp_sal BY DATABASE
  FUNCTION FOR HDB LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY USING
  zdt_employee_tab
  zdt_emp_sal_tab.

  RETURN SELECT zdt_employee_tab.client,
                  zdt_employee_tab.id,
                  name,
                  salary,
                  cuky
                  FROM zdt_employee_tab
                  INNER JOIN zdt_emp_sal_tab
                  on zdt_employee_tab.client = zdt_emp_sal_tab.client
                  and zdt_employee_tab.id = CAST( zdt_emp_sal_tab.id as CHAR(10) );

*                  Handling Casting for different type data field ON Condition while joining two tables

  ENDMETHOD.

ENDCLASS.
