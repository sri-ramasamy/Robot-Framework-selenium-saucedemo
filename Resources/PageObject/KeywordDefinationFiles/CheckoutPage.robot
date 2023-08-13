*** Settings ***
Library  SeleniumLibrary
Library    XML
Library    Collections
Variables  ../Locators/Locators.py
Variables  ../TestData/Testdata.py


*** Keywords ***

Get total price of items after checkout
    ${calculatedTotalPrice} =    set variable    ${0}
    ${items_price_with_tax} =  Get Text   css=div.summary_info_label.summary_total_label:nth-child(8)
    ${items_price_with_tax} =  evaluate    '${items_price_with_tax}'.replace('Total: $','')
    ${items_tax} =  Get Text     css=div.summary_info > div.summary_tax_label:nth-child(7)
    ${items_tax} =  evaluate    '${items_tax}'.replace('Tax: $','')
    ${items_price_with tax} =  Convert To Number  ${items_price_with_tax}
    ${items_tax} =  Convert To Number    ${items_tax}
    ${TotalPriceMinusTax} =    Evaluate    ${items_price_with_tax} - ${items_tax}
    Log    ${TotalPriceMinusTax}
    [Return]   ${TotalPriceMinusTax}

Click on Finish button
    Click Button    ${Finish_Button}