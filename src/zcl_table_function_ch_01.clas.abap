CLASS zcl_table_function_ch_01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_amdp_marker_hdb.
  CLASS-METHODS get_fight_travel FOR TABLE FUNCTION
  zi_table_function_demo_01.  " Static Method for AMDP
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_table_function_ch_01 IMPLEMENTATION.
  METHOD get_fight_travel BY DATABASE FUNCTION " Implementation for AMDP Static Method
  FOR HDB LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY USING zrap_travel_ch.

  it_return = SELECT client, travel_id, booking_fee,
  currency_code, overall_status  from zrap_travel_ch
  WHERE  agency_id = '070048' AND
         client = :client1;

  RETURN :it_return;


  ENDMETHOD.

ENDCLASS.
