@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption view for Travel'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@Metadata.allowExtensions: true

define root view entity ZC_RAP_TRAVEL_CH as projection on ZI_RAP_TRAVEL_CH as Travel
{
    key TravelUuid,
    @Search.defaultSearchElement: true
    TravelId,
    @Consumption.valueHelpDefinition : [{ entity: { name: '/dmo/agency', element: 'AgencyID'} }]
    @ObjectModel.text.element: [ 'AgencyName' ]
    @Search.defaultSearchElement: true
    AgencyId,
    _Agency.Name as AgencyName,
    @Search.defaultSearchElement: true
    CustomerId,
    _Customer.FirstName as CustomerName,
    BeginDate,
    EndDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    BookingFee,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    TotalPrice,
    CurrencyCode,
    Description,
    OverallStatus,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    
    /* Associations */
    _Agency,
    _Booking : redirected to composition child ZC_RAP_BOOKING_CH,
    _Currency,
    _Customer
}
