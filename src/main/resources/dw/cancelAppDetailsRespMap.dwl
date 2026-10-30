%dw 2.0
output application/json
 
var ctTimeZone = "America/Chicago" as TimeZone
// Current time in CT
var currentCTLocal = (now() >> ctTimeZone) as LocalDateTime

// Scheduled date/time in source payload is already CT. Keep it as local CT time.
fun scheduledCTLocal(item) =
  ((
    (item.Scheduled_Date__c as String) ++
    "T" ++
    (item.Scheduled_Time__c as String)
  ) as DateTime { format: "yyyy-MM-dd'T'HH:mm:ss.SSSX" }) as LocalDateTime

var scheduledLocal = scheduledCTLocal(payload[0])
var hasPastSchedule = scheduledLocal < currentCTLocal


var response = {
"FirstName": payload[0].Account.FirstName,
"LastName": payload[0].Account.LastName,
"Scheduled_Time__c":  scheduledLocal as String { format: "HH:mm:ss.SSS" },
"Id": payload[0].Id,
"Scheduled_Date__c": scheduledLocal as String { format: "yyyy-MM-dd" }
}
---
if (payload[0].Status == "Cancelled")  { Message: "The appointment has already been cancelled." }
else if (hasPastSchedule)
  { Message: "The appointment cannot be considered for cancellation as scheduled date or time is in past." }
else
  response