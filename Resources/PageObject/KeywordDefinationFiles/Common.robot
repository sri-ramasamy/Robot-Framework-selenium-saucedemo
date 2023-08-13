*** Settings ***
Library  SeleniumLibrary
Variables  ../Locators/Locators.py
Variables  ../TestData/Testdata.py
Resource    LoginPage.robot
Resource    HomePage.robot

*** Keywords ***
Opening Browser
    [Arguments]  ${site_url}  ${browser}
    Open Browser  ${site_url}  ${browser}
    Wait Until Element Is Visible  ${LoginUsernameInputBox}  timeout=5

Login to SauceDemo
    Opening Browser    https://www.saucedemo.com/    Chrome
    Enter Username
    Enter Password
    Click Login
    
Get page sub-title
    ${subtitle}  Get Text    css=div.header_secondary_container > span.title
    Log  ${subtitle}
    [Return]  ${subtitle}

Click Cancel
    Click Button   ${Cancel_Button}
    
    

    