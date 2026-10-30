%dw 2.0
output application/json
---
{
 "errorType": "BAD_REQUEST",
 "errorCode": 400,
 "errorDescription": "Booking lead time of " ++ vars.vQParams.leadTimeHours ++ " hours moves the start date to " ++ vars.vQParams.effectiveStartDate ++ ", which is after the requested endDate " ++ vars.vQParams.endDate,
 "errorMessage": "leadTimeExceedsDateRange",
 "rfcName": "Bad Request",
 "correlationId": correlationId,
 "timeStamp": now()
}
