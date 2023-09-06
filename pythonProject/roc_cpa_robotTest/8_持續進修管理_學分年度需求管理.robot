*** Settings ***
Documentation   持續進修自動測試腳本(8-20-01~8-21-03)
...             雖然完整測試後會自動刪除測試中新增之資料，以利重複測試
...             測試前請先確認參數${creditRequirement.Year}此年份之學分需求不存在，使參數不重複，以利測試正確執行

Resource    Resource/8_持續進修管理_共用關鍵字.resource

Suite Setup    Setup
Test Setup    Credit Maintain
Test Teardown    Unselect Frame

*** Variables ***
&{CreditRequirement}    Year=109    Specialist=20    Specialist2=0    Specialist3=0    Credit=0
    ...            Credit2=0    Credit3=0    Aml=3    ProfessionalEthics=0    RecoSpecialist=20
    ...            RecoNonspecialist=20    RecoAml=3    RecoProfessionalEthics=0    Multiple=2
&{WrongRequirement}    Year=109    Specialist=abc    Specialist2=0    Specialist3=0    Credit=0
    ...            Credit2=0    Credit3=0    Aml=3    ProfessionalEthics=0    RecoSpecialist=cde
    ...            RecoNonspecialist=20    RecoAml=3    RecoProfessionalEthics=0    Multiple=2

*** Keywords ***

Setup
    Open Page
    Login   ${Employee}
Credit Maintain
    Click And Enabled    //div[@id="navbar"]//li[contains(.,"課程活動報名管理")]
    Click And Visible    //a[text()="學分管理"]
    Wait And Select Frame    ${IFrameId}
Input Credit Requirement
    [Documentation]    輸入學分需求資料
    [Arguments]    ${creditRequirement}
    Click And Enabled    ${Button.Add}
    Wait And Select Frame    ${IFrameId}
    Wait And Input    //input[@id="basic_year"]     ${creditRequirement.Year}
    Wait And Input    //input[@id="basic_specialist"]     ${creditRequirement.Specialist}
    Wait And Input    //input[@id="basic_specialist2"]     ${creditRequirement.Specialist2}
    Wait And Input    //input[@id="basic_specialist3"]     ${creditRequirement.Specialist3}
    Wait And Input    //input[@id="basic_credit"]     ${creditRequirement.Credit}

    Wait And Input    //input[@id="basic_credit2"]     ${creditRequirement.Credit2}
    Wait And Input    //input[@id="basic_credit3"]     ${creditRequirement.Credit3}
    Wait And Input    //input[@id="basic_aml"]     ${creditRequirement.Aml}
    Wait And Input    //input[@id="basic_professional_ethics"]     ${creditRequirement.ProfessionalEthics}
    Wait And Input    //input[@id="basic_reco_specialist"]     ${creditRequirement.RecoSpecialist}

    Wait And Input    //input[@id="basic_reco_nonspecialist"]     ${creditRequirement.RecoNonspecialist}
    Wait And Input    //input[@id="basic_reco_aml"]     ${creditRequirement.RecoAml}
    Wait And Input    //input[@id="basic_reco_professional_ethics"]     ${creditRequirement.RecoProfessionalEthics}
    Wait And Input    //input[@id="basic_multiple"]     ${creditRequirement.Multiple}
Delete Credit Requirement
    [Documentation]    刪除此年分學分需求
    [Arguments]    ${year}
    Unselect Frame
    Credit Maintain
    Scroll In IFrame    300
    Click And Enabled    //tbody//tr[contains(.,"${year}")]${Button.Delete}
    Sleep    1
    Click And Visible    ${Button.Confirm}
    Sleep    1
*** Test Cases ***
8-20-01
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[學分清單]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[學分清單]
...  /      Expected Result: 顯示相關頁面
    [Tags]    7020 持續進修管理-學分清單
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Page Should Contain    學分清單
8-20-02
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[學分清單]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[學分清單]
...  /      4.點擊[學分總和清單]
...  /      Expected Result: 顯示相關頁面
    [Tags]    7020 持續進修管理-學分清單-學分總和清單
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Click And Enabled    //label[contains(.,"學分總和")]
    Element Should Contain    //thead  學分總和
