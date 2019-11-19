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

Open Setting
    [Tags]    WadeCW
    Open App
    Pass Tutorial
    Enter Setting

Close App
    [Tags]    WadeCW
    Close All Applications
    Log    already close app

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
    Sleep    3
    : FOR    ${i}    IN RANGE    1    20
    \    ${count}    Get Matching Xpath Count    xpath=//*[contains(@text, 'YouCam Makeup Sample')]
    \    Exit For Loop If    ${count}>0
    \    Swipe    400    1000    400    300    400
    Click text    YouCam Makeup Sample
    ${dialog}    Run Keyword And Return Status    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive    timeout=2
    Run Keyword if    ${dialog}>0    Download sample photos
    ...    ELSE    Click Element    com.cyberlink.youcammakeup:id/photoItemImage
    Sleep    3

Subscribe
    [Tags]    Pocky
    Click button    //*[@resource-id="root"]/android.view.View[1]/android.view.View[1]/android.view.View[7]/android.view.View[1]/android.widget.Button[1]
    Sleep    3
    Click button    com.android.vending:id/footer_placeholder    #按"SUBSCRIBE" button
    ${status}    Run Keyword And Return Status    Wait Until Page Contains Element    com.android.vending:id/input    5
    Run keyword if    ${status} > 0    Run Keywords    Input Password    com.android.vending:id/input    Pft24725102
    ...    AND    Press Keycode    66    #66 is enter key

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
    [Arguments]    ${order}    # 0: 第一個 1: 第二個
    [Tags]    Pocky
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/colorItemColorTexture    timeout=10
    @{element}    Get Webelements    com.cyberlink.youcammakeup:id/colorItemColorTexture
    Sleep    1
    Click Element    @{element}[${order}]

Adjust Horizontal Seekbar
    [Tags]    Pocky
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/unitSeekBar    timeout=10
    ${element_size}=    Get Element Size    id=com.cyberlink.youcammakeup:id/unitSeekBar
    ${element_location}=    Get Element Location    id=com.cyberlink.youcammakeup:id/unitSeekBar
    ${start_x}=    Evaluate    ${element_location['x']} + (${element_size['width']} * 0)
    ${start_y}=    Evaluate    ${element_location['y']} + (${element_size['height']} * 0.5)
    ${end_x}=    Evaluate    ${element_location['x']} + (${element_size['width']} * 1)
    ${end_y}=    Evaluate    ${element_location['y']} + (${element_size['height']} * 0.5)
    Swipe    ${start_x}    ${start_y}    ${end_x}    ${end_y}    1500

Adjust Vertical Seekbar
    [Tags]    Pocky
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/unitSeekBar    timeout=10
    ${element_size}=    Get Element Size    id=com.cyberlink.youcammakeup:id/unitSeekBar
    ${element_location}=    Get Element Location    id=com.cyberlink.youcammakeup:id/unitSeekBar
    ${start_x}=    Evaluate    ${element_location['x']} + (${element_size['width']} * 0.5)
    ${start_y}=    Evaluate    ${element_location['y']} + (${element_size['height']} * 0.8)
    ${end_x}=    Evaluate    ${element_location['x']} + (${element_size['width']} * 0.5)
    ${end_y}=    Evaluate    ${element_location['y']} + (${element_size['height']} * 0)
    Swipe    ${start_x}    ${start_y}    ${end_x}    ${end_y}    1500

Enter Setting
    [Tags]    Ethan
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/launcherSettingButton
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
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/makeupMenuBottomToolbar    timeout=20
    ${element_size}=    Get Element Size    id=com.cyberlink.youcammakeup:id/makeupMenuBottomToolbar
    ${element_location}=    Get Element Location    id=com.cyberlink.youcammakeup:id/makeupMenuBottomToolbar
    ${start_x}=    Evaluate    ${element_location['x']} + (${element_size['width']} * 0.8)
    ${start_y}=    Evaluate    ${element_location['y']} + (${element_size['height']} * 0.5)
    ${end_x}=    Evaluate    ${element_location['x']} + (${element_size['width']} * 0.2)
    ${end_y}=    Evaluate    ${element_location['y']} + (${element_size['height']} * 0.5)
    Swipe    ${start_x}    ${start_y}    ${end_x}    ${end_y}    1000

