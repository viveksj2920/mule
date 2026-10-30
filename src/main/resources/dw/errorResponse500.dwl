%dw 2.0
output application/json
---
{ 
        errorType: (error.errorType.namespace default "") ++ ": " ++ (error.errorType.identifier default "") default "MULE_INTERNAL_ERROR",
        errorCode: 500,
        errorDescription: error.detailedDescription,
        errorMessage: "Failed to retrieve slot availability, Error while querying CDAS_Slot_Master__c",
        rfcName: (error.errorType.identifier default "") default "MULE_INTERNAL_ERROR",
     correlationId : correlationId,
     timeStamp: now()
}

 