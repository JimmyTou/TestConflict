*** Settings ***
Documentation  持續進修自動測試腳本(8-01-01~8-03-03)
...            測試時請先更換檔案8_持續進修管理_共用關鍵字.resource中的${Event.Name}，以免新增重複名稱的課程活動

Resource    Resource/8_持續進修管理_共用關鍵字.resource

Suite Setup    Setup
Test Teardown    Teardown
*** Variables ***
*** Keywords ***

Setup
    Open Page
Teardown
    ${IsLoginPage}   Run Keyword And Return Status
    ...     Location Should Contain    https://test.roccpa.org.tw/TACCTG/loginPage
    Run Keyword If    not ${IsLoginPage}   Logout
Activities And Course Maintain
    Click And Enabled    //div[@id="navbar"]//li[contains(.,"課程活動報名管理")]
    Click And Visible    //a[text()="活動與課程管理"]
    Wait And Select Frame    ${IFrameId}
Logout
    Unselect Frame
    Click And Enabled    id=logout
Add New Activities Or Course
    [Arguments]    ${EventName}
    Click And Enabled    ${Button.Add}/..
    Sleep    1
    Scroll In IFrame    100
    Click And Enabled    //span[text()="全聯會專教會講習會"]
    Click And Enabled    //span[text()="建 立"]
    Wait And Select Frame    ${IFrameId}
    Wait And Input    //input[@id="title"]      ${EventName}
    Wait And Input    //input[@id="sub_title"]      sub_testing
    Scroll In IFrame    300
    Click And Visible    //input[@id="event_group_id"]/..
    Click And Visible    //div[@label="工商組"]
    Click And Visible    //span[text()="洗錢防制"]/..
    Input Start And End Date    event_date    2023-08-20 00:00    2023-08-22 00:00
    Input Start And End Date    apply_date    2023-08-01 00:00    2023-08-19 00:00
    Input Start And End Date    publish_date    2023-08-01 00:00    2023-08-22 00:00
    Input Text    //input[@id="score"]  10
    Input Text    //input[@id="contact"]  王阿明
    Input Text    //input[@id="email"]  aa123@gmail.com
    Input Text    //input[@id="place"]  天龍國
    Scroll In IFrame    1000
    Input Start And End Date    class_date_0_0  2023-08-04 00:00    2023-08-07 00:00
    Input Text    //input[@id="class_price_0"]  1000
    Input Text    //input[@id="class_name_0"]  ${EventName}
    Input Text    //input[@id="class_lecturer_score_0_0"]  10
    Input Text    //input[@id="class_lecturer_hour_0_0"]  10
    Click Element    //input[@id="class_lecturer_id_0_0"]
    Click And Visible    //div[@id="class_lecturer_id_0_0_list"]/../div/div/div/div/div/div
    Click Element    //span[text()="保 存"]/..
*** Test Cases ***
#bug
8-01-01
    [Documentation]     進入[所有課程/活動]>可以看到課程/活動列表
...  /      1.登入後
...  /      2.系統直接進入[所有課程/活動]頁面
...  /      3.使用者可以隨意調整/輸入第一列的篩選條件
...  /      4.第一列的所有篩選條件及關鍵字調整完後底下的列表結果隨著調整
...  /      5.下方的跳頁數字隨著第4點的動作而顯示正確的結果
...  /      Expected Result: 第一列的所有篩選條件及關鍵字調整完後底下的列表結果隨著調整>下方的跳頁數字隨著第4點的動作而顯示正確的結果
    [Tags]    7001 持續進修管理-課程活動查詢
    Login   ${Admin}
#    Activities And Course Maintain
#    Wait Until Element Is Visible    //label[@title="性質"]
#    @{types}    Get Webelements    //div[@id="type"]/label
#    FOR     ${type}    IN   @{types}
#        Click Element    ${type}
#        Click And Enabled    (//div[@class="ant-select-selection-overflow"])[1]
#        @{categories}    Get Webelements    //div[@id="category_list"]/..//div[@title]
#        Click Element    (//div[@class="ant-select-selection-overflow"])[1]
#        FOR     ${category}    IN   @{categories}
#            Click And Enabled    (//div[@class="ant-select-selection-overflow"])[1]
#            Click And Visible    ${category}
#            Click And Enabled    (//div[@class="ant-select-selection-overflow"])[2]
#            @{statuses}    Get Webelements    //div[@id="status_list"]/..//div[@title]
#            Click Element    (//div[@class="ant-select-selection-overflow"])[2]
#            FOR    ${status}   IN    @{statuses}
#                Sleep    1
#                Click And Enabled    (//div[@class="ant-select-selection-overflow"])[2]
#                Click And Visible    ${status}
#                Click Element    //input[@placeholder="開始日期"]
#                Input Text    //input[@placeholder="開始日期"]   2023-08-01
#                Click Element    //input[@placeholder="結束日期"]
#                Input Text    //input[@placeholder="結束日期"]   2023-08-31
#            END
#        END
#    END

