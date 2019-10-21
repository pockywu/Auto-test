*** Settings ***
Suite Setup       Open App
Library           AppiumLibrary
Resource          resource/YMK_Keyword.robot

*** Variables ***

*** Test Cases ***
Check launcher banner AD
    [Tags]    Shura
    Pass Tutorial
    Launcher-Click Setting button    #Click setting button
    Press Keycode    4
    Sleep    3
    Press Keycode    4    #close subscription page
    Sleep    3
    ${count}    Run Keyword And Return Status    Page Should Not Contain Element    com.cyberlink.youcammakeup:id/background_native_ad_container    #AD banner
    Run Keyword If    ${count} == 0    Run Keywords    Set Test Message    Launcher Banner have AD
    ...    AND    Capture Page Screenshot    LauncherBannerAD.png
    ...    ELSE    Fail    Launcher Banner no AD

Check launcher AD tile
    [Tags]    Shura
    ${count}    Run Keyword And Return Status    Page Should Not Contain Element    com.cyberlink.youcammakeup:id/native_ad_icon    #AD TILE
    Run Keyword If    ${count} == 0    Run Keywords    Set Test Message    Launcher have AD tile
    ...    AND    Capture Page Screenshot    LauncherADtile.png
    ...    ELSE    Fail    Launcher no AD tile

Check camera back AD
    Launcher-Click Makeup Cam
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/before    100
    Click Element    com.cyberlink.youcammakeup:id/cameraBackIcon
    Sleep    3
    Launcher-Click Makeup Cam
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/before    100
    Click Element    com.cyberlink.youcammakeup:id/cameraBackIcon
    Sleep    3
    ${Status}    Run Keyword And Return Status    Page Should Not Contain Element    com.cyberlink.youcammakeup:id/launcherMakeupCamBtn    #檢查有沒有看到makeup cam button
    Run Keyword if    ${Status} == 0    Fail    No AD when back from makeup cam
    Run Keyword if    ${Status} > 0    Run Keywords    Set Test Message    Have AD when back from makeup cam
    ...    AND    Capture Page Screenshot    makeupcambackAD.PNG
    ...    AND    Press Keycode    4

Check launcher trending AD
    [Tags]    Shura
    Sleep    3
    : FOR    ${i}    IN RANGE    1    20
    \    Swipe    400    1000    400    500    200
    \    ${count}    Run Keyword And Return Status    Page Should Not Contain Element    com.cyberlink.youcammakeup:id/google_ad_panel
    \    Run Keyword If    ${count} == 0    Exit For Loop
    Run Keyword if    ${count} > 0    Run Keywords    FAIL    Launcher No AD
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
    : FOR    ${i}    IN RANGE    1    20
    \    Swipe    400    1000    400    450
    \    Sleep    1
    \    ${count}    Run Keyword And Return Status    Page Should Not Contain Element    com.cyberlink.youcammakeup:id/ad_info_panel
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
