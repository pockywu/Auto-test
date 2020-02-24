*** Settings ***
Suite Setup       Open Application and Pass Tutorial and Set Library Order
Suite Teardown    Close Application
Test Setup        Launch Application and enter Makeup Cam
Test Teardown     Quit Application
Library           AppiumLibrary
Resource          resource/YMK_Keyword.robot

*** Test Cases ***
01-1. Makeup collection-Show in-place download collection in look tab (not subscribe)
    Sleep    8
    Click Text    LOOKS
    Click Element    com.cyberlink.youcammakeup:id/effectGridCheck
    Sleep    5
    Page Should Contain Element    com.cyberlink.youcammakeup:id/effectDownloadIcon
    Capture Page Screenshot    downloadcollection.png

01-2. Makeup collection-Show in-place download collection in Premium tab (not subscribe)

01-3. Makeup collection-Pop up dialog when switch to makeup category (not subscribe)

01-4. Makeup collection-When taking a photo, show free trial button (not subscribe)

01-5. LOOK-Check effect can be applied normally
    Sleep    3
    Click Text    LOOKS
    Randomly_apply_look
    Sleep    3
    Capture Page Screenshot    LOOKCheckEffect.png