Apply Pattern
    [Arguments]    ${order}    # 0: 第一個 1: 第二個
    [Tags]    Pocky
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/panel_beautify_template_button_image    timeout=10
    @{element}    Get Webelements    com.cyberlink.youcammakeup:id/panel_beautify_template_button_image
    Sleep    1
    Click Element    @{element}[${order}]

Click Switch Button
    [Tags]    Pocky
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/switchBtn
    Click Element    com.cyberlink.youcammakeup:id/switchBtn

Click Switch
    [Arguments]    ${Settings_catrgory}
    [Tags]    Ethan
    #On Launcher Setting
    Sleep    1
    ${element_location}=    Get Element Location    xpath=//*[@text='${Settings_catrgory}']
    ${screen_width}=    Get Window Width
    ${start_x}=    Evaluate    ${screen_width} * 0.9
    ${start_y}=    Evaluate    ${element_location['y']} + 10
    Click Element At Coordinates    ${start_x}    ${start_Y}

Click on the specified button
    [Arguments]    ${resource-id}    ${index}
    [Tags]    WadeCW
    ${element}    Get Webelements    //*[contains(@resource-id,'${resource-id}')]
    Click Element    ${element}[${index}]

Scroll down to Find
    [Arguments]    ${Name}
    [Tags]    Pocky
    Sleep    2
    : FOR    ${i}    IN RANGE    1    20    #向下划直到找到"${Name} " text
    \    ${count}    Get Matching Xpath Count    xpath=//*[contains(@text, '${Name}')]
    \    Exit For Loop If    ${count}>0
    \    Swipe    400    1000    400    300    400
    Click text    ${Name}

Scroll down to Find specified button
    [Arguments]    ${resource-id}    ${min_times}    ${max_times}    ${start_x}    ${start_y}    ${end_x}
    ...    ${end_y}    ${duration}
    [Tags]    WadeCW
    Sleep    1
    : FOR    ${i}    IN RANGE    ${min_times}    ${max_times}    #向下划直到找到resource-id
    \    Swipe By Percent    ${start_x}    ${start_y}    ${end_x}    ${end_y}    ${duration}
    \    ${count}    Get Matching Xpath Count    //*[contains(@resource-id,'${resource-id}')]
    \    Exit For Loop If    ${count}>0
    Click Element    ${resource-id}

Save
    [Tags]    Pocky
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/topToolBarExportBtn    timeout=30
    Sleep    5
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

Click button
    [Arguments]    ${element name}
    [Tags]    Shura
    Wait Until Element Is Visible    ${element name}    timeout=30
    Click Element    ${element name}

Back from Setting
    [Tags]    Ethan
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/btn_setting_back
    Click Element    com.cyberlink.youcammakeup:id/btn_setting_back

Randomly Swipe
    [Arguments]    ${min_times}    ${max_times}    ${start_x}    ${start_y}    ${end_x}    ${end_y}
    ...    ${duration}
    [Tags]    WadeCW
    ${swipe_count}    evaluate    random.randint(${min_times},${max_times})    random
    Sleep    1
    : FOR    ${j}    IN RANGE    0    ${swipe_count}
    \    Swipe By Percent    ${start_x}    ${start_y}    ${end_x}    ${end_y}    ${duration}
    \    Exit For Loop If    ${j}==${swipe_count}

