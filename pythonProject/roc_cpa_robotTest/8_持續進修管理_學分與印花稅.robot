*** Settings ***
Documentation  持續進修自動測試腳本(8-10-01~8-13-01)
...             測試完後自動刪除測試中新增之資料，以利重複測試

Resource    Resource/8_持續進修管理_共用關鍵字.resource

Suite Setup    Setup
Test Teardown    Unselect Frame
*** Variables ***
&{ScoreRecord}  EventName=testing2    MemberName=陳小美   NationalId=A234567890
&{ScoreRecord2}  EventName=testing2    MemberName=李大星   NationalId=B123456789
*** Keywords ***

Setup
    Open Page
    Login   ${Employee}
Activities And Course Maintain
    Click And Enabled    //div[@id="navbar"]//li[contains(.,"課程活動報名管理")]
    Click And Visible    //a[text()="活動與課程管理"]
    Wait And Select Frame    ${IFrameId}
Get Stamp Duty Record
    [Documentation]    取得印花稅紀錄
    [Arguments]    ${StartDate}  ${EndDate}
    Activities And Course Maintain
    Click And Enabled    //span[text()="印花稅查詢"]/..
    Choose Start And End Date    
    ...     //div[contains(.,"選擇印花稅")]//input[@placeholder="開始日期"]
    ...     ${StartDate}  ${EndDate}
    Click Element    //span[text()="查 詢"]/..
Search Score By MemberName
    [Documentation]    搜尋會員學分紀錄
    [Arguments]    ${MemberName}    ${Year}=${Empty}
    Activities And Course Maintain
    Click And Enabled    //span[text()="學分編輯"]/..
    Wait And Input    //input[@id="member"]     ${MemberName}
    Sleep    1
    Click Element    //input[@id="year"]/../..
    Run Keyword If  '${Year}' != '${Empty}'
    ...     Click And Visible    //div[@title="${Year}"]
    ...     ELSE    Click Element    //span[@class="anticon anticon-close-circle"]
    Sleep    1
    Click And Enabled    ${Button.Sure}
    Wait And Select Frame    ${IFrameId}
Search Score By Date
    [Documentation]    搜尋日期內學分紀錄
    [Arguments]    ${StartDate}    ${EndDate}
    Activities And Course Maintain
    Click And Enabled    //span[text()="學分編輯"]/..
    Click And Visible    //span[text()="查詢日期"]/..
    Choose Start And End Date    //input[@id="created_at"]    ${StartDate}  ${EndDate}
    Click And Enabled    ${Button.Sure}
    Wait And Select Frame    ${IFrameId}
Search Score By EventName
    [Documentation]    搜尋課程學分紀錄
    [Arguments]    ${EventName}
    Activities And Course Maintain
    Click And Enabled    //span[text()="學分編輯"]/..
    Click And Visible    //span[text()="課程名稱"]/..
    Wait And Input    //input[@id="event_name"]     ${EventName}
    Click And Enabled    ${Button.Sure}
    Wait And Select Frame    ${IFrameId}
Add Score Record
    [Documentation]    新增學分紀錄
    [Arguments]    ${scoreRecord}
    Click And Visible    ${Button.Add}
    Wait And Select Frame    ${IFrameId}
    Wait And Input    //input[@id="event_name"]     ${scoreRecord.EventName}
    Click And Visible    //div[@title="${scoreRecord.EventName}"]
    Wait And Input    //input[@id="member_name"]   ${scoreRecord.MemberName}
    Click And Visible    //div[@title="${scoreRecord.NationalId}-${scoreRecord.MemberName}"]
    Click Element    //span[text()="保 存"]/..
    Sleep    1
    Wait And Select Frame    ${IFrameId}
Edit Score Record
    [Documentation]    修改學分紀錄
    [Arguments]    ${Year}  ${Score}
    Click And Enabled    ${Button.Edit}
    Run Keyword If    "${Year}" != "fixed"
    ...     Run Keywords
    ...     Click And Visible    //tbody/tr/td[4]
    ...     AND    Click And Visible    //div[@title="${Year}"]
    Run Keyword If    "${Score}" != "fixed"
    ...     Clear And Input Text    //tbody/tr/td[7]//input   ${Score}
    Click And Enabled    //span[text()="送出"]/..
Delete Score Record
    [Documentation]    刪除學分紀錄
    Wait Until Page Contains Element    //tbody/tr/td[9]
    Click And Enabled    ${Button.Delete}
    Sleep    1
    Click And Enabled    ${Button.Confirm}
    Sleep    1
*** Test Cases ***

8-10-01
    [Documentation]     會務人員身份進入[持續進修管理]後台>點擊[印花稅查詢]
...  /      1.進入[持續進修管理]後台; 顯示所有課程/活動清單列表
...  /      2.點擊[印花稅查詢]
...  /      3.畫面輸入日期區間起, 迄後, 按下查詢
...  /      Expected Result: 顯示相關頁面
    [Tags]    7010 持續進修管理-印花稅查詢
    Get Stamp Duty Record    2021-01-01  2021-12-31
    Sleep    5
    File Should Exist    C:\\Users\\User\\Downloads\\stampDuty.xlsx
    Remove File    C:\\Users\\User\\Downloads\\stampDuty.xlsx
    Close Browser
    Setup
