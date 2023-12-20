*** Settings ***
Documentation  執業會員資料自動測試腳本
Library    SeleniumLibrary
Library    BuiltIn
Library    String
Library    Collections
Library    OperatingSystem
Library    Screenshot
Resource    CommonResource.resource

Suite Setup    Setup
Test Setup    Practicing Member Data Maintain
*** Variables ***
&{Login}    Account=admin  Password=3edc4rfv%TGB^YHN
...         Url=https://test.ROCcpa.org.tw/TACCTG/loginPage#
...         Browser=Edge
&{Testing}  MemberName=王阿明  NationalId=A123456789   OfficeTaxId=45407953
...         CellPhone=0922011233    Email=aa123@gmail.com
...         Education=台灣大學會計系   CurrentJob=喬成聯合會計師事務所
...         PracticingDate=110/12/01    PracticingNo=測試發文號100號
...         OfficeName=喬成聯合會計師事務所
&{Change}   MemberName=${Testing.MemberName}123  NationalId=B198765432
&{ChangeItem}   任職事務所異動=customOfficeEdit     姓名變更=F
...             懲戒=L     身分證字號變更=M    會計師及格證書字號變更=N
...             會計師證書字號變更=O     住居所變更=P  公發簽證變更=Q
...             執業登記變更=R    停執=T   復執=S     退會=A
*** Keywords ***
Setup
    Open Page
    Login    ${Admin}

Practicing Member Data Maintain
    [Documentation]    會員管理>執業會員資料管理
    Wait Until Element Is Enabled   //div[@id="navbar"]/ul/li[1]/a
    Click Element   //div[@id="navbar"]/ul/li[1]/a
    Wait Until Element Is Visible    //a[text()="會員資料管理"]
    Click Element    //a[text()="會員資料管理"]
Add New Member
    [Documentation]    新增會員
    Wait Until Element Is Enabled   //button[@onclick="add()"]
    Click Element    //button[@onclick="add()"]
    Input Text    //input[@id="nationalId"]     ${Testing.NationalId}
    Input Text    //input[@id="memberName"]     ${Testing.MemberName}
    Input Text    //input[@id="officeTaxId"]     ${Testing.OfficeTaxId}
    Input Text    //input[@id="cellPhone"]     ${Testing.CellPhone}
    Input Text    //input[@id="email"]     ${Testing.Email}
    Input Text    //textarea[@id="education"]     ${Testing.Education}
    Input Text    //textarea[@id="currentJob"]     ${Testing.CurrentJob}
    Input Text    //input[@id="practicingDate"]     ${Testing.PracticingDate}
    Input Text    //input[@id="practicingNo"]     ${Testing.PracticingNo}
    Scroll Element Into View    //button[@id="save"]
    Click Element    //button[@id="save"]
    Wait Until Page Contains    新增成功
    Click Element    //button[text()="OK"]
Check ROC Card
    [Documentation]    查看印鑑卡(全聯會)
    Wait Until Element Is Enabled    //tbody/tr[1]/td[7]/button[5]
    Click Element    //tbody/tr[1]/td[7]/button[5]
    Wait Until Element Is Visible    //select[@id="cardType"]
    Select From List By Value    //select[@id="cardType"]   ROC
Search MemberName
    [Arguments]    ${memberName}
    Wait Until Element Is Visible    //input[@id="memberName"]
    Input Text    //input[@id="memberName"]     ${memberName}
    Click Element    //button[@onclick="query()"]
Search OfficeName
    [Arguments]    ${officeName}
    Wait Until Element Is Visible    //input[@id="officeName"]
    Input Text    //input[@id="officeName"]     ${officeName}
    Click Element    //button[@onclick="query()"]
Search NationalId
    [Arguments]    ${nationalId}
    Wait Until Element Is Visible    //input[@id="nationalId"]
    Input Text    //input[@id="nationalId"]     ${nationalId}
    Click Element    //button[@onclick="query()"]
Search PracticingDate
    [Arguments]     ${practicingStartDate}    ${practicingEndDate}
    Wait Until Element Is Visible    //input[@id="practicingStartDate"]
    Input Text    //input[@id="practicingStartDate"]     ${practicingStartDate}
    Input Text    //input[@id="practicingEndDate"]     ${practicingEndDate}
    Click Element    //button[@onclick="query()"]
Check Member Details
    [Documentation]    查看會員明細
    Wait Until Element Is Enabled    //tbody/tr[1]/td[7]/button[3]
    Click Element    //tbody/tr[1]/td[7]/button[3]
Save And Back To Preious Page
    [Documentation]    儲存並回上頁
    Click Element    //button[@id="save"]
    Wait Until Page Contains    修改成功
    Click Element    //button[text()="OK"]
    Wait Until Element Is Enabled    //a[text()="回上一頁"]
    Scroll Element Into View    //a[text()="回上一頁"]
    Click Element    //a[text()="回上一頁"]
Change Member Data
    [Documentation]     會員異動
    [Arguments]    ${SelectValue}
    Wait Until Element Is Enabled    //tbody/tr[1]/td[7]/button[2]
    Click Element    //tbody/tr[1]/td[7]/button[2]
    Wait Until Element Is Enabled    //select[@id="changeItem"]
    Select From List By Value    //select[@id="changeItem"]     ${SelectValue}
