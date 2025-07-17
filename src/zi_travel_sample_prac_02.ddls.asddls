@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for Practice Ref - 06'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity ZI_TRAVEL_SAMPLE_PRAC_02 
with parameters p_travelid : /dmo/travel_id, // Input Parameter
                @Environment.systemField: #SYSTEM_DATE // Annotations for System field with default value.
                p_date : abap.dats
as select from /dmo/travel as Travel
inner join /dmo/booking as Booking
on Travel.travel_id = Booking.travel_id
{
    key Travel.travel_id as TravelId,
    Booking.booking_id as BookingId,
    Travel.agency_id as AgencyId,
    Travel.begin_date as BeginDate,
    Travel.end_date as EndDate,
    Travel.status as Status,
    Booking.booking_date as BookingDate,
    Booking.flight_date as FlightDate,
    101 as numerical_lit,  // Numerical literal
    'CDS Practice' as character_lit, // Character Literal
    
    $parameters.p_date as System_Date  // Parameter usage in Field List
    
}
where Travel.travel_id = $parameters.p_travelid // Parameter usage in where condition.
