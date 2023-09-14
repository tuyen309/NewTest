*** Settings ***
Library     Collections
Library    DateTime
Library     String

*** Variables ***
&{DateFormats}    d=2    ab=3    y=2    h=2    m=2    ap=2    s=2    b=3    M=3    Y=5    p=2    I=2    A=2

*** Keywords ***
Convert To Fixed Date Format
    [Arguments]    ${input_string}
    ${input_date}=    Split String    ${input_string}    ${SPACE}
    ${format_date}=    Create List
    FOR   ${index}    IN    @{input_date}
        ${len_index}=    Get Length    ${index}
        ${format_index}=    Run Keyword If   "${len_index}"=="8" and ":" in "${index}"     Run Keyword
        #...    Log     00:00:00
        ...      Set Variable    hh:mm:ss
        ...     ELSE IF   "${len_index}"=="5" and ":" in "${index}"    Run Keyword
        #...     Log    00:00
        ...      Set Variable    hh:mm
        ...     ELSE IF    "${len_index}"=="10" and "/" in "${index}"    Run Keyword
        #...     Log     11/25/2022
        ...      Set Variable   mm/dd/yyyy
        ...     ELSE IF     "${len_index}"=="8" and "/" in "${index}"    Run Keyword
        #...     Log    11/25/22
        ...      Set Variable   mm/dd/yy
        ...     ELSE IF      "${index}"=="AM" or "${index}"=="PM"     Run Keyword
        #...     Log     AM/PM
        ...     Append To List       ${format_date}    ${index}
        ...     ELSE IF     "-" in "${index}"    Run Keyword
        #...     Log     25-Nov-22
        ...      Set Variable    dd-MMM-yy
        ...     ELSE IF    "," in "${index}"      Run Keyword
        #...     Log    Friday, November 25, 2023
        ...     Set Variable     ${format_index}    dddd, MMMM dd, yyyy
        ...     ELSE IF    "${len_index}"=="5" and "/" in "${index}"     Run Keyword
        #...     Log     11/25 or 11/22
        ...     ELSE IF     "${len_index}"=="3"    Run Keyword
        #...     Log     Nov
        ...     Set Variable      ${format_index}    MMM
        ...     ELSE IF     "${len_index}"=="4"    Run Keyword
        #...     Log   2022
        ...     Set Variable         ${format_index}      yyyy
        Append To List       ${format_date}    ${format_index}   
    END
    ${format_date}=   Convert To String   ${format_date}
    ${format_date}=    Remove String    ${format_date}   [   ]   '   ,
    Log    ${format_date}
    Return From Keyword    ${format_date}

Convert Dates
    #${date_input1}=    Set Variable    25-Nov-22
    #${date_input2}=    Set Variable    12:00 AM 11/25/2022
    #${date_input3}=    Set Variable    11/25/2022 AM 12:00:00
    #${date_input4}=    Set Variable    00:00 11/25/2022
    ${date_input5}=    Set Variable    00:00:00 11/25/2022

    #${formatted_date1}=    Convert To Fixed Date Format    ${date_input1}
    #${formatted_date2}=    Convert To Fixed Date Format    ${date_input2}
    #${formatted_date3}=    Convert To Fixed Date Format    ${date_input3}
    #${formatted_date4}=    Convert To Fixed Date Format    ${date_input4}
    ${formatted_date5}=    Convert To Fixed Date Format    ${date_input5}

    #Log    Datetime1 ${formatted_date1}
    #Log    Datetime2 ${formatted_date2}
    #Log    Datetime3 ${formatted_date3}
    #Log    Datetime4 ${formatted_date4}
    Log    Datetime5 ${formatted_date5}

*** Test Cases ***
Convert Dates
    Convert Dates