Check Data Changed Record
    [Documentation]    查看異動紀錄
    Wait Until Element Is Enabled    //tbody/tr/td[7]/button[4]
    Click Element    //tbody/tr/td[7]/button[4]
Input Change Date And Reason
    [Documentation]    填寫修改日期及理由
    Input Text    //input[@id="recNo"]   123
    Input Text    //input[@id="changeDate"]   112/08/01
    Input Text    //input[@id="changeReason"]   testing
Check Changed Details
    [Documentation]    查看異動明細
    [Arguments]    ${ChangedItem}
    Wait Until Element Is Enabled   //tbody/tr/td[text()="${ChangedItem}"]/../td/button[1]
    Click Element    //tbody/tr/td[text()="${ChangedItem}"]/../td/button[1]
*** Test Cases ***
1-02-01
    [Documentation]     新增會員資料
    ...  /      1.開啟全國會計師聯會公會網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[會員資料管理]
    ...  /      4.點擊[新增]>輸入[身分證字號]:A123456789、[事務所統編]:45407953、[姓名]:王阿明、[入會發文號]:測試發文號100號
    ...  /       、[入會日期]:110/12/01、[會員證書字號]:會員證書測試字第1000號、[行動電話]:0922011233、[E-MAIL]:(輸入可收信的測試email
    ...  /       ，因會寄送密碼至email信箱)、[學歷]:台灣大學會計系、[經歷]:喬成聯合會計師事務所、[現執]:喬成聯合會計師事務所
    ...  /      5.點擊[儲存]>跳出[新增成功]>點擊[ok]
    ...  /      Expected Result: 點擊[會員編號]>輸入[王阿明]>點擊[xxxx-王阿明]加入到[會員編號]>點擊[查詢]>顯示王阿明會員資料於查詢結果
    [Tags]    1002 會員資料新增
    Add New Member
    Practicing Member Data Maintain
    Search MemberName    ${Testing.MemberName}
    Wait Until Element Is Visible    //tbody/tr/td[2]
    Element Text Should Be    //tbody/tr/td[2]  ${Testing.MemberName}
1-03-01
    [Documentation]     修改會員資料
    ...  /      1.開啟全國會計師聯會公會網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[會員資料管理]
    ...  /      4.點擊[會員編號]>輸入輸入[王阿明]>點擊[xxxx-王阿明]>加入到[會員編號]
    ...  /      5.點擊[查詢]>點擊[編輯]
    ...  /      6.點擊[出生地]>修改為[台灣省台北市]
    ...  /      7.點擊[儲存]>跳出[修改成功]>點擊[OK]
    ...  /      Expected Result: 點擊[明細]>[出生地]欄位已修改為[台灣省台北市]
    [Tags]    1003 會員資料編輯
    Search MemberName    ${Testing.MemberName}
    Wait Until Element Is Enabled    //tbody/tr/td/button[1]
    Click Element    //tbody/tr/td/button[1]
    Wait Until Element Is Enabled    //input[@id="domicileAddress"]
    Input Text    //input[@id="domicileAddress"]    台灣省台北市
    Scroll Element Into View    //button[@id="save"]
    Click Element    //button[@id="save"]
    Wait Until Page Contains    修改成功
    Click Element    //button[text()="OK"]
    Practicing Member Data Maintain
    Search MemberName    ${Testing.MemberName}
    Check Member Details
    Wait Until Element Is Visible    //input[@id="domicileAddress"]
    Element Attribute Value Should Be    //input[@id="domicileAddress"]     value   台灣省台北市
1-01-01
    [Documentation]     查詢執業會計師資料
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員姓名]>輸入[王阿明]
    ...  /      5.點擊[查詢]
    ...  /      Expected Result: 顯示王阿明於查詢結果
    [Tags]    1001 執業會員資料查詢
    Search MemberName    ${Testing.MemberName}
    Element Should Contain    //tbody   ${Testing.MemberName}
    Scroll Element Into View    //tbody/tr
    Sleep    5

1-01-02
    [Documentation]     查詢事務所的會員資料
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[事務所名稱]>輸入[喬成聯合會計師事務所]
    ...  /      5.點擊[查詢]
    ...  /      Expected Result: 顯示碩品會計師事務所的會員於查詢結果
    [Tags]    1001 執業會員資料查詢
    Search OfficeName    ${Testing.OfficeName}
    FOR    ${item}    IN    //table/tbody/tr/td[4]
        Element Should Contain    ${item}   ${Testing.OfficeName}
    END
1-01-03
    [Documentation]     查詢身份證字號的會計師資料
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[身份證字號]>輸入[A123456789]
    ...  /      5.點擊[查詢]
    ...  /      Expected Result: 顯示王阿明於查詢結果
    [Tags]    1001 執業會員資料查詢
    Search NationalId    ${Testing.NationalId}
    Element Should Contain    //table/tbody   ${Testing.MemberName}
