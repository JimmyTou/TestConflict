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
&{Testing}  OfficeTaxId=76326631
...         MainOfficeTaxId=76326631   OfficeEname=suger
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
    [Documentation]    會員管理>事務所月結管理
    Wait Until Element Is Enabled   //div[@id="navbar"]/ul/li[1]/a
    Click Element   //div[@id="navbar"]/ul/li[1]/a
    Wait Until Element Is Visible    //a[text()="事務所月結管理"]
    Click Element    //a[text()="事務所月結管理"]
#Search OfficeName
#    [Arguments]    ${OfficeTaxId}
#    Wait Until Element Is Visible    (//input[@class="select2-search__field"])[2]
#    Input Text    (//input[@class="select2-search__field"])[2]     ${OfficeTaxId}
#    Press Key    (//input[@class="select2-search__field"])[2]    \\13
#    Click Element    //button[@onclick="query()"]
Search Officeid
    [Arguments]    ${MainOfficeTaxId}
    Wait Until Element Is Visible    (//input[@class="select2-search__field"])[2]
    Input Text    (//input[@class="select2-search__field"])[2]     ${MainOfficeTaxId}
    Press Key    (//input[@class="select2-search__field"])[2]    \\13
    Click Element    //button[@onclick="query()"]
Add office
    Click Element    //button[@class="ant-btn ant-btn-primary"]
    Input Text    //input[@class="ant-select-selection-overflow"]    76326631
    Click Element    /html/body/div[2]/div/div[2]/div/div[2]/div[3]/button[2]/span


*** Test Cases ***

2-06-01
    [Documentation]     新增事務所
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[事務所月結群組]
    ...  /      4.點擊[新增]>點擊[事務所統編]>輸入[76326631]>點擊[76326631-爍益聯合會計師事務所]
    ...  /      5.點擊[確認]
    ...  /      Expected Result: 顯示爍益聯合會計師事務所於下方清單
    [Tags]    2006 事務所月結新增
    Add office