Randomly play video
    [Tags]    WadeCW
    ${count_video}    Get Matching Xpath Count    //*[contains(@resource-id,'com.cyberlink.youcammakeup:id/post_cover')]    #計算影片數
    ${count}    Get Webelements    //*[contains(@resource-id,'com.cyberlink.youcammakeup:id/post_cover')]
    ${video_index}    evaluate    ${count_video} -1
    ${random_click}    evaluate    random.randint(0,${video_index})    random
    Click Element    ${count}[${random_click}]
    Sleep    1
    ${video_type1}=    Run Keyword And Return Status    Page Should Contain Element    com.cyberlink.youcammakeup:id/post_play_icon
    Run Keyword If    '${video_type1}'=='True'    Click Element    com.cyberlink.youcammakeup:id/post_play_icon
    ...    ELSE    Run Keyword    No Operation
    Sleep    10
    Capture Page Screenshot    filename=Tutorialsscreenshot.png

Randomly choose Notice
    [Tags]    WadeCW
    ${count_notice}    Get Matching Xpath Count    //*[contains(@resource-id,'com.cyberlink.youcammakeup:id/NoticeItemArrowDown')]    #計算Notice數
    ${count}    Get Webelements    //*[contains(@resource-id,'com.cyberlink.youcammakeup:id/NoticeItemArrowDown')]
    ${notice_index}    evaluate    ${count_notice} -1
    ${random_click}    evaluate    random.randint(0,${notice_index})    random
    Click Element    ${count}[${random_click}]
    Sleep    5
    Scroll down to Find specified button    com.cyberlink.youcammakeup:id/NoticeItemChildDownloadBtn    0    5    50    60    50
    ...    50    2000
    Sleep    10

TapTryButton
    [Tags]    WadeCW
    Sleep    1
    Swipe By Percent    50    60    50    50    2000
    ${try_it_button}    Run Keyword And Return Status    Page Should Contain Element    com.cyberlink.youcammakeup:id/post_try_it_button
    ${action_buy}    Run Keyword And Return Status    Page Should Contain Element    com.cyberlink.youcammakeup:id/post_action_buy
    Run Keyword If    ${try_it_button}==True    Run Keywords    Click Element    com.cyberlink.youcammakeup:id/post_try_it_button
    ...    AND    Sleep    10
    ...    AND    Capture Page Screenshot    filename=Versionscreenshot.png
    ...    ELSE IF    ${action_buy}==True    Run Keywords    Click Element    com.cyberlink.youcammakeup:id/post_action_buy
    ...    AND    Sleep    10
    ...    AND    Capture Page Screenshot    filename=Versionscreenshot.png
    ...    ELSE    Run Keywords    Sleep    3
    ...    AND    Press Keycode    4    None
    ...    AND    Press Keycode    4    None
    ...    AND    Scroll down to Find    Events & Version Updates
    ...    AND    Wait Until Page Contains    com.cyberlink.youcammakeup:id/NoticeItemArrowDown
    ...    AND    Randomly Swipe    0    20    50    70
    ...    50    55    2000
    ...    AND    Randomly choose Notice
    ...    AND    TapTryButton

Randomly switch Country/Region
    [Tags]    WadeCW
    ${count_country}    Get Matching Xpath Count    //*[contains(@resource-id,'com.cyberlink.youcammakeup:id/country_name')]    #計算Country數
    ${count}    Get Webelements    //*[contains(@resource-id,'com.cyberlink.youcammakeup:id/country_name')]
    ${country_index}    evaluate    ${count_country} -1
    ${random_click}    evaluate    random.randint(0,${country_index})    random
    Click Element    ${count}[${random_click}]
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive
    Click Element    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive
    Sleep    5

Start 7-Day Free Trial
    [Tags]    Ethan
    ${FirstSubscribe}    Run keyword and Return Status    Wait Until Page Contains Element    com.android.vending:id/footer_placeholder
    Run keyword If    ${FirstSubscribe} == "True"    Click Element    com.android.vending:id/footer_placeholder
    ...    ELSE    Run keywords    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/dialogExContainer
    ...    AND    Click Element    com.cyberlink.youcammakeup:id/dialogExContainer
    Sleep    5

Enter Makeup Cam
    [Tags]    Ethan
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/launcherMakeupCamBtn
    Click Element    com.cyberlink.youcammakeup:id/launcherMakeupCamBtn
    Sleep    3

