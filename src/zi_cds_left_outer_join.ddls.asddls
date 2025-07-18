@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS View Entity Left Outer Join Practice'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_CDS_LEFT_OUTER_JOIN as select from zrap_travel_ch as Travel
left outer to many join zrap_book_ch as Booking   // Left Outer Join with [1:N] Cardinality
on Travel.travel_uuid = Booking.travel_uuid
{
    key Travel.travel_id as TravelId,
    case Travel.overall_status     // Case statements in Selection List of CDS View Entity
    when 'B' then 'A'
    when 'X' then 'X'
    else 'O'
    end as Status,
    Booking.booking_date as BookingDate // Exposing data from RHS Table 
    
    // count(*) as NoOfRecords // Aggregate Functions optimize the query
}


// Left Outer Join with [N:1] Cardinality

//define view entity ZI_CDS_LEFT_OUTER_JOIN as select from zrap_book_ch as Booking
//left outer many to one join zrap_travel_ch as Travel  
//on Travel.travel_uuid = Booking.travel_uuid
//{
//    key Booking.booking_id as BookingId,
//    case Travel.overall_status     
//    when 'B' then 'A'
//    when 'X' then 'X'
//    else 'O'
//    end as Status,
//    Booking.booking_date as BookingDate // Exposing data from RHS Table 
//}

// Notes

//Left outer join to many or Left outer joins works:-
//Relationship 1:N  :- it will create a join even if we don't fetch data from the RHS table
//Relationship  N:1 l:- it will not create a join if we don't fetch data from the RHS table
//
//1:N and N:1 is the relationship between the LHS table and the RHS table
//*******************************************************************************
//Relationship 1:N  behaves differently for "Left outer to one join" :-
//Select no contain any fields from RHS then optimization takes place join will not form
//Aggregate functions like  count(*) is used then optimization takes place join will not form
