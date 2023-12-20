*** Settings ***
Documentation  持續進修自動測試腳本(8-07-01~8-09-01)
...            執行此測試檔前，建議先執行課程活動新增測試檔，以事先新增測試資料
...            為方便測試先進行8-08-01~8-09-01測試案例
...            在進行8-07-01~8-07-03測試案例
...             測試前請先準備一資料正確之測試檔，檔案內之活動名稱為參數${Event.Name}之值，並將路徑填入參數${ImportedFile}
...             和一身份證字號錯誤之測試檔，並將路徑填入參數${FileForMemberNotExist}
...             或使用專案中FileForTesting資料夾中範例檔案，使用前請將"全聯會報名匯入範例.xlsx"中的活動名稱設定為${Event.Name}

Resource    Resource/8_持續進修管理_共用關鍵字.resource

Suite Setup    Setup
Test Setup     Activities And Course Maintain
Test Teardown    Unselect Frame
*** Variables ***
&{Member1}   Name=陳小美    NationalId=A234567890   WrongId=A1001001001
&{Member2}   Name=李大星    NationalId=B123456789
&{Member3}   Name=張小華    NationalId=C123456789
&{Guest}    Name=王小美    NationalId=A121212121
${ImportedFile}     ${EXECDIR}\\roc_cpa_robotTest\\FileForTesting\\全聯會報名匯入範例.xlsx
${FileForMemberNotExist}    ${EXECDIR}\\roc_cpa_robotTest\\FileForTesting\\全聯會報名匯入範例-無此人員.xlsx
*** Keywords ***

Setup
    Open Page
    Login   ${Employee}
Activities And Course Maintain
    Click And Enabled    //div[@id="navbar"]//li[contains(.,"課程活動報名管理")]
    Click And Visible    //a[text()="活動與課程管理"]
    Wait And Select Frame    ${IFrameId}
Sign Up
    [Documentation]    新增報名資料
    [Arguments]    ${Name}  ${NationalId}
    Click And Visible    //span[text()="新增報名"]/..
    Wait And Select Frame    ${IFrameId}
    Click And Visible    //span[text()="我要報名"]/..
    Clear And Input Text    //input[@id="national_id"]    ${NationalId}
    Input Text    //input[@id="name"]    ${Name}
    Input Text    //input[@id="phone"]    0912345678
    Scroll In IFrame    500
    Click Element    //span[text()="送出報名"]/..
*** Test Cases ***

8-08-01
    [Documentation]     會務人員身份進入[持續進修管理]後台>順利新增課程/活動清單列表
...  /      1.進入[持續進修管理]後台; 顯示所有課程/活動清單列表
...  /      2.點擊活動名稱欄位底下的清單連結
...  /      例如:法規法務委員會-洗錢防制法111年課程
...  /      3.此時顯示報名用戶清單
...  /      4.點擊[新增報名]
...  /      5.於畫面上輸入報名人員的基本資料且確認後
...  /      6.畫面重整並顯示於清單中
...  /      Expected Result: 顯示相關頁面
    [Tags]    7008 持續進修管理-課程活動名單-新增報名
    Statistical Analysis For    ${Event.Name}
    Sign Up    ${Member1.Name}   ${Member1.NationalId}
    Activities And Course Maintain
    Statistical Analysis For    ${Event.Name}
    Scroll In IFrame    300
    Wait Until Element Is Visible   //tbody/tr/td[2]
    Sleep    2
    Page Should Contain Element    //tbody/tr[contains(.,"${Member1.Name}") and contains(.,"未付款")]
8-08-02
    [Documentation]     會務人員身份進入[持續進修管理]後台>順利新增課程/活動清單列表
...  /      1.進入[持續進修管理]後台; 顯示所有課程/活動清單列表
...  /      2.點擊活動名稱欄位底下的清單連結
...  /      例如:法規法務委員會-洗錢防制法111年課程
...  /      3.此時顯示報名用戶清單
...  /      4.點擊[新增報名]
...  /      5.於畫面上輸入(錯誤的)報名人員的基本資料
...  /      6.出現錯誤提示
...  /      Expected Result: 顯示相關頁面>錯誤提示相關錯誤訊息
    [Tags]    7008 持續進修管理-課程活動名單-新增報名-異常(錯誤的身分證號)
    Statistical Analysis For    ${Event.Name}
    Sign Up    ${Member1.Name}   ${Member1.WrongId}
    Wait Until Element Is Visible   //span[text()="提示"]
    Page Should Contain    身分證字號格式不正確
8-08-03
    [Documentation]     會務人員身份進入[持續進修管理]後台>順利新增課程/活動清單列表