Set counting to 3 seconds
    [Tags]    Ethan
    #In Makeup Cam
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/cameraMoreOptionButton
    Click Element    com.cyberlink.youcammakeup:id/cameraMoreOptionButton
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/cameraTimerButton
    Click Element    com.cyberlink.youcammakeup:id/cameraTimerButton
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/timer3s
    Click Element    com.cyberlink.youcammakeup:id/timer3s
    ${screen_height}=    Get Window Height
    ${screen_width}=    Get Window Width
    ${start_x}=    Evaluate    ${screen_width} * 0.5
    ${start_y}=    Evaluate    ${screen_height} * 0.5
    Click A Point    ${start_x}    ${start_y}

Take a photo
    [Tags]    Ethan
    #In Makeup Cam
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/before
    Click Element    com.cyberlink.youcammakeup:id/before

Save the photo
    [Tags]    Ethan
    #In Makeup Cam
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/saveButtonImage
    Click Element    com.cyberlink.youcammakeup:id/saveButtonImage

Back from Makeup Cam
    [Tags]    Ethan
    #In Makeup Cam
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/cameraBackIcon
    Click Element    com.cyberlink.youcammakeup:id/cameraBackIcon

Natural Looks
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/banner_image
    Click Element    com.cyberlink.youcammakeup:id/launcherExtra
    Wait Until Page Contains Element
    Click text    ${Nature Look text}
    Click text    ${Nature Look text}
    Wait Until Page Contains Element    com.android.packageinstaller:id/desc_container
    Click Element    com.android.packageinstaller:id/permission_allow_button
    Wait Until Page Contains Element    com.android.packageinstaller:id/desc_container
    Click Element    com.android.packageinstaller:id/permission_allow_button
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/focusAreaView
    Click Element    com.cyberlink.youcammakeup:id/cameraBackButton

Store Start free 7-day trial
    [Tags]    Lynette
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/banner_image
    Click Element    com.cyberlink.youcammakeup:id/launcherSubscriptionEntryButton
    Click text    7-DAY FREE TRIAL
    Click Element    com.android.vending:id/footer_placeholder

Store Live preview (not subscribe)
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/banner_image
    Click Element    com.cyberlink.youcammakeup:id/launcherExtra
    Click text    bcaee214-cd27-46a0-a402-a085306e6b7a
    Click text    Live Preview

Costume Looks
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/banner_image
    Click Element    com.cyberlink.youcammakeup:id/launcherExtra
    Click text    Costume
    Click text    ${Costume Look text}
    Click text    ${Costume Look text}
    Wait Until Page Contains Element    com.android.packageinstaller:id/desc_container
    Click Element    com.android.packageinstaller:id/permission_allow_button
    Wait Until Page Contains Element    com.android.packageinstaller:id/desc_container
    Click Element    com.android.packageinstaller:id/permission_allow_button
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/focusAreaView
    Click Element    com.cyberlink.youcammakeup:id/cameraBackButton

Eyeshadow
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/banner_image
    Click Element    com.cyberlink.youcammakeup:id/launcherExtra
    Click text    Eye Shadow
    Click text    ${Palette Colors number}
    Click text    thumb_palettes_2
    Click text    YouCam Makeup Sample
    Click Element    com.cyberlink.youcammakeup:id/photoItemImage
    Click Element    com.cyberlink.youcammakeup:id/topToolBarBackBtn
    Click Element    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive
    Click Element    com.cyberlink.youcammakeup:id/topToolBarBackBtnContainer
    Click Element    com.cyberlink.youcammakeup:id/topToolBarBackBtnContainer
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/focusAreaView
    Click Element    com.cyberlink.youcammakeup:id/cameraBackButton

Eyeliner
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/banner_image
    Click Element    com.cyberlink.youcammakeup:id/launcherExtra
    Click text    Eyeliner
    Click Element    All >
    Click text    ${Eyeliner Pattern Name}
    Click text    ${Eyeliner Pattern Name}
    Click text    YouCam Makeup Sample
    Click Element    com.cyberlink.youcammakeup:id/photoItemImage
    Click Element    com.cyberlink.youcammakeup:id/topToolBarBackBtn
    Click Element    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive
    Click Element    com.cyberlink.youcammakeup:id/topToolBarBackBtnContainer
    Click Element    com.cyberlink.youcammakeup:id/topToolBarBackBtnContainer
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/focusAreaView
    Click Element    com.cyberlink.youcammakeup:id/cameraBackButton

