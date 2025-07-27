@AbapCatalog.sqlViewName: 'ZSQL_INHERIT_CON'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Inherit Condition DCL Demo'
@Metadata.ignorePropagatedAnnotations: true
define view ZI_TRAVEL_DCL_INHERIT_COND as select from ZI_TRAVEL_VIEW_CH

{
    key TravelId,
    AgencyId,
    CustomerId,
    BeginDate,
    EndDate,
    BookingFee,
    TotalPrice,
    CurrencyCode,
    Description,
    Status,
    Createdby,
    Createdat,
    Lastchangedby,
    Lastchangedat,
    sysClient,
    sysLang,
    sysData,
    agency_id,
    /* Associations */
    _Agency
}
