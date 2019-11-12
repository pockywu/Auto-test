*** Settings ***
Documentation     *Need to start VPN to Brasil before runing test
Suite Setup       Open App
Library           AppiumLibrary
Resource          resource/YMK_Keyword.robot

*** Variables ***
${platformVersion}    9
${noReset}        False    #True: don't reset when open app. False: reset when open app

*** Test Cases ***
1-1 Check pop up subscription when select SmartHD
    [Tags]    Shura
    Pass Tutorial
    Launcher-Click Setting button    #點setting button
    Sleep    1
    ${ScreenHight}    Get Window Height
    ${ScreenHight}=    Evaluate    ${ScreenHight}/2
    : FOR    ${i}    IN RANGE    1    20
    \    ${count}    Run Keyword And Return Status    Page Should Contain Text    Quality
    \    Exit For Loop If    ${count} > 0
    \    Swipe    400    1000    400    ${ScreenHight}    200
    Click    Quality
    Sleep    1
    ${count}    Run Keyword And Return Status    Page Should Contain Text    Smart HD PRO
    Run Keyword If    ${count} == 0    Run Keyword    Set Test Message    [Note] This device doesn't support Smart HD, Skip this test
    ...    ELSE    Click    Smart HD PRO
    Wait Until Page Contains    Premium Version    100
    ${count}    Run Keyword And Return Status    Page Should Contain Text    Premium Version
    Press Keycode    4
    Run Keyword If    ${count} == 0    Fail    Subscription page doesn't show when selecting Smart HD
    Set Test Message    Subscription page show when selecting Smart HD
    Sleep    1
    Press Keycode    4

1-2 Check pop up subscription when turn off photo watermark
    [Tags]    Shura
    Sleep    1
    : FOR    ${i}    IN RANGE    1    20
    \    ${count}    Run Keyword And Return Status    Page Should Contain Text    Photo Watermark
    \    Exit For Loop If    ${count} > 0
    \    Swipe    400    1000    400    700    200
    ${photowatermarklocation}    Get Element Location    com.cyberlink.youcammakeup:id/watermarkBtn
    ${photowatermarksize}    Get Element Size    com.cyberlink.youcammakeup:id/watermarkBtn
    ${Switherlocation}    Get Element Location    com.cyberlink.youcammakeup:id/item_switch
    ${size}=    Evaluate    ${photowatermarksize['height']}/2
    ${photowatermarklocation}=    Evaluate    ${photowatermarklocation['y']}+${size}
    Click A Point    ${Switherlocation['x']}    ${photowatermarklocation}
    Wait Until Page Contains    Premium Version
    ${count}    Run Keyword And Return Status    Page Should Contain Text    Premium Version
    Run Keyword If    ${count} == 0    Fail    Subscription page doesn't show when turn off photo watermark
    ...    ELSE    Run Keywords    Set Test Message    Subscription page show when turn off photo watermark
    ...    AND    Press Keycode    4

1-3 Check pop up subscription when turn off video watermark
    [Tags]    Shura
    Sleep    1
    : FOR    ${i}    IN RANGE    1    20
    \    ${count}    Run Keyword And Return Status    Page Should Contain Text    Video Watermark
    \    Exit For Loop If    ${count} > 0
    \    Swipe    400    1000    400    700    200
    ${videowatermarklocation}    Get Element Location    com.cyberlink.youcammakeup:id/videoWatermarkBtn
    ${videowatermarksize}    Get Element Size    com.cyberlink.youcammakeup:id/videoWatermarkBtn
    ${Switherlocation}    Get Element Location    com.cyberlink.youcammakeup:id/item_switch
    ${size}=    Evaluate    ${videowatermarksize['height']}/2
    ${videowatermarklocation}=    Evaluate    ${videowatermarklocation['y']}+${size}
    Click A Point    ${Switherlocation['x']}    ${videowatermarklocation}
    Wait Until Page Contains    Premium Version
    ${count}    Run Keyword And Return Status    Page Should Contain Text    Premium Version
    Run Keyword If    ${count} == 0    Fail    Subscription page doesn't show when turn off video watermark
    ...    ELSE    Run Keywords    Set Test Message    Subscription page show when turn off video watermark
    ...    AND    Press Keycode    4

