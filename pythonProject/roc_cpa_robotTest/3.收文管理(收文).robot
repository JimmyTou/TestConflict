*** Settings ***
Documentation  Tags in Robot Framework
Library    SeleniumLibrary
Library    BuiltIn
Library    String
Library    Collections
Library    OperatingSystem
Library    Screenshot

Suite Setup    Setup
Test Setup    Practicing Member Data Maintain
*** Variables ***
&{Login}    Account=admin  Password=3edc4rfv%TGB^YHN
...         Url=https://test.ROCcpa.org.tw/TACCTG/loginPage#
...         Browser=chrom
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
    Login    ${Login.Account}     ${Login.Password}
Open Page
    Open Browser    ${Login.Url}  ${Login.Browser}
#    ${chromedriver_path}=   Get Chromedriver Path
#    ${op}=   Get Chromedriver Op
#    Create Webdriver    ${browser}   executable_path=${chromedriver_path}  options=${op}
    Maximize Browser Window
Login
    [Arguments]    ${account}   ${password}
    Wait Until Element Is Enabled    //input[@name="userCode"]
    Input Text    //input[@name="userCode"]    ${account}
    Input Text    //input[@type="password"]   ${password}
    Click Element    //button[@type="submit"]
Logout
    Click Element    //button[@id="logout"]
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



Document Management01
    [Documentation]    公文管理進入收文
    Click Element    //div[@id="navbar"]/ul/li[3]/a
    Click Element    //a[@href="/TACCTG/documentReceive/manage/list"]
Document Management_search
    [Documentation]    公文管理搜尋公文
    [Arguments]    ${var1}
    Input Text    //input[@id="receivedDateStart"]   ${EMPTY}
    Input Text    //input[@id="assignPersonnelName"]   ${EMPTY}
    Input Text    //input[@id="receiveNo"]     ${var1}
    Click Element    //button[@onclick="query('receive-form')"]
    Wait Until Element Is Enabled    //tbody/tr/td
    Scroll Element Into View    //tbody/tr/td
Document Management_add
    [Documentation]    收文新增
    [Arguments]    ${comDate}   ${comNo2}  ${gist}  112/08/11    001   測試主旨
    Click Element    //button[@onclick="add('receive')"]
    Click Element    //span[@id="select2-comeOrgan-container"]
#    輸入資料
    Click Element  //class[@id="select2-comeOrgan-result-fcmr-001"]
    Click Element    //span[@id="select2-receiveType-container"]
    Click Element    //li[@id="select2-receiveType-result-w02s-電子"]
    Input Text    //text[@id="comeDate"]     ${comDate}
    Input Text    //text[@id="comeNo2"]     ${comNo2}
    Input Text    //textarea[@id="gist"]   ${gist}






*** Test Cases ***
3-05-01
    [Documentation]     收文管理收文指派
...         1.開啟全聯會E化系統網站
...         2.輸入總收發文人員帳密，點擊[登入]
...         3.點擊[公文管理]>點擊[收文管理]
...         4.點擊[收文號]>輸入[1120503]
...         5.點擊[查詢]>點擊[重新指派]
...         6.點擊[重新指派人員]:document05-副秘書長
...         7.點擊[儲存]>跳出[修改成功]>點擊[OK]
...         Expected Result: 顯示公文的指派人為副秘書長

<<<<<<< HEAD
[Tags]    10005 收文管理收文指派
    Document Management01  1120503
=======
    [Tags]    10005 收文管理收文指派
    Document Management01   1120503
>>>>>>> 1814ad1c05dd32989a0f63f746c92db72590d5bf
    Click Element     //button[@class="btn btn-outline-danger btn-sm"]
    Execute JavaScript    window.scrollTo(0, 500)
    Click Element    //span[@id="select2-assignPersonnel-container"]
    Input Text        //span[@class="select2-search select2-search--dropdown"]/input   副秘書長
    Press Key    //span[@class="select2-search select2-search--dropdown"]/input   \\13
    Click Element    //button[@onclick="doAssign()"]
    Click Element    //button[@class="confirm"]
    Sleep    5
#    查尋結果
<<<<<<< HEAD
    Document Management01  1120503
=======
    Document Management01  1120507
    Logout
    Login   document05   1qaz2wsx
    Click Element    //div[@id="navbar"]/ul[1]/li[3]/ul/li[1]/a
    Click Element    //a[@href="/TACCTG/documentReceive/manage/list"]
    Click Element    //button[@onclick="query('receive-form')"]
    Click Element    //button[@onclick="assign(198352 ,&quot;receive&quot;)"]
>>>>>>> 1814ad1c05dd32989a0f63f746c92db72590d5bf

    Execute JavaScript    window.scrollTo(0, 500)
    Input Text    //input[@id="caseOfficerOpinion"]     test意見簽核
    Click Element    //button[@onclick="doAssign()"]
    Sleep    3
    Click Element   //button[@class="confirm"]
    Execute JavaScript    window.scrollTo(0, 0)
    Click Element    //span[@id="select2-assignPersonnel-container"]
    Input Text        //span[@class="select2-search select2-search--dropdown"]/input   admin
    Press Key    //span[@class="select2-search select2-search--dropdown"]/input   \\13
    Click Element    //button[@onclick="doAssign()"]
    Click Element    //button[@class="confirm"]
    Logout
    Login   admin   3edc4rfv%TGB^YHN
    Document Management01    1120507