1-01-04
    [Documentation]     查詢執業登記起迄日的會員資料
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[執業登記起日]>輸入[112/01/01](或點擊小日曆選擇[112年]>[一月]>[1])
    ...  /      5.點擊[執業登記迄日]>輸入[112/12/31](或點擊小日曆選擇[112年]>[十二月]>[31])
    ...  /      6.點擊[查詢]
    ...  /      Expected Result: 顯示執業登記起迄日為112/01/01~112/12/31的會員於查詢結果
    [Tags]    1001 執業會員資料查詢
    Search PracticingDate    112/01/01  112/12/31
    FOR    ${item}    IN    //table/tbody/tr/td[5]
        Element Should Contain    ${item}   112
    END

1-04-01
    [Documentation]     查看會員詳細資料
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員姓名]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[明細]
    ...  /      Expected Result: 檢視[王阿明]會員明細資料
    [Tags]    1004 執業會員明細
    Search MemberName    ${Testing.MemberName}
    Check Member Details
    Wait Until Page Contains Element    //input[@id="memberName"]
    ${input_value}    Get Element Attribute    //input[@id="memberName"]    value
    Should Contain    ${input_value}    ${Testing.MemberName}

1-05-01
    [Documentation]     新增會員印鑑卡
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員姓名]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[印鑑卡]
    ...  /      6.下拉選單選擇地方公會 [全聯會/台北市公會]
    ...  /      6.點擊[瀏覽]>上傳印鑑卡範本
    ...  /      7.點擊[上傳]>跳出[修改成功]>點擊[OK]>點擊[回上一頁]
    ...  /      Expected Result: 點擊[會員編號]>輸入[王阿明]>點擊[查詢]>點擊[印鑑卡]>顯示[印鑑卡]
    [Tags]    1005 會計師印鑑卡編輯
    Search MemberName    ${Testing.MemberName}
    Check ROC Card
    Choose File    //input[@id="customFile"]    C:\\Users\\User\\Pictures\\Screenshots\\testing.png
    Scroll Element Into View    //a[text()="回上一頁"]
    Input Text    //input[@id="changeDate"]     112/08/01
    Input Text    //input[@id="changeReason"]   新增印鑑卡
    Save And Back To Preious Page
    Practicing Member Data Maintain
    Search MemberName    ${Testing.MemberName}
    Check ROC Card
    ${count}    Get Element Count   //div[@data-cardtype="ROC"]/div/img
    Should Be Equal As Integers    ${count}    1
1-05-02
    [Documentation]     編輯會員印鑑卡
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員姓名]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[印鑑卡]
    ...  /      6.下拉選單選擇地方公會 [全聯會/台北市公會]
    ...  /      7.點擊[瀏覽]>上傳印鑑卡範本>輸入[收文號]:110112500001、[異動日期]:112/07/11、[異動原因]:更換印鑑卡
    ...  /      8.點擊[上傳]>跳出[修改成功]>點擊[OK]>點擊[回上一頁]
    ...  /      Expected Result: 點擊[會員姓名]>輸入[王阿明]>點擊[查詢]>點擊[印鑑卡]>依序顯示[印鑑卡]
    [Tags]    1005 會計師印鑑卡編輯
    Search MemberName    ${Testing.MemberName}
    Check ROC Card
    Choose File    //input[@id="customFile"]    C:\\Users\\User\\Pictures\\Screenshots\\testing.png
    Scroll Element Into View    //a[text()="回上一頁"]
    Wait Until Element Is Visible    //input[@id="changeDate"]     5
    Input Text    //input[@id="changeDate"]   112/07/11
    Input Text    //input[@id="changeReason"]   更換印鑑卡
    Save And Back To Preious Page
    Practicing Member Data Maintain
    Search MemberName    ${Testing.MemberName}
    Check ROC Card
    ${count}    Get Element Count   //div[@data-cardtype="ROC"]/div/img
    Should Be True    ${count}>1
1-05-03
    [Documentation]     刪除印鑑卡
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員姓名]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[印鑑卡]
    ...  /      6.下拉選單選擇地方公會 [全聯會/台北市公會]
    ...  /      7.點擊[刪除]
    ...  /      Expected Result: 印鑑卡被刪除
    [Tags]    1005 會計師印鑑卡編輯
    Search MemberName    ${Testing.MemberName}
    Check ROC Card
    ${count}    Get Element Count   //div[@data-cardtype="ROC"]/div/button
    FOR     ${i}    IN RANGE     ${count}
        Wait Until Element Is Enabled   //div[@data-cardtype="ROC"]/div/button      5
        Scroll Element Into View    //div[@data-cardtype="ROC"]/div/button
        Sleep    1
        Click Element    //div[@data-cardtype="ROC"]/div/button
        Sleep    1
        Wait Until Element Is Visible    //button[text()="確認刪除"]
        Click Element    //button[text()="確認刪除"]
        Wait Until Element Is Visible    //button[text()="OK"]
        Click Element    //button[text()="OK"]
    END
    ${count}    Get Element Count   //div[@data-cardtype="ROC"]/div/button
    Should Be Equal As Integers    ${count}     0
