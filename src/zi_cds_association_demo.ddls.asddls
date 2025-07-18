@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS View with Association'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_CDS_ASSOCIATION_DEMO as select from zrap_travel_ch as Travel
association [1..*] to zrap_book_ch as _Booking   // Association [1..*] cardinality
on $projection.TravelGuid = _Booking.travel_uuid
{
    key travel_uuid as TravelGuid,
    travel_id as TravelId,
    case Travel.overall_status  
    when 'B' then 'A'
    when 'X' then 'X'
    else 'O'
    end as Status,
    @Semantics.amount.currencyCode: 'currency_code'  // Currency code reference to Amount Field
    booking_fee as BookingFee, // Amount
    Travel.currency_code,  // Currency code
    
    _Booking            // Exposed Association
   // _Booking.booking_id  // Ad-hoc Association
   
}
