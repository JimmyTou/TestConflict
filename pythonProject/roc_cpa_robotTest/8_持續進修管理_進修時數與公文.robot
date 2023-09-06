*** Settings ***
Documentation   持續進修自動測試腳本(8-26-01~8-27-04)
...             測試完後自動刪除測試中新增之資料，以利重複測試

Resource    Resource/8_持續進修管理_共用關鍵字.resource

Suite Setup    Setup
Test Teardown    Unselect Frame
*** Variables ***
&{Document}     Year=109  Name=testing
...             DocumentSatisfiedHours=${EXECDIR}\\roc_cpa_robotTest\\FileForTesting\\testing.pdf
...             DocumentUnsatisfiedHours=${EXECDIR}\\roc_cpa_robotTest\\FileForTesting\\testing.pdf
*** Keywords ***

Setup
    Open Page
    Login   ${Employee}
Training Hours Searching
    Click And Enabled    //div[@id="navbar"]//li[contains(.,"課程活動報名管理")]
    Click And Visible    //a[text()="進修時數查詢"]
    Wait And Select Frame    ${IFrameId}
Document Maintain
    Click And Enabled    //div[@id="navbar"]//li[contains(.,"課程活動報名管理")]
    Click And Visible    //a[text()="公文維護"]
    Wait And Select Frame    ${IFrameId}
Create Document
    [Documentation]     新增公文
    [Arguments]    ${doucment}
    Document Maintain
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Click And Enabled    ${Button.Add}
    Wait And Select Frame    ${IFrameId}
    Wait And Input    //input[@id="year"]   ${document.Year}
    Choose File    //label[@title="時數滿足公文"]/../../..//input[@type="file"]   ${document.DocumentSatisfiedHours}
    Choose File    //label[@title="時數不滿足公文"]/../../..//input[@type="file"]   ${document.DocumentUnsatisfiedHours}
    Sleep    1
    Scroll In IFrame    300
    Click And Enabled    //span[text()="保 存"]/..
Delete Document
    [Documentation]    刪除此名稱之公文
    [Arguments]    ${documentName}
    Document Maintain
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Scroll In IFrame    300
    Click And Enabled    //tbody//tr[contains(.,"${documentName}")]${Button.Delete}
    Sleep    1
    Click And Visible    ${Button.Confirm}
    Sleep    1
*** Test Cases ***

8-26-01
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[進修時數查詢]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[進修時數查詢]
...  /      4.顯示清單列表資料
...  /      Expected Result: 顯示相關頁面
    [Tags]    7026 進修時數查詢-列表
    Training Hours Searching
    Wait Until Page Contains Element    //tbody/tr/td[1]
    Page Should Contain    年度會計師持續進修時數查詢
8-26-02
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[進修時數查詢]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[進修時數查詢]
...  /      4.查詢其它年度
...  /      Expected Result: 顯示相關頁面
    [Tags]    7026 進修時數查詢-列表-查詢某年度
    Training Hours Searching
    Wait Until Page Contains Element    //tbody/tr/td[1]
    Search By Keyword    111
    Sleep    1
    Element Should Contain    //div[contains(.,"年度會計師持續進修時數查詢")]    111
#需使用excellibrary
8-26-03
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[進修時數查詢]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[進修時數查詢]
...  /      4.查詢其它年度
...  /      5.匯出
...  /      Expected Result: 取得匯出檔, 內容比對查詢頁面需一致
    [Tags]    7026 進修時數查詢-列表-查詢某年度-匯出
    Training Hours Searching
    Wait Until Page Contains Element    //tbody/tr/td[1]
    Search By Keyword    111
    Sleep    1
    Click And Enabled    //span[text()="匯出"]/..

8-27-01
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[公文維護]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[公文維護]
...  /      4.清單列表
...  /      Expected Result: 顯示相關頁面
    [Tags]    7027 進修時數登記表列印套用公文維護-清單
    Document Maintain
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Page Should Contain    公文維護
8-27-02
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[公文維護]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[公文維護]
...  /      4.清單列表
...  /      5.點擊[新增]
...  /      6.年度輸111年
...  /      7.時數滿足公文,選擇檔案上傳
...  /      8.時數不滿足公文 , 選擇檔案上傳
...  /      9.按下存檔出現提示訊息按下確認
...  /      Expected Result: 顯示相關頁面
    [Tags]    7027 進修時數登記表列印套用公文維護-新增
    Create Document    ${Document}
    Sleep    1
    Document Maintain
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Page Should Contain    ${Document.Name}
    #刪除新增資料
    Delete Document    ${Document.Name}
8-27-03
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[公文維護]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[公文維護]
...  /      4.清單列表
...  /      5.點擊[新增]
...  /      6.年度輸111年
...  /      7.時數滿足公文,選擇檔案上傳
...  /      8.時數不滿足公文 , 選擇檔案上傳
...  /      9.按下存檔
...  /      10.應出現錯誤訊息 此年度已重覆
...  /      Expected Result: 顯示相關頁面
    [Tags]    7027 進修時數登記表列印套用公文維護-新增(新增已存在年度)
    Create Document    ${Document}
    Wait And Select Frame    ${IFrameId}
    Create Document    ${Document}
    Sleep    1
    Wait Until Page Contains    新增失敗
    Page Should Contain    重複新增
    Delete Document    ${Document.Name}
8-27-04
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[公文維護]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[公文維護]
...  /      4.清單列表
...  /      5.點擊[刪除]
...  /      6.出現訊息後 按下[確定]
...  /      Expected Result: 顯示相關頁面
    [Tags]    7027 進修時數登記表列印套用公文維護-刪除
    #新增測試資料
    Create Document    ${Document}
    Delete Document    ${Document.Name}
    Document Maintain
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Sleep    1
    Scroll In IFrame    500
    Page Should Not Contain    ${Document.Year}











