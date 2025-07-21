CLASS zcl_cds_practice_ch DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    METHODS data_display.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cds_practice_ch IMPLEMENTATION.
  METHOD data_display.

  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.


    out->write( 'CDS View with Input Param output below' ).

    SELECT FROM
    zi_travel_sample_prac_02( p_travelid = '00000002', p_date = '20250716' ) " CDS View with Input Parameter value
    FIELDS TravelId, AgencyId, BookingId,
    BookingDate, Status, character_lit, System_Date
    INTO TABLE @DATA(lt_data_display).

    IF sy-subrc = 0.

      out->write( lt_data_display ). " Print the table in output directly

*         LOOP AT lt_data_display INTO DATA(ls_Data_display).
*            out->write( | { ls_data_display-TravelId }  { ls_data_display-AgencyId }  { ls_data_display-BookingId } { ls_data_display-Status } { ls_data_display-BookingDate } { ls_data_display-character_lit } { ls_data_display-System_Date }| ).
*         ENDLOOP.
    ENDIF.


    out->write( 'Asscoiation cds with aggregation output below' ).

    SELECT FROM
    zi_cds_association_demo
    FIELDS SUM( BookingFee )      " Aggregation Function
    INTO @DATA(lv_total_amount).

    IF sy-subrc = 0.
      out->write( | { lv_total_amount } | ).
    ENDIF.



    out->write( 'Association Join On Demand Implementation with help of Path Expression' ).

    SELECT FROM
    zi_cds_association_demo
    FIELDS TravelGuid, TravelId, BookingFee,
    \_Booking-booking_id,\_Booking-customer_id  " Path Expressions
    INTO TABLE @DATA(lt_assoc_data).

*         SELECT FROM
*       zi_cds_association_demo
*       FIELDS TravelGuid, TravelId, BookingFee
*       INTO TABLE @DATA(lt_assoc_data).

    IF sy-subrc = 0.

      " Reduce will give the summation result from the internal table.

      DATA(lv_total_result) = REDUCE /dmo/booking_fee(
              INIT lv_sum TYPE /dmo/booking_fee
              FOR ls_result IN lt_assoc_data
              NEXT lv_sum = lv_sum + ls_result-BookingFee
       ).

      out->write( | { lv_total_result } | ). " Aggregation result

*         LOOP AT lt_assoc_data INTO DATA(ls_assoc_data).
*            out->write( | { ls_assoc_data-TravelGuid } { ls_assoc_data-TravelId } { ls_assoc_data-booking_id } { ls_assoc_data-customer_id }| ).
*         ENDLOOP.


    ENDIF.


    " Association in Select Query with help of Path Expression

    out->write( 'Association in Select Query with help of Path Expression' ).

    out->write( 'Association as Inner Join' ).

    SELECT FROM zi_cds_association_demo\_Booking AS book  " It will create Inner Join (Alias as mandate) ( Make ensure no default filter condition in definition )
    FIELDS book~booking_id, book~customer_id    " Association Targeted Fields will be accessible
    INTO TABLE @DATA(lt_tab_out1).
    IF sy-subrc = 0.
      out->write( lt_tab_out1 ).
    ENDIF.

    out->write( 'Association with Cardinality, Join Type, Filter Parameters' ).

    SELECT FROM zi_cds_association_demo
    FIELDS TravelId, \_Booking[ (1) INNER WHERE flight_price > 500 ]-booking_id AS BookingId,   " Passing parameters for Inner Join with Cardinality
                     \_Booking[ (1) INNER WHERE flight_price > 500 ]-flight_price AS FlightPrice " Note - If we didn't filter, then it will take default filter if specified in definition
    INTO TABLE @DATA(lt_tab_out2).
    IF sy-subrc = 0.
      out->write( lt_tab_out2 ).
    ENDIF.


    " Get Annotations from CDS View Entity ( Metadata, Entity & Derived Annotations )

    out->write( 'Get Annotations from CDS View using service class' ).

*     call method CL_DD_DDL_ANNOTATION_SERVICE=>get_annos(        // This template will get the annotations for a CDS View
*       EXPORTING
*         entityname         = 'ZI_CDS_ASSOCIATION_DEMO'
*       IMPORTING
*         entity_annos       = DATA(lt_entity_anno)
*         element_annos      = DATA(lt_element_anno)
*     ).


    " Usage of Currency Conversion in Open SQL Query

    out->write( 'Currency Conversion in Open SQL' ).

    SELECT FROM zi_unit_currency_conv_demo
    FIELDS TravelId, TravelGuid, currency_code , BookingFee,
    currency_conversion( amount = BookingFee,
  source_currency = currency_code,   "// Source Currency
  target_currency = 'INR',     " // Casting to Target Currency
  exchange_rate_date = @sy-datum,  "// Date for Exchange Rate
  on_error  = @sql_currency_conversion=>c_on_error-set_to_null,  "// Error handling
  round = 'X' ) AS convert_amt
  INTO TABLE @DATA(lt_curr_data).

    IF sy-subrc = 0.
      out->write( lt_curr_data ).
    ENDIF.



    " Table Function usage in ABAP Program

    out->write( 'Table Function usage in Open SQL Program' ).

    " Check the whether the DB Supports Table AMDP Table Function

*    SELECT *
*    FROM zi_table_function_demo_01( client1 = '100'  ) " Client Independent Table Function
*    INTO TABLE @DATA(lt_table_func_out).
*
*    IF sy-subrc = 0.
*      out->write( lt_table_func_out ).
*    ENDIF.

    SELECT *
    FROM zi_table_function_demo_01( client1 = '100' ) " Client Dependent Table Function with Using Client
    INTO TABLE @DATA(lt_table_func_out2).

    IF sy-subrc = 0.
      out->write( lt_table_func_out2 ).
    ENDIF.


  ENDMETHOD.

ENDCLASS.