1-06-01
    [Documentation]     異動會員資料，退出任職事務所
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員姓名]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[會員異動]
    ...  /      6.點擊[異動項目]>選擇[任職事務所異動]
    ...  /      7.輸入[公文日期]:110/11/01、[公文文號]:110112500001、事務所原任職(退出)相關資訊
    ...  /      8.點擊[儲存]>跳出[修改成功]>點擊[OK]>點擊[回上一頁]
    ...  /      Expected Result: 點擊[會員名稱]>輸入[王阿明]>點擊[查詢]>事務所資訊已經為空
    [Tags]    1006 會員資料異動
    Search MemberName   ${Testing.MemberName}
    Change Member Data     ${ChangeItem.任職事務所異動}
    Wait Until Element Is Enabled   //input[@id="officeChangeDate"]
    Input Text    //input[@id="officeChangeDate"]   110/11/01
    Input Text    //input[@id="officeRecNo"]    110112500001
    Input Text    //input[@id="officeQuitDate"]     110/11/01
    Input Text    //input[@id="officeQuitNoDate"]   110/11/01
    Input Text    //input[@id="officeQuitNo"]   110112500001
    Save And Back To Preious Page
    Practicing Member Data Maintain
    Search MemberName    ${Testing.MemberName}
    Element Text Should Be    //table/tbody/tr/td[3]    ${EMPTY}
1-07-01-01
    [Documentation]     查看會員異動紀錄，退出任職事務所
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員姓名]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[異動紀錄]
    ...  /      Expected Result: 顯示異動紀錄清單
    [Tags]    1007 會員異動紀錄
    Search MemberName    ${Testing.MemberName}
    Check Data Changed Record
    Wait Until Element Is Visible   //tbody
    Element Should Contain    //tbody   任職事務所異動
1-07-01-02
    [Documentation]     查看會員異動紀錄，退出任職事務所
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員姓名]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[異動紀錄]>顯示異動紀錄清單
    ...  /      6.點擊[明細]
    ...  /      Expected Result: 顯示異動前後的資料
    [Tags]    1007 會員異動紀錄
    Search MemberName    ${Testing.MemberName}
    Check Data Changed Record
    Check Changed Details    任職事務所異動
    Wait Until Element Is Visible   (//label[text()="事務所"])[1]/following-sibling::input
    Element Attribute Value Should Be    (//label[text()="事務所"])[1]/following-sibling::input    value    ${Testing.OfficeTaxId}
    Element Attribute Value Should Be    (//label[text()="事務所"])[2]/following-sibling::input    value     ${EMPTY}

1-06-02
    [Documentation]     異動會員資料，修改任職事務所
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員姓名]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[會員異動]
    ...  /      6.點擊[異動項目]>選擇[任職事務所異動]
    ...  /      7.輸入[公文日期]:110/11/01、[公文文號]:110112500001、事務所原任職(退出)相關資訊、事務所新任職(加入)相關資訊
    ...  /      8.點擊[儲存]>跳出[修改成功]>點擊[OK]>點擊[回上一頁]
    ...  /      Expected Result: 點擊[會員姓名]>輸入[王阿明]>點擊[查詢]>事務所資訊已更新為新事務所
    [Tags]    1006 會員資料異動
    Search MemberName   ${Testing.MemberName}
    Change Member Data     ${ChangeItem.任職事務所異動}
    Wait Until Element Is Enabled   //input[@id="officeChangeDate"]
    Input Text    //input[@id="officeChangeDate"]   110/11/01
    Input Text    //input[@id="officeRecNo"]    110112500001
    Input Text    //input[@id="officeQuitDate"]     110/11/01
    Input Text    //input[@id="officeQuitNoDate"]   110/11/01
    Input Text    //input[@id="officeQuitNo"]   110112500001
    Input Text    //input[@id="editOfficeTaxId"]    ${Testing.OfficeTaxId}
    Input Text    //input[@id="officeJoinDate"]     110/11/01
    Input Text    //input[@id="officeJoinNoDate"]   110/11/01
    Input Text    //input[@id="officeJoinNo"]   110112500001
    Save And Back To Preious Page
    Practicing Member Data Maintain
    Search MemberName    ${Testing.MemberName}
    Wait Until Element Is Visible    //table/tbody/tr/td[3]
    Element Text Should Be    //table/tbody/tr/td[3]    ${Testing.OfficeTaxId}

1-06-03
    [Documentation]     異動會員資料，姓名變更
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員姓名]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[會員異動]
    ...  /      6.點擊[異動項目]>選擇[姓名變更]
    ...  /      7.輸入[異動後姓名]、[收文號]、[異動日期]、[異動原因]
    ...  /      8.點擊[儲存]>跳出[修改成功]>點擊[OK]>點擊[回上一頁]
    ...  /      Expected Result: 點擊[會員姓名]>輸入剛才異動的名字>點擊[查詢]>顯示結果
    [Tags]    1006 會員資料異動
    Search MemberName   ${Testing.MemberName}
    Change Member Data     ${ChangeItem.姓名變更}
    Scroll Element Into View    //a[text()="回上一頁"]
    Wait Until Element Is Enabled    //input[@id="memberName"]
    Input Text    //input[@id="memberName"]   ${Change.MemberName}
    Input Change Date And Reason
    Save And Back To Preious Page
    Search MemberName    ${Testing.MemberName}
    Wait Until Element Is Visible    //table/tbody/tr/td[2]
    Element Text Should Be    //table/tbody/tr/td[2]    ${Change.MemberName}
1-07-03-02
    [Documentation]     查看會員異動紀錄，姓名變更
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員姓名]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[異動紀錄]>顯示異動紀錄清單
    ...  /      6.點擊[明細]
    ...  /      Expected Result: 顯示異動前後的資料
    [Tags]    1007 會員異動紀錄
    Search MemberName    ${Testing.MemberName}
    Check Data Changed Record
    Check Changed Details    更名
    Wait Until Element Is Visible   //label[text()="姓名"]/following-sibling::input[1]
    Element Attribute Value Should Be    (//label[text()="姓名"])[1]/following-sibling::input    value    ${Testing.MemberName}
    Element Attribute Value Should Be    (//label[text()="姓名"])[2]/following-sibling::input    value     ${Change.MemberName}

1-06-04
    [Documentation]     異動會員資料，懲戒
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員編號]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[會員異動]
    ...  /      6.點擊[異動項目]>選擇[停業]
    ...  /      7.選擇任一種類懲戒
    ...  /      8.輸入[起始日期]、[結束日期]、[收文號]、[異動日期]、[異動原因]
    ...  /      9.點擊[儲存]>跳出[修改成功]>點擊[OK]>點擊[回上一頁]
    ...  /      Expected Result: 點擊[會員姓名]>輸入[王阿明]>[查詢]>顯示會籍狀態[停執]
    [Tags]    11004 會員資料異動
    Search MemberName   ${Testing.MemberName}
    Change Member Data     ${ChangeItem.懲戒}
    Scroll Element Into View    //a[text()="回上一頁"]
    Wait Until Element Is Enabled    //input[@id="discipline"]
    Click Element    //input[@value="4"]
    Input Text    //input[@id="disciplineStartDate"]   112/08/01
    Input Text    //input[@id="disciplineEndDate"]   112/08/31
    Input Change Date And Reason
    Save And Back To Preious Page
    Search MemberName    ${Testing.MemberName}
    Wait Until Element Is Visible    //table/tbody/tr/td[6]
    Element Text Should Be    //table/tbody/tr/td[6]    停執
1-07-04-01
    [Documentation]     查看會員異動紀錄，懲戒
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員姓名]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[異動紀錄]
    ...  /      Expected Result: 顯示異動紀錄清單
    [Tags]    1007 會員異動紀錄
    Search MemberName    ${Testing.MemberName}
    Check Data Changed Record
    Wait Until Element Is Visible    //tbody
    Element Should Contain    //tbody     懲戒