8-20-03
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[學分清單]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[學分清單]
...  /      4.點擊[建議學分清單]
...  /      Expected Result: 顯示相關頁面
    [Tags]    7020 持續進修管理-學分清單-建議學分清單
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Click And Enabled    //label[contains(.,"建議學分")]
    Element Should Not Contain    //thead   學分總和

8-21-01
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[學分清單]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[學分清單]
...  /      4.點擊[新增]
...  /      5. 依序填入年度111年度,專教學會學分20,專教會學分連二0,專教會連三學分零,學分總和連一0,
...  /          學分總和連二0,學分總和連三0,洗錢防制法3,職業道德0,建議專教會學分20,
...  /          建議非專教會學分20,建議洗錢防治法學分3,建議道德學分0,公開發行倍數2
...  /      6.儲存
...  /      7.跳出提示訊息[確認]並點擊[確認]
...  /      Expected Result: 顯示相關頁面
    [Tags]    7021 持續進修管理-學分管理-學分資料新增
    Input Credit Requirement    ${CreditRequirement}
    Click And Enabled    ${Button.Save}
    Sleep    1
    Click And Enabled    ${Button.Confirm}
    Sleep    1
    Unselect Frame
    Credit Maintain
    Wait Until Page Contains Element    //tbody/tr/td[2]
    Sleep    1
    Scroll In IFrame    500
    ${found}    Set Variable    False
    @{items}    Get Webelements    //tbody/tr/td[1]
    FOR    ${item}  IN  @{items}
        ${found}    Run Keyword And Return Status    Element Should Contain    ${item}  ${creditRequirement.Year}
        Run Keyword If    ${found}    Exit For Loop
    END
    Run Keyword If    not ${found}    Fail    Element Should Contain  ${creditRequirement.Year}
    Delete Credit Requirement  ${creditRequirement.Year}
8-21-02
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[學分清單]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[學分清單]
...  /      4.點擊[新增]
...  /      5. 依序填入年度111年度,專教學會學分20,專教會學分連二0,專教會連三學分零,學分總和連一0,
...  /          學分總和連二0,學分總和連三0,洗錢防制法3,職業道德0,建議專教會學分20,
...  /          建議非專教會學分20,建議洗錢防治法學分3,建議道德學分0,公開發行倍數2
...  /      6.取消
...  /      7. 回上一頁
...  /      Expected Result: 顯示相關頁面
    [Tags]    7021 持續進修管理-學分管理-學分資料新增-取消
    Input Credit Requirement    ${CreditRequirement}
    Click And Enabled    ${Button.Cancel}
    Location Should Be    https://test.roccpa.org.tw/TACCTG/event/score
8-21-03
    [Documentation]     會務人員身份進入[持續進修管理]>活動課程管理>點擊[學分清單]
...  /      1.進入[持續進修管理]
...  /      2.活動課程管理
...  /      3.點擊[學分清單]
...  /      4.點擊[新增]
...  /      5. 依序填入年度111,年度專教學會學分abc,專教會學分連二0,專教會連三學分零,學分總和連一0,
...  /          學分總和連二0,學分總和連三0,洗錢防制法3,職業道德0,建議專教會學分cde,
...  /          建議非專教會學分20,建議洗錢防治法學分3,建議道德學分0,公開發行倍數2
...  /      6.儲存
...  /      7.應跳出提示訊息[年度專教學會學], [建議專教會學分]錯誤
...  /      Expected Result: 顯示相關頁面
    [Tags]    7021 持續進修管理-學分管理-學分資料新增-異常
    Input Credit Requirement    ${WrongRequirement}
    Click And Enabled    ${Button.Save}
    Page Should Contain     請輸入專教會學分!
    Page Should Contain     請輸入建議專教會學分!