1-4 Check launcher banner AD
    [Tags]    Shura
    Press Keycode    4
    Check subscription page and skip    #讓subscription page有時間出現
    Wait Until Page Contains    com.cyberlink.youcammakeup:id/background_native_ad_container    100    #等廣告出現
    ${count}    Run Keyword And Return Status    Page Should Contain Element    com.cyberlink.youcammakeup:id/background_native_ad_container    #AD banner
    Run Keyword If    ${count} > 0    Run Keywords    Set Test Message    Launcher Banner have AD
    ...    AND    Capture Page Screenshot    LauncherBannerAD.png
    ...    ELSE    Fail    Launcher Banner no AD

1-5 Check launcher AD tile
    [Tags]    Shura
    ${count}    Run Keyword And Return Status    Page Should Contain Element    com.cyberlink.youcammakeup:id/native_ad_icon    #AD TILE
    Run Keyword If    ${count} > 0    Run Keywords    Set Test Message    Launcher have AD tile
    ...    AND    Capture Page Screenshot    LauncherADtile.png
    ...    ELSE    Fail    Launcher no AD tile

1-6 Check have crown icon
    [Tags]    Shura
    ${count}    Run Keyword And Return Status    Page Should Contain Element    com.cyberlink.youcammakeup:id/launcherSubscriptionEntryButton    #crown icon
    Run Keyword If    ${count} > 0    Run Keyword    Set Test Message    Have crown icon
    ...    ELSE    Fail    No crown icon

1-7 Check record video have watermark
    [Tags]    Shura
    Launcher-Click Makeup Cam
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/effectDivider    100    #直到出現promote premium look跟look間的分隔線出現
    Sleep    10    #在makeup cam裡等待久一點
    Click Button    com.cyberlink.youcammakeup:id/videoRecModeBtn    #Click "Video" button
    Sleep    10    #等到video tutorial不見
    Click Button    com.cyberlink.youcammakeup:id/before    #Click "Record" button
    Sleep    5    #錄個幾秒
    Click Button    com.cyberlink.youcammakeup:id/before    #Click "Stop" button
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/videoPlaybackBottomPanel
    ${Status}    Run Keyword And Return Status    Page Should Contain Text    Remove Watermark
    Run Keyword If    ${Status} > 0    Run Keyword    Set Test Message    Record video have watermark
    ...    ELSE    Fail    Record video no watermark
    Press Keycode    4    #Back to video cam
    Sleep    2
    Press Keycode    4    #Back to launcher

1-8 Check camera back AD
    [Tags]    Shrua
    Launcher-Click Makeup Cam
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/effectDivider    100    #直到出現promote premium look跟look間的分隔線出現
    Sleep    10    #在makeup cam裡等待久一點
    Click Element    com.cyberlink.youcammakeup:id/cameraBackIcon    #點back button 回到launcher
    Sleep    10    #load廣告的時間
    ${Status2}    Run Keyword And Return Status    Page Should Contain Element    xpath=//*[contains(@resource-id, 'abgcp')]
    Run Keyword if    ${Status2} == 0    Fail    No AD when back from makeup cam
    Run Keyword if    ${Status2} > 0    Run Keywords    Set Test Message    Have AD when back from makeup cam
    ...    AND    Capture Page Screenshot    makeupcambackAD.PNG
    ...    AND    Press Keycode    4

1-9 Check launcher trending AD
    [Tags]    Shura
    Sleep    3
    ${ScreenHight}    Get Window Height
    ${HalfScreenHight}=    Evaluate    ${ScreenHight}/2
    : FOR    ${i}    IN RANGE    1    20
    \    Swipe    400    ${HalfScreenHight}    400    200
    \    Sleep    1
    \    ${count}    Run Keyword And Return Status    Page Should not Contain Element    com.cyberlink.youcammakeup:id/google_ad_panel
    \    Run Keyword If    ${count} == 0    Exit For Loop
    Run Keyword if    ${count} > 0    FAIL    [FAIL] Launcher No AD
    ${Size}    Get Element Location    com.cyberlink.youcammakeup:id/google_ad_panel
    Run Keyword if    ${Size['y']} > ${ScreenHight}    Swipe    400    ${Size['y']}    400    ${HalfScreenHight}
    Set Test Message    Launcher have AD
    [Teardown]    Launcher-Click Home button