1-07-04-02
    [Documentation]     查看會員異動紀錄，懲戒
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員姓名]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[異動紀錄]>顯示異動紀錄清單
    ...  /      6.點擊[明細]
    ...  /      Expected Result: 顯示異動前後的資料
    [Tags]    1007 會員異動紀錄
    Search MemberName    ${Testing.MemberName}
    Check Data Changed Record
    Check Changed Details    懲戒
    Wait Until Element Is Visible   (//label[text()="懲戒"])[1]/following-sibling::input
    Element Attribute Value Should Be    (//label[text()="懲戒"])[1]/following-sibling::input    value    ${EMPTY}
    Element Attribute Value Should Be    (//label[text()="懲戒起始日"])[1]/following-sibling::input    value    ${EMPTY}
    Element Attribute Value Should Be    (//label[text()="懲戒終止日"])[1]/following-sibling::input    value    ${EMPTY}
    Element Attribute Value Should Be    (//label[text()="懲戒"])[2]/following-sibling::input    value    停業
    Element Attribute Value Should Be    (//label[text()="懲戒起始日"])[2]/following-sibling::input    value    112/08/01
    Element Attribute Value Should Be    (//label[text()="懲戒終止日"])[2]/following-sibling::input    value    112/08/31

1-06-05
    [Documentation]     異動會員資料，身份證字號變更
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員編號]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[會員異動]
    ...  /      6.點擊[異動項目]>選擇[身份證字號變更]
    ...  /      7.輸入[異動後身份證號]、[收文號]、[異動日期]、[異動原因]
    ...  /      Expected Result: 點擊[會員姓名]>輸入[王阿明]>點擊[查詢]>[明細]>顯示變更後的身份證字號
    [Tags]    11004 會員資料異動
    Search MemberName   ${Testing.MemberName}
    Change Member Data     ${ChangeItem.身分證字號變更}
    Scroll Element Into View    //a[text()="回上一頁"]
    Input Text    //input[@id="nationalId"]   ${Change.NationalId}
    Input Change Date And Reason
    Save And Back To Preious Page
    Search MemberName    ${Testing.MemberName}
    Check Member Details
    Wait Until Element Is Visible    //input[@id="nationalId"]
    Element Attribute Value Should Be    //input[@id="nationalId"]    value    ${Change.NationalId}
1-07-05-01
    [Documentation]     查看會員異動紀錄，身份證字號變更
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員姓名]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[異動紀錄]
    ...  /      Expected Result: 顯示異動紀錄清單
    [Tags]    1007 會員異動紀錄
    Search MemberName    ${Testing.MemberName}
    Check Data Changed Record
    Wait Until Element Is Visible    //tbody
    Element Should Contain    //tbody     身分證字號變更
1-07-05-02
    [Documentation]     查看會員異動紀錄，身份證字號變更
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員姓名]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[異動紀錄]>顯示異動紀錄清單
    ...  /      6.點擊[明細]
    ...  /      Expected Result: 顯示異動前後的資料
    [Tags]    1007 會員異動紀錄
    Search MemberName    ${Testing.MemberName}
    Check Data Changed Record
    Check Changed Details    身分證字號變更
    Wait Until Element Is Visible   (//label[text()="身分證字號"])[1]/following-sibling::input
    Element Attribute Value Should Be    (//label[text()="身分證字號"])[1]/following-sibling::input    value    ${Testing.NationalId}
    Element Attribute Value Should Be    (//label[text()="身分證字號"])[2]/following-sibling::input    value    ${Change.NationalId}

1-06-07
    [Documentation]     異動會員資料，會計師證書字號變更
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員編號]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[會員異動]
    ...  /      6.點擊[異動項目]>選擇[會計師證書字號變更]
    ...  /      7.輸入[頒發機關]、[頒發日期]、[會計師考試證書字號]、[收文號]、[異動日期]、[異動原因]
    ...  /      8.點擊[儲存]>跳出[修改成功]>點擊[OK]>點擊[回上一頁]
    ...  /      Expected Result: 點擊[會員姓名]>輸入[王阿明]>點擊[查詢]>[明細]>顯示變更後的會計師及格證書字號
    [Tags]    11004 會員資料異動
    Search MemberName   ${Testing.MemberName}
    Change Member Data     ${ChangeItem.會計師證書字號變更}
    Scroll Element Into View    //a[text()="回上一頁"]
    Input Text    //input[@id="issuingAuthority"]   全聯會123
    Input Text    //input[@id="issueDate"]   112/08/01
    Input Text    //input[@id="accountantCertNo"]   testing
    Input Text    //input[@id="accountantCertNo2"]   0000
    Input Change Date And Reason
    Save And Back To Preious Page
    Search MemberName    ${Testing.MemberName}
    Check Member Details
    Wait Until Element Is Visible    //input[@id="issuingAuthority"]
    Element Attribute Value Should Be    //input[@id="issuingAuthority"]    value    全聯會123
    Element Attribute Value Should Be    //input[@id="issueDate"]    value    112/08/01
    Element Attribute Value Should Be    //input[@id="accountantCertNo"]    value    testing
    Element Attribute Value Should Be    //input[@id="accountantCertNo2"]    value    0000
1-07-06-01
    [Documentation]     查看會員異動紀錄，會計師證書字號變更
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員姓名]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[異動紀錄]
    ...  /      Expected Result: 顯示異動紀錄清單
    [Tags]    1007 會員異動紀錄
    Search MemberName    ${Testing.MemberName}
    Check Data Changed Record
    Wait Until Element Is Visible    //tbody
    Element Should Contain    //tbody     會計師證書字號變更
1-07-06-02
    [Documentation]     查看會員異動紀錄，會計師證書字號變更
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員姓名]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[異動紀錄]>顯示異動紀錄清單
    ...  /      6.點擊[明細]
    ...  /      Expected Result: 顯示異動前後的資料
    [Tags]    1007 會員異動紀錄
    Search MemberName    ${Testing.MemberName}
    Check Data Changed Record
    Check Changed Details    會計師證書字號變更
    Wait Until Element Is Visible   (//label[text()="會計師證書字號變更"])[1]/following-sibling::input
    Element Attribute Value Should Be    (//label[text()="會計師證書字號變更"])[1]/following-sibling::input    value    ${EMPTY}
    Element Attribute Value Should Be    (//label[text()="會計師證書字號變更"])[2]/following-sibling::input    value    testing

1-06-09
    [Documentation]     異動會員資料，公發簽證變更
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員編號]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[會員異動]
    ...  /      6.點擊[異動項目]>選擇[公發簽證變更]
    ...  /      7.切換[公發簽證]狀態、並填入[執行日期]、[收文號]、[異動日期]、[異動原因]
    ...  /      8.點擊[儲存]>跳出[修改成功]>點擊[OK]>點擊[回上一頁]
    ...  /      Expected Result: 點擊[會員姓名]>輸入[王阿明]>點擊[查詢]>點擊[明細]>顯示變更後的公發簽證狀態
    [Tags]    11004 會員資料異動
    Search MemberName   ${Testing.MemberName}
    Change Member Data     ${ChangeItem.公發簽證變更}
    Scroll Element Into View    //a[text()="回上一頁"]
    Click Element    //input[@value="Y" and @id="independentAuditCpaStatus"]
    Input Text    //input[@id="independentAuditCpaDate"]   112/08/01
    Input Change Date And Reason
    Save And Back To Preious Page
    Search MemberName    ${Testing.MemberName}
    Check Member Details
    Wait Until Element Is Visible    //label[@for="independentAuditCpaStatusDesc"]/following-sibling::input
    Element Attribute Value Should Be    //label[@for="independentAuditCpaStatusDesc"]/following-sibling::input    value    核准
    Element Attribute Value Should Be    //input[@id="independentAuditCpaDate"]    value    112/08/01
    Element Attribute Value Should Be    //input[@id="independentAuditCpaNo"]    value    123
1-07-08-01
    [Documentation]     查看會員異動紀錄，公發簽證變更
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員姓名]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[異動紀錄]
    ...  /      Expected Result: 顯示異動紀錄清單
    [Tags]    1007 會員異動紀錄
    Search MemberName    ${Testing.MemberName}
    Check Data Changed Record
    Wait Until Element Is Visible    //tbody
    Element Should Contain    //tbody     公發簽證變更
1-07-08-02
    [Documentation]     查看會員異動紀錄，公發簽證變更
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員姓名]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[異動紀錄]>顯示異動紀錄清單
    ...  /      6.點擊[明細]
    ...  /      Expected Result: 顯示異動前後的資料
    [Tags]    1007 會員異動紀錄
    Search MemberName    ${Testing.MemberName}
    Check Data Changed Record
    Check Changed Details    公發簽證變更
    Wait Until Element Is Visible   (//label[text()="公發簽證"])[1]/following-sibling::input
    Element Attribute Value Should Be    (//label[text()="公發簽證"])[1]/following-sibling::input    value    ${EMPTY}
    Element Attribute Value Should Be    (//label[text()="公發簽證日期"])[1]/following-sibling::input    value    ${EMPTY}
    Element Attribute Value Should Be    (//label[text()="公發簽證"])[2]/following-sibling::input    value    核准
    Element Attribute Value Should Be    (//label[text()="公發簽證日期"])[2]/following-sibling::input    value    112/08/01

1-06-10
    [Documentation]     異動會員資料，執業登記變更
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員編號]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[會員異動]
    ...  /      6.點擊[異動項目]>選擇[執業登記變更變更]
    ...  /      7.切換[執業登記]狀態、並填入收文號]、[異動日期]、[異動原因]
    ...  /      8.點擊[儲存]>跳出[修改成功]>點擊[OK]>點擊[回上一頁]
    ...  /      Expected Result: 點擊[會員姓名]>輸入[王阿明]>點擊[查詢]>點擊[明細]>顯示變更後的執業登記狀態
    [Tags]    11004 會員資料異動
    Search MemberName   ${Testing.MemberName}
    Change Member Data     ${ChangeItem.執業登記變更}
    Scroll Element Into View    //a[text()="回上一頁"]
    Click Element    //input[@value="2" and @id="practicingStatus"]
    Input Change Date And Reason
    Save And Back To Preious Page
    Search MemberName    ${Testing.MemberName}
    Check Member Details
    Wait Until Element Is Visible    //label[@for="practicingStatusDesc"]/following-sibling::input
    Element Attribute Value Should Be    //label[@for="practicingStatusDesc"]/following-sibling::input    value     廢止
    Element Attribute Value Should Be    //input[@id="practicingDate"]    value    112/08/01
    Element Attribute Value Should Be    //input[@id="practicingNo"]    value    123
1-07-10-01
    [Documentation]     查看會員異動紀錄，執業登記變更
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員姓名]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[異動紀錄]
    ...  /      Expected Result: 顯示異動紀錄清單
    [Tags]    1007 會員異動紀錄
    Search MemberName    ${Testing.MemberName}
    Check Data Changed Record
    Wait Until Element Is Visible    //tbody
    Element Should Contain    //tbody     執業登記變更
1-07-10-02
    [Documentation]     查看會員異動紀錄，執業登記變更
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員姓名]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[異動紀錄]>顯示異動紀錄清單
    ...  /      6.點擊[明細]
    ...  /      Expected Result: 顯示異動前後的資料
    [Tags]    1007 會員異動紀錄
    Search MemberName    ${Testing.MemberName}
    Check Data Changed Record
    Check Changed Details    執業登記變更
    Wait Until Element Is Visible   (//label[text()="執業登記"])[1]/following-sibling::input
    Element Attribute Value Should Be    (//label[text()="執業登記"])[1]/following-sibling::input    value    核准
    Element Attribute Value Should Be    (//label[text()="公文日期"])[1]/following-sibling::input    value    110/12/01
    Element Attribute Value Should Be    (//label[text()="執業登記"])[2]/following-sibling::input    value    廢止
    Element Attribute Value Should Be    (//label[text()="公文日期"])[2]/following-sibling::input    value    112/08/01

1-06-11
    [Documentation]     異動會員資料，停執
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員編號]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[會員異動]
    ...  /      6.點擊[異動項目]>選擇[停執(學分不足)]
    ...  /      7.輸入[停執日期]、[收文號]、[異動日期]、[異動原因]
    ...  /      8.點擊[儲存]>跳出[修改成功]>點擊[OK]>點擊[回上一頁]
    ...  /      Expected Result: 點擊[會員姓名]>輸入[王阿明]>點擊[查詢]>顯示狀態為停執
    [Tags]    11004 會員資料異動
    Search MemberName   ${Testing.MemberName}
    Change Member Data     ${ChangeItem.停執}
    Scroll Element Into View    //a[text()="回上一頁"]
    Input Text    //input[@id="stopExecStartDate"]      112/08/01
    Input Change Date And Reason
    Save And Back To Preious Page
    Search MemberName    ${Testing.MemberName}
    Element Should Contain    //tbody    停執
1-07-11-01
    [Documentation]     查看會員異動紀錄，停執
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員姓名]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[異動紀錄]
    ...  /      Expected Result: 顯示異動紀錄清單
    [Tags]    1007 會員異動紀錄
    Search MemberName    ${Testing.MemberName}
    Check Data Changed Record
    Wait Until Element Is Visible    //tbody
    Element Should Contain    //tbody     停執
1-07-11-02
    [Documentation]     查看會員異動紀錄，停執
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員姓名]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[異動紀錄]>顯示異動紀錄清單
    ...  /      6.點擊[明細]
    ...  /      Expected Result: 顯示異動前後的資料
    [Tags]    1007 會員異動紀錄
    Search MemberName    ${Testing.MemberName}
    Check Data Changed Record
    Check Changed Details    停執
    Wait Until Element Is Visible   (//label[text()="停執日期"])[1]/following-sibling::input
    Element Attribute Value Should Be    (//label[text()="停執日期"])[1]/following-sibling::input    value    ${EMPTY}
    Element Attribute Value Should Be    (//label[text()="停執日期"])[2]/following-sibling::input    value    112/08/01

1-06-12
    [Documentation]     異動會員資料，復執
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員編號]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[會員異動]
    ...  /      6.點擊[異動項目]>選擇[復執]
    ...  /      7.輸入[復執日期]、[收文號]、[異動日期]、[異動原因]
    ...  /      8.點擊[儲存]>跳出[修改成功]>點擊[OK]>點擊[回上一頁]
    ...  /      Expected Result: 點擊[會員姓名]>輸入[王阿明]>點擊[查詢]>顯示狀態為復執
    [Tags]    11004 會員資料異動
    Search MemberName   ${Testing.MemberName}
    Change Member Data     ${ChangeItem.復執}
    Scroll Element Into View    //a[text()="回上一頁"]
    Input Text    //input[@id="stopExecEndDate"]      112/08/01
    Input Change Date And Reason
    Save And Back To Preious Page
    Search MemberName    ${Testing.MemberName}
    Element Text Should Be    //tbody/tr/td[6]    正常
1-06-13
    [Documentation]     異動會員資料，退會
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[執業會員資料管理]
    ...  /      4.點擊[會員編號]>輸入[王阿明]
    ...  /      5.點擊[查詢]>點擊[會員異動]
    ...  /      6.點擊[異動項目]>選擇[退會]
    ...  /      7.輸入[退會日期]、[收文號]、[異動日期]、[異動原因]
    ...  /      8.點擊[儲存]>跳出[修改成功]>點擊[OK]>點擊[回上一頁]
    ...  /      Expected Result: 點擊[會員姓名]>輸入[王阿明]>點擊[查詢]>顯示狀態為退會
    [Tags]    11004 會員資料異動
    Search MemberName   ${Testing.MemberName}
    Change Member Data     ${ChangeItem.退會}
    Scroll Element Into View    //a[text()="回上一頁"]
    Input Text    //input[@id="rocQuitDate"]      112/08/01
    Input Change Date And Reason
    Save And Back To Preious Page
    Search MemberName    ${Testing.MemberName}
    Element Text Should Be    //tbody/tr/td[6]    退會


#1-04-01(1)
#    [Documentation]     查看會員詳細資料
#    ...  /      1.開啟全國會計師聯會公會網站
#    ...  /      2.輸入測試者帳密，點擊[登入]
#    ...  /      3.點擊[會員管理]>點擊[會員資料管理]
#    ...  /      4.點擊[會員編號]>輸入[張清煌]>點擊[0373-張清煌]加入到[會員編號]
#    ...  /      5.點擊[查詢]>點擊[明細]
#    ...  /      Expected Result: 檢視[張清煌]會員明細資料
#    [Tags]    1004 會員資料明細
#    Search MemberName    張清煌
#    Check Member Details
#    Wait Until Page Contains Element    //input[@id="memberName"]
#    Element Attribute Value Should Be    //input[@id="memberName"]    value     張清煌
#    Sleep    5
1-05-01(1)
    [Documentation]     查看會員詳細資料
    ...  /      1.開啟全國會計師聯會公會網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[空戶會員管理]
    ...  /      4.點擊[查詢]>點擊[匯出]
    ...  /      Expected Result: 應取得匯出檔, 且內容與頁面上[查詢]的清單一致
    [Tags]    6001 空戶會員
    Wait Until Element Is Enabled   //div[@id="navbar"]/ul/li[1]/a
    Click Element   //div[@id="navbar"]/ul/li[1]/a
    Wait Until Element Is Visible    //a[text()="空戶會員管理"]
    Click Element    //a[text()="空戶會員管理"]
    Wait Until Element Is Visible    //button[text()="查詢"]
    Click Element    //button[text()="查詢"]
    Click Element    //button[text()="匯出"]




