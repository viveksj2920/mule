%dw 2.0
output application/json
---

{
 "errorType": "BAD_REQUEST",
 "errorCode": 400,
 "errorDescription": "startDate must be less than or equal to endDate",
 "errorMessage": "invalidDateRange",
 "rfcName": "Bad Request",
 "correlationId": correlationId,
 "timeStamp": now()
}