1-10 Check trending AD
    [Tags]    Shura
    Launcher-Click Discover button
    Sleep    3
    Click A Point    500    500    #隨便點一點把tutorial消掉
    Sleep    3
    Swipe    400    200    400    1000    500    #refresh 一次
    Launcher-Click Discover button
    Sleep    3    #讓trending page load資料一下
    : FOR    ${i}    IN RANGE    1    25
    \    Swipe    400    1000    400    450
    \    Sleep    1
    \    ${count}    Run Keyword And Return Status    Page Should not Contain Element    com.cyberlink.youcammakeup:id/ad_info_panel
    \    Run Keyword If    ${count} == 0    Exit For Loop
    Run Keyword if    ${count} > 0    Fail    Trending No AD
    Run Keyword if    ${count} == 0    Run Keywords    Set Test Message    Trending have AD    append=yes
    ...    AND    Capture Page Screenshot    2-trendingAD.png

1-11 Check photo picker AD
    [Tags]    Shura
    Launcher-Click Home button    #點Home
    Launcher-Click Photo Makeup button
    Sleep    2
    Select Sample Photo
    : FOR    ${i}    IN RANGE    1    4
    \    Sleep    1
    \    ${count}    Run Keyword And Return Status    Page Should Contain Element    com.cyberlink.youcammakeup:id/ad_wrapper_container
    \    Run Keyword If    ${count} > 0    Run Keywords    Set Test Message    Photo Picker have AD
    \    ...    AND    Exit For Loop
    \    Click Element    com.cyberlink.youcammakeup:id/topToolBarBackBtnContainer
    \    Sleep    1
    \    Select Sample Photo
    Run Keyword If    ${count} == 0    FAIL    [FAIL] Photo Picker no AD

1-12 Check photo have watermark
    [Tags]    Shura
    Click Element    com.cyberlink.youcammakeup:id/photoItemImage    #選照片
    Sleep    10
    Click Element    com.cyberlink.youcammakeup:id/lookTypeSwitcherCostumeButtonText
    Click    Lotus    #套default第一個costume look
    Sleep    10
    ${favoriteicon}    Get Element Location    com.cyberlink.youcammakeup:id/lookTypeSwitcherMyLooksButtonImage
    ${favoritebutton}    Get Element Location    com.cyberlink.youcammakeup:id/lookTypeSwitcherMyLooksButton    #my favorite button location
    ${xpoint}=    Set Variable    ${favoriteicon['x']}
    ${ypoint}=    Evaluate    ${favoritebutton['y']}-5
    : FOR    ${i}    IN RANGE    1    30
    \    Click Element At Coordinates    ${xpoint}    ${ypoint}
    \    Sleep    3
    \    ${status}    Run Keyword And Return Status    Page Should Not Contain Text    Premium Version
    \    Run Keyword If    ${status} == 0    Exit For Loop
    \    ${ypoint}=    Evaluate    ${ypoint}-10
    Run Keyword If    ${status} > 0    Fail    No photo watermark
    Run Keyword If    ${status} == 0    Run Keywords    Set Test Message    Have photo watermark
    ...    AND    Press Keycode    4

1-13 Check feature room have premium button
    [Tags]    Shura
    Sleep    3
    ${status}    Run Keyword And Return Status    Page Should Contain Text    Premium
    Run Keyword if    ${status} > 0    Run Keyword    Set Test Message    Photo Edit have "Premium" button
    ...    ELSE    Fail    [Edit] Photo Edit doesn't have "Premium" button

