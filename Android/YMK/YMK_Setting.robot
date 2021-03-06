*** Settings ***
Suite Setup       Open Application and Pass Tutorial and Set Library Order
Suite Teardown    Close Application
Test Setup        Launch Application and enter setting
Test Teardown     Quit Application
Library           AppiumLibrary
Resource          resource/YMK_Keyword.robot

*** Variables ***

*** Test Cases ***
01. Camera and GPS
    Sleep    1
    Back from Setting
    Subscribe Now
    Enter Makeup Cam
    Sleep    5
    Set counting to 3 seconds
    Take a photo
    Sleep    4
    Save the photo
    Back from Makeup Cam
    Enter Setting
    Click Switch    Auto Save Photo
    Click Switch    Front Camera Mirror
    Click Switch    Skin Beautifier
    Click Switch    Countdown Sound Effect
    Click Switch    Face Metering
    Click Switch    Access GPS Location
    Back from Setting
    Enter Makeup Cam
    Take a photo
    Sleep    4
    Back from Makeup Cam
    Enter Setting

02-1. Photo-Quality
    Back from Setting
    Subscribe Now
    Enter Setting
    Click Quality
    Choose Quality    Smart HD PRO
    Back from Quality
    Back from Setting
    Launcher-Click Photo Makeup button
    Click    Camera
    Select the first photo
    Click    Save
    Back from Result page
    Enter Setting
    Click Quality
    Choose Quality    Ultra High
    Back from Quality
    Back from Setting
    Launcher-Click Photo Makeup button
    Click    Camera
    Select the first photo
    Click    Save
    Back from Result page
    Enter Setting
    Click Quality
    Choose Quality    High
    Back from Quality
    Back from Setting
    Launcher-Click Photo Makeup button
    Click    Camera
    Select the first photo
    Click    Save
    Sleep    3
    Press Keycode    4
    Back from Result page
    Enter Setting
    Click Quality
    Choose Quality    Normal
    Back from Quality
    Back from Setting
    Launcher-Click Photo Makeup button
    Click    Camera
    Select the first photo
    Click    Save
    Back from Result page
    Enter Setting

02-2. Photo-Back up to cloud and Watermark
    Click Back up to Cloud
    Click Switch    Photo backup
    Sleep    3
    Log in    ethan1@a.com    aaaaaa
    Click Switch    Video backup
    Click Back    #From Back up to Cloud
    Click Switch    Photo Watermark
    Subscribe Now
    Scroll down to Find    Video Watermark
    Click Switch    Video Watermark
    Back from Setting
    Enter Makeup Cam
    Take a photo
    ${Save_button}    Run Keyword And Return Status    Page Should Contain Element    com.cyberlink.youcammakeup:id/saveButtonImage
    Run keyword if    ${Save_button} == "True"    Run Keyword    Save the photo
    Save the photo
    Switch to video mode
    Start recording 3 seconds
    Stop recording
    Save the video
    Back from video result page
    Click Me page
    Sleep    20
    Capture Page Screenshot    Back_up_to_cloud_without_Watermark.png

03. Video - Autoplay
    Scroll down to Find    Autoplay
    Click    Never Autoplay Videos
    Click Back    #From Autoplay
    Scroll down to Find    Tutorials
    Click the first video
    Sleep    3
    Capture Page Screenshot    Never_Autoplay_with_Wi-Fi.png
    Click Back    #From the video
    Click Back    #From Tutorials
    Sleep    1
    Scroll down to Find    Autoplay
    Click    Wi-Fi Only
    Sleep    1
    Click Back    #From Autoplay
    Set Network Connection Status    0
    Log    Wi-Fi off
    Scroll down to Find    Tutorials
    Sleep    3
    Capture Page Screenshot    Wi-Fi Only_without_Wi-Fi.png
    Click Leave
    Set Network Connection Status    2
    Log    Wi-Fi on
    Sleep    1
    Scroll down to Find    Tutorials
    Click the first video
    Sleep    5
    Capture Page Screenshot    Wi-Fi Only_with_Wi-Fi.png

04-1. Push Notifications-Push Notifications (Include BC setting)

04-2. Event & Version Updates-Show Event & Version Update notice
    [Tags]    WadeCW
    Sleep    1
    Scroll down to Find    Events & Version Updates
    Wait Until Page Contains    com.cyberlink.youcammakeup:id/NoticeItemArrowDown
    Click Element    com.cyberlink.youcammakeup:id/NoticeItemArrowDown
    Click Element    com.cyberlink.youcammakeup:id/NoticeItemChildDownloadBtn
    #Randomly Swipe by Percent    0    20    50    70    50    55    2000
    #Randomly choose Notice
    Sleep    3
    Capture Page Screenshot    Show_Event_AND_Version_Update_notice.png

