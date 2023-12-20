*** Settings ***
Documentation  持續進修自動測試腳本(8-16-01~8-17-04)
...             測試前請先改變&{Committee}參數，以確保測試正確執行

Resource    Resource/8_持續進修管理_共用關鍵字.resource

Suite Setup    Setup
Test Setup    Committee Maintain
Test Teardown    Unselect Frame
*** Variables ***
&{Committee}     Name=測試一    NationalId=A123456789   Email=zxc123@gmail.com
...             Tel=0412345678    Phone=0912345678    OfficeName=testing
...             OfficeTaxId=123     Session=123     StartDate=2023-01-01
...             EndDate=2023-12-31  Gender=女
${CommitteeForSearching}    張小華
*** Keywords ***

Setup
    Open Page
    Login   ${Employee}
Committee Maintain
    Click And Enabled    //div[@id="navbar"]//li[contains(.,"課程活動報名管理")]
    Click And Visible    //a[text()="委員管理"]
    Wait And Select Frame    ${IFrameId}
Input Committee Data
    [Documentation]    填上講師資料
    [Arguments]    ${committee}
    Wait Until Page Contains Element    //form[@id="basic"]
    Input Text    //input[@id="basic_name"]     ${Committee.Name}
    Input Text    //input[@id="basic_national_id"]      ${Committee.NationalId}
    Input Text    //input[@id="basic_email"]    ${Committee.Email}
    Input Text    //input[@id="basic_tel"]      ${Committee.Tel}
    Input Text    //input[@id="basic_phone"]    ${Committee.Phone}
    Input Text    //input[@id="basic_office_name"]      ${Committee.OfficeName}
    Input Text    //input[@id="basic_office_tax_id"]    ${Committee.OfficeTaxId}
    Input Text    //input[@id="basic_session"]    ${Committee.Session}
    Scroll In IFrame    500
    Choose Start And End Date    //input[@id="basic_duration"]  ${Committee.StartDate}    ${Committee.EndDate}
    Click Element    //span[text()="${Committee.Gender}"]/..
*** Test Cases ***