1-14 Check result page whole page AD
    [Tags]    Shura
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/topToolBarExportBtn    #Save button
    Click Element    com.cyberlink.youcammakeup:id/topToolBarExportBtn    #點save
    Sleep    10
    ${count}    Run Keyword And Return Status    Page Should Contain Element    xpath=//*[contains(@resource-id, 'abgcp')]
    Run Keyword if    ${count} > 0    Run Keywords    Set Test Message    Result page have whole page AD
    ...    AND    Press Keycode    4
    ...    ELSE    Fail    Result page doesn't have whole page AD

1-15 Check result page AD
    [Tags]    Shura
    Sleep    10
    ${count}    Run Keyword And Return Status    Page Should Contain Element    com.cyberlink.youcammakeup:id/photo_result_page_native_ad_container    #AD banner
    Run Keyword If    ${count} > 0    Run Keywords    Set Test Message    Result page have AD
    ...    AND    Capture Page Screenshot    ResultpageAD.png
    ...    ELSE    Fail    Result page no AD
    Click Element    com.cyberlink.youcammakeup:id/sharePageHomeButton

1-16 Check Back AD
    [Tags]    Shura
    Sleep    3
    Press Keycode    4
    Sleep    5
    ${count}    Run Keyword And Return Status    Page Should Contain Element    com.cyberlink.youcammakeup:id/ad_container_leave_option    #有沒有confirm dialog
    Run Keyword If    ${count} == 0    Fail    Back key no AD
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/ad_container    20
    ${count}    Run Keyword And Return Status    Page Should Contain Element    com.cyberlink.youcammakeup:id/ad_container
    Run Keyword If    ${count} > 0    Run Keywords    Set Test Message    Back key have AD
    ...    AND    Capture Page Screenshot    BackkeyAD.png
    ...    ELSE    Fail    [FAIL] Back key no AD
    Click Element    com.cyberlink.youcammakeup:id/ad_container_cancel_leave_activity

1-17 Check no Back AD after Subscribe
    [Tags]    Shura
    Pass Tutorial
    #Click Button    com.cyberlink.youcammakeup:id/launcherSubscriptionEntryButton
    #Subscribe
    Sleep    10
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/launcherMakeupCamBtn    100
    Press Keycode    4
    ${status}    Run Keyword And Return Status    Page Should Not Contain Element    com.cyberlink.youcammakeup:id/ad_container    3
    Run Keyword If    ${status} == 0    Fail    [FAIL] Still have AD after subscribe
    Set Test Message    Subscribed - Back key no AD
    [Teardown]    Close Application

1-18 Check no crown icon
    [Tags]    Shura
    [Setup]
    Open App
    Pass Tutorial
    Restore purchase status
    ${count}    Run Keyword And Return Status    Page Should Not Contain Element    com.cyberlink.youcammakeup:id/launcherSubscriptionEntryButton    #crown icon
    Run Keyword If    ${count} > 0    Run Keyword    Set Test Message    No crown icon
    ...    ELSE    Fail    [FAIL] Have crown icon

1-19 Check Smart HD quality
    [Tags]    Shura
    [Setup]
    Click Button    com.cyberlink.youcammakeup:id/launcherSettingButton
    Sleep    1
    ${ScreenHight}    Get Window Height
    ${ScreenHight}=    Evaluate    ${ScreenHight}/2
    : FOR    ${i}    IN RANGE    1    20
    \    ${count}    Run Keyword And Return Status    Page Should Contain Text    Quality
    \    Run Keyword If    ${count} > 0    Exit For Loop
    \    ...    ELSE    Swipe    400    1000    400
    \    ...    ${ScreenHight}    200
    ${quality}    Run Keyword And Return Status    Page Should Contain Text    Smart HD PRO
    Run Keyword If    ${quality} > 0    Set Test Message    App has auto select Smart HD PRO\n
    ...    ELSE    Fail    App doesn't auto select Smart HD PRO\n
    Click    Quality
    Sleep    1
    ${count}    Run Keyword And Return Status    Page Should Contain Text    Smart HD PRO
    Run Keyword If    ${count} == 0    Run Keyword    Fail    [Note] This device doesn't support Smart HD, Skip this test
    Click    Normal
    Sleep    1
    Click    Smart HD PRO
    Sleep    3
    ${count}    Run Keyword And Return Status    Page Should Not Contain Text    Premium Version
    Run Keyword If    ${count} > \ 0    Set Test Message    Subscription page no show when selecting Smart HD
    ...    ELSE    Fail    [FAIL] Subscription page show when selecting Smart HD
    Press Keycode    4

