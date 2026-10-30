%dw 2.0

output application/json

var sfResponse = payload.items[0].payload

---

{

success: sfResponse.success,

consumerAppointmentId: sfResponse.id,

message:

if (sfResponse.success)

"CDAS Consumer AppointmentId cancelled successfully"

else

(sfResponse.errors[0].message default "Failed to cancel CDAS Consumer Appointment")

}