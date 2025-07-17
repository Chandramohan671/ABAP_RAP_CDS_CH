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

       SELECT FROM
       zi_travel_sample_prac_02( p_travelid = '00000001', p_date = '20250716' ) " CDS View with Input Parameter value
       FIELDS TravelId, AgencyId, BookingId,
       BookingDate, Status, character_lit, System_Date
       into TABLE @DATA(lt_data_display).

       if sy-subrc = 0.
         LOOP AT lt_data_display INTO DATA(ls_Data_display).
            out->write( | { ls_data_display-TravelId }  { ls_data_display-AgencyId }  { ls_data_display-BookingId } { ls_data_display-Status } { ls_data_display-BookingDate } { ls_data_display-character_lit } { ls_data_display-System_Date }| ).
         ENDLOOP.
       ENDIF.
  ENDMETHOD.

ENDCLASS.
