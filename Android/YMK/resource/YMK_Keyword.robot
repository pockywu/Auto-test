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
    Sleep    3
    Click Element    com.fvcorp.flyclient:id/selectedServer
    Wait Until Page Contains    America
    Click Text    America
    Wait Until Page Contains    Brazil
    Click Text    Brazil
    Wait Until Page Contains    Connected

Pass Tutorial
    [Tags]    Pocky
    ${buttonShow}    Run keyword and Return Status    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/getStartBtn
    Run keyword If    ${buttonShow}>0    Click Element    com.cyberlink.youcammakeup:id/getStartBtn
    ...    ELSE    Run keywords    Click Element    com.cyberlink.youcammakeup:id/tutorialSkipBtn
    ...    AND    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive
    ...    AND    Click Element    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive
    Sleep    3

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
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/launcherNaturalMakeupBtn
    Click Element    com.cyberlink.youcammakeup:id/launcherNaturalMakeupBtn
    Sleep    2
    : FOR    ${i}    IN RANGE    1    20    #向下划直到找到"${folderName} " text
    \    ${count}    Get Matching Xpath Count    xpath=//*[contains(@text, '${folderName}')]
    \    Exit For Loop If    ${count}>0
    \    Swipe    400    1000    400    300    400
    Click text    ${folderName}

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
    ...    ELSE    Click Element    com.cyberlink.youcammakeup:id/photoItemImage

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
    ...    ELSE    log    The country is already ${country}

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
    Wait Until Page Contains    ${feature name}    timeout=30
    Click Text    ${feature name}

CheckSubscriptionAndClose
    [Tags]    Shura
    Sleep    3
    #慢網路CASE
    ${busy}    Run Keyword And Return Status    Page Should Contain Element    com.cyberlink.youcammakeup:id/busy_indicator_switcher
    ${subscriptioncheck}    Run Keyword And Return Status    Page Should Contain Element    com.cyberlink.youcammakeup:id/promote_background
    Run Keyword If    ${busy} > 0    Press Keycode    4
    Run Keyword If    ${subscriptioncheck}>0    Run Keywords    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/promote_close_btn
    ...    AND    Click Element    com.cyberlink.youcammakeup:id/promote_close_btn

Launcher-Click Discover button
    [Tags]    Shura
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/bottom_bar_tab_discover
    Click Element    com.cyberlink.youcammakeup:id/bottom_bar_tab_discover

Launcher-Click Home button
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/bottom_bar_tab_add
    Click Element    com.cyberlink.youcammakeup:id/bottom_bar_tab_add

Apply Color
    [Tags]    Pocky
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/colorItemColorTexture    timeout=10
    Click Element    com.cyberlink.youcammakeup:id/colorItemColorTexture

Adjust Horizontal Seekbar
    [Tags]    Pocky
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/unitSeekBar
    ${element_size}=    Get Element Size    id=com.cyberlink.youcammakeup:id/unitSeekBar
    ${element_location}=    Get Element Location    id=com.cyberlink.youcammakeup:id/unitSeekBar
    ${start_x}=    Evaluate    ${element_location['x']} + (${element_size['width']} * 0)
    ${start_y}=    Evaluate    ${element_location['y']} + (${element_size['height']} * 0.5)
    ${end_x}=    Evaluate    ${element_location['x']} + (${element_size['width']} * 1)
    ${end_y}=    Evaluate    ${element_location['y']} + (${element_size['height']} * 0.5)
    Swipe    ${start_x}    ${start_y}    ${end_x}    ${end_y}    1500

Adjust Vertical Seekbar
    [Tags]    Pocky
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/unitSeekBar
    ${element_size}=    Get Element Size    id=com.cyberlink.youcammakeup:id/unitSeekBar
    ${element_location}=    Get Element Location    id=com.cyberlink.youcammakeup:id/unitSeekBar
    ${start_x}=    Evaluate    ${element_location['x']} + (${element_size['width']} * 0.5)
    ${start_y}=    Evaluate    ${element_location['y']} + (${element_size['height']} * 0.8)
    ${end_x}=    Evaluate    ${element_location['x']} + (${element_size['width']} * 0.5)
    ${end_y}=    Evaluate    ${element_location['y']} + (${element_size['height']} * 0)
    Swipe    ${start_x}    ${start_y}    ${end_x}    ${end_y}    1500

Enter Settings
    [Tags]    Ethan
    Click Element    com.cyberlink.youcammakeup:id/launcherSettingButton

Launcher-Click Photo Makeup button
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/launcherNaturalMakeupBtn
    Click Element    com.cyberlink.youcammakeup:id/launcherNaturalMakeupBtn

Launcher-Click Setting button
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/launcherSettingButton
    Click Element    com.cyberlink.youcammakeup:id/launcherSettingButton

Launcher-Click Makeup Cam
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/launcherMakeupCamBtn
    Click Element    com.cyberlink.youcammakeup:id/launcherMakeupCamBtn

