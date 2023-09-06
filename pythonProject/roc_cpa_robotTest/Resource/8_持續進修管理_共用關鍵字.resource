*** Settings ***
Documentation  持續進修自動測試腳本共用關鍵字

Resource    ../CommonResource.resource
*** Variables ***
&{Button}   Search=//button[contains(.,"查詢")]   Confirm=//button[contains(.,"確 認")]
...         Save=//button[contains(.,"儲 存")]    Add=//button[contains(.,"新增")]
...         Cancel=//button[contains(.,"取 消")]  Edit=//button[contains(.,"編輯")]
...         Clear=//button[contains(.,"清 除")]   Check=//button[contains(.,"查看")]
...         Delete=//button[contains(.,"刪除")]   Import=//Button[contains(.,"匯 入")]
...         Sure=//button[contains(.,"確 定")]
&{Event}    Name=Testing6
*** Keywords ***

Input Start And End Date
    [Arguments]    ${ElementId}  ${StartDate}  ${EndDate}
    Click Element    //input[@id="${ElementId}"]
    Input Text    //input[@id="${ElementId}"]      ${StartDate}
    Click Element    //input[@id="${ElementId}"]/../following-sibling::div/input
    Input Text    //input[@id="${ElementId}"]/../following-sibling::div/input   ${EndDate}
    Press Key    //input[@id="${ElementId}"]/../following-sibling::div/input   \\13
Choose Date
    [Documentation]    點選日期YYYY-MM-DD
    [Arguments]    ${Date}
    ${YYYY}    Get Substring    ${Date}    0    4
    ${YYYY-MM}    Get Substring    ${Date}    0    7
    Click And Visible    (//button[@class="ant-picker-year-btn"])[1]
    Sleep    1
    Click And Visible    //td[@title="${YYYY}"]
    Click And Visible    (//button[@class="ant-picker-month-btn"])[1]
    Sleep    1
    Click And Visible    //td[@title="${YYYY-MM}"]
    Click And Visible    //td[@title="${Date}"]
Choose Start And End Date
    [Arguments]    ${Element}  ${StartDate}  ${EndDate}
    Click And Visible    ${Element}
    Choose Date    ${StartDate}
    Choose Date    ${EndDate}
Search By Keyword
    [Arguments]    ${keyword}
    Wait And Input    //input[contains(@placeholder,"請輸入")]   ${keyword}
    Click And Enabled    ${Button.Search}
Statistical Analysis For
    [Documentation]    使用者點選某入課程活動>點擊[統計分析]>畫面顯示統計分析資料
    [Arguments]    ${ActivityOrCourse}
    Scroll In IFrame    300
    Click And Enabled    //span[text()="${ActivityOrCourse}"]/..
    Wait And Select Frame    ${IFrameId}
    Click And Visible    //span[text()="統計分析"]/..
    Sleep    1
    Scroll In IFrame    300