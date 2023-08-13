*** Settings ***
Documentation  Page Object in Robot Framework
Library  SeleniumLibrary
Resource  ../Resources/PageObject/KeywordDefinationFiles/LoginPage.robot
Resource  ../Resources/PageObject/KeywordDefinationFiles/HomePage.robot
Resource  ../Resources/PageObject/KeywordDefinationFiles/Common.robot
Resource  ../Resources/PageObject/KeywordDefinationFiles/CartPage.robot
Resource   ../Resources/PageObject/KeywordDefinationFiles/Checkout_Information.robot
Resource   ../Resources/PageObject/KeywordDefinationFiles/CheckoutPage.robot
Test Setup    Login to SauceDemo
Test Teardown    Close All Browsers

*** Variables ***

*** Test Cases ***
Verify sorting
    [documentation]  This test case verifies adding and removing all products into and from the cart
    [tags]  Smoke
    Verify sort items in ascending or descending order    Name (Z to A)
    Verify sort items in ascending or descending order    Name (A to Z)