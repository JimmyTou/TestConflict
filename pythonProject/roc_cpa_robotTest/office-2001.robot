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
Search OfficeName
    [Arguments]    ${OfficeTaxId}
    Wait Until Element Is Visible    (//input[@class="select2-search__field"])[2]
    Input Text    (//input[@class="select2-search__field"])[2]     ${OfficeTaxId}
    Press Key    (//input[@class="select2-search__field"])[2]    \\13
    Click Element    //button[@onclick="query()"]
Search Officeid
    [Arguments]    ${MainOfficeTaxId}
    Wait Until Element Is Visible    (//input[@class="select2-search__field"])[1]
    Input Text    (//input[@class="select2-search__field"])[1]     ${MainOfficeTaxId}
    Press Key    (//input[@class="select2-search__field"])[1]    \\13
    Click Element    //button[@onclick="query()"]
Search PracticingDate
    [Arguments]     ${StartDateS}    ${StartDateE}
    Wait Until Element Is Visible    //input[@id="startDateS"]
    Input Text    //input[@id="startDateS"]     ${StartDateS}
    Input Text    //input[@id="startDateE"]     ${StartDateE}
    Click Element    //button[@onclick="query()"]


*** Test Cases ***

2-01-01
    [Documentation]     查詢主統編
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[事務所管理]
    ...  /      4.點擊[主事務所統編]>輸入[76312215]>點擊[76312215-碩品會計師事務所]加入到[主事務所統編]
    ...  /      5.點擊[查詢]
    ...  /      Expected Result: 顯示碩品會計師事務所於查詢結果
    [Tags]    2001 事務所查詢
    Search Officeid    ${Testing.MainOfficeTaxId}
    Wait Until Element Is Visible    //table/tbody
    FOR    ${name}    IN    //table/tbody
        Element Should Contain    ${name}   ${Testing.MainOfficeTaxId}
        Scroll Element Into View    //table/tbody
    END
2-01-02
    [Documentation]     查詢統編
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[事務所管理]
    ...  /      4.點擊[事務所統編]>輸入[76312215]>點擊[76312215-碩品會計師事務所]加入到[事務所統編]
    ...  /      5.點擊[查詢]
    ...  /      Expected Result: 顯示碩品會計師事務所於查詢結果
    [Tags]    2001 事務所查詢
    Search OfficeName    ${Testing.OfficeTaxId}
    Wait Until Element Is Visible    //table/tbody/tr/td[2]
    FOR    ${name}    IN    //table/tbody/tr/td[2]
        Element Should Contain    ${name}   ${Testing.OfficeTaxId}
        Scroll Element Into View   //tbody/tr/td[2]
    END
2-01-03
    [Documentation]     查詢成立日期
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[事務所管理]
    ...  /      4.點擊[成立起日]>輸入[112/01/01](或點擊小日曆選擇[112年]>[一月]>[1])
    ...  /      5.點擊[成立迄日]>輸入[112/12/31](或點擊小日曆選擇[112年]>[十二月]>[31])
    ...  /      6.點擊[查詢]
    ...  /      Expected Result: 顯示成立日期為112/01/01~112/12/31的事務所於查詢結果
    [Tags]    2001 事務所查詢
    Search PracticingDate    112/01/01  112/12/31
    Wait Until Element Is Visible    //table/tbody
    FOR    ${name}    IN    //table/tbody
        Element Should Contain    ${name}   112
        Scroll Element Into View    //table/tbody
    END