8-16-01
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[委員管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[委員管理]
...  /      4.此時顯示委員清單
...  /      Expected Result: 顯示相關頁面
    [Tags]    7016 持續進修管理-委員列表
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Page Should Contain    委員清單
8-16-02
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[委員管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[委員管理]
...  /      4.此時顯示委員清單
...  /      5.於查詢關鍵字輸入-無
...  /      6.應查無資料
...  /      Expected Result: 顯示相關頁面
    [Tags]    7016 持續進修管理-委員列表-查詢
    Search By Keyword   無
    Wait Until Page Contains Element    //tbody/tr/td
    Sleep    1
    Page Should Contain    無此資料
8-16-03
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[委員管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[委員管理]
...  /      4.此時顯示委員清單
...  /      5.於查詢關鍵字輸入-陳
...  /      6.所查詢的清單應與姓氏"陳"有關聯
...  /      Expected Result: 顯示相關頁面
    [Tags]    7016 持續進修管理-委員列表-查詢
    Search By Keyword   ${CommitteeForSearching}
    Sleep    1
    Wait Until Page Contains Element    //tbody/tr/td[2]
    @{items}    Get Webelements    //tbody/tr/td[2]
    FOR    ${item}  IN  @{items}
        Element Should Contain    ${item}   ${CommitteeForSearching}
    END
8-16-04
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[委員管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[委員管理]
...  /      4.點擊[清除]
...  /      5.此時顯示所有委員清單
...  /      Expected Result: 顯示相關頁面
    [Tags]    7016 持續進修管理-委員列表-清除
    Search By Keyword   ${CommitteeForSearching}
    Click And Enabled    ${Button.Clear}
    Sleep    1
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Element Should Not Contain    //tbody/tr/td[2]  ${CommitteeForSearching}
8-16-05
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[委員管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[委員管理]
...  /      4.此時顯示所有委員清單
...  /      5.點擊某一委員列上的[停用]鈕
...  /      6.跳出[確認]提示訊息>點擊[確認]
...  /      7.畫面重新整理後該委員變為[停用]狀態
...  /      Expected Result: 顯示相關頁面
    [Tags]    7016 持續進修管理-委員列表-停用
    Search By Keyword   ${CommitteeForSearching}
    Sleep    1
    Click And Enabled    //span[text()="停用"]/..
    Click And Visible    ${Button.Confirm}
    Sleep    1
    Wait And Select Frame    ${IFrameId}
    Search By Keyword   ${CommitteeForSearching}
    Sleep    1
    Wait Until Page Contains Element    //tbody/tr/td[6]
    Element Should Contain    //tbody/tr/td[6]  停用
8-16-06
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[委員管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[委員管理]
...  /      4.此時顯示所有委員清單
...  /      5.點擊某一委員列上的[停用]鈕
...  /      6.跳出[確認]提示訊息>點擊[確認]
...  /      7.畫面重新整理後該委員變為[啟用]狀態
...  /      Expected Result: 顯示相關頁面
    [Tags]    7016 持續進修管理-委員列表-啟用
    Search By Keyword   ${CommitteeForSearching}
    Sleep    1
    Click And Enabled    //span[text()="啟用"]/..
    Click And Visible    ${Button.Confirm}
    Sleep    1
    Wait And Select Frame    ${IFrameId}
    Search By Keyword   ${CommitteeForSearching}
    Sleep    1
    Wait Until Page Contains Element    //tbody/tr/td[6]
    Element Should Contain    //tbody/tr/td[6]  啟用
8-16-07
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[委員管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[委員管理]
...  /      4.點擊[編輯]
...  /      5.此時顯示委員內容詳細資料
...  /      Expected Result: 顯示相關頁面
    [Tags]    7016 持續進修管理-委員列表-委員詳細資料
    Click And Enabled    ${Button.Edit}
    Wait And Select Frame    ${IFrameId}
    Wait Until Page Contains Element    //form[@id="basic"]
    Page Should Contain    基本資料
8-16-08
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[委員管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[委員管理]
...  /      4.點擊[編輯]
...  /      5.此時顯示所有委員內容詳細資料
...  /      6.點擊[取消]
...  /      7.回到上一頁
...  /      Expected Result: 顯示相關頁面
    [Tags]    7014 持續進修管理-委員列表-委員詳細資料-取消
    Click And Enabled    ${Button.Edit}
    Wait And Select Frame    ${IFrameId}
    Wait Until Page Contains Element    //form[@id="basic"]
    Scroll In IFrame    500
    Click And Enabled    ${Button.Cancel}
    Location Should Be    https://test.roccpa.org.tw/TACCTG/event/committee

8-17-01
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[委員管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[委員管理]
...  /      4.點擊[新增]
...  /      5.此時顯示新增委員基本資料頁
...  /      6.點擊[取消]
...  /      7.回到上一頁
...  /      Expected Result: 顯示相關頁面
    [Tags]    7015 持續進修管理-委員管理--委員新增--取消
    Click And Enabled    ${Button.Add}
    Wait And Select Frame    ${IFrameId}
    Wait Until Page Contains Element    //form[@id="basic"]
    Scroll In IFrame    500
    Click And Enabled    ${Button.Cancel}
    Location Should Be    https://test.roccpa.org.tw/TACCTG/event/committee
8-17-02
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[委員管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[委員管理]
...  /      4.點擊[新增]
...  /      5.此時顯示新增委員基本資料頁
...  /      6.輸入所有畫面上有*必填的欄位
...  /      7.點擊[保存]
...  /      Expected Result: 顯示相關頁面
    [Tags]    7015 持續進修管理-委員管理--委員新增
    Click And Enabled    ${Button.Add}
    Wait And Select Frame    ${IFrameId}
    Input Committee Data    ${Committee}
    Click And Enabled    ${Button.Save}
    Sleep    1
    Click And Visible    ${Button.Confirm}
    Sleep    1
    Wait Until Page Contains Element    //div[@id="navbar"]//li[contains(.,"課程活動報名管理")]
    Committee Maintain
    Search By Keyword   ${Committee.Name}
    Page Should Contain    ${Committee.Name}
8-17-03
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[委員管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[委員管理]
...  /      4.點擊[新增]
...  /      5.此時顯示新增委員基本資料頁
...  /      6.身分證號輸入"A987654321"
...  /      7.點擊[保存]
...  /      8.應跳出訊息[身分證號有誤]
...  /      Expected Result: 顯示相關頁面
    [Tags]    7015 持續進修管理-委員管理--委員新增--異常欄位--身份證號
    Click And Enabled    ${Button.Add}
    Wait And Select Frame    ${IFrameId}
    Wait Until Page Contains Element    //form[@id="basic"]
    Input Text    //input[@id="basic_national_id"]      A987654321
    Page Should Contain    請輸入正確的身分證字號!
8-17-04
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[委員管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[委員管理]
...  /      4.點擊[編輯]
...  /      5.此時顯示修改委員基本資料頁, 且帶出資料內容
...  /      6.修改單位名稱為, "測資單位名稱"
...  /      7.點擊[保存]
...  /      8.跳出[成功]提示訊息>點擊[確認]
...  /      Expected Result: 顯示相關頁面
    [Tags]    7015 持續進修管理-委員管理--委員修改
    Search By Keyword   ${Committee.Name}
    Sleep    1
    Click And Visible    ${Button.Edit}
    Wait And Select Frame    ${IFrameId}
    Wait Until Page Contains Element    //form[@id="basic"]
    Clear And Input Text    //input[@id="basic_office_name"]      ChangingTest
    Scroll In IFrame    500
    Click And Enabled    ${Button.Save}
    Sleep    1
    Click And Visible    ${Button.Confirm}
    Sleep    1
    Committee Maintain
    Search By Keyword   ${Committee.Name}
    Wait Until Page Contains Element    //tbody/tr/td[4]
    Page Should Contain    ChangingTest
