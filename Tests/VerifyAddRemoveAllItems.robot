*** Settings ***
Documentation  Page Object Model in Robot Framework
Library  SeleniumLibrary
Resource  ../Resources/PageObject/KeywordDefinationFiles/LoginPage.robot
Resource  ../Resources/PageObject/KeywordDefinationFiles/HomePage.robot
Resource  ../Resources/PageObject/KeywordDefinationFiles/Common.robot
Resource  ../Resources/PageObject/KeywordDefinationFiles/CartPage.robot
Resource   ../Resources/PageObject/KeywordDefinationFiles/Checkout_Information.robot
Resource   ../Resources/PageObject/KeywordDefinationFiles/CheckoutPage.robot

*** Variables ***
${count_all_products_added}
${all_products_label}
${count_cart_icon}
${cart_products_label}
${cart_products_count}
${count_all_products_removed}

*** Test Cases ***
Verify Add and Remove All Items
    [documentation]  This test case verifies adding and removing all products into and from the cart
    [tags]  Smoke
    Login to SauceDemo
    ${count_all_products_added} =  Add or remove all products and get total count   "Add to cart"                
    ${all_products_label} =  Get seleted items label
    ${count_cart_icon} =  Click on cart icon and get count     
    ${cart_products_label} =  Get cart items label before checkout   
    ${cart_products_count} =  Get cart items count before checkout
    Lists Should Be Equal    ${all_products_label}    ${cart_products_label}        #Verify whether the item names match betwwen the selected and the ones in cart
    Should Be Equal As Numbers    ${count_cart_icon}    ${cart_products_count}
    Click on continue shopping
    Add or remove all products and get total count    "Remove"
    Run Keyword And Return Status    Page Should Not Contain Element    ${count_cart_icon}
