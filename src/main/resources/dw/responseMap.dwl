output application/json

var cutoffCT = vars.vQParams.earliestSlotCT
var cutoffLocal = if (cutoffCT == null) null else (cutoffCT as LocalDateTime)

// Slot date and time are stored in Central Time; substring guards trailing millis/offset (e.g. "08:00:00.000Z").
fun slotCT(item) = do {
    var d = (item.Appointment_Date__c as String)[0 to 9]
    var t = (item.Appointment_Time__c as String)[0 to 7]
    ---
    (d ++ "T" ++ t) as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}
}

// One row per slot, so this drops individual times within the cutoff day rather than the whole day.
var availableSlots =
    if (cutoffLocal == null) payload
    else (payload filter (slotCT($) >= cutoffLocal))

var slots = (availableSlots groupBy $.Appointment_Date__c ) pluck ((value, key, index) -> {
    "date": key,
    "slots": (value.*Appointment_Time__c ) orderBy $

})

var NullList = {Message:"No Slots Available"}
var Data = {
  "timeZone": vars.vQParams.timeZone,
  "startDate": vars.vQParams.effectiveStartDate,
  "endDate": vars.vQParams.endDate,
  "slotDurationMinutes": 60,
  "availableDates": slots,
  
}
---
if (isEmpty(availableSlots)) NullList else Data