*** Settings ***
Library  SeleniumLibrary
Library    XML
Library    Collections
Variables  ../Locators/Locators.py
Variables  ../TestData/Testdata.py


*** Keywords ***
Enter User Information
    Input Text    ${Firstname_TextBox}    ${First_Name}
    Input Text    ${Lastname_TextBox}    ${Last_Name}
    Input Text    ${Postalcode_TextBox}    ${Postal_Code}

Click Continue button
    Click Button    ${Continue_Button}
