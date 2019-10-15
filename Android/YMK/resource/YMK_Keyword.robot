*** Settings ***
Library           AppiumLibrary

*** Variables ***
${REMOTE_URL}     http://localhost:4723/wd/hub
${platformName}    Android
${platformVersion}    9
${deviceName}     Android
${appPackage}     com.cyberlink.youcammakeup
${appActivity}    activity.SplashActivity
${automationName}    UiAutomator2
${noReset}        False    #True: don't reset when open app. False: reset when open app
${autoGrantPermissions}    True    #Auto allow permission

*** Keywords ***
Open App
    [Tags]    Pocky
    Open Application    ${REMOTE_URL}    platformName=${platformName}    platformVersion=${platformVersion}    deviceName=${deviceName}    automationName=${automationName}    appPackage=${appPackage}
    ...    appActivity=${appActivity}    noReset=${noReset}    autoGrantPermissions=${autoGrantPermissions}

Open VPN
    [Tags]    Pocky
    Open Application    ${REMOTE_URL}    platformName=${platformName}    platformVersion=${platformVersion}    deviceName=${deviceName}    automationName=${automationName}    appPackage=com.fvcorp.flyclient
    ...    appActivity=com.fvcorp.android.fvclient.activity.SplashActivity    noReset=True    autoGrantPermissions=${autoGrantPermissions}

Pass Tutorial
    [Tags]    Pocky
    ${buttonShow}    Run keyword and Return Status    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/getStartBtn
    Run keyword If    ${buttonShow}>0    Click Element    com.cyberlink.youcammakeup:id/getStartBtn
    ...    ELSE    Run keywords    Click Element    com.cyberlink.youcammakeup:id/tutorialSkipBtn
    ...    AND    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive
    ...    AND    Click Element    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive
    Sleep    3

Enter Makeup Cam
    [Tags]    Pocky
    Click Element    com.cyberlink.youcammakeup:id/launcherMakeupCamBtn

Download sample photos
    [Tags]    Pocky
    Click Element    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive    #Tap Yes button on the downlaoding sample photo dialog
    Wait Until Page Does Not Contain Element    com.cyberlink.youcammakeup:id/bc_upload_dialog_message    timeout=100
    : FOR    ${i}    IN RANGE    1    20    #向上划直到找到"YouCam Makeup Sample" text
    \    Swipe    400    300    400    1000    400
    \    ${count}    Get Matching Xpath Count    xpath=//*[contains(@text, 'YouCam Makeup Sample')]
    \    Exit For Loop If    ${count}>0
    Click text    YouCam Makeup Sample
    Click Element    com.cyberlink.youcammakeup:id/photoItemImage    #Tap the first photo

Select Album
    [Arguments]    ${folderName}
    [Tags]    Pocky
    Click Element    com.cyberlink.youcammakeup:id/launcherNaturalMakeupBtn
    Sleep    2
    : FOR    ${i}    IN RANGE    1    20    #向下划直到找到"${folderName} " text
    \    ${count}    Get Matching Xpath Count    xpath=//*[contains(@text, '${folderName}')]
    \    Exit For Loop If    ${count}>0
    \    Swipe    400    1000    400    300    400
    Click text    ${folderName}
    Click Element    com.cyberlink.youcammakeup:id/photoItemImage    #Tap the first photo, 除了找座標，怎麼樣才能點到別張照片？

Select Sample Photo
    [Tags]    Pocky
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/launcherNaturalMakeupBtn
    Click Element    com.cyberlink.youcammakeup:id/launcherNaturalMakeupBtn
    Sleep    2
    : FOR    ${i}    IN RANGE    1    20
    \    ${count}    Get Matching Xpath Count    xpath=//*[contains(@text, 'YouCam Makeup Sample')]
    \    Exit For Loop If    ${count}>0
    \    Swipe    400    1000    400    300    400
    Click text    YouCam Makeup Sample
    ${dialog}    Run Keyword And Return Status    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive    timeout=2
    Run Keyword if    ${dialog}>0    Download sample photos
    ...    ELSE    Click Element    com.cyberlink.youcammakeup:id/photoItemImage    #Tap the first photo, 除了找座標，怎麼樣才能點到別張照片？

