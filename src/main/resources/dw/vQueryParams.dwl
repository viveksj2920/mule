%dw 2.0
output application/json

var ctZone = "America/Chicago" as TimeZone
// Sourced from a flow variable, not p(): the property lives in config-${mule.env}.yaml, which p() cannot resolve.
var leadTimeHours = vars.leadTimeHours
var nowCT = now() >> ctZone
var cutoffCT = (nowCT as LocalDateTime) + (("PT" ++ leadTimeHours ++ "H") as Period)

// Requested start date carried at the current Central time-of-day, per the lead-time comparison rule.
var candidateCT =
  ((attributes.queryParams.startDate as String)[0 to 9] ++ "T" ++ (nowCT as String {format: "HH:mm:ss"}))
    as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}

var isShifted = candidateCT < cutoffCT
var effectiveStartCT = if (isShifted) cutoffCT else candidateCT
---
{ 
  "timeZone": attributes.queryParams.timeZone,
  "startDate": attributes.queryParams.startDate,
  "endDate": attributes.queryParams.endDate,
  "leadTimeHours": leadTimeHours,
  "effectiveStartDate": effectiveStartCT as String {format: "yyyy-MM-dd"},
  // Appointment_Date__c has no time part, so the SOQL date bound alone would still return earlier slots on the cutoff day.
  "earliestSlotCT": if (isShifted) (cutoffCT as String {format: "yyyy-MM-dd'T'HH:mm:ss"}) else null
}