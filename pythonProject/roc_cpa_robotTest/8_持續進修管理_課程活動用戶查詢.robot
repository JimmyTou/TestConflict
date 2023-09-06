*** Settings ***
Documentation  持續進修自動測試腳本(8-04-01~8-06-05)
...            執行此測試檔前，建議先執行課程活動新增及課程活動報名報到測試檔
...            以事先新增測試資料

Resource    Resource/8_持續進修管理_共用關鍵字.resource

Suite Setup    Setup
Test Setup    Activities And Course Maintain
Test Teardown    Unselect Frame
*** Variables ***
*** Keywords ***

Setup
    Open Page
    Login   ${Admin}
Activities And Course Maintain
    Click And Enabled    //div[@id="navbar"]//li[contains(.,"課程活動報名管理")]
    Click And Visible    //a[text()="活動與課程管理"]
    Wait And Select Frame    ${IFrameId}

*** Test Cases ***
8-04-01
    [Documentation]     進入[所有課程/活動]>可以看到課程/活動列表
...  /      1.登入後
...  /      2.系統直接進入[所有課程/活動]頁面
...  /      3.使用者點選某入課程活動
...  /      4.畫面進入該課程活動的詳細內容頁面
...  /      Expected Result: 純顯示該課程內容, 不提供編輯的功能
    [Tags]    7004 持續進修管理-課程活動詳細內容
    Scroll In IFrame    300
    Click And Enabled    //span[text()="${Event.Name}"]/..
    Wait And Select Frame    ${IFrameId}
    Wait Until Element Is Visible    //input[contains(@value,"${Event.Name}")]
    Element Should Be Disabled    //input[contains(@value,"${Event.Name}")]

8-05-01
    [Documentation]     進入[所有課程/活動]>可以看到課程/活動列表>點擊[統計分析]
...  /      1.登入後
...  /      2.系統直接進入[所有課程/活動]頁面
...  /      3.使用者點選某入課程活動
...  /      4.點擊[統計分析]>畫面顯示統計分析資料
...  /      Expected Result: 畫面上應有底下欄位或功能
...  /                      1.學分資料匯出按鈕
...  /                      2.簽到簿列印按鈕
...  /                      3.學分數表格欄位
...  /                      4.學分證明按鈕
    [Tags]    7005 持續進修管理-課程活動統計分析
    Statistical Analysis For    ${Event.Name}
    Page Should Contain Element    //span[text()="匯出報表"]
    Page Should Contain Element    //span[text()="匯出名單"]
    Page Should Contain Element    //span[text()="學分證明"]
    Page Should Contain Element    //thead/tr/th/div/span[text()="學分數"]

8-06-01
    [Documentation]     進入[所有課程/活動]>可以看到課程/活動列表>點擊[統計分析]
...  /      1.登入後
...  /      2.系統直接進入[所有課程/活動]頁面
...  /      3.使用者點選某入課程活動
...  /      4.點擊[統計分析]>畫面顯示統計分析資料
...  /      5.畫面下方出現一[報名清單區塊]
...  /      6.點擊該會員編號列的功能[查看]
...  /      7.顯示該會員之課程報名紀錄
...  /      Expected Result: 顯示相關頁面
    [Tags]    7006 持續進修管理-用戶查詢-報名紀錄
    Statistical Analysis For    ${Event.Name}
    Click And Enabled    ${Button.Check}
    Wait And Select Frame    ${IFrameId}
    Wait Until Element Is Visible    //p[text()="活動狀態"]
    Page Should Contain Element    //p[text()="活動狀態"]
8-06-02
    [Documentation]     進入[所有課程/活動]>可以看到課程/活動列表>點擊[統計分析]
...  /      1.登入後
...  /      2.系統直接進入[所有課程/活動]頁面
...  /      3.使用者點選某入課程活動
...  /      4.點擊[統計分析]>畫面顯示統計分析資料
...  /      5.畫面下方出現一[報名清單區塊]
...  /      6.點擊該會員編號列的功能[查看]
...  /      7.顯示該會員之課程報名紀錄
...  /      8.點擊[列印學分證明]
...  /      Expected Result: 顯示相關頁面
    [Tags]    7006 持續進修管理-用戶查詢-報名紀錄-列印學分證明
    Statistical Analysis For    ${Event.Name}
    Click And Enabled    ${Button.Check}
    Wait And Select Frame    ${IFrameId}
    Click And Enabled    //span[text()="列印學分證明"]/..
    Sleep    5
    ${current_window}    Get Window Handles
    Switch Window    ${current_window}[1]
    Location Should Contain    https://test.roccpa.org.tw/TACCTG/event/score/certPrint
    Close Window
    Switch Window    ${current_window}[0]

8-06-03
    [Documentation]     進入[所有課程/活動]>可以看到課程/活動列表>點擊[統計分析]
...  /      1.登入後
...  /      2.系統直接進入[所有課程/活動]頁面
...  /      3.使用者點選某入課程活動
...  /      4.點擊[統計分析]>畫面顯示統計分析資料
...  /      5.選擇表格標頭[學分]欄位, 更新其排序
...  /      6.選擇為0學分的報名人員
...  /      7.點擊該會員編號列的功能[查看]
...  /      8.顯示該會員之課程報名紀錄
...  /      9.無按鈕[列印學分證明]
...  /      Expected Result: 顯示相關頁面
    [Tags]    7006 持續進修管理-用戶查詢-報名紀錄-列印學分證明-例外:0學分
    Statistical Analysis For    ${Event.Name}
    Click And Enabled    //td[text()="0"]/..${Button.Check}
    Wait And Select Frame    ${IFrameId}
    Page Should Not Contain Element    //span[text()="列印學分證明"]
8-06-04
    [Documentation]     進入[所有課程/活動]>可以看到課程/活動列表>點擊[統計分析]
...  /      1.登入後
...  /      2.系統直接進入[所有課程/活動]頁面
...  /      3.使用者點選某入課程活動
...  /      4.點擊[統計分析]>畫面顯示統計分析資料
...  /      5.畫面下方出現一[報名清單區塊]
...  /      6.點擊該會員編號列的link
...  /      7.顯示該會員報名歷史紀錄
...  /      Expected Result: 顯示相關頁面
    [Tags]    7006 持續進修管理-用戶查詢-用戶報名歷史紀錄
    Statistical Analysis For    ${Event.Name}
    Click And Enabled    //tbody/tr/td/button
    Wait And Select Frame    ${IFrameId}
    Wait Until Element Is Visible    //th[text()="報到狀態"]
    Page Should Contain Element    //th[text()="報到狀態"]
    Page Should Contain Element    //th[text()="報名狀態"]
8-06-05
    [Documentation]     進入[所有課程/活動]>可以看到課程/活動列表>點擊[某課程]
...  /      1.登入後
...  /      2.系統直接進入[所有課程/活動]頁面
...  /      3.使用者點選某入課程活動
...  /      4.注意UI上的活動日期, 報名開始時間
...  /      5.活動收據可以下載的時間應於活動日期後才能下載
...  /      Expected Result: 顯示相關頁面
    [Tags]    7006 持續進修管理-我的課程與活動-清單-收據
    Click And Enabled    //button[contains(.,"${Event.Name}")]
    Wait And Select Frame    ${IFrameId}
    Click And Enabled    //span[text()="匯出報表"]/..
    Click And Enabled    //span[text()="匯 出"]/..
    Sleep    5
    ${current_window}    Get Window Handles
    Switch Window    ${current_window}[1]
    Location Should Contain    https://test.roccpa.org.tw/TACCTG/event/report/detail
    Close Window
    Switch Window    ${current_window}[0]

