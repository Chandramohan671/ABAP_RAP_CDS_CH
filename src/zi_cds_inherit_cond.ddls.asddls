@AbapCatalog.sqlViewName: 'ZSQL_INHERT_COND'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Inherit Conditions from Entity'
@Metadata.ignorePropagatedAnnotations: true
define view ZI_CDS_INHERIT_COND as select from /dmo/travel as Travel
association to /dmo/agency as _Agency on $projection.AgencyId = _Agency.agency_id
{
    key travel_id as TravelId,
    agency_id as AgencyId,
    customer_id as CustomerId,
    begin_date as BeginDate,
    end_date as EndDate,
    booking_fee as BookingFee,
    total_price as TotalPrice,
    currency_code as CurrencyCode,
    description as Description,
    status as Status,
    createdby as Createdby,
    createdat as Createdat,
    lastchangedby as Lastchangedby,
    lastchangedat as Lastchangedat,
    
    _Agency // Exposed Association
}
