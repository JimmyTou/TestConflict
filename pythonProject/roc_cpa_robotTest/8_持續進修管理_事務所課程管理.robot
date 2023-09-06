*** Settings ***
Documentation   持續進修自動測試腳本(8-28-01~8-28-06)
...             測試前請事先準備好測試用檔案
...             一個隨意pdf檔路徑填入參數${WrongFile}
...             一個格式正確之excel檔路徑填入參數${ImportedFile}
...             一個身分證字號錯誤之excel檔路徑填入參數${FileForMemberNotExist}
...             或使用專案中FileForTesting資料夾中範例檔案"全聯會課程與學分匯入測試.xlsx"，使用前請正確修改參數
...             檔案使用過一次後須更改${ImportedFile}檔案中活動名稱，以免測試名稱重複方可再次測試

Resource    Resource/8_持續進修管理_共用關鍵字.resource

Suite Setup    Setup
Test Setup    Activities And Course Maintain
Test Teardown    Unselect Frame
*** Variables ***
${WrongFile}        ${EXECDIR}\\roc_cpa_robotTest\\FileForTesting\\testing.pdf
${DownloadedFile}   C:\\Users\\User\\Downloads\\全聯會課程與學分匯入範例.xlsx
${ImportedFile}     ${EXECDIR}\\roc_cpa_robotTest\\FileForTesting\\全聯會課程與學分匯入測試.xlsx
${FileForMemberNotExist}     ${EXECDIR}\\roc_cpa_robotTest\\FileForTesting\\全聯會課程與學分匯入測試 - 會員不存在.xlsx
*** Keywords ***
Setup
    Open Page
    Login   ${Employee}
Activities And Course Maintain
    Click And Enabled    //div[@id="navbar"]//li[contains(.,"課程活動報名管理")]
    Click And Visible    //a[text()="活動與課程管理"]
    Wait And Select Frame    ${IFrameId}
    
*** Test Cases ***
8-28-01
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[活動與課程管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[活動與課程管理]
...  /      4.清單列表
...  /      Expected Result: 顯示相關頁面
    [Tags]    7028 事務所課程管理-清單
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Page Should Contain    課程清單
8-28-02
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[活動與課程管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[活動與課程管理]
...  /      4.點擊[下載]範例文件
...  /      Expected Result: 顯示相關頁面
    [Tags]    7028 事務所課程管理-匯入課程與學分-下載範例excel文件
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Click And Enabled    ${Button.Import}
    Click And Enabled    //a[text()="下載範例檔案"]
    Sleep    5
    File Should Exist    ${DownloadedFile}
    Remove File    ${DownloadedFile}
    Close Browser
    Setup
8-28-03
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[活動與課程管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[活動與課程管理]
...  /      4.點擊[匯入]
...  /      5.上傳課程與學分EXCEL檔案
...  /      6.畫面出現匯入成功
...  /      Expected Result: 顯示相關頁面
    [Tags]    7028 事務所課程管理-匯入課程與學分
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Click And Enabled    ${Button.Import}
    Choose File    //input[@type="file"]    ${ImportedFile}
    Click And Enabled    //Button[contains(.,"查 詢")]
    Sleep    2
    Page Should Contain    學分清單
8-28-04
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[活動與課程管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[活動與課程管理]
...  /      4.點擊[匯入]
...  /      5.上傳課程與學分PDF檔案
...  /      6.畫面出現提示訊息-檔案錯誤,按下確認後結束
...  /      Expected Result: 顯示相關頁面
    [Tags]    7028 事務所課程管理-匯入課程與學分-異常檔案
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Click And Enabled    ${Button.Import}
    Choose File    //input[@type="file"]    ${WrongFile}
    Wait Until Page Contains    檔案錯誤
    Page Should Contain    請使用正確檔案格式!
8-28-05
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[活動與課程管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[活動與課程管理]
...  /      4.點擊[匯入]
...  /      5.上傳課程與學分PDF檔案
...  /      6.畫面出現提示訊息-檔案錯誤,按下確認後結束
...  /      Expected Result: 顯示相關頁面
    [Tags]    7028 事務所課程管理-匯入課程與學分-異常檔案
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Click And Enabled    ${Button.Import}
    Choose File    //input[@type="file"]    ${ImportedFile}
    Sleep    1
    Click And Enabled    //Button[contains(.,"查 詢")]
    Sleep    2
    Wait Until Page Contains    警告
    Page Should Contain    課程重複
8-28-06
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[活動與課程管理]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[活動與課程管理]
...  /      4.點擊[匯入]
...  /      5.上傳課程與學分PDF檔案
...  /      6.畫面出現提示訊息-錯誤:某會員不存在,按下確認後結束
...  /      Expected Result: 顯示相關頁面
    [Tags]    7028 事務所課程管理-匯入課程與學分-會員不存在
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Click And Enabled    ${Button.Import}
    Choose File    //input[@type="file"]    ${FileForMemberNotExist}
    Sleep    1
    Click And Enabled    //Button[contains(.,"查 詢")]
    Sleep    2
    Wait Until Page Contains    警告
    Page Should Contain    查無會計師資料