...  /      1.進入[持續進修管理]後台; 顯示所有課程/活動清單列表
...  /      2.點擊活動名稱欄位底下的清單連結
...  /      例如:法規法務委員會-洗錢防制法111年課程
...  /      3.此時顯示報名用戶清單
...  /      4.點擊[新增報名]
...  /      5.於畫面上輸入(該事務所無此人員)報名人員的基本資料
...  /      6.出現錯誤提示
...  /      Expected Result: 顯示相關頁面>錯誤提示相關錯誤訊息
    [Tags]    7008 持續進修管理-課程活動名單-異常(該事務所無此人員),i.e.活動不允許訪客報名
    Statistical Analysis For    ${Event.Name}
    Sign Up    ${Guest.Name}   ${Guest.NationalId}
    Sleep    1
    Wait Until Element Is Visible   //span[text()="提示"]
    Page Should Contain    本活動不允許訪客報名
8-08-04
    [Documentation]     會務人員身份進入[持續進修管理]後台>順利新增課程/活動清單列表
...  /      1.進入[持續進修管理]後台; 顯示所有課程/活動清單列表
...  /      2.點擊活動名稱欄位底下的清單連結
...  /      例如:法規法務委員會-洗錢防制法111年課程
...  /      3.此時顯示報名用戶清單
...  /      4.點擊[匯入名單]
...  /      5.於畫面上提示上傳檔案並送出
...  /      6.提示訊息[匯入成功]
...  /      Expected Result: 顯示相關頁面
    [Tags]    7008 持續進修管理-課程活動名單-新增報名-匯入
    Statistical Analysis For    ${Event.Name}
    Click And Visible    //button[contains(.,"匯入名單")]
    Choose File     //div[@id=":r0:"]/../..//input[@type="file"]    ${ImportedFile}
    Scroll In IFrame    100
    Click And Enabled    //span[text()="匯入"]
    Sleep    2
    Page Should Contain    匯入成功
    Activities And Course Maintain
    Statistical Analysis For    ${Event.Name}
    Scroll In IFrame    300
    Page Should Contain Element    //tbody/tr[contains(.,"${Member2.Name}") and contains(.,"未付款")]

8-08-05
    [Documentation]     會務人員身份進入[持續進修管理]後台>順利新增課程/活動清單列表
...  /      1.進入[持續進修管理]後台; 顯示所有課程/活動清單列表
...  /      2.點擊活動名稱欄位底下的清單連結
...  /      例如:法規法務委員會-洗錢防制法111年課程
...  /      3.此時顯示報名用戶清單
...  /      4.點擊[匯入名單]
...  /      5.於畫面上提示上傳檔案並送出
...  /      6.資料中有一筆資料的事務所名稱,身分證對不起來
...  /      7.提示訊息[匯入失敗]
...  /      Expected Result: 顯示相關頁面>錯誤提示相關錯誤訊息>第二筆該事務所名稱, 身分證字號 無此人員
    [Tags]    7008 持續進修管理-課程活動名單-新增報名-匯入異常
    Statistical Analysis For    ${Event.Name}
    Click And Visible    //button[contains(.,"匯入名單")]
    Sleep    1
    Choose File     //div[@id=":r0:"]/../..//input[@type="file"]    ${FileForMemberNotExist}
    Sleep    1
    Scroll In IFrame    100
    Click And Enabled    //span[text()="匯入"]
    Wait Until Page Contains    錯誤
    Sleep    1
    Page Should Contain    MemberNotFound

8-09-01
    [Documentation]     會務人員身份進入[持續進修管理]後台>順利新增課程/活動清單列表
...  /      1.進入[持續進修管理]後台; 顯示所有課程/活動清單列表
...  /      2.點擊活動名稱欄位底下的清單連結
...  /      例如:法規法務委員會-洗錢防制法111年課程
...  /      3.此時顯示報名用戶清單
...  /      4.查詢到該用戶
...  /      5.點擊該用戶右邊的功能項[繳款]按鈕
...  /      6.待於提示訊息顯示後點擊[確認]後
...  /      7.畫面重整後該用戶報名狀態, 已報名
...  /      Expected Result: 顯示相關頁面
    [Tags]    7009 持續進修管理-手動收款
    Statistical Analysis For    ${Event.Name}
    Click And Enabled    //tbody/tr[contains(.,"${Member1.Name}")]//button[contains(.,"繳款")]
    Sleep    1
    Click And Enabled    ${Button.Confirm}
    Unselect Frame
    Activities And Course Maintain
    Statistical Analysis For    ${Event.Name}
    Page Should Contain Element    //tbody/tr[contains(.,"${Member1.Name}") and contains(.,"報名成功")]

