*** Settings ***
Suite Setup       Open App
Library           AppiumLibrary
Resource          resource/YMK_Keyword.robot

*** Variables ***

*** Test Cases ***
Check launcher banner AD
    [Tags]    Shura
    Pass Tutorial
    Sleep    10
    Launcher-Click Setting button    #Click setting button
    Press Keycode    4    #Click Back
    Sleep    10    #讓subscription page有時間出現
    Press Keycode    4    #close subscription page
    Wait Until Page Contains    com.cyberlink.youcammakeup:id/background_native_ad_container    100    #等廣告出現
    ${count}    Run Keyword And Return Status    Page Should Contain Element    com.cyberlink.youcammakeup:id/background_native_ad_container    #AD banner
    Run Keyword If    ${count} > 0    Run Keywords    Set Test Message    Launcher Banner have AD
    ...    AND    Capture Page Screenshot    LauncherBannerAD.png
    ...    ELSE    Fail    Launcher Banner no AD

Check launcher AD tile
    [Tags]    Shura
    ${count}    Run Keyword And Return Status    Page Should Contain Element    com.cyberlink.youcammakeup:id/native_ad_icon    #AD TILE
    Run Keyword If    ${count} > 0    Run Keywords    Set Test Message    Launcher have AD tile
    ...    AND    Capture Page Screenshot    LauncherADtile.png
    ...    ELSE    Fail    Launcher no AD tile

Check camera back AD
    Launcher-Click Makeup Cam
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/effectDivider    100    #直到出現promote premium look跟look間的分隔線出現
    Sleep    10    #在makeup cam裡等待久一點
    Click Element    com.cyberlink.youcammakeup:id/cameraBackIcon    #點back button 回到launcher
    Launcher-Click Makeup Cam
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/effectDivider    100    #直到出現promote premium look跟look間的分隔線出現
    Sleep    10    #在makeup cam裡等待久一點
    Click Element    com.cyberlink.youcammakeup:id/cameraBackIcon    #點back button 回到launcher
    Sleep    10    #load廣告的時間
    ${Status}    Run Keyword And Return Status    Page Should Not Contain Element    com.cyberlink.youcammakeup:id/launcherMakeupCamBtn    #檢查有沒有看到makeup cam button
    ${Status2}    Run Keyword And Return Status    Page Should Contain Element    xpath=//*[contains(@resource-id, 'abgcp')]
    Run Keyword if    ${Status2} == 0    Fail    No AD when back from makeup cam
    Run Keyword if    ${Status2} > 0    Run Keywords    Set Test Message    Have AD when back from makeup cam
    ...    AND    Capture Page Screenshot    makeupcambackAD.PNG
    ...    AND    Press Keycode    4

Check launcher trending AD
    [Tags]    Shura
    Sleep    3
    : FOR    ${i}    IN RANGE    1    20
    \    Swipe    400    1000    400    500    200
    \    ${count}    Run Keyword And Return Status    Page Should not Contain Element    com.cyberlink.youcammakeup:id/google_ad_panel
    \    Run Keyword If    ${count} == 0    Exit For Loop
    Run Keyword if    ${count} > 0    Run Keywo3rds    FAIL    Launcher No AD
    ...    AND    Capture Page Screenshot    1-launcherAD.png
    ${ScreenHight}    Get Window Height
    ${ScreenHight}=    Evaluate    ${ScreenHight}/2
    ${Size}    Get Element Location    com.cyberlink.youcammakeup:id/google_ad_panel
    Run Keyword if    ${Size['y']} > ${ScreenHight}    Swipe    400    ${Size['y']}    400    ${ScreenHight}
    Set Test Message    Launcher have AD\n    append=yes
    Capture Page Screenshot    1-launcherAD.png
    Launcher-Click Home button    #回到頂端

Check trending AD
    [Tags]    Shura
    Launcher-Click Discover button
    Sleep    3
    Click A Point    500    500
    Sleep    3
    Swipe    400    200    400    1000    500
    Launcher-Click Discover button
    Sleep    1    #讓trending page load資料一下
    : FOR    ${i}    IN RANGE    1    20
    \    Swipe    400    1000    400    450
    \    Sleep    1
    \    ${count}    Run Keyword And Return Status    Page Should not Contain Element    com.cyberlink.youcammakeup:id/ad_info_panel
    \    Run Keyword If    ${count} == 0    Run Keywords    Set Test Message    Trending have AD    append=yes
    \    ...    AND    Capture Page Screenshot    2-trendingAD.png
    \    ...    AND    Exit For Loop
    Run Keyword if    ${count} > 0    Fail    Trending No AD

Check photo picker AD
    [Tags]    Shura
    Launcher-Click Home button    #點Home
    Launcher-Click Photo Makeup button
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

Check result page whole page AD
    [Tags]    Shura
    Click Element    com.cyberlink.youcammakeup:id/photoItemImage    #選照片
    Sleep    10
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/topToolBarExportBtn    #Save button
    Click Element    com.cyberlink.youcammakeup:id/topToolBarExportBtn    #點save
    Sleep    10
    ${count}    Run Keyword And Return Status    Page Should Contain Element    xpath=//*[contains(@resource-id, 'abgcp')]
    Run Keyword if    ${count} > 0    Run Keywords    Set Test Message    Result page have whole page AD
    ...    AND    Press Keycode    4
    ...    ELSE    Fail    Result page doesn't have whole page AD

Check result page AD
    Sleep    10
    ${count}    Run Keyword And Return Status    Page Should Contain Element    com.cyberlink.youcammakeup:id/photo_result_page_native_ad_container    #AD banner
    Run Keyword If    ${count} > 0    Run Keywords    Set Test Message    Result page have AD
    ...    AND    Capture Page Screenshot    ResultpageAD.png
    ...    ELSE    Fail    Result page no AD
    Click Element    com.cyberlink.youcammakeup:id/sharePageHomeButton

Check Back AD

*** Keywords ***
skipTutorial
    Open Application    http://localhost:4723/wd/hub    platformName=Android    platformVersion=${platformVersion}    deviceName=Android    automationName=UiAutomator2    appPackage=com.cyberlink.youcammakeup
    ...    appActivity=activity.SplashActivity    autoGrantPermissions=$S{autoGrantPermissions}    noReset=FALSE
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/bc_login_panel
    ${loginstatus}    Run Keyword And Return Status    Page Should Contain Element    com.cyberlink.youcammakeup:id/getStartBtn
    Run Keyword If    ${loginstatus} == 0    Run Keywords    Click Element    com.cyberlink.youcammakeup:id/tutorialSkipBtn
    ...    AND    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive
    ...    AND    Click Element    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive
    ...    ELSE    Click Element    com.cyberlink.youcammakeup:id/getStartBtn
    #Run Keyword If    ${loginstatus} == 0    Run Keyword    Click Element    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive

CheckSubscriptionAndClose
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
