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

Search officeName
    [Arguments]    ${OfficeTaxId}
    Wait Until Element Is Visible    (//input[@class="select2-search__field"])[2]
    Input Text    (//input[@class="select2-search__field"])[2]     ${OfficeTaxId}
    Press Key    (//input[@class="select2-search__field"])[2]    \\13
    Click Element    //button[@onclick="query()"]
    Wait Until Element Is Enabled    (//button[@class="btn btn-outline-info btn-sm"])[3]
    Click Element    (//button[@class="btn btn-outline-info btn-sm"])[3]



*** Test Cases ***
2-01-04
    [Documentation]     查詢主統編
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[事務所管理]
    ...  /      4.點擊[事務所統編]>輸入[華林聯合]>點擊[98774393-華林聯合會計師事務所]加入到[事務所統編]
    ...  /      5.點擊[查詢]>點擊[明細]
    ...  /      Expected Result: 顯示華林聯合會計師事務所詳細資料
    [Tags]    2001 事務所查詢
    Search officeName    ${Testing.MainOfficeTaxId}
    Wait Until Element Is Visible    //input[@id="officeTaxId"]
   ${name}    Get Element Attribute    //input[@id="officeTaxId"]    value
   Should Contain    ${name}    ${Testing.MainOfficeTaxId}