8-07-01
    [Documentation]     會務人員身份進入[持續進修管理]後台>順利新增課程/活動清單列表
...  /      1.進入[持續進修管理]後台; 顯示所有課程/活動清單列表
...  /      2.點擊活動名稱欄位底下的清單連結
...  /      例如:法規法務委員會-洗錢防制法111年課程
...  /      3.點擊上方頁籤[統計分析]
...  /      4.點選按鈕[報到模式]
...  /      Expected Result: 進入報到模式>畫面上僅顯示一輸入框
    [Tags]    7007 持續進修管理-課程活動報到
    Statistical Analysis For    ${Event.Name}
    Click And Enabled    //span[text()="報到模式"]/..
    Wait Until Element Is Visible    //div[text()="報到模式"]/../..
    Page Should Contain Element    //div[text()="報到模式"]

8-07-02
    [Documentation]     進入[持續進修管理]後台>順利新增課程/活動清單列表
...  /      1.進入[持續進修管理]後台; 顯示所有課程/活動清單列表
...  /      2.點擊活動名稱欄位底下的清單連結
...  /      例如:法規法務委員會-洗錢防制法111年課程
...  /      3.此時顯示報名用戶清單
...  /      4.點擊上方頁籤[統計分析]
...  /      5.點選按鈕[報到模式]
...  /      6.掃描此活動[報到QRCode]以報到
...  /      7.畫面立即顯示該會員之[印鑑卡]
...  /      8.會務人員比對照片確認其身份
...  /      9.若正確則按下[報到]
...  /      10.若不正確則按下[非本人]
...  /      Expected Result: 進入報到模式>畫面上僅顯示一輸入框
    [Tags]    7007 持續進修管理-課程活動報到-人員自助報到
    Statistical Analysis For    ${Event.Name}
    Sleep    1
    Click And Enabled    //tbody/tr[contains(.,"${Member2.Name}")]//button[contains(.,"繳款")]
    Sleep    1
    Click And Enabled    ${Button.Confirm}
    Sleep    1
    Click And Enabled    //tr[contains(.,"${Member2.Name}")]${Button.Check}
    Wait And Select Frame    ${IFrameId}
    Wait Until Page Contains Element    //div/img/following-sibling::div
    ${QRCode}   Get Text    //div/img/following-sibling::div
    Go Back
    Wait And Select Frame    ${IFrameId}
    Click And Visible    //span[text()="統計分析"]/..
    Sleep    1
    Scroll In IFrame    300
    Click And Enabled    //span[text()="報到模式"]/..
    Wait Until Element Is Visible    //div[text()="報到模式"]/../..
    Wait And Input    //input[@placeholder="請輸入或掃描 QRCode"]     ${QRCode}
    Press Key    //input[@placeholder="請輸入或掃描 QRCode"]      \ue007
    Wait Until Page Contains    印鑑卡
    Click And Visible    //div[contains(.,"印鑑卡")]//button[contains(.,"報到")]
    Sleep    1
    Click And Visible    //div[contains(.,"報到模式")]//button[@aria-label="Close"]/..
    Sleep    1
    Element Should Contain    //tr[contains(.,"${Member2.Name}")]    報到成功
8-07-03
    [Documentation]     進入[持續進修管理]後台>順利新增課程/活動清單列表
...  /      1.進入[持續進修管理]後台; 顯示所有課程/活動清單列表
...  /      2.點擊活動名稱欄位底下的清單連結
...  /      例如:法規法務委員會-洗錢防制法111年課程
...  /      3.此時顯示報名用戶清單
...  /      4.查詢到該用戶
...  /      5.點擊該用戶右邊的功能項[報到]按鈕
...  /      6.確認後即成功報到
...  /      Expected Result: 報到成功>畫面保留在此用戶清單頁
    [Tags]    7007 持續進修管理-課程活動報到-會務人員協助個別報到
    Statistical Analysis For    ${Event.Name}
    Scroll In IFrame    300
    Click And Enabled    //tr[contains(.,"${Member1.Name}")]//span[text()="報到"]/..
    Click And Visible    //div[contains(.,"印鑑卡")]//button[contains(.,"報到")]
    Sleep    1
    Wait Until Element Is Visible    //tbody/tr/td[5]
    Scroll In IFrame    300
    Page Should Contain Element    //tbody/tr[contains(.,"${Member1.Name}") and contains(.,"報到成功")]
    Click Element    ${Button.Check}
    Wait And Select Frame    ${IFrameId}
    Sleep    1
    Scroll In IFrame    300
    Wait Until Element Is Visible    //div[text()="活動完成"]
    Page Should Contain    活動完成



