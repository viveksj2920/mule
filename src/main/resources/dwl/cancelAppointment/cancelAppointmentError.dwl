%dw 2.0
output application/json

var sfCode = upper(payload.items[0].payload.errors[0].statusCode default "")

var badRequestErrors = [
    "INVALID_FIELD",
    "INVALID_FIELD_FOR_INSERT_UPDATE",
    "INVALID_CROSS_REFERENCE_KEY",
    "INVALID_ID_FIELD",
    "INVALID_TYPE",
    "INVALID_OR_NULL_FOR_RESTRICTED_PICKLIST",
    "REQUIRED_FIELD_MISSING",
    "STRING_TOO_LONG",
    "DUPLICATES_DETECTED",
    "MALFORMED_ID",
    "NUMBER_OUTSIDE_VALID_RANGE",
    "FIELD_CUSTOM_VALIDATION_EXCEPTION",
    "INVALID_EMAIL_ADDRESS",
    "INVALID_PHONE_NUMBER",
    "CANNOT_INSERT_UPDATE_ACTIVATE_ENTITY"
]

---
{
    statusCode:
        if (
            (sfCode contains "INVALID")
            or
            (badRequestErrors contains sfCode)
        )
            400
        else if (
            sfCode == "ENTITY_IS_DELETED"
            or sfCode == "INSUFFICIENT_ACCESS_ON_CROSS_REFERENCE_ENTITY"
        )
            404
        else
            500,

    message: payload.items[0].payload.errors[0].message default null
}