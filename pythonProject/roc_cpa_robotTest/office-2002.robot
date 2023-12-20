*** Settings ***
Documentation  Tags in Robot Framework
Library    SeleniumLibrary
Library    BuiltIn
Library    String
Library    Collections
Library    OperatingSystem
Library    Screenshot

Suite Setup    Setup
Test Setup    Office Data Maintain

*** Variables ***
&{Login}    Account=admin  Password=3edc4rfv%TGB^YHN
...         Url=https://test.ROCcpa.org.tw/TACCTG/loginPage#
...         Browser=Chrome
&{Testing}  OfficeTaxId=27392776
...         MainOfficeTaxId=73883772   OfficeEname=suger
...         PrincipalName=康本言     JobTitle=會計師
...         ContactName=康本言      ContactPhone=0922928177
...         StartDate=110/01/01     RecNo=10019801
...         ChangeDate=110/01/02      ChangeReason=新增
*** Keywords ***
Setup
    Open Page
    Login    ${Login.Account}     ${Login.Password}
Open Page
    Open Browser    ${Login.Url}  ${Login.Browser}
    Maximize Browser Window
Login
    [Arguments]    ${account}   ${password}
    Wait Until Element Is Enabled    //input[@name="userCode"]
    Input Text    //input[@name="userCode"]    ${account}
    Input Text    //input[@type="password"]   ${password}
    Click Element    //button[@type="submit"]
 Office Data Maintain
    [Documentation]    會員管理>事務所管理
    Wait Until Element Is Enabled   //div[@id="navbar"]/ul/li[1]/a
    Click Element   //div[@id="navbar"]/ul/li[1]/a
    Wait Until Element Is Visible    //a[text()="事務所管理"]
    Click Element    //a[text()="事務所管理"]
Add New office
    [Documentation]    新增事務所
    Wait Until Element Is Enabled   //button[@onclick="add()"]
    Click Element    //button[@onclick="add()"]
    Input Text    //input[@id="mainOfficeTaxId"]     ${Testing.MainOfficeTaxId}
    Input Text    //input[@id="officeTaxId"]     ${Testing.OfficeTaxId}
    Click Element    //input[@id="accountingFirmsType1"]
    Click Element    //select[@id="officeName"]/option[@value="本言事務所"]
    Input Text    //input[@id="officeEname"]     ${Testing.OfficeEname}
    Input Text    //input[@id="principalName"]     ${Testing.PrincipalName}
    Input Text    //input[@id="jobTitle"]     ${Testing.JobTitle}
    Input Text    //input[@id="contactName"]     ${Testing.ContactName}
    Input Text    //input[@id="contactPhone"]     ${Testing.ContactPhone}
    Input Text    //input[@id="startDate"]     ${Testing.StartDate}
    Input Text    //input[@id="recNo"]     ${Testing.RecNo}
    Input Text    //input[@id="changeDate"]     ${Testing.ChangeDate}
    Input Text    //input[@id="changeReason"]     ${Testing.ChangeReason}
    Scroll Element Into View    //button[@id="save"]
    Click Element    //button[@id="save"]
    Wait Until Page Contains    新增成功
    Click Element    //button[text()="OK"]
Add New office2
    [Documentation]    新增事務所
    Wait Until Element Is Enabled   //button[@onclick="add()"]
    Click Element    //button[@onclick="add()"]
    Input Text    //input[@id="mainOfficeTaxId"]     ${Testing.MainOfficeTaxId}
    Input Text    //input[@id="officeTaxId"]     ${Testing.OfficeTaxId}
    Click Element    //input[@id="accountingFirmsType1"]
    Click Element    //select[@id="officeName"]/option[@value="本言事務所"]
    Input Text    //input[@id="officeEname"]     ${Testing.OfficeEname}
    Input Text    //input[@id="principalName"]     ${Testing.PrincipalName}
    Input Text    //input[@id="jobTitle"]     ${Testing.JobTitle}
    Input Text    //input[@id="contactName"]     ${Testing.ContactName}
    Input Text    //input[@id="contactPhone"]     ${Testing.ContactPhone}
    Input Text    //input[@id="startDate"]     ${Testing.StartDate}
    Input Text    //input[@id="recNo"]     ${Testing.RecNo}
    Input Text    //input[@id="changeDate"]     ${Testing.ChangeDate}
    Input Text    //input[@id="changeReason"]     ${Testing.ChangeReason}
    Scroll Element Into View    //button[@id="save"]
    Click Element    //button[@id="save"]
    Wait Until Page Contains    新增失敗
    Sleep    2
    Click Element    //button[text()="OK"]
