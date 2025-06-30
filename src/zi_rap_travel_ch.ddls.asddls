@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for Travel Booking'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZI_RAP_TRAVEL_CH 
as select from zrap_travel_ch as Travel

 composition of many ZI_RAP_BOOKING_CH as _Booking 
// Composition - Will be useful in Transaction behaviour for BO Object - Parent to Child

//association [0..*] to ZI_RAP_BOOKING_CH as _Booking on $projection.TravelUuid = _Booking.TravelUuid

association [0..1] to /DMO/I_Agency as _Agency on $projection.AgencyId = _Agency.AgencyID
association [0..1] to /DMO/I_Customer as _Customer on $projection.CustomerId = _Customer.CustomerID
association [0..1] to I_Currency as _Currency on $projection.CurrencyCode = _Currency.Currency
{
    key Travel.travel_uuid as TravelUuid,
    Travel.travel_id as TravelId,
    Travel.agency_id as AgencyId,
    Travel.customer_id as CustomerId,
    Travel.begin_date as BeginDate,
    Travel.end_date as EndDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    Travel.booking_fee as BookingFee,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    Travel.total_price as TotalPrice,
    Travel.currency_code as CurrencyCode,
    Travel.description as Description,
    Travel.overall_status as OverallStatus,
    @Semantics.user.createdBy: true
    Travel.created_by as CreatedBy,
    Travel.created_at as CreatedAt,
    @Semantics.user.lastChangedBy: true
    Travel.last_changed_by as LastChangedBy,
    Travel.last_changed_at as LastChangedAt,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    Travel.local_last_changed_at as LocalLastChangedAt,
    
    //_Booking.TravelUuid as BookTravelUuid, // Ad-hoc Association (Rarely used )
    
    // Exposed associations  (Best practice to use)
    _Booking,
    _Agency,
    _Customer,
    _Currency  
    
}
