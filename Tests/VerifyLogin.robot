*** Settings ***
Documentation  Page Object Model in Robot Framework
Library  SeleniumLibrary
Resource  ../Resources/PageObject/KeywordDefinationFiles/LoginPage.robot
Resource  ../Resources/PageObject/KeywordDefinationFiles/HomePage.robot
Resource  ../Resources/PageObject/KeywordDefinationFiles/Common.robot
Variables  ../Resources/PageObject/TestData/Testdata.py
Test Teardown    Close All Browsers
Test Setup    Opening Browser    ${site_url}  ${browser}

*** Variables ***
${site_url}  https://www.saucedemo.com/
${browser}  Chrome


*** Test Cases ***
Verify Successful Login to SauceDemo
    [documentation]  This test case verifies that the user is able to successfully Login and Logout to saucedemo using Page Object
    [tags]  Smoke
    Enter Username
    Enter Password
    Click Login
    Press Keys    None    ESC
    Verify Page title

Invalid Password
    [documentation]  This test case verifies invalid username and password
    [tags]  Smoke
    [Template]    Login with invalid credentials should fail
    ${invalid_user}    ${invalid_password}
    ${Username}    ${invalid_password}

