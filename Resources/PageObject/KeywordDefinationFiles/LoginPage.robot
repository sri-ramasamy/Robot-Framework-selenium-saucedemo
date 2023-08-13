*** Settings ***
Library  SeleniumLibrary
Variables  ../Locators/Locators.py
Variables  ../TestData/Testdata.py

*** Keywords ***
Enter Username
    Input Text  ${LoginUsernameInputBox}  ${Username}

Enter Password
    Input Text  ${LoginPasswordInputBox}  ${Password}

Click Login 
    Click Element  ${LoginButton}

Login with invalid credentials should fail
    [Arguments]    ${Username}    ${Password}
    Input Text  ${LoginUsernameInputBox}  ${Username}
    Input Text  ${LoginPasswordInputBox}  ${Password}
    Click Element  ${LoginButton}
    ${error_msg} =    Get Text    css=div.error-message-container.error:nth-child(3) > h3:nth-child(1)
    Should Be Equal As Strings    ${error_msg}    Epic sadface: Username and password do not match any user in this service