8-10-02
    [Documentation]     會務人員身份進入[持續進修管理]後台>點擊[印花稅查詢]
...  /      1.進入[持續進修管理]後台; 顯示所有課程/活動清單列表
...  /      2.點擊[印花稅查詢]
...  /      3.畫面輸入日期區間起, 迄後,
...  /      4.起, 迄 內容請將 迄的日期, 小於 起的日期
...  /      5.按下查詢
...  /      Expected Result: 顯示相關頁面>應指示輸入錯誤
    [Tags]    7010 持續進修管理-印花稅查詢-異常
    Activities And Course Maintain
    Click And Enabled    //span[text()="印花稅查詢"]/..
    Click And Visible    //div[contains(.,"選擇印花稅")]//input[@placeholder="開始日期"]
    Choose Date    2021-12-31
    Click And Visible    (//button[@class="ant-picker-year-btn"])[1]
    Sleep    1
    Click And Visible    //td[@title="2021"]
    Sleep    1
    Click And Visible    (//button[@class="ant-picker-month-btn"])[1]
    Wait Until Page Contains Element    //td[@title="2021-01"]
    ${class}    Get Element Attribute   //td[@title="2021-01"]  class

    #//td[@title="2021-01"]無法點選
    Should Contain    ${class}  ant-picker-cell-disabled
#開啟excel需安裝excellibrary
#但excellibrary不支援最新版本python3.11
#需考慮降級python至3.8或3.9
8-10-03
    [Documentation]     會務人員身份進入[持續進修管理]後台>點擊[印花稅查詢]
...  /      1.內容應有該範圍區間的資料
...  /      2.欄位應有a.序號 b.收據號碼 c.金額 d.備註
...  /      Expected Result: 顯示相關頁面
    [Tags]    7010 持續進修管理-印花稅查詢-匯出的excel檔案內容
#    Get Stamp Duty Record    2021-01-01  2021-12-31
    Sleep    5
    Open Excel    C:\\Users\\User\\Downloads\\stampDuty.xlsx

8-11-01
    [Documentation]     會務人員身份進入[持續進修管理]後台>活動課程管理>學分查詢
...  /      1.ID或姓名欄位[輸入某會計師姓名]
...  /      2.選取日期區間為不指定
...  /      3.課程名稱為空
...  /      4.年度為111年度
...  /      5.按下查詢
...  /      Expected Result: 顯示相關頁面>僅出現該會計師111年度的所有上課歷程清單
    [Tags]    7011 持續進修管理-學分查詢
    Search Score By MemberName    蔡德港   111
    Wait Until Page Contains Element    //tbody/tr/td[4]
    @{items}    Get Webelements    //tbody/tr
    FOR    ${item}    IN    @{items}
        Element Should Contain    ${item}   111
        Element Should Contain    ${item}   蔡德港
    END
8-11-02
    [Documentation]     會務人員身份進入[持續進修管理]後台>活動課程管理>學分查詢
...  /      1.ID或姓名欄位及年度輸入
...  /      2.選取日期區間
...  /      3.課程名稱為空
...  /      4.按下查詢
...  /      Expected Result: 顯示相關頁面(顯示查詢日期區間對應之年度)
    [Tags]    7011 持續進修管理-學分查詢
    Search Score By Date    2021-08-01    2021-08-31
    Wait Until Element Is Visible    //tbody/tr/td[4]
    @{items}    Get Webelements    //tbody/tr/td[4]
    FOR    ${item}    IN    @{items}
        Element Should Contain    ${item}   110
    END
8-11-03
    [Documentation]     會務人員身份進入[持續進修管理]後台>活動課程管理>學分查詢
...  /      1.ID或姓名欄位及年度輸入
...  /      2.選取日期區間
...  /      3.課程名稱為[某一課程名稱]
...  /      4.按下查詢
...  /      Expected Result: 顯示相關頁面>僅出現該課程名稱的所有上課人員清單
    [Tags]    7011 持續進修管理-學分查詢
    Search Score By EventName    營所稅
    Sleep    5
    Wait Until Element Is Visible    //tbody/tr/td[1]
    @{items}    Get Webelements    //tbody/tr/td[1]
    FOR    ${item}    IN    @{items}
        Element Should Contain    ${item}   營所稅
    END
8-11-04
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>編輯可存檔
...  /      1.先選擇多筆勾選[check box]
...  /      2.按下[編輯]
...  /      3.所選取的多筆勾選的[課程名稱[,[年度],[進修項目],[學分數]隨即變為可輸入欄位
...  /      4.修改年度改為 100, 學分數改為 5
...  /      5.按下[送出]
...  /      6.跳出[成功]提示訊息>點擊[確認]
...  /      Expected Result: 顯示相關頁面
    [Tags]    7011 持續進修管理-學分編輯
    Search Score By MemberName    ${ScoreRecord2.MemberName}
    #新增測試資料
    Add Score Record    ${ScoreRecord2}
    Edit Score Record    110    10
    Search Score By MemberName    ${ScoreRecord2.MemberName}
    Wait Until Page Contains Element    //tbody/tr/td[4]
    Element Should Contain    //tbody/tr/td[4]  110
    Element Should Contain    //tbody/tr/td[7]   10
    #刪除測試資料
    Delete Score Record
8-11-05
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>編輯檢核不通過訊息提示
...  /      1.先選擇多筆勾選[check box]
...  /      2.按下[編輯]
...  /      3.所選取的多筆勾選的[課程名稱[,[年度],[進修項目],[學分數]隨即變為可輸入欄位
...  /      4.修改年度改為 "壹百年", 學分數改為 "五"
...  /      5.按下[送出]
...  /      6.跳出[不成功]提示訊息>點擊[確認]
...  /      Expected Result: 顯示相關頁面
    [Tags]    7011 持續進修管理-學分編輯-異常
    Search Score By MemberName    ${ScoreRecord2.MemberName}
    #新增測試資料
    Add Score Record    ${ScoreRecord2}
    Edit Score Record    fixed  五
    Search Score By MemberName    ${ScoreRecord2.MemberName}
    Wait Until Page Contains Element    //tbody/tr/td[7]
    Element Should Contain    //tbody/tr/td[7]   10
    #刪除測試資料
    Delete Score Record
8-11-06
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>不應呈現[洗防法]警示圖示
...  /      1.新增一筆全新的人員
...  /      2.進入[持續進修管理]
...  /      3.活動課程管理
...  /      4.進入學分查詢
...  /      5.查詢剛才所建立的全新人員
...  /      6.不應出現們何警示訊息
...  /      Expected Result: 顯示相關頁面
    [Tags]    7011 持續進修管理-學分編輯-異常(洗防法)
    Search Score By MemberName    ${ScoreRecord.MemberName}
    #新增測試資料
    Add Score Record    ${ScoreRecord}
    Unselect Frame
    Search Score By MemberName    ${ScoreRecord.MemberName}
    Wait Until Page Contains Element    //tbody/tr/td[5]
    Page Should Contain Element    //tbody/tr[1]/td[5]/div/div[2]/span[@class="anticon anticon-check-circle"]
    #刪除測試資料
    Delete Score Record
8-11-07
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>不應呈現[洗防法]警示圖示
...  /      1.查詢以區間99年1月1日~111年1月1日
...  /      2.查出畫面上沒有出現警示的會員姓名
...  /      3.重新查詢, 以剛才查出未出現警示的姓名當條件
...  /      4.按下查詢
...  /      5.勾選並修改所有的學分數為0
...  /      6.提示訊息>點擊[確認]
...  /      7.再次以剛才查出未出現警示的姓名當條件
...  /      8.按下查詢
...  /      9.應出學分不足及洗防法不足的警示
...  /      Expected Result: 顯示相關頁面
    [Tags]    7011 持續進修管理-學分編輯-異常(洗防法)
    Search Score By MemberName    ${ScoreRecord.MemberName}
    Sleep    1
    #新增測試資料
    Add Score Record    ${ScoreRecord}
    Edit Score Record    fixed  0
    Search Score By MemberName    ${ScoreRecord.MemberName}
    Wait Until Page Contains Element    //tbody/tr/td[5]
    Page Should Contain Element    //tbody/tr[1]/td[5]/div/div[1]/span[@class="anticon anticon-exclamation-circle"]
    Page Should Contain Element    //tbody/tr[1]/td[5]/div/div[2]/span[@class="anticon anticon-exclamation-circle"]
    #刪除測試資料
    Delete Score Record
8-12-01
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[進修時數登記表列印]
...  /      1.查詢姓名:張清田, 年度:111年
...  /      2.確定
...  /      3.列印
...  /      4.應與所提供附件同
...  /      Expected Result: 顯示相關頁面
    [Tags]    7012 持續進修管理-進修時數登記表列印
    Activities And Course Maintain
    Click And Enabled    //span[text()="學分登記表"]/..
    Click And Visible    //span[text()="未入公會"]/..
    Click And Visible    ${Button.Sure}
    ${current_window}    Get Window Handles
    Switch Window    ${current_window}[1]
    Location Should Contain    https://test.roccpa.org.tw/TACCTG/event/score/print
    Close Window
    Switch Window    ${current_window}[0]
8-13-01
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[總帳報表]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[總帳報表]
...  /      Expected Result: 顯示相關頁面
    [Tags]    7013 持續進修管理-總帳報表
    Activities And Course Maintain
    Click And Enabled    //span[text()="總帳報表"]/../..
    Choose Start And End Date    //div[text()="請選擇匯出日期"]/../..//input     2023-01-01  2023-12-31
    Click And Visible    //span[text()="匯 出"]/..
    ${current_window}    Get Window Handles
    Switch Window    ${current_window}[1]
    Location Should Contain    https://test.roccpa.org.tw/TACCTG/event/report
    Close Window
    Switch Window    ${current_window}[0]
