%dw 2.0
output application/json

var sfCode = upper(payload.items[0].payload.errors[0].statusCode default "")
var badRequestErrors = [
    "REQUIRED_FIELD_MISSING",
    "STRING_TOO_LONG",
    "DUPLICATES_DETECTED",
    "MALFORMED_ID",
    "NUMBER_OUTSIDE_VALID_RANGE",
    "FIELD_CUSTOM_VALIDATION_EXCEPTION"
]

---
{
    statusCode:
        if (
            (sfCode contains "INVALID") or
            ((badRequestErrors contains sfCode) default false)
        )
            400
        else
            500,

    message: payload.items[0].payload.errors[0].message default null
}