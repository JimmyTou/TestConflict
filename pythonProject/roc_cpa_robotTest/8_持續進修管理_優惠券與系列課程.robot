*** Settings ***
Documentation   持續進修自動測試腳本(8-22-01~8-25-02)
...             測試後會自動刪除測試中新增之資料，以利重複測試

Library    ExcelLibrary
Resource    Resource/8_持續進修管理_共用關鍵字.resource

Suite Setup    Setup
Test Teardown    Unselect Frame

*** Variables ***
&{Series}   Name=testing1  EntireEventPrice=1000  GroupEventPrice=900  GroupEventPeople=10

*** Keywords ***

Setup
    Open Page
    Login   ${Employee}
Coupon Maintain
    Click And Enabled    //div[@id="navbar"]//li[contains(.,"課程活動報名管理")]
    Click And Visible    //a[text()="優惠劵管理"]
    Wait And Select Frame    ${IFrameId}
Series Maintain
    Click And Enabled    //div[@id="navbar"]//li[contains(.,"課程活動報名管理")]
    Click And Visible    //a[text()="系列管理"]
    Wait And Select Frame    ${IFrameId}
Input Series Data
    [Documentation]    輸入系列課程資料
    [Arguments]    ${series}
    Wait And Input    //input[@id="basic_name"]     ${series.Name}
    Wait And Input    //input[@id="basic_entire_event_price"]     ${series.EntireEventPrice}
    Wait And Input    //input[@id="basic_group_event_price"]     ${series.GroupEventPrice}
    Wait And Input    //input[@id="basic_group_event_people"]     ${series.GroupEventPeople}
Delete Series
    [Documentation]    刪除此名稱之系列課程
    [Arguments]    ${seriesName}
    Series Maintain
    Search By Keyword    ${seriesName}
    Click And Enabled    //tbody//tr[contains(.,"${seriesName}")]${Button.Delete}
    Sleep    1
    Click And Visible    ${Button.Confirm}
    Sleep    1
*** Test Cases ***

8-22-01
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[優惠券列表]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[優惠券列表]
...  /      Expected Result: 顯示相關頁面
    [Tags]    7022 持續進修管理-優惠券列表
    Coupon Maintain
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Page Should Contain    優惠劵清單
8-23-01
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[優惠券列表]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[優惠券列表]
...  /      4.列表中點擊會員姓名link
...  /      5.進入該會員優惠券清單
...  /      Expected Result: 顯示相關頁面
    [Tags]    7023 持續進修管理-會員優惠券
    Coupon Maintain
    Wait Until Page Contains Element    //tbody/tr/td[2]
    ${accountantName}  Get Text    //tbody/tr/td[2]
    Click And Enabled    //tbody/tr/td[2]/button
    Wait And Select Frame    ${IFrameId}
    Wait Until Page Contains Element    //tbody/tr/td[2]
    @{elements}     Get Webelements    //tbody/tr/td[2]
    FOR    ${element}   IN      @{elements}
        Element Should Contain    ${element}    ${accountantName}
    END

#8-24-01與8-24-01情境流程互換?
8-24-01
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[系列課程]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[系列課程]
...  /      4.於關鍵字輸入1
...  /      5.點擊[查詢]
...  /      Expected Result: 顯示相關頁面
    [Tags]    7024 持續進修管理-系列課程清單
    Series Maintain
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Search By Keyword   1
    Sleep    1
    Wait Until Page Contains Element    //tbody/tr/td[2]
    @{elements}     Get Webelements    //tbody/tr/td[1]
    FOR    ${element}   IN      @{elements}
        Element Should Contain    ${element}    1
    END
8-24-02
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[系列課程]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[系列課程]
...  /      Expected Result: 顯示相關頁面
    [Tags]    7024 持續進修管理-系列課程清單-查詢
    Series Maintain
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Page Should Contain    系列清單

8-25-01
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[系列課程]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[系列課程]
...  /      4.點擊[新增]
...  /      5. 與基本資料的名稱輸入測試一，全休金額輸入$1000 ，團報金額輸入$900 ， 團報人數輸入10人
...  /      6. 按下儲存後畫面跳出提示訊息，並點擊確認
...  /      Expected Result: 顯示相關頁面
    [Tags]    7025 持續進修管理-系列課程新增
    Series Maintain
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Click And Enabled    ${Button.Add}
    Wait And Select Frame    ${IFrameId}
    Input Series Data    ${Series}
    Click And Enabled    ${Button.Save}
    Sleep    1
    Click And Enabled    ${Button.Confirm}
    Sleep    1
    Series Maintain
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Search By Keyword    ${Series.Name}
    Sleep    1
    Page Should Contain    ${Series.Name}
    #刪除新增測試資料
    Delete Series     ${Series.Name}
8-25-02
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[系列課程]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[系列課程]
...  /      4.點擊[新增]
...  /      5. 與基本資料的名稱輸入測試一，全休金額輸入$1000 ，團報金額輸入$900 ， 團報人數輸入10人
...  /      6. 按下取消
...  /      Expected Result: 顯示相關頁面
    [Tags]    7025 持續進修管理-系列課程新增-取消
    Series Maintain
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Click And Enabled    ${Button.Add}
    Wait And Select Frame    ${IFrameId}
    Input Series Data    ${Series}
    Click And Enabled    ${Button.Cancel}
    Location Should Be    https://test.roccpa.org.tw/TACCTG/event/series