Add New office3
    [Documentation]    新增事務所
    Wait Until Element Is Enabled   //button[@onclick="add()"]
    Click Element    //button[@onclick="add()"]
    Input Text    //input[@id="mainOfficeTaxId"]     ${Testing.MainOfficeTaxId}
    Input Text    //input[@id="officeTaxId"]     ${Testing.OfficeTaxId}
    Click Element    //input[@id="accountingFirmsType1"]
    Click Element    //select[@id="officeName"]/option[@value="cc0"]
    Input Text    //input[@id="officeEname"]     ${Testing.OfficeEname}
    Input Text    //input[@id="principalName"]     ${Testing.PrincipalName}
    Input Text    //input[@id="jobTitle"]     ${Testing.JobTitle}
    Input Text    //input[@id="contactName"]     ${Testing.ContactName}
    Input Text    //input[@id="contactPhone"]     ${Testing.ContactPhone}
    Input Text    //input[@id="startDate"]     ${Testing.StartDate}
    Input Text    //input[@id="recNo"]     ${Testing.RecNo}
    Input Text    //input[@id="changeDate"]     ${Testing.ChangeDate}
    Input Text    //input[@id="changeReason"]     ${Testing.ChangeReason}
    Scroll Element Into View    //button[@id="save"]
    Click Element    //button[@id="save"]
    Wait Until Page Contains    新增失敗
    Sleep    2
    Click Element    //button[text()="OK"]
Search OfficeName
    [Arguments]    ${OfficeTaxId}
    Wait Until Element Is Visible    (//input[@class="select2-search__field"])[2]
    Input Text    (//input[@class="select2-search__field"])[2]     ${OfficeTaxId}
    Press Key    (//input[@class="select2-search__field"])[2]    \\13
    Click Element    //button[@onclick="query()"]
Save And Back To Preious Page
    [Documentation]    儲存並回上頁
    Click Element    //button[@id="save"]
    Wait Until Page Contains    修改成功
    Click Element    //button[text()="OK"]
    Wait Until Element Is Enabled    //a[text()="回上一頁"]
    Scroll Element Into View    //a[text()="回上一頁"]
    Click Element    //a[text()="回上一頁"]

*** Test Cases ***

2-02-01
    [Documentation]     新增事務所
    ...  /      1.開啟全國會計師聯會公會網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[事務所管理]
    ...  /      4.輸入[主事務所統編]:A221323725、[事務所統編]:A221323729、[事務所名稱]:德茂會計師事務所台北分所、[事務所英文名]:A221323729、[負責人姓名]:陳聖芬、[負責人職稱]:執業會計師、[聯絡人姓名]:陳聖芬、[聯絡人電話]:0229247523、[成立日期]:107/03/26、[收文號]: 110120100001、[異動日期]: 110/12/01、[異動原因]:新增台北分所
    ...  /      5.點擊[儲存]>跳出[新增成功]>點擊[ok]
    ...  /      Expected Result: 顯示德茂會計師事務所台北分所於查詢結果
    [Tags]    2002 事務所新增
    Add New Office
    Office Data Maintain
    Search OfficeName    ${Testing.OfficeTaxId}
    Wait Until Element Is Visible    //tbody/tr/td[2]
    Scroll Element Into View      //tbody/tr/td[2]
    Element Text Should Be    //tbody/tr/td[2]  ${Testing.OfficeTaxId}
    Scroll Element Into View   //tbody/tr
    Sleep    3
2-02-02
    [Documentation]     新增事務所失敗
    ...  /      1.開啟全國會計師聯會公會網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[事務所管理]
    ...  /      4.點擊[新增]
    ...  /      5.輸入[主事務所統編]:A221323725、[事務所統編]:A221323729、[事務所名稱]:德茂會計師事務所台北分所、[事務所英文名]:A221323729、[負責人姓名]:陳聖芬、[負責人職稱]:執業會計師、[聯絡人姓名]:陳聖芬、[聯絡人電話]:0229247523、[成立日期]:107/03/26、[收文號]: 110120100001、[異動日期]: 110/12/01、[異動原因]:新增台北分所
    ...  /      6.點擊[儲存]
    ...  /      Expected Result: 跳出新增失敗
    [Tags]    2002 事務所新增
    Add New Office2

2-02-03
    [Documentation]     新增事務所失敗
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[事務所管理]
    ...  /      4.點擊[新增]
    ...  /      5.輸入[主事務所統編]:A221323725、[事務所統編]:A221323729、[事務所名稱]:德茂會計師事務所台北分所、[事務所英文名]:A221323729、[負責人姓名]:陳聖芬、[負責人職稱]:執業會計師、[聯絡人姓名]:陳聖芬、[聯絡人電話]:0229247523、[成立日期]:107/03/26、[收文號]: 110120100001、[異動日期]: 110/12/01、[異動原因]:新增台北分所
    ...  /      6.點擊[儲存]
    ...  /      Expected Result: 跳出新增失敗>[事務所名稱非有效之預查資料]
    [Tags]    2002 事務所新增
    Add New office3