Eyelashes
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/banner_image
    Click Element    com.cyberlink.youcammakeup:id/launcherExtra
    Click text    Eyelashes
    Click text    ${Eyelashes Pattern Name}
    Click text    ${Eyelashes Pattern Name}
    Click text    YouCam Makeup Sample
    Click Element    com.cyberlink.youcammakeup:id/photoItemImage
    Click Element    com.cyberlink.youcammakeup:id/topToolBarBackBtn
    Click Element    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive
    Click Element    com.cyberlink.youcammakeup:id/topToolBarBackBtnContainer
    Click Element    com.cyberlink.youcammakeup:id/topToolBarBackBtnContainer
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/focusAreaView
    Click Element    com.cyberlink.youcammakeup:id/cameraBackButton

Face Paint
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/banner_image
    Click Element    com.cyberlink.youcammakeup:id/launcherExtra
    Click text    Face Paint
    Click text    ${Face Paint Pattern}
    Click text    ${Face Paint Pattern}
    Click text    YouCam Makeup Sample
    Click Element    com.cyberlink.youcammakeup:id/photoItemImage
    Click Element    com.cyberlink.youcammakeup:id/topToolBarBackBtn
    Click Element    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive
    Click Element    com.cyberlink.youcammakeup:id/topToolBarBackBtnContainer
    Click Element    com.cyberlink.youcammakeup:id/topToolBarBackBtnContainer
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/focusAreaView
    Click Element    com.cyberlink.youcammakeup:id/cameraBackButton

Hair
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/banner_image
    Click Element    com.cyberlink.youcammakeup:id/launcherExtra
    Click text    Hair
    Click text    ${Wig Pattern}
    Click text    ${Wig Pattern}
    Click text    YouCam Makeup Sample
    Click Element    com.cyberlink.youcammakeup:id/photoItemImage
    Click Element    com.cyberlink.youcammakeup:id/topToolBarBackBtn
    Click Element    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive
    Click Element    com.cyberlink.youcammakeup:id/topToolBarBackBtnContainer
    Click Element    com.cyberlink.youcammakeup:id/topToolBarBackBtnContainer
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/focusAreaView
    Click Element    com.cyberlink.youcammakeup:id/cameraBackButton

Eyewear
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/banner_image
    Click Element    com.cyberlink.youcammakeup:id/launcherExtra
    Click text    Eyewear
    Click text    ${Eyewear Pattern}
    Click text    ${Eyewear Pattern}
    Click text    YouCam Makeup Sample
    Click Element    com.cyberlink.youcammakeup:id/photoItemImage
    Click Element    com.cyberlink.youcammakeup:id/topToolBarBackBtn
    Click Element    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive
    Click Element    com.cyberlink.youcammakeup:id/topToolBarBackBtnContainer
    Click Element    com.cyberlink.youcammakeup:id/topToolBarBackBtnContainer
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/focusAreaView
    Click Element    com.cyberlink.youcammakeup:id/cameraBackButton

Headband
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/banner_image
    Click Element    com.cyberlink.youcammakeup:id/launcherExtra
    Click text    Headband
    Click text    ${Headband Pattern}
    Click text    ${Headband Pattern}
    Click text    YouCam Makeup Sample
    Click Element    com.cyberlink.youcammakeup:id/photoItemImage
    Click Element    com.cyberlink.youcammakeup:id/topToolBarBackBtn
    Click Element    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive
    Click Element    com.cyberlink.youcammakeup:id/topToolBarBackBtnContainer
    Click Element    com.cyberlink.youcammakeup:id/topToolBarBackBtnContainer
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/focusAreaView
    Click Element    com.cyberlink.youcammakeup:id/cameraBackButton

