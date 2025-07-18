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
       into TABLE @DATA(lt_data_display).

       if sy-subrc = 0.

       out->write( lt_data_display ). " Print the table in output directly

*         LOOP AT lt_data_display INTO DATA(ls_Data_display).
*            out->write( | { ls_data_display-TravelId }  { ls_data_display-AgencyId }  { ls_data_display-BookingId } { ls_data_display-Status } { ls_data_display-BookingDate } { ls_data_display-character_lit } { ls_data_display-System_Date }| ).
*         ENDLOOP.
       ENDIF.

       out->write( 'Asscoiation cds with aggregation output below' ).

       SELECT FROM
       zi_cds_association_demo
       FIELDS SUM( BookingFee )      " Aggregation Function
       INTO @data(lv_total_amount).

       if sy-subrc = 0.
         out->write( | { lv_total_amount } | ).
       ENDIF.

       out->write( 'Association cds with Path Expression for exposing elements' ).

       SELECT FROM
       zi_cds_association_demo
       FIELDS TravelGuid, TravelId, BookingFee,
       \_Booking-booking_id,\_Booking-customer_id  " Path Expressions
       INTO TABLE @DATA(lt_assoc_data).

*         SELECT FROM
*       zi_cds_association_demo
*       FIELDS TravelGuid, TravelId, BookingFee
*       INTO TABLE @DATA(lt_assoc_data).

        if sy-subrc = 0.

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


  ENDMETHOD.

ENDCLASS.
