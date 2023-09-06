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
&{ChangeItem}   事務所負責人變更=D      事務所登錄狀態異動=I      事務所地址變更=C
...             主分所互換變更=E     事務所統編變更=F    事務所型態變更=H     事務所更名=A

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

Search officeName
    [Arguments]    ${OfficeTaxId}
    Wait Until Element Is Visible    (//input[@class="select2-search__field"])[2]
    Input Text    (//input[@class="select2-search__field"])[2]     ${OfficeTaxId}
    Press Key    (//input[@class="select2-search__field"])[2]    \\13
    Click Element    //button[@onclick="query()"]
    Wait Until Element Is Enabled     (//button[@class="btn btn-outline-primary btn-sm"])[3]
    Click Element    (//button[@class="btn btn-outline-primary btn-sm"])[3]
    Wait Until Element Is Enabled    //select[@id="changeItem"]


Change Office Data
    [Documentation]     事務所異動
    [Arguments]    ${SelectValue}
    Wait Until Element Is Enabled    //select[@id="changeItem"]
    Select From List By Value    //select[@id="changeItem"]     ${SelectValue}
deiete Office
    [Documentation]     事務所異動
    [Arguments]    ${SelectValue}
    Wait Until Element Is Enabled    //select[@id="changeItem"]
    Select From List By Value    //select[@id="changeItem"]     ${SelectValue}
Change Office Address
    [Documentation]     事務所異動
    [Arguments]    ${SelectValue}
    Wait Until Element Is Enabled    //select[@id="changeItem"]
    Select From List By Value    //select[@id="changeItem"]     ${SelectValue}
Change Office Head
    [Documentation]     事務所異動
    [Arguments]    ${SelectValue}
    Wait Until Element Is Enabled    //select[@id="changeItem"]
    Select From List By Value    //select[@id="changeItem"]     ${SelectValue}
Save And Back To Preious Page
    [Documentation]    儲存並回上頁
    Click Element    //button[@id="save"]
    Wait Until Page Contains    修改成功
    Click Element    //button[text()="OK"]
    Wait Until Element Is Enabled    //a[text()="回上一頁"]
    Scroll Element Into View    //a[text()="回上一頁"]
    Click Element    //a[text()="回上一頁"]

anew search officeName
    [Arguments]    ${OfficeTaxId}
      Input Text    (//input[@class="select2-search__field"])[2]     ${OfficeTaxId}
      Press Key    (//input[@class="select2-search__field"])[2]    \\13
      Click Element    //button[@onclick="query()"]

Search officeName2
    [Arguments]    ${OfficeTaxId}
    Wait Until Element Is Visible    (//input[@class="select2-search__field"])[2]
    Input Text    (//input[@class="select2-search__field"])[2]     ${OfficeTaxId}
    Press Key    (//input[@class="select2-search__field"])[2]    \\13
    Click Element    //button[@onclick="query()"]
    Wait Until Element Is Enabled    (//button[@class="btn btn-outline-info btn-sm"])[4]
    Click Element    (//button[@class="btn btn-outline-info btn-sm"])[4]

*** Test Cases ***
2-03-01
      [Documentation]     修改事務所資料
    ...  /      1.開啟全國會計師聯會公會網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.[會員管理]>點擊[事務所管理]
    ...  /      4.點擊[事務所統編]>輸入[李柏瑋會計師]>點擊[99334660-李柏瑋會計師事務所]加入到[事務所統編]
    ...  /      5.點擊[查詢]>點擊[事務所異動]
    ...  /      6.點擊[異動項目]>選擇[事務所更名]
    ...  /      7.輸入[新事務所名稱]:李柏宏會計師事務所、[收文號]:110120100002、[異動日期]:110/12/01及[異動原因]:更名
    ...  /      8.點擊[儲存]>跳出[修改成功]>點擊[OK]>點擊[回上一頁]
    ...  /      Expected Result: 點擊[事務所統編]>輸入[李柏宏會計師事務所]>出現新名稱事務所於查詢結果
    [Tags]    2003 事務所異動
    Search officeName    ${Testing.OfficeTaxId}
    Change Office Data   ${ChangeItem.事務所更名}
    Wait Until Element Is Enabled   //select[@id="officeName"]/option[@value="66事務所"]
    Click Element    //select[@id="officeName"]/option[@value="66事務所"]
    Input Text    //input[@id="recNo"]    378201190
    Input Text    //input[@id="changeDate"]    112/08/10
    Input Text    //input[@id="changeReason"]    更名
    Save And Back To Preious Page
    anew search officeName    ${Testing.OfficeTaxId}
    Wait Until Element Is Visible    //tbody/tr/td[2]
    Element Text Should Be    //tbody/tr/td[2]  ${Testing.OfficeTaxId}
    Scroll Element Into View   //tbody/tr
    Sleep    2
2-04-01
    [Documentation]     查詢事務所異動紀錄
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[事務所管理]
    ...  /      4.點擊[事務所統編]>輸入[李柏宏會計師]>點擊[99334660-李柏宏會計師事務所]加入到[事務所統編]
    ...  /      5.點擊[查詢]>點擊[異動紀錄]
    ...  /      Expected Result: 1.點擊異動項目為[事務所更名]的[明細]
    ...  /      Expected Result: 2.顯示異動前後名稱
    [Tags]    2003 事務所異動
    Search officeName2    ${Testing.OfficeTaxId}
    Wait Until Element Is Visible     //tbody/tr/td[text()="378201190"]/../td[7]/button
    Click Element     //tbody/tr/td[text()="378201190"]/../td[7]/button
    Wait Until Element Is Visible    //input[@class="form-control"]
    ${name}    Get Element Attribute    //input[@class="form-control"]    value
    Should Contain    ${name}    66事務所
    Sleep    2
2-03-02
      [Documentation]     註銷事務所
    ...  /      1.開啟全國會計師聯會公會網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[事務所管理]
    ...  /      4.點擊[事務所統編]>輸入[假裝有這個事務所]>點擊[88881111-假裝有這個事務所]加入到[事務所統編]
    ...  /      5.點擊[查詢]>點擊[事務所異動]
    ...  /      6.點擊[異動項目]>選擇[事務所註銷]
    ...  /      7.輸入[收文號]:110120100003、[異動日期]:110/12/01及[異動原因]:註銷
    ...  /      8.點擊[儲存]>跳出[修改成功]>點擊[OK]>點擊[回上一頁]
    ...  /      Expected Result: 點擊[事務所統編]>輸入[假裝有這個事務所]>點擊[88881111-假裝有這個事務所]加入到[事務所統編]>點擊[查詢]>事務所狀態為註銷
    [Tags]    2003 事務所異動
    Search officeName    ${Testing.OfficeTaxId}
    Change Office Data   ${ChangeItem.事務所登錄狀態異動}
    Wait Until Element Is Enabled   //input[@id="accountingFirmsStatus4"]
    Click Element    //input[@id="accountingFirmsStatus4"]
    Input Text    //input[@id="recNo"]    3899002
    Input Text    //input[@id="changeDate"]    112/08/10
    Input Text    //input[@id="changeReason"]    註銷
    Save And Back To Preious Page
    anew search officeName    ${Testing.OfficeTaxId}
    Wait Until Element Is Visible    //tbody/tr/td[2]
    Element Text Should Be    //tbody/tr/td[2]  ${Testing.OfficeTaxId}
    Scroll Element Into View   //tbody/tr
    Sleep    2

2-04-02
    [Documentation]     查詢事務所異動紀錄
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[事務所管理]
    ...  /      4.點擊[事務所統編]>輸入[假裝有這個事務所]>點擊[88881111-假裝有這個事務所]加入到[事務所統編]
    ...  /      5.點擊[查詢]>點擊[異動紀錄]
    ...  /      Expected Result: 顯示異動項目為[事務所註銷]的紀錄
    [Tags]    2003 事務所異動
    Search officeName2    ${Testing.OfficeTaxId}
    Wait Until Element Is Visible     //tbody/tr/td[text()="3899002"]/../td[7]/button
    Click Element     //tbody/tr/td[text()="3899002"]/../td[7]/button
    Wait Until Element Is Visible    //div[@id="changeStatusBlock"]
    Sleep    2
2-03-03
      [Documentation]     事務所地址變更
    ...  /      1.開啟全國會計師聯會公會網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[事務所管理]
    ...  /      4.點擊[事務所統編]>輸入[吳厚璋會計師]>點擊[A1100672963-吳厚璋會計師事務所]加入到[事務所統編]
    ...  /      5.點擊[查詢]>點擊[事務所異動]
    ...  /      6.點擊[異動項目]>選擇[事務所地址變更]
    ...  /      7.輸入[事務所地址]: 台北市中正區懷寧街100號、[收文號]:110120100004、[異動日期]:110/12/01及[異動原因]:地址變更
    ...  /      8.點擊[儲存]>跳出[修改成功]>點擊[OK]>點擊[回上一頁]
    ...  /      Expected Result: 1.點擊[事務所統編]>輸入[吳厚璋會計師]>點擊[A1100672963-吳厚璋會計師事務所]加入到[事務所統編]>點擊[查詢]
    ...  /                       2.點擊[明細]>地址已經變更
    [Tags]    2003 事務所異動
    Search officeName    ${Testing.OfficeTaxId}
    Change Office Address   ${ChangeItem.事務所地址變更}
    Wait Until Element Is Enabled   //select[@id="officeCity"]/option[@value="基隆市"]
    Click Element    //select[@id="officeCity"]/option[@value="基隆市"]
    Click Element    //select[@id="officeArea"]/option[@value="仁愛區"]
    Input Text    //input[@id="recNo"]    391872201
    Input Text    //input[@id="changeDate"]    112/08/10
    Input Text    //input[@id="changeReason"]    地址變更
    Save And Back To Preious Page
    anew search officeName    ${Testing.OfficeTaxId}
    Wait Until Element Is Visible    //tbody/tr/td[2]
    Element Text Should Be    //tbody/tr/td[2]  ${Testing.OfficeTaxId}
    Scroll Element Into View   //tbody/tr
    Sleep    2
2-04-03
    [Documentation]     查詢事務所異動紀錄
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[事務所管理]
    ...  /      4.點擊[事務所統編]>輸入[吳厚璋會計師]>點擊[A1100672963-吳厚璋會計師事務所]加入到[事務所統編]
    ...  /      5.點擊[查詢]>點擊[異動紀錄]
    ...  /      Expected Result: 1.點擊異動項目為[事務所地址變更]的[明細]
    ...  /                       2.顯示地址變更前後資料
    [Tags]    2003 事務所異動
    Search officeName2    ${Testing.OfficeTaxId}
    Wait Until Element Is Visible     //tbody/tr/td[text()="391872201"]/../td[7]/button
    Click Element     //tbody/tr/td[text()="391872201"]/../td[7]/button
    Wait Until Element Is Visible    //div[@id="changeAddressBlock"]
    Scroll Element Into View    //button[@class="btn btn-outline-primary btn-sm"]
    Sleep    2
2-03-04
      [Documentation]     事務所負責人變更
    ...  /      1.開啟全國會計師聯會公會網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[事務所管理]
    ...  /      4.點擊[事務所統編]>輸入[吳厚璋會計師]>點擊[A1100672963-吳厚璋會計師事務所]加入到[事務所統編]
    ...  /      5.點擊[查詢]>點擊[事務所異動]
    ...  /      6.點擊[異動項目]>選擇[事務所負責人變更]
    ...  /      7.輸入[負責人姓名]:王大明、[職稱]:會計師、[收文號]:110120100005、[異動日期]:110/12/01及[異動原因]:新增負責人
    ...  /      8.點擊[儲存]>跳出[修改成功]>點擊[OK]>點擊[回上一頁]
    ...  /      Expected Result: 1.點擊[事務所統編]>輸入[吳厚璋會計師]>點擊[A1100672963-吳厚璋會計師事務所]加入到[事務所統編]>點擊[查詢]
    ...  /                       2.顯示負責人於查詢結果
    [Tags]    2003 事務所異動
    Search officeName    ${Testing.OfficeTaxId}
    Change Office Head   ${ChangeItem.事務所負責人變更}
    Wait Until Element Is Enabled   //input[@id="principalName"]
    Input Text       //input[@id="principalName"]  唐本言
    Input Text    //input[@id="recNo"]    722010001
    Input Text    //input[@id="changeDate"]    112/08/10
    Input Text    //input[@id="changeReason"]    負責人變更
    Save And Back To Preious Page
    anew search officeName    ${Testing.OfficeTaxId}
    Wait Until Element Is Visible    //tbody/tr/td[2]
    Element Text Should Be    //tbody/tr/td[2]  ${Testing.OfficeTaxId}
    Scroll Element Into View   //tbody/tr
    Sleep    2
2-04-04
    [Documentation]     查詢事務所異動紀錄
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[事務所管理]
    ...  /      4.點擊[事務所統編]>輸入[吳厚璋會計師]>點擊[A1100672963-吳厚璋會計師事務所]加入到[事務所統編]
    ...  /      5.點擊[查詢]>點擊[異動紀錄]
    ...  /      Expected Result: 1.點擊異動項目為[事務所負責人變更]的[明細]
    ...  /                       2.顯示負責人變更前後資料
    [Tags]    2003 事務所異動
    Search officeName2    ${Testing.OfficeTaxId}
    Wait Until Element Is Visible     //tbody/tr/td[text()="722010001"]/../td[7]/button
    Click Element     //tbody/tr/td[text()="722010001"]/../td[7]/button
    Wait Until Element Is Visible    //div[@id="changePrincipalBlock"]
    Scroll Element Into View    //button[@class="btn btn-outline-primary btn-sm"]
    Sleep    2
2-03-05
      [Documentation]     事務所負責人變更
    ...  /      1.開啟全國會計師聯會公會網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[事務所管理]
    ...  /      4.點擊[事務所統編]>輸入[吳厚璋會計師]>點擊[A1100672963-吳厚璋會計師事務所]加入到[事務所統編]
    ...  /      5.點擊[查詢]>點擊[事務所異動]
    ...  /      6.點擊[異動項目]>選擇[事務所負責人變更]
    ...  /      7.輸入[負責人姓名]:王大明、[職稱]:會計師、[收文號]:110120100005、[異動日期]:110/12/01及[異動原因]:新增負責人
    ...  /      8.點擊[儲存]>跳出[修改成功]>點擊[OK]>點擊[回上一頁]
    ...  /      Expected Result: 1.點擊[事務所統編]>輸入[吳厚璋會計師]>點擊[A1100672963-吳厚璋會計師事務所]加入到[事務所統編]>點擊[查詢]
    ...  /                       2.顯示負責人於查詢結果
    [Tags]    2003 事務所異動
    Search officeName    ${Testing.OfficeTaxId}
    Change Office Head   ${ChangeItem.事務所負責人變更}
    Wait Until Element Is Enabled   //input[@id="principalName"]
    Input Text       //input[@id="principalName"]  唐本言
    Input Text    //input[@id="recNo"]    722010001
    Input Text    //input[@id="changeDate"]    112/08/10
    Input Text    //input[@id="changeReason"]    負責人變更
    Save And Back To Preious Page
    anew search officeName    ${Testing.OfficeTaxId}
    Wait Until Element Is Visible    //tbody/tr/td[2]
    Element Text Should Be    //tbody/tr/td[2]  ${Testing.OfficeTaxId}
    Scroll Element Into View   //tbody/tr
    Sleep    2