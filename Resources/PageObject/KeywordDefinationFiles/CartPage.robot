*** Settings ***
Library  SeleniumLibrary
Library    XML
Library    Collections
Variables  ../Locators/Locators.py
Variables  ../TestData/Testdata.py


*** Keywords ***
Get cart items count before checkout
    @{cart_items} =  Get WebElements    ${Cart_Items_List}
    ${cart_items_count} =  Get Length    ${cart_items}
    [Return]  ${cart_items_count}

Get cart items label before checkout
    @{cart_item_label} =  Get WebElements  css= div.cart_item_label a:nth-child(1) > div.inventory_item_name
    ${cart_result} =  Create List
    FOR  ${item}  IN  @{cart_item_label}
        ${label} =  Get Text  ${item}
        Append To List    ${cart_result}  ${label}
    END
    Log Many  ${cart_result}
    [Return]   ${cart_result}


Get total price of items
    ${calculatedTotalPrice} =    set variable    ${0}
    @{items_price_list} =  Get WebElements    css=div.cart_item_label div.item_pricebar:nth-child(3) > div.inventory_item_price
    ${items_price_result} =  Create List
    FOR  ${item}  IN  @{items_price_list}
        ${item_price} =  Get text  ${item}
        ${item_price} =  evaluate    '${item_price}'.replace('$','')
        ${item_price_num} =  Convert To Number  ${item_price}
        ${calculatedTotalPrice} =    Evaluate    ${item_price_num} + ${calculatedTotalPrice}
    END
    Log    ${calculatedTotalPrice}
    [Return]   ${calculatedTotalPrice}

Click on checkout
    Click Button    ${Checkout} 

Click on continue shopping
    Click Button    ${Continue_Shopping_Button}