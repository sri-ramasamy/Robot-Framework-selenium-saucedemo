*** Settings ***
Documentation  Page Object Model in Robot Framework
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
${homepage_subtitle}
${count}
${inventory_item_count}    
${cart_icon_count}
${cartpage_subtitle}
${selected_items_label}
${cart_items_label}
${items_total_price}
${checkout_infopage_subtitle}
${checkout_overviewpage_subtitle}
${items_total_price_after_checkout}
${checkout_completepage_subtitle}


*** Test Cases ***
Verify checkout
    [documentation]  This test case verifies the checkout functionality of Sauce Demo
    [tags]  Smoke
    ${homepage_subtitle} =  Get page sub-title
    Should Be Equal As Strings    ${homepage_subtitle}    Products    #Verify home page subtitle 
    ${count} =  Add specific number of products     2                 
    ${selected_items_label} =  Get seleted items label
    ${cart_icon_count} =  Click on cart icon and get count     #Verify the count displayed on cart icon is same as the count of selected items
    Run Keyword And Return Status  Page Should Contain Element    ${Checkout}
    ${cartpage_subtitle} =  Get page sub-title
    Should Be Equal As Strings    ${cartpage_subtitle}    Your Cart 
    ${cart_items_label} =  Get cart items label before checkout   
    ${inventory_item_count} =  Get cart items count before checkout
    Lists Should Be Equal    ${selected_items_label}    ${cart_items_label}        #Verify whether the item names match betwwen the selected and the ones in cart
    Should Be Equal As Numbers    ${cart_icon_count}    ${inventory_item_count}   #Verify count displayed on cart_icon is same as the count in the cart
    Click on checkout
    Run Keyword And Return Status    Page Should Contain Button    ${Cancel_Button}
    ${checkout_infopage_subtitle} =  Get page sub-title
    Should Be Equal As Strings    ${checkout_infopage_subtitle}    Checkout: Your Information  #Verify Checkout Information  page subtitle
    Click Cancel
    ${items_total_price} =     Get total price of items
    Click on checkout
    Run Keyword And Return Status    Page Should Contain Element    ${Firstname_TextBox}
    Enter User Information
    Click Continue button
    ${checkout_overviewpage_subtitle_subtitle} =  Get page sub-title
    Should Be Equal As Strings    ${checkout_overviewpage_subtitle_subtitle}    Checkout: Overview        #Verify checkout overview page subtitle
    ${items_total_price_after_checkout} =  Get total price of items after checkout
    Should Be Equal As Numbers    ${items_total_price}    ${items_total_price_after_checkout}  #Verify that the total price minus tax in checkout is same as before checkout
    Click on Finish button
    ${checkout_completepage_subtitle} =  Get page sub-title
    Should Be Equal As Strings    ${checkout_completepage_subtitle}    Checkout: Complete!
    



*** Keywords ***