%dw 2.0
output application/json
---
{
 "errorType": "BAD_REQUEST",
 "errorCode": 400,
 "errorDescription": "Appointment can't be scheduled for the given lead time of " ++ vars.leadTimeCheck.leadTimeHours ++ " hours",
 "errorMessage": "leadTimeNotMet",
 "rfcName": "Bad Request",
 "correlationId": correlationId,
 "timeStamp": now()
}
