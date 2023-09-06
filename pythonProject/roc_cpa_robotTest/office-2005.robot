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
...         MainOfficeTaxId=76326631   ChangeReason=編輯
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
    Wait Until Element Is Visible    (//input[@class="select2-search__field"])[2]
    Input Text    (//input[@class="select2-search__field"])[2]     ${MainOfficeTaxId}
    Press Key    (//input[@class="select2-search__field"])[2]    \\13
    Click Element    //button[@onclick="query()"]

Edit office
    Click Element    (//button[@class="btn btn-outline-primary btn-sm"])[2]
    Sleep    2
    Input Text    //input[@id="officePhone"]    0912345678
    Sleep    2
    Input Text    //input[@id="officeEmail"]    test@gmail.com
    Sleep    2
    Input Text    //input[@id="officeLink"]   test@gmail.com
    Sleep    2
    Input Text    //input[@id="startDate"]    112/07/01
    Sleep    2
    Click Element    //button[@class="btn btn-outline-info btn-sm"]
    Sleep    2
    Click Element    //button[text()="OK"]

*** Test Cases ***

2-05-01
    [Documentation]     事務所編輯
    ...  /      1.開啟全聯會E化系統網站
    ...  /      2.輸入測試者帳密，點擊[登入]
    ...  /      3.點擊[會員管理]>點擊[事務所管理]
    ...  /      4.點擊[主事務所統編]>輸入[76326631]>點擊[76326631-爍益聯合會計師事務所]加入到[主事務所統編]
    ...  /      5.點擊[查詢]>[編輯]
    ...  /      Expected Result: 顯示爍益聯合會計師事務所編輯資料於查詢結果
    [Tags]    2005 事務所編輯
    Search Officeid    ${Testing.MainOfficeTaxId}
    Sleep    3
    Wait Until Element Is Visible    //tbody/tr
    Scroll Element Into View    //tbody/tr
    Edit office
    Search OfficeName    76326631
    Scroll Element Into View    //tbody/tr
    Sleep    5
    Click Element    (//button[@class="btn btn-outline-info btn-sm"])[3]
    Scroll Element Into View    (//div/input)[19]
    Sleep    10
    Click Element    //a[@class="btn btn-outline-primary btn-sm"]
