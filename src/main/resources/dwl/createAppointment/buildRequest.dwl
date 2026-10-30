%dw 2.0
output application/java
---
[
    {
        CDAS_First_Name__c: payload.firstName,
        CDAS_Last_Name__c: payload.lastName,
        CDAS_Email_Address__c: payload.emailAddress,
        CDAS_Zip_Code__c: payload.zipCode,

        CDAS_Birthdate__c:
            if (!isEmpty(payload.dateOfBirth default ""))
                (payload.dateOfBirth as Date {format: "MM/dd/yyyy"})
            else
                null,

        CDAS_Medicare_Number__c:
            if (!isEmpty(payload.medicareNumber default ""))
                payload.medicareNumber
            else
                null,

        CDAS_Phone_Number__c: payload.phoneNumber,
        CDAS_Phone_Type__c: payload.phoneType,

        CDAS_Consent_Mobile_Number__c:
            if (!isEmpty(payload.consentMobileNumber default ""))
                payload.consentMobileNumber
            else
                null,

       	CDAS_Appointment_Date__c:
    if (!isEmpty(payload.appointmentDate default ""))
        if (payload.appointmentDate matches /^(0[1-9]|1[0-2])\/(0[1-9]|[12][0-9]|3[01])\/\d{4}$/)
            (payload.appointmentDate as Date {format: "MM/dd/yyyy"})
        else
            null
    else
        null,

       CDAS_Appointment_Time__c:

			if (!isEmpty(payload.appointmentTime))
			
			payload.appointmentTime ++ ":00.000Z"
			
			else
			
			null,

        CDAS_MCID__c:
            if (!isEmpty(payload.mcid default ""))
                payload.mcid
            else
                null,

        CDAS_UUID__c:
            if (!isEmpty(payload.uuid default ""))
                payload.uuid
            else
                null,

        CDAS_PSID__c:
            if (!isEmpty(payload.pscid default ""))
                payload.pscid
            else
                null,

        CDAS_Page_Name__c:
            if (!isEmpty(payload.pageName default ""))
                payload.pageName
            else
                null,

        CDAS_SMS_Consent__c: payload.smsConsent,

        CDAS_Marketing_Text__c: payload.marketingTexts,

        CDAS_Appointment_Time_Zone__c:
            if (!isEmpty(payload.appointmentTimeZone default ""))
                upper(payload.appointmentTimeZone)
            else
                "CT",

        CDAS_Status__c: "New",
        cancelURL__c: if (!isEmpty(payload.cancelUrl default "") and ((payload.cancelUrl as String) matches /^https?:\/\/.+/)and ((payload.cancelUrl as String) endsWith ".html"))
        payload.cancelUrl
   			 else
        null,
    }
]