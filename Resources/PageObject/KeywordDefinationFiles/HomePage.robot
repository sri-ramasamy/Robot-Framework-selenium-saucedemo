*** Settings ***
Library  SeleniumLibrary
Library    XML
Library    Collections
Variables  ../Locators/Locators.py
Variables  ../TestData/Testdata.py


*** Keywords ***
Handle alert if present
    Handle Alert
Verify page title
    ${Title}=  Get Title
    Should Be Equal As Strings  ${Title}   ${Expected_Page_Title}

Add or remove all products and get total count
    [Arguments]  ${button_name}
    @{all_items} =   Get WebElements     //button[contains(text(),${button_name})]
    ${count} =  Get Length    ${all_items}
    Log  ${count}
    FOR   ${product}   IN   @{all_items}
        Log  ${product}
        Click Element    ${product}
    END
    Run Keyword And Return Status    Page Should Not Contain Element    //button[contains(text(),${button_name})]
    [Return]   ${count}


Add specific number of products
    [Arguments]  ${count_of_products}
    @{items} =  Get WebElements    (//button[contains(text(),'Add to cart')])[position()<= ${count_of_products}] 
    ${length} =  Get Length    ${items}
    Log  ${length} 
    FOR  ${item}  IN  @{items}
        Log  ${item}
        Click Element    ${item}
    END
    [Return]  ${length}

Get seleted items label
    @{selected_items_label} =  Get WebElements  ${Cart_Selected_Items_Label}
    ${result} =  Create List
    FOR  ${item}  IN  @{selected_items_label}
        ${name} =  Get Text  ${item}
        Append To List    ${result}  ${name}
    END
    Log Many  ${result}
    [Return]  ${result}
    
Click on cart icon and get count
    Click Element     ${Cart_Icon}
    # ${cart_count} =  Get Text    css=a.shopping_cart_link > span.shopping_cart_badge
    ${cart_count} =  Get Text    //a[@class='shopping_cart_link']/span
    Log  ${cart_count}
    [Return]  ${cart_count}

Get cart icon count
     ${cart_count} =  Get Text    css=a.shopping_cart_link > span.shopping_cart_badge
    Log  ${cart_count}
    [Return]  ${cart_count}

Verify sort items in ascending or descending order
    [Arguments]  ${sort_order} 
    Run Keyword And Return Status    Page Should Contain Element    css=div.inventory_item_label a:nth-child(1) > div.inventory_item_name
    @{inventory_items} =  Get WebElements  css=div.inventory_item_label a:nth-child(1) > div.inventory_item_name
    ${string_result} =  Create List
    FOR  ${item}  IN  @{inventory_items}
        ${name} =  Get Text  ${item}
        Append To List    ${string_result}  ${name}
    END
    Run Keyword If    "${sort_order}" == "Name (A to Z)"
        ...    Sort List    ${string_result}
        ...  ELSE
        ...    Reverse List   ${string_result}
    Click Element     ${Sort_icon}
    Click Element    //span[@class='select_container']/select/option[contains(text(), '${sort_order}')]
    Sleep    3
    @{sorted_inventory_items} =  Get WebElements  css=div.inventory_item_label a:nth-child(1) > div.inventory_item_name
    FOR  ${a}  IN RANGE    0    5
        ${actual} =     Get Text    ${sorted_inventory_items[${a}]}
        Log    ${actual}  
        Should Be Equal As Strings    ${actual}    ${string_result[${a}]}
    END
        
# Logout
#     CLick Element  ${WelcomeText}
#     Wait Until Element Is Visible  ${LogoutButton}  timeout=5
#     Click Element  ${LogoutButton}
#     Wait Until Element Is Visible  ${LoginUsernameInputBox}  timeout=5