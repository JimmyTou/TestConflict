*** Settings ***
Documentation   持續進修自動測試腳本(8-14-01~8-15-04)
...             測試前請先改變&{Lecturer.Name}參數，以確保測試正確執行

Resource    Resource/8_持續進修管理_共用關鍵字.resource

Suite Setup    Setup
Test Setup    Lecturer Maintain
Test Teardown    Unselect Frame
*** Variables ***
&{Lecturer}     Name=測試一    NationalId=A123456789   Email=zxc123@gmail.com
...             Tel=0412345678    Phone=0912345678    OfficeName=testing
...             OfficeTaxId=123     IsAountant=是   Gender=女
*** Keywords ***

Setup
    Open Page
    Login   ${Employee}
Lecturer Maintain
    Click And Enabled    //div[@id="navbar"]//li[contains(.,"課程活動報名管理")]
    Click And Visible    //a[text()="講師管理"]
    Wait And Select Frame    ${IFrameId}
Input Lecturer Data
    [Documentation]    填上講師資料
    [Arguments]    ${lecturer}
    Wait Until Page Contains Element    //form[@id="basic"]
    Input Text    //input[@id="basic_name"]     ${lecturer.Name}
    Input Text    //input[@id="basic_national_id"]      ${lecturer.NationalId}
    Input Text    //input[@id="basic_email"]    ${lecturer.Email}
    Input Text    //input[@id="basic_tel"]      ${lecturer.Tel}
    Input Text    //input[@id="basic_phone"]    ${lecturer.Phone}
    Input Text    //input[@id="basic_office_name"]      ${lecturer.OfficeName}
    Input Text    //input[@id="basic_office_tax_id"]    ${lecturer.OfficeTaxId}
    Scroll In IFrame    500
    Click Element    //span[text()="${lecturer.IsAountant}"]/..
    Click Element    //span[text()="${lecturer.Gender}"]/..
*** Test Cases ***

