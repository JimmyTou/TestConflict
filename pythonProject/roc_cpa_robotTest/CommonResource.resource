*** Settings ***
Documentation    共用程式碼
Library    SeleniumLibrary
Library    BuiltIn
Library    String
Library    Collections
Library    OperatingSystem
Library    Screenshot

*** Variables ***
${IFrameId}   ng-frame
${Browser}  Chrome
${Url}      https://test.ROCcpa.org.tw/TACCTG/loginPage#
&{Admin}    Account=admin  Password=3edc4rfv%TGB^YHN
&{Accountant}   Account=E224542548  Password=5tgb6yhn&UJM*IK<
&{Handler}  Account=document02  Password=1qaz2wsx
&{Employee}  Account=document04  Password=1qaz2wsx
*** Keywords ***
Open Page
    Open Browser    ${Url}  ${Browser}
#    ${chromedriver_path}=   Get Chromedriver Path
#    ${op}=   Get Chromedriver Op
#    Create Webdriver    ${browser}   executable_path=${chromedriver_path}  options=${op}
    Maximize Browser Window
Login
    [Arguments]    ${User}
    Wait Until Element Is Enabled    //input[@name="userCode"]
    Input Text    //input[@name="userCode"]    ${User.Account}
    Input Text    //input[@type="password"]   ${User.Password}
    Click Element    //button[@type="submit"]
Click And Enabled
    [Arguments]    ${Element}
    Wait Until Element Is Enabled    ${Element}
    Click Element    ${Element}
Click And Visible
    [Arguments]    ${Element}
    Wait Until Element Is Visible    ${Element}
    Click Element    ${Element}
Wait And Input
    [Arguments]    ${Element}   ${Text}
    Wait Until Element Is Enabled    ${Element}
    Input Text    ${Element}    ${Text}
Activities And Course Maintain
    Click And Enabled    //div[@id="navbar"]//li[contains(.,"課程活動報名管理")]
    Click And Visible    //a[text()="活動與課程管理"]
Scroll In IFrame
    [Arguments]    ${Length}
    Unselect Frame
    Execute Javascript    window.scrollTo(0, ${Length})
    Select Frame    //iframe[@id="${IFrameId}"]
Wait And Select Frame
    [Arguments]    ${Id}
    Wait Until Element Is Visible    //iframe[@id="${Id}"]
    Select Frame    //iframe[@id="${Id}"]
Clear Input Text
    [Documentation]    清空元素中的字串
    [Arguments]    ${Element}
    ${value}     Get Element Attribute   ${Element}      value
    ${backspaces count}    Get Length      ${value}
    Run Keyword If    """${value}""" != ''
    ...     Repeat Keyword  ${backspaces count}  Press Key  ${Element}   \\08
Clear And Input Text
    [Arguments]    ${Element}   ${Text}
    Wait Until Element Is Enabled    ${Element}
    Clear Input Text    ${Element}
    Input Text    ${Element}    ${Text}