1-20 Check photo watermark is OFF
    [Tags]    Shura
    [Setup]
    Sleep    1
    : FOR    ${i}    IN RANGE    1    20
    \    ${count}    Run Keyword And Return Status    Page Should Contain Text    Photo Watermark
    \    Run Keyword If    ${count} > 0    Exit For Loop
    \    ...    ELSE    Swipe    400    1000    400
    \    ...    700    200
    ${text}    Get Element Attribute    //*[@resource-id="com.cyberlink.youcammakeup:id/watermarkBtn"]/android.widget.Switch[1]    text
    Run Keyword if    '${text}' == 'OFF'    Set Test Message    Photo watermark is OFF
    ...    ELSE    Fail    [FAIL] Photo watermark is ON

1-21 Check video watermark is OFF
    [Tags]    Shura
    Sleep    1
    : FOR    ${i}    IN RANGE    1    20
    \    ${count}    Run Keyword And Return Status    Page Should Contain Text    Video Watermark
    \    Run Keyword If    ${count} > 0    Exit For Loop
    \    ...    ELSE    Swipe    400    1000    400
    \    ...    700    200
    ${text}    Get Element Attribute    //*[@resource-id="com.cyberlink.youcammakeup:id/videoWatermarkBtn"]/android.widget.Switch[1]    text
    Run Keyword if    '${text}' == 'OFF'    Set Test Message    Video watermark is OFF
    ...    ELSE    Fail    [FAIL] Video watermark is ON
    Press Keycode    4    #Back to laucher

1-22 Check no launcher banner AD
    [Tags]    Shura
    Sleep    1
    ${bannersize}    Get Element Size    com.cyberlink.youcammakeup:id/launcher_banner_viewpager
    ${bannerlocation}    Get Element Location    com.cyberlink.youcammakeup:id/launcher_banner_viewpager
    ${bannersize}=    Evaluate    ${bannersize['height']}/2
    ${ypoint}=    Evaluate    ${bannerlocation['y']}+${bannersize}
    :FOR    ${i}    IN RANGE    1    6
    \    Swipe    600    ${ypoint}    100    ${ypoint}    1000
    \    ${count}    Run Keyword And Return Status    Page Should Not Contain Element    com.cyberlink.youcammakeup:id/background_native_ad_container    #AD banner
    \    Exit For Loop if    ${count} == 0
    Run Keyword If    ${count} > 0    Run Keyword    Set Test Message    Launcher Banner no AD
    ...    ELSE    Fail    [FAIL] Launcher Banner have AD

1-23 Check no launcher AD tile
    [Tags]    Shura
    ${count}    Run Keyword And Return Status    Page Should Not Contain Element    com.cyberlink.youcammakeup:id/native_ad_icon    #AD TILE
    Run Keyword If    ${count} > 0    Run Keyword    Set Test Message    Launcher NO no tile
    ...    ELSE    Fail    [FAIL] Launcher have AD tile

1-24 Check no watermark in video
    [Tags]    Shura
    Launcher-Click Makeup Cam
    Sleep    10    #在makeup cam裡等待久一點
    Click Button    com.cyberlink.youcammakeup:id/videoRecModeBtn    #Click "Video" button
    Sleep    5    #等到video tutorial不見
    Click Button    com.cyberlink.youcammakeup:id/before    #Click "Record" button
    Sleep    5    #錄個幾秒
    Click Button    com.cyberlink.youcammakeup:id/before    #Click "Stop" button
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/videoPlaybackBottomPanel
    ${Status}    Run Keyword And Return Status    Page Should Not Contain Text    Remove Watermark
    Run Keyword If    ${Status} > 0    Set Test Message    Record video no watermark
    ...    ELSE    Fail    [FAIL] Record video have watermark
    Press Keycode    4
    Press Keycode    4