Accessories
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/banner_image
    Click Element    com.cyberlink.youcammakeup:id/launcherExtra
    Click text    Accessories
    Click text    ${Accessories Pattern}
    Click text    ${Accessories Pattern}
    Click text    YouCam Makeup Sample
    Click Element    com.cyberlink.youcammakeup:id/photoItemImage
    Click Element    com.cyberlink.youcammakeup:id/topToolBarBackBtn
    Click Element    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive
    Click Element    com.cyberlink.youcammakeup:id/topToolBarBackBtnContainer
    Click Element    com.cyberlink.youcammakeup:id/topToolBarBackBtnContainer
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/focusAreaView
    Click Element    com.cyberlink.youcammakeup:id/cameraBackButton

Select the first photo
    [Tags]    Ethan
    #On Photo picker
    Sleep    5
    ${screen_width}=    Get Window Width
    ${screen_Height}=    Get Window Height
    ${start_x}=    Evaluate    ${screen_width} * 0.3
    ${start_y}=    Evaluate    ${screen_Height} * 0.2
    Click Element At Coordinates    ${start_x}    ${start_Y}

Back from Result page
    [Tags]    Ethan
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/sharePageHomeButton
    Click Element    com.cyberlink.youcammakeup:id/sharePageHomeButton

Click Quality
    [Tags]    Ethan
    #On Setting
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/photoQualityRowBtn
    Click Element    com.cyberlink.youcammakeup:id/photoQualityRowBtn

Choose Quality
    [Arguments]    ${Quality_catrgory}
    [Tags]    Ethan
    #On Setting - Photo Quality
    Sleep    3
    ${element_location}=    Get Element Location    xpath=//*[@text='${Quality_catrgory}']
    ${screen_width}=    Get Window Width
    ${start_x}=    Evaluate    ${screen_width} * 0.7
    ${start_y}=    Evaluate    ${element_location['y']} * 1
    Click A Point    ${start_x}    ${start_Y}

Back from Quality
    [Tags]    Ethan
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/aboutBackBtn
    Click Element    com.cyberlink.youcammakeup:id/aboutBackBtn

Subscribe Now
    [Tags]    Ethan
    #IAP page
    Sleep    3
    ${screen_width}=    Get Window Width
    ${screen_height}=    Get Window Height
    ${start_x}=    Evaluate    ${screen_width} * 0.5
    ${start_y}=    Evaluate    ${screen_height} * 0.55
    Click Element At Coordinates    ${start_x}    ${start_Y}

Click Back up to Cloud
    [Tags]    Ethan
    #On Setting
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/CloudAlbumBtn
    Click Element    com.cyberlink.youcammakeup:id/CloudAlbumBtn

Back from Back up to Cloud
    [Tags]    Ethan
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/top_bar_btn_back
    Click Element    com.cyberlink.youcammakeup:id/top_bar_btn_back

Switch to video mode
    [Tags]    Ethan
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/videoRecModeBtn
    Click Element    com.cyberlink.youcammakeup:id/videoRecModeBtn

Start recording 3 seconds
    [Tags]    Ethan
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/before
    Click Element    com.cyberlink.youcammakeup:id/before
    Sleep    3

Stop recording
    [Tags]    Ethan
    ${screen_width}=    Get Window Width
    ${element_location}=    Get Element Location    com.cyberlink.youcammakeup:id/category
    ${start_x}=    Evaluate    ${screen_width} * 0.5
    ${start_y}=    Evaluate    ${element_location['y']} + 90
    Click Element At Coordinates    ${start_x}    ${start_Y}

Save the video
    [Tags]    Ethan
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/videoSaveButton
    Click Element    com.cyberlink.youcammakeup:id/videoSaveButton

Back from video result page
    [Tags]    Ethan
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/homeButton
    Click Element    com.cyberlink.youcammakeup:id/homeButton

Click Me page
    [Tags]    Ethan
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/bc_me_icon
    Click Element    com.cyberlink.youcammakeup:id/bc_me_icon