Subsribe
    [Tags]    Pocky
    Wait Until Page Contains    7-DAY FREE TRIAL    timeout=10
    Click Text    7-DAY FREE TRIAL
    Wait Until Page Contains Element    com.android.vending:id/footer_placeholder
    Click Element    com.android.vending:id/footer_placeholder
    Wait Until Page Contains Element    com.android.vending:id/input
    Input Password    com.android.vending:id/input    Pft24725102
    Press Keycode    66    #66 is enter key

Set photo quality
    [Arguments]    ${quality}
    [Tags]    Pocky
    Click Element    com.cyberlink.youcammakeup:id/launcherSettingButton    #Tap setting button
    Click Element    com.cyberlink.youcammakeup:id/photoQualityRowBtn
    Click text    ${quality}

Switch Country
    [Arguments]    ${country}
    [Tags]    Pocky
    Click Element    com.cyberlink.youcammakeup:id/launcherSettingButton
    Sleep    1
    : FOR    ${i}    IN RANGE    1    20    #向下划直到找到"Contry/Region" text
    \    Swipe    400    1000    400    300    400
    \    ${count}    Get Matching Xpath Count    xpath=//*[contains(@text, '${region}')]
    \    Exit For Loop If    ${count}>0
    ${countrySetting}    Run keyword and Return Status    Wait Until Page Contains    ${country}
    Run keyword if    ${countrySetting}==0    Run Keywords    Click text    ${region}
    ...    AND    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/country_picker_search_bar
    ...    AND    Input text    com.cyberlink.youcammakeup:id/country_picker_search_bar    ${country}
    ...    AND    Press Keycode    66
    ...    AND    Click Element    com.cyberlink.youcammakeup:id/country_name
    ...    AND    Click Element    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive
    ...    ELSE    log    The country is already China

Syetem language
    [Arguments]    ${language}
    [Tags]    Pocky
    ${region}=    Set Variable If    "${language}"=="ENU"    Country/Region    "${language}"=="CHS"    国家/地区
    Set Global Variable    ${region}
    ${about}=    Set Variable If    "${language}"=="ENU"    About    "${language}"=="CHS"    关于
    Set Global Variable    ${about}

Click Undo
    [Tags]    Pocky
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/EditViewUndoBtn
    Click Element    com.cyberlink.youcammakeup:id/EditViewUndoBtn

Click
    [Arguments]    ${feature name}
    [Tags]    Pocky
    Wait Until Page Contains    ${feature name}
    Click Text    ${feature name}

CheckSubscriptionAndClose
    [Tags]    Shura
    Sleep    3
    ${subscriptioncheck}    Run Keyword And Return Status    Page Should Contain Element    com.cyberlink.youcammakeup:id/promote_background
    Run Keyword If    ${subscriptioncheck}>0    Run Keywords    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/promote_close_btn
    ...    AND    Click Element    com.cyberlink.youcammakeup:id/promote_close_btn

Launcher-Click Discover button
    [Tags]    Shura
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/bottom_bar_tab_discover
    Click Element    com.cyberlink.youcammakeup:id/bottom_bar_tab_discover

Launcher-Click Home button
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/bottom_bar_tab_add
    Click Element    com.cyberlink.youcammakeup:id/bottom_bar_tab_add
	
Apply Color
    [Tags]    Pocky
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/colorItemColorTexture
    Click Element    com.cyberlink.youcammakeup:id/colorItemColorTexture

Adjust Seekbar
    [Tags]    Sol
    ${element_size}=    Get Element Size    id=com.cyberlink.youcammakeup:id/unitSeekBar
    ${element_location}=    Get Element Location    id=com.cyberlink.youcammakeup:id/unitSeekBar
    ${start_x}=    Evaluate    ${element_location['x']} + (${element_size['width']} * 0.5)
    ${start_y}=    Evaluate    ${element_location['y']} + (${element_size['height']} * 0.5)
    ${end_x}=    Evaluate    ${element_location['x']} + (${element_size['width']} * 0.5)
    ${end_y}=    Evaluate    ${element_location['y']} + (${element_size['height']} * 1)
    Swipe    ${start_x}    ${start_y}    ${end_x}    ${end_y}    500

Enter Settings
    [Tags]    Ethan
    Click Element    com.cyberlink.youcammakeup:id/launcherSettingButton