1-25 Check no camera back AD
    [Tags]    Shura
    Launcher-Click Makeup Cam
    Sleep    10    #在makeup cam裡等待久一點
    Click Element    com.cyberlink.youcammakeup:id/cameraBackIcon    #點back button 回到launcher
    Sleep    10    #load廣告的時間
    ${Status2}    Run Keyword And Return Status    Page Should Not Contain Element    xpath=//*[contains(@resource-id, 'abgcp')]
    Run Keyword if    ${Status2} == 0    Fail    [FAIL] Have AD when back from makeup cam
    Run Keyword if    ${Status2} > 0    Run Keyword    Set Test Message    No AD when back from makeup cam

1-26 Check no AD in launcher trending
    [Tags]    Shura
    Sleep    3
    : FOR    ${i}    IN RANGE    1    20
    \    Swipe    400    1000    400    450
    \    Sleep    1
    \    ${count}    Run Keyword And Return Status    Page Should not Contain Element    com.cyberlink.youcammakeup:id/google_ad_panel
    \    Run Keyword if    ${count} == 0    Exit For Loop
    Run Keyword if    ${count} > 0    Run Keyword    Set Test Message    Launcher No AD    ESLE    FAIL
    ...    [FAIL] Launcher have AD
    Launcher-Click Home button

1-27 Check no AD in tranding
    [Tags]    Shura
    Launcher-Click Discover button
    Sleep    3
    Swipe    400    200    400    1000    500    #refresh 一次
    Launcher-Click Discover button
    Sleep    3    #讓trending page load資料一下
    : FOR    ${i}    IN RANGE    1    25
    \    Swipe    400    1000    400    450
    \    Sleep    1
    \    ${count}    Run Keyword And Return Status    Page Should not Contain Element    com.cyberlink.youcammakeup:id/ad_info_panel
    \    Run Keyword If    ${count} == 0    Exit For Loop
    Run Keyword if    ${count} > 0    Set Test Message    Trending no AD
    ...    ELSE    Fail    [FAIL] Trending have AD
    Launcher-Click Home button

1-28 Check no AD in photo picker
    [Tags]    Shura
    Launcher-Click Home button    #點Home
    Launcher-Click Photo Makeup button
    Sleep    2
    Select Sample Photo
    : FOR    ${i}    IN RANGE    1    4
    \    Sleep    1
    \    ${count}    Run Keyword And Return Status    Page Should Not Contain Element    com.cyberlink.youcammakeup:id/ad_wrapper_container
    \    Exit For Loop If    ${count} == 0
    \    Click Element    com.cyberlink.youcammakeup:id/topToolBarBackBtnContainer    #Back to album list
    \    Sleep    1
    \    Select Sample Photo
    Run Keyword If    ${count} > 0    Set Test Message    Photo Picker No AD
    ...    ELSE    FAIL    [FAIL] Photo Picker Have AD

1-29 Check no premium button in edit room
    [Tags]    Shura
    Click Element    com.cyberlink.youcammakeup:id/photoItemImage    #選照片
    Sleep    10
    ${status}    Run Keyword And Return Status    Page Should Not Contain Text    Premium Version
    Run Keyword if    ${status} > 0    Run Keyword    Set Test Message    Photo Edit have "Premium" button
    ...    ELSE    Fail    Photo Edit doesn't have "Premium" button

1-30 Check no watermark in photo
    [Tags]    Shura

1-31 Check no whole page AD in result page
    [Tags]    Shura

1-32 Check no AD in rulst page
    [Tags]    Shura

*** Keywords ***
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

Check subscription page and skip
    Wait Until Page Contains    Premium Version
    ${status}    Run Keyword And Return Status    Page Should Contain Text    Premium Version
    Run keyword if    ${status} > 0    Press Keycode    4

Restore purchase status
    Click Button    com.cyberlink.youcammakeup:id/launcherSubscriptionEntryButton    #crown icon
    Wait Until Page Contains    Restore purchase    10
    Click    Restore purchase
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/launcherMakeupCamBtn    #看到MAKEUP CAM BUTTON
