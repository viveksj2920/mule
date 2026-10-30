%dw 2.0
output application/json
---
{
  "errorType": "APP:NOT_FOUND",
  "errorCode": "404",
  "errorDescription": "The requested appointmentId was not found in the system",
  "rfcName": "Not Found",
  "correlationId": correlationId,
   timeStamp: now()
}