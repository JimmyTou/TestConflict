*** Settings ***
Documentation   持續進修自動測試腳本(8-18-01~8-19-03)
...             測試後會自動刪除測試中新增之資料，以利重複測試

Resource    Resource/8_持續進修管理_共用關鍵字.resource

Suite Setup    Setup
Test Setup    Group Maintain
Test Teardown    Unselect Frame
*** Variables ***
${GroupName}    Testing
*** Keywords ***

Setup
    Open Page
    Login   ${Employee}
Group Maintain
    Click And Enabled    //div[@id="navbar"]//li[contains(.,"課程活動報名管理")]
    Click And Visible    //a[text()="組別管理"]
    Wait And Select Frame    ${IFrameId}
Create Group
    [Arguments]    ${groupName}
    Click And Enabled    ${Button.Add}
    Wait And Select Frame    ${IFrameId}
    Wait And Input    //input[@id="basic_name"]     ${groupName}
    Click And Enabled    ${Button.Save}
    Sleep    1
    Click And Enabled    ${Button.Confirm}
    Sleep    1
Delete Group
    [Arguments]    ${groupName}
    Unselect Frame
    Group Maintain
    Search By Keyword   ${groupName}
    Sleep    1
    Click And Enabled    ${Button.Delete}
    Sleep    1
    Click And Enabled    ${Button.Confirm}
    Sleep    1
*** Test Cases ***
8-18-01
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[組別管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[組別管理]
...  /      Expected Result: 顯示相關頁面
    [Tags]    7018 持續進修管理-組別管理-列表
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Page Should Contain    組別清單
8-18-02
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[組別管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[組別管理]
...  /      4.點擊某一筆[查看]
...  /      5.進入修改頁面, 修改名稱, 於名稱後加上"1"後點[儲存]
...  /      6.跳出訊息後按下確認
...  /      Expected Result: 顯示相關頁面
    [Tags]    7018 持續進修管理-組別管理-修改
    Create Group    ${GroupName}
    Wait And Select Frame    ${IFrameId}
    Search By Keyword   ${GroupName}
    Sleep    1
    Click And Enabled    ${Button.Check}
    Wait And Select Frame    ${IFrameId}
    Clear And Input Text    //input[@id="basic_name"]     Changing${GroupName}
    Click And Enabled    ${Button.Save}
    Sleep    1
    Click And Enabled    ${Button.Confirm}
    Sleep    1
    Group Maintain
    Search By Keyword   Changing${GroupName}
    Sleep    1
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Page Should Contain    Changing${GroupName}
    Delete Group    ${GroupName}
8-18-03
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[組別管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[組別管理]
...  /      4.點擊某一筆[刪除]
...  /      5.跳出訊息後按下確認
...  /      Expected Result: 顯示相關頁面
    [Tags]    7018 持續進修管理-組別管理-刪除
    Create Group    ${GroupName}
    Delete Group    ${GroupName}
    Group Maintain
    Search By Keyword   ${GroupName}
    Sleep    1
    Wait Until Page Contains Element    //tbody/tr/td
    Page Should Contain     無此資料

8-19-01
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[組別管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[組別管理]
...  /      4.點擊[新增]
...  /      5.名稱內輸入[測試組別]
...  /      6.跳出訊息後按下[確認]
...  /      Expected Result: 顯示相關頁面
    [Tags]    7019 持續進修管理-組別管理-新增
    Create Group    ${GroupName}
    Group Maintain
    Search By Keyword   ${GroupName}
    Sleep    1
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Page Should Contain     ${GroupName}
    Delete Group    ${GroupName}
8-19-02
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[組別管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[組別管理]
...  /      4.點擊[新增]
...  /      5.名稱內輸入[測試組別2]
...  /      6.點擊[取消]
...  /      5.回到上一頁
...  /      Expected Result: 顯示相關頁面
    [Tags]    7019 持續進修管理-組別管理-新增-取消
    Click And Enabled    ${Button.Add}
    Wait And Select Frame    ${IFrameId}
    Wait And Input    //input[@id="basic_name"]     ${GroupName}2
    Click And Enabled    ${Button.Cancel}
    Location Should Be    https://test.roccpa.org.tw/TACCTG/event/group
8-19-03
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[組別管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[組別管理]
...  /      4.點擊[新增]
...  /      5.名稱內輸入[測試組別]
...  /      6.跳出訊息後按下[確認]
...  /      Expected Result: 顯示相關頁面>應彈跳出錯誤訊息, 此名稱已存在
    [Tags]    7019 持續進修管理-組別管理-新增-異常(同樣名稱)
    Create Group    ${GroupName}
    Wait And Select Frame    ${IFrameId}
    Create Group    ${GroupName}
    Wait Until Page Contains    錯誤
    Page Should Contain     組別名稱已存在
    Delete Group    ${GroupName}
