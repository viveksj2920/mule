%dw 2.0
output application/json
---
{ 
        errorType: (error.errorType.namespace default "") ++ ": " ++ (error.errorType.identifier default "") default "MULE_INTERNAL_ERROR",
        errorCode: 500,
        errorDescription: error.detailedDescription,
        errorMessage: "Failed to fetch appointment details, Error while querying Case object",
        rfcName: (error.errorType.identifier default "") default "MULE_INTERNAL_ERROR",
        correlationId : correlationId,
        timeStamp: now()
} 

 