%dw 2.0
output application/json skipNullOn="everywhere"
---
{
  "firstName": payload.firstName,
  "lastName": payload.lastName,
  "email": payload.email,
  "zipCode": payload.zipCode,
  "birthDate": payload.birthDate,
  "marketingPSC": payload.marketingPSC,
  "conversationId": payload.conversationId,
  "agentId": payload.agentId,
  "agentName": payload.agentName,
  "adobeId": payload.adobeId,
  "customerId": payload.customerId
}