04-3. Country-Check BC post and sku data are correct after swithching country
    [Tags]    WadeCW    #Not finish
    Sleep    1
    Scroll down to Find specified button    com.cyberlink.youcammakeup:id/countryBtn
    Randomly Swipe    0    30    50    80    50    20    2000
    Randomly switch Country/Region

05-1.Tutorial-Play video normally
    [Tags]    WadeCW
    Sleep    1
    Scroll down to Find specified button    com.cyberlink.youcammakeup:id/tutorialBtn
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/post_cover
    Randomly Swipe    0    10    50    70    50    20    2000
    Randomly play video

05-2. Rate us-Go to Google/Apple store
    [Tags]    WadeCW
    Sleep    1
    Scroll down to Find specified button    com.cyberlink.youcammakeup:id/rateUsBtn
    Go to store
    #Wait Until Page Contains Element    vivo:id/text1
    #Click Element    vivo:id/text1
    #Sleep    5
    Capture Page Screenshot    filename=Rateusscreenshot.png

05-3. Follow Us-Go FB page
    [Tags]    WadeCW
    Sleep    1
    Scroll down to Find specified button    com.cyberlink.youcammakeup:id/followUsBtn
    Sleep    5
    Capture Page Screenshot    filename=Followusscreenshot.png

05-4. FAQ & Send Feedback-Show FAQ page
    [Tags]    WadeCW
    Sleep    1
    Scroll down to Find specified button    com.cyberlink.youcammakeup:id/sendFeedbackBtn
    Sleep    20
    Wait Until Page Contains    Send feedback
    Capture Page Screenshot    filename=ShowFAQpagescreenshot.png

05-5. FAQ & Send Feedback-Check if user feedback can be sent to server
    [Tags]    WadeCW
    Sleep    1
    Scroll down to Find specified button    com.cyberlink.youcammakeup:id/sendFeedbackBtn
    Sleep    20
    Wait Until Page Contains    Send feedback
    Click Text    Send feedback
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/edit_feedback_text
    Input Text    com.cyberlink.youcammakeup:id/edit_feedback_text    QA Test    #輸入QA TEST
    Input Text    com.cyberlink.youcammakeup:id/edit_feedback_email    WadeCW_Lee@PerfectCorp.com    #輸入E-mail
    Click Element    com.cyberlink.youcammakeup:id/btn_agree_continue    #點選交出
    Sleep    5
    Wait Until Page Contains Element    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive
    Click Element    com.cyberlink.youcammakeup:id/alertDialog_buttonPositive    #點選OK

05-6. About-Current Version
    [Tags]    WadeCW
    Sleep    1
    Scroll down to Find specified button    com.cyberlink.youcammakeup:id/aboutBtn
    Sleep    1
    Capture Page Screenshot    filename=CurrentVersionscreenshot.png

05-7. About-Latest Version
    [Tags]    WadeCW
    Sleep    1
    Scroll down to Find specified button    com.cyberlink.youcammakeup:id/aboutBtn
    Sleep    1
    Click Text    Latest Version
    Sleep    1
    Capture Page Screenshot    filename=LatestVersionscreenshot.png

05-8. About-Legal Notice
    [Tags]    WadeCW
    Sleep    1
    Scroll down to Find specified button    com.cyberlink.youcammakeup:id/aboutBtn
    Sleep    1
    Click Text    Legal Notice
    Sleep    1
    Capture Page Screenshot    filename=LegalNoticescreenshot.png

05-9. Abour-Terms of Service
    [Tags]    WadeCW
    Sleep    1
    Scroll down to Find specified button    com.cyberlink.youcammakeup:id/aboutBtn
    Sleep    1
    Click Text    Terms of Service
    Sleep    1
    Capture Page Screenshot    filename=TermsofServicescreenshot.png

05-10. About-Privacy Policy
    [Tags]    WadeCW
    Sleep    1
    Scroll down to Find specified button    com.cyberlink.youcammakeup:id/aboutBtn
    Sleep    1
    Click Text    Privacy Policy
    Sleep    1
    Capture Page Screenshot    filename=PrivacyPolicyscreenshot.png
