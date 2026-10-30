%dw 2.0
output application/java
---
[
    {
        Id: payload.recordid,
        Status: payload.Status,
        Cancellation_Reason__c: payload.CancelReason,
        CDAS_appoint_cancel_source__c: payload.RequestSource
     }
]