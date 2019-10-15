*** Settings ***
Suite Setup       skipTutorial
Library           AppiumLibrary

*** Variables ***
${platformVersion}    9
${autoGrantPermissions}    True

*** Test Cases ***
Check launcher trending AD
    Sleep    3
    : FOR    ${i}    IN RANGE    1    20
    \    Swipe    400    1000    400    500    200
    \    ${count}    Run Keyword And Return Status    Page Should Not Contain Element    com.cyberlink.youcammakeup:id/google_ad_panel
    \    Run Keyword If    ${count} == 0    Run Keywords    Set Test Message    Launcher have AD\n    append=yes
    \    ...    AND    Capture Page Screenshot    1-launcherAD.png
    \    ...    AND    Exit For Loop
    Run Keyword if    ${count} > 0    Run Keywords    FAIL    Launcher No AD
    ...    AND    Capture Page Screenshot    1-launcherAD.png
    Click Element    com.cyberlink.youcammakeup:id/bottom_bar_tab_add    #回到頂端
    ${count}    Set Variable    1

Check trending AD
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/bottom_bar_tab_discover
    Click Element    com.cyberlink.youcammakeup:id/bottom_bar_tab_discover
    : FOR    ${i}    IN RANGE    1    20
    \    Swipe    400    1000    400    450
    \    Sleep    1
    \    ${count}    Run Keyword And Return Status    Page Should Not Contain Element    com.cyberlink.youcammakeup:id/ad_info_panel
    \    Run Keyword If    ${count} == 0    Run Keywords    Set Test Message    Trending have AD    append=yes
    \    ...    AND    Capture Page Screenshot    2-trendingAD.png
    \    ...    AND    Exit For Loop
    Run Keyword if    ${count} > 0    Fail    Trending No AD

Check photo picker AD
    Click Element    com.cyberlink.youcammakeup:id/bottom_bar_tab_add    #點Home
    checkSubscriptionAndClose
    Run Keywords    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/launcherNaturalMakeupBtn
    ...    AND    Click Element    com.cyberlink.youcammakeup:id/launcherNaturalMakeupBtn
    Sleep    2
    : FOR    ${i}    IN RANGE    1    4
    \    Select Sample Photo
    \    Sleep    1
    \    ${count}    Run Keyword And Return Status    Page Should Contain Element    com.cyberlink.youcammakeup:id/ad_wrapper_container
    \    Run Keyword If    ${count} > 0    Run Keywords    Set Test Message    Photo Picker have AD
    \    ...    AND    Capture Page Screenshot    3-photopickerAD.png
    \    Exit For Loop If    ${count} > 0
    \    Click Element    com.cyberlink.youcammakeup:id/topToolBarBackBtnContainer
    Run Keyword If    ${count} == 0    FAIL    Photo Picker no AD

Check result page AD
    Click Element    com.cyberlink.youcammakeup:id/photoItemImage    #選照片
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/topToolBarExportBtn    #Save button
    Click Element    com.cyberlink.youcammakeup:id/topToolBarExportBtn    #點save
    Sleep    3
    ${count}    Run Keyword And Return Status    Page Should Not Contain Element    abgcp    #0是有廣告
    ${count2}    Run Keyword And Return Status    Page Should Not Contain Element    com.cyberlink.youcammakeup:id/sharePageHomeButton    #0是有HOME鍵
    Run Keyword if    ${count2} > 0    Run Keywords    Set Test Message    Result page have whole page AD
    ...    AND    Capture Page Screenshot    4-resultpagewholeAD.PNG
    ...    AND    Press Keycode    4
    ...    ELSE IF    ${count} == 0
    ...    AND    ${count2} == 0    FAIL    Result page no whole page AD
    ...    ELSE    Run Keywords    Set Test Message    Result page have whole page AD
    ...    AND    Capture Page Screenshot    4-resultpagewholeAD.PNG
    ...    AND    Click Element    close_button_icon

TEST
    PHOTOMAKEUP

*** Keywords ***
skipTutorial
    Open Application    http://localhost:4723/wd/hub    platformName=Android    platformVersion=${platformVersion}    deviceName=Android    automationName=UiAutomator2    appPackage=com.cyberlink.youcammakeup
    ...    appActivity=activity.SplashActivity    autoGrantPermissions=${autoGrantPermissions}    noReset=FALSE
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/bc_login_panel
    ${loginstatus}    Run Keyword And Return Status    Page Should Contain Element    com.cyberlink.youcammakeup:id/getStartBtn
    Run Keyword If    ${loginstatus} == 0    Run Keywords    Click Element    com.cyberlink.youcammakeup:id/tutorialSkipBtn
    ...    AND    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive
    ...    AND    Click Element    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive
    ...    ELSE    Click Element    com.cyberlink.youcammakeup:id/getStartBtn
    #Run Keyword If    ${loginstatus} == 0    Run Keyword    Click Element    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive

checkSubscriptionAndClose
    Sleep    3
    ${subscriptioncheck}    Run Keyword And Return Status    Page Should Contain Element    com.cyberlink.youcammakeup:id/promote_background
    Run Keyword If    ${subscriptioncheck}>0    Run Keywords    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/promote_close_btn
    ...    AND    Click Element    com.cyberlink.youcammakeup:id/promote_close_btn

Select Sample Photo
    : FOR    ${i}    IN RANGE    1    20
    \    ${count}    Get Matching Xpath Count    xpath=//*[contains(@text, 'YouCam Makeup Sample')]
    \    Exit For Loop If    ${count}>0
    \    Swipe    400    1000    400    300    400
    Click text    YouCam Makeup Sample
    ${dialog}    Run Keyword And Return Status    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive    timeout=2
    Run Keyword if    ${dialog}>0    Download sample photos

Download sample photos
    Click Element    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive    #Tap Yes button on the downlaoding sample photo dialog
    Wait Until Page Does Not Contain Element    com.cyberlink.youcammakeup:id/bc_upload_dialog_message    timeout=100
    : FOR    ${i}    IN RANGE    1    20    #向上划直到找到"YouCam Makeup Sample" text
    \    Swipe    400    300    400    1000    400
    \    ${count}    Get Matching Xpath Count    xpath=//*[contains(@text, 'YouCam Makeup Sample')]
    \    Exit For Loop If    ${count}>0
    Click text    YouCam Makeup Sample

PHOTOMAKEUP
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/launcherNaturalMakeupBtn
    Click Element    com.cyberlink.youcammakeup:id/launcherNaturalMakeupBtn