8-14-01
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[講師管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[講師管理]
...  /      4.此時顯示講師清單
...  /      Expected Result: 顯示相關頁面
    [Tags]    7014 持續進修管理-講師列表
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Page Should Contain    講師清單
8-14-02
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[講師管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[講師管理]
...  /      4.此時顯示講師清單
...  /      5.於查詢關鍵字輸入-無
...  /      6.應查無資料
...  /      Expected Result: 顯示相關頁面
    [Tags]    7014 持續進修管理-講師列表-查詢
    Search By Keyword    無
    Wait Until Page Contains Element    //tbody/tr/td
    Sleep    1
    Page Should Contain    無此資料
8-14-03
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[講師管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[講師管理]
...  /      4.此時顯示講師清單
...  /      5.於查詢關鍵字輸入-陳
...  /      6.所查詢的清單應與姓氏"陳"有關聯
...  /      Expected Result: 顯示相關頁面
    [Tags]    7014 持續進修管理-講師列表-查詢
    Search By Keyword   張
    Sleep    1
    Wait Until Page Contains Element    //tbody/tr/td[2]
    @{items}    Get Webelements    //tbody/tr/td[2]
    FOR    ${item}  IN  @{items}
        Element Should Contain    ${item}   張
    END
8-14-04
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[講師管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[講師管理]
...  /      4.點擊[清除]
...  /      5.此時顯示所有講師清單
...  /      Expected Result: 顯示相關頁面
    [Tags]    7014 持續進修管理-講師列表-清除
    Search By Keyword   張
    Click And Enabled    ${Button.Clear}
    Sleep    1
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Element Should Not Contain    //tbody/tr/td[2]  張
8-14-05
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[講師管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[講師管理]
...  /      4.點擊[查看]
...  /      5.此時顯示講師內容詳細資料
...  /      Expected Result: 顯示相關頁面
    [Tags]    7014 持續進修管理-講師列表-講師詳細資料
    Click And Enabled    ${Button.Check}
    Wait And Select Frame    ${IFrameId}
    Wait Until Page Contains Element    //form[@id="basic"]
    Page Should Contain    基本資料
8-14-06
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[講師管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[講師管理]
...  /      4.點擊[查看]
...  /      5.此時顯示所有講師內容詳細資料
...  /      6.點擊[取消]
...  /      7.回到上一頁
...  /      Expected Result: 顯示相關頁面
    [Tags]    7014 持續進修管理-講師列表-講師詳細資料-取消
    Click And Enabled    ${Button.Check}
    Wait And Select Frame    ${IFrameId}
    Wait Until Page Contains Element    //form[@id="basic"]
    Scroll In IFrame    500
    Click And Enabled    ${Button.Cancel}
    Location Should Be    https://test.roccpa.org.tw/TACCTG/event/lecturer

8-15-01
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[講師管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[講師管理]
...  /      4.點擊[新增]
...  /      5.此時顯示新增講師基本資料頁
...  /      6.點擊[取消]
...  /      7.回到上一頁
...  /      Expected Result: 顯示相關頁面
    [Tags]    7015 持續進修管理-講師管理--講師新增--取消
    Click And Enabled    ${Button.Add}
    Wait And Select Frame    ${IFrameId}
    Wait Until Page Contains Element    //form[@id="basic"]
    Scroll In IFrame    500
    Click And Enabled    ${Button.Cancel}
    Location Should Be    https://test.roccpa.org.tw/TACCTG/event/lecturer
8-15-02
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[講師管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[講師管理]
...  /      4.點擊[新增]
...  /      5.此時顯示新增講師基本資料頁
...  /      6.輸入所有畫面上有*必填的欄位
...  /      7.點擊[保存]
...  /      Expected Result: 顯示相關頁面
    [Tags]    7015 持續進修管理-講師管理--講師新增
    Click And Enabled    ${Button.Add}
    Wait And Select Frame    ${IFrameId}
    Input Lecturer Data     ${Lecturer}
    Click And Enabled    ${Button.Save}
    Sleep    1
    Click And Visible    ${Button.Confirm}
    Sleep    1
    Lecturer Maintain
    Search By Keyword   ${Lecturer.Name}
    Wait Until Page Contains Element    //tbody/tr/td[4]
    Page Should Contain    ${Lecturer.Name}
8-15-03
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[講師管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[講師管理]
...  /      4.點擊[新增]
...  /      5.此時顯示新增講師基本資料頁
...  /      6.身分證號輸入"A987654321"
...  /      7.點擊[保存]
...  /      8.應跳出訊息[身分證號有誤]
...  /      Expected Result: 顯示相關頁面
    [Tags]    7015 持續進修管理-講師管理--講師新增--異常欄位--身份證號
    Click And Enabled    ${Button.Add}
    Wait And Select Frame    ${IFrameId}
    Wait Until Page Contains Element    //form[@id="basic"]
    Input Text    //input[@id="basic_national_id"]      A987654321
    Page Should Contain    請輸入正確的身分證字號!
8-15-04
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[講師管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[講師管理]
...  /      4.點擊[查看]
...  /      5.此時顯示修改講師基本資料頁, 且帶出資料內容
...  /      6.修改單位名稱為, "測資單位名稱"
...  /      7.點擊[保存]
...  /      8.跳出[成功]提示訊息>點擊[確認]
...  /      Expected Result: 顯示相關頁面
    [Tags]    7015 持續進修管理-講師管理--講師修改
    Search By Keyword   ${Lecturer.Name}
    Sleep    1
    Click And Visible    ${Button.Check}
    Wait And Select Frame    ${IFrameId}
    Wait Until Page Contains Element    //form[@id="basic"]
    Sleep    1
    Clear And Input Text    //input[@id="basic_office_name"]    ChangingTest
    Scroll In IFrame    500
    Click And Enabled    ${Button.Save}
    Sleep    1
    Click And Visible    ${Button.Confirm}
    Sleep    1
    Lecturer Maintain
    Search By Keyword   ${Lecturer.Name}
    Wait Until Page Contains Element    //tbody/tr/td[4]
    Sleep    1
    Page Should Contain    ChangingTest