Select PERFECT Brand
    [Tags]    Pocky
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/toolView
    Click Element    com.cyberlink.youcammakeup:id/toolView
    ${element_size}=    Get Element Size    id=com.cyberlink.youcammakeup:id/skuVendorMenu
    ${element_location}=    Get Element Location    id=com.cyberlink.youcammakeup:id/skuVendorMenu
    ${start_x}=    Evaluate    ${element_location['x']} + (${element_size['width']} * 0.5)
    ${start_y}=    Evaluate    ${element_location['y']} + (${element_size['height']} * 0.2)
    ${end_x}=    Evaluate    ${element_location['x']} + (${element_size['width']} * 0.5)
    ${end_y}=    Evaluate    ${element_location['y']} + (${element_size['height']} * 0.8)
    : FOR    ${i}    IN RANGE    1    10
    \    ${count}    Get Matching Xpath Count    xpath=//*[contains(@text, 'PERFECT')]
    \    Exit For Loop If    ${count}>0
    \    Swipe    ${start_x}    ${start_y}    ${end_x}    ${end_y}    800
    Click    PERFECT

Scroll Makeup Menu
    [Tags]    Pocky
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/makeupMenuBottomToolbar    timeout=10
    ${element_size}=    Get Element Size    id=com.cyberlink.youcammakeup:id/makeupMenuBottomToolbar
    ${element_location}=    Get Element Location    id=com.cyberlink.youcammakeup:id/makeupMenuBottomToolbar
    ${start_x}=    Evaluate    ${element_location['x']} + (${element_size['width']} * 0.8)
    ${start_y}=    Evaluate    ${element_location['y']} + (${element_size['height']} * 0.5)
    ${end_x}=    Evaluate    ${element_location['x']} + (${element_size['width']} * 0.2)
    ${end_y}=    Evaluate    ${element_location['y']} + (${element_size['height']} * 0.5)
    Swipe    ${start_x}    ${start_y}    ${end_x}    ${end_y}    1000

Apply Pattern
    [Tags]    Pocky
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/panel_beautify_template_button_image    timeout=10
    Click Element    com.cyberlink.youcammakeup:id/panel_beautify_template_button_image

Click Switch Button
    [Tags]    Pocky
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/switchBtn
    Click Element    com.cyberlink.youcammakeup:id/switchBtn

Click Switch
    [Arguments]    ${Settings_catrgory}
    [Tags]    Ethan
    #On Launcher Setting
    ${element_location}=    Get Element Location    xpath=//*[@text='${Settings_catrgory}']
    ${screen_width}=    Get Window Width
    ${start_x}=    Evaluate    ${screen_width} * 0.9
    ${start_y}=    Evaluate    ${element_location['y']} + 10
    Click Element At Coordinates    ${start_x}    ${start_Y}    #目前只能土法煉鋼，針對不同resolution還要再想想

Scroll down to Find
    [Arguments]    ${Name}
    [Tags]    Pocky
    Sleep    2
    : FOR    ${i}    IN RANGE    1    20    #向下划直到找到"${Name} " text
    \    ${count}    Get Matching Xpath Count    xpath=//*[contains(@text, '${Name}')]
    \    Exit For Loop If    ${count}>0
    \    Swipe    400    1000    400    300    400
    Click text    ${Name}

Save
    [Tags]    Pocky
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/topToolBarExportBtn    timeout=30
    Click Element    com.cyberlink.youcammakeup:id/topToolBarExportBtn

Log in
    [Arguments]    ${email}    ${password}
    [Tags]    Pocky
    ${login}    Run Keyword And Return Status    Page Should Contain Element    com.cyberlink.youcammakeup:id/bc_have_an_account
    Run keyword if    ${login}>0    Run Keywords    Click Element    com.cyberlink.youcammakeup:id/bc_have_an_account
    ...    AND    Input text    com.cyberlink.youcammakeup:id/register_id    ${email}
    ...    AND    Input text    com.cyberlink.youcammakeup:id/register_password    ${password}
    ...    AND    Click Element    com.cyberlink.youcammakeup:id/register_accept_btn

Select Photo
    [Arguments]    ${number}    # 選擇第幾張照片
    [Tags]    Pocky
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/photoItemImage
    &{element_size}=    Get Element Size    com.cyberlink.youcammakeup:id/photoItemImage
    ${element_location}=    Get Element Location    com.cyberlink.youcammakeup:id/photoItemImage
    ${column} =    Evaluate    (${number}%3)
    ${column} =    Set Variable If    ${column} == 0    3    ${column}
    ${row} =    Evaluate    math.ceil(${number}/3)    math
    ${start_x}=    Evaluate    ${element_location['x']} + (${element_size['width']} * ${column}) - (${element_size['width']} * 0.5)
    ${start_y}=    Evaluate    ${element_location['y']} + (${element_size['height']} * ${row}) - ( ${element_size['height']} * 0.5)
    Click Element At Coordinates    ${start_x}    ${start_y}

Randomly Swipe
    [Arguments]    ${min_times}    ${max_times}    ${start_x}    ${start_y}    ${end_x}    ${end_y}
    ...    ${duration}
    [Tags]    WadeCW
    ${swipe_count}    evaluate    random.randint(${min_times},${max_times})    random
    Sleep    1
    : FOR    ${j}    IN RANGE    0    ${swipe_count}
    \    Swipe By Percent    ${start_x}    ${start_y}    ${end_x}    ${end_y}    ${duration}
    \    Exit For Loop If    ${j}==${swipe_count}
