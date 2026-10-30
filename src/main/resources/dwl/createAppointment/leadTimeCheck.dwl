%dw 2.0
output application/java

var ctZone = "America/Chicago" as TimeZone

var leadTimeHours = vars.leadTimeHours
var cutoffCT = ((now() >> ctZone) as LocalDateTime) + (("PT" ++ leadTimeHours ++ "H") as Period)

var rawDate = payload.appointmentDate default ""
var rawTime = payload.appointmentTime default ""

// appointmentTime arrives as HH:mm or HH:mm:ss depending on the consumer; normalise to HH:mm before parsing.
var timeParts = rawTime splitBy ":"
var normalisedTime =
  if (sizeOf(timeParts) >= 2) (timeParts[0] ++ ":" ++ timeParts[1]) else ""

// Malformed date/time is left to the existing RAML and Salesforce validation rather than masked as a lead-time failure.
var isParseable =
  (rawDate matches /^(0[1-9]|1[0-2])\/(0[1-9]|[12][0-9]|3[01])\/\d{4}$/) and
  (normalisedTime matches /^([01][0-9]|2[0-3]):[0-5][0-9]$/)

var requestedCT =
  if (isParseable)
    ((rawDate ++ " " ++ normalisedTime) as LocalDateTime {format: "MM/dd/yyyy HH:mm"})
  else
    null
---
{
  leadTimeHours: leadTimeHours,
  isViolation: if (requestedCT == null) false else (requestedCT < cutoffCT)
}