8-02-01
    [Documentation]     進入[所有課程/活動]>可以看到課程/活動列表
...  /      1.進入[持續進修管理]後台; 顯示所有課程/活動清單列表
...  /      2.按下[新增]按鈕
...  /      3.選擇[性質/類型]後下一步;按下[建立]
...  /      4.進入設定課程/活動的基本資料頁面
...  /      5.填妥各項資料
...  /      6.按下儲存
...  /      Expected Result: 回到[持續進修管理]後台;顯示所有課程/活動清單列表>其狀態停留於[編輯中]
    [Tags]    7002 持續進修管理-課程活動新增
    Login   ${Admin}
    Activities And Course Maintain
    Add New Activities Or Course    ${Event.Name}
    Activities And Course Maintain
    Click And Visible    //input[@id="status"]/..
    Click And Visible    //div[@title="編輯中"]
    Wait Until Element Is Visible    //tr[contains(.,"${Event.Name}")]
    Element Should Contain    //tr[contains(.,"${Event.Name}")]  編輯中
8-02-02
    [Documentation]     以會計師身份登入>進入[持續進修管理]後台>不能新增課程/活動
...  /      1.無法進入[持續進修管理]後台;因為無該下拉功能表
...  /      Expected Result: 無該下拉功能表
    [Tags]    7002 持續進修管理-課程活動新增-無功能權限
    Login   ${Accountant}
    Click And Enabled    //div[@id="navbar"]//li[contains(.,"課程活動報名管理")]
    Page Should Not Contain    課程與活動管理
8-02-03
    [Documentation]     以會計師身份登入>使用link進入[持續進修管理]後台
...  /      1.無法進入[持續進修管理]後台
...  /      2.無法進入[編輯]功能
...  /      Expected Result: 畫面直接跳轉至首頁
    [Tags]    7002 持續進修管理-課程活動新增-有功能但無新增
    Login   ${Accountant}
    Wait Until Page Contains    江宥儀
    Go To    https://test.roccpa.org.tw/TACCTG/event/mgt/list#
    Location Should Be  https://test.roccpa.org.tw/TACCTG/loginPage#

8-03-01
    [Documentation]     以會務身份登入>進入[持續進修管理]後台>順利新增課程/活動
...  /      1.進入[持續進修管理]後台; 顯示所有課程/活動清單列表
...  /      2.按下[新增]按鈕
...  /      3.選擇[性質/類型]後下一步;按下[建立]
...  /      4.進入設定課程/活動的基本資料頁面
...  /      5.填妥各項資料
...  /      6.按下儲存
...  /      Expected Result: 回到[持續進修管理]後台;顯示所有課程/活動清單列表>其狀態停留於[編輯中]
    [Tags]    7003 持續進修管理-課程活動編輯
    Login   ${Employee}
    Activities And Course Maintain
    Add New Activities Or Course    ${Event.Name}Emp
    Activities And Course Maintain
    Click And Visible    //input[@id="status"]/..
    Click And Visible    //div[@title="編輯中"]
    Wait Until Element Is Visible    //tr[contains(.,"${Event.Name}Emp")]
    Element Should Contain    //tr[contains(.,"${Event.Name}Emp")]  編輯中
8-03-02
    [Documentation]     以會計師/事務所經辦身份登入>進入[持續進修管理]後台>不能[編輯]課程/活動
...  /      1.無法進入[持續進修管理]後台;因為無該下拉功能表
...  /      Expected Result: 無該下拉功能表
    [Tags]    7003 持續進修管理-課程活動編輯-無權限1
    Login   ${Accountant}
    Click And Enabled    //div[@id="navbar"]//li[contains(.,"課程活動報名管理")]
    Page Should Not Contain    課程與活動管理
8-03-03
    [Documentation]     以會計師/事務所經辦身份登入>使用link進入[持續進修管理]後台
...  /      1.無法進入[持續進修管理]後台[編輯]功能
...  /      Expected Result: 畫面直接跳轉至首頁
    [Tags]    7003 持續進修管理-課程活動編輯-無權限2
    Login   ${Accountant}
    Wait Until Page Contains    江宥儀
    Go To    https://test.roccpa.org.tw/TACCTG/event/mgt/list#
    Location Should Be  https://test.roccpa.org.tw/TACCTG/loginPage#
