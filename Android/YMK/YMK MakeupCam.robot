*** Settings ***
Suite Setup       Open Application and Pass Tutorial and Set Library Order
Suite Teardown    Close Application
Test Setup        Launch Application and enter Makeup Cam
Test Teardown     Quit Application
Library           AppiumLibrary
Resource          resource/YMK_Keyword.robot

*** Variables ***
${Variable1}      value1

*** Test Cases ***
01-1. Makeup collection-Show in-place download collection in look tab (not subscribe)
    [Tags]    WadeCW
    Sleep    3
    Click Text    LOOKS
    Click Element    com.cyberlink.youcammakeup:id/effectGridCheck
    Sleep    5
    Page Should Contain Element    com.cyberlink.youcammakeup:id/effectDownloadIcon
    Capture Page Screenshot    downloadcollection_inlooktab.png

01-2. Makeup collection-Show in-place download collection in Premium tab (not subscribe)
    [Tags]    WadeCW
    Sleep    3
    @{count_categoryImage}    Get Webelements    //*[contains(@resource-id,'com.cyberlink.youcammakeup:id/categoryImage')]
    Click Element    @{count_categoryImage}[1]    #點皇冠
    Sleep    3
    Click Element    com.cyberlink.youcammakeup:id/effectGridPhoto
    Sleep    5
    Page Should Contain Element    com.cyberlink.youcammakeup:id/effectDownloadIcon
    Capture Page Screenshot    downloadcollection_inPremiumtab.png

01-3. Makeup collection-Pop up dialog when switch to makeup category (not subscribe)
    [Tags]    WadeCW
    Sleep    8
    @{count_categoryImage}    Get Webelements    //*[contains(@resource-id,'com.cyberlink.youcammakeup:id/categoryImage')]
    Click Element    @{count_categoryImage}[1]    #點皇冠
    Sleep    3
    Randomly_apply_premium_look
    Click Text    MAKEUP
    Sleep    3
    Page Should Contain Text    Later
    Capture Page Screenshot    Pop_up_dialog_when_switch_to_makeup.png

01-4. Makeup collection-When taking a photo, show free trial button (not subscribe)
    [Tags]    WadeCW
    Sleep    8
    @{count_categoryImage}    Get Webelements    //*[contains(@resource-id,'com.cyberlink.youcammakeup:id/categoryImage')]
    Click Element    @{count_categoryImage}[1]    #點皇冠
    Sleep    3
    Randomly_apply_premium_look
    Click Element    com.cyberlink.youcammakeup:id/before
    Page Should Contain Text    Later
    Capture Page Screenshot    When_taking_a_photo_show_free_trial_button.png

01-5. LOOK-Check effect can be applied normally
    [Tags]    WadeCW
    Sleep    3
    Click Text    LOOKS
    Randomly_apply_look
    Sleep    3
    Capture Page Screenshot    LOOKCheckEffect.png

01-6. LOOK-Check if in-place download looks show on the list
    [Tags]    WadeCW
    Sleep    3
    Page Should Contain Element    com.cyberlink.youcammakeup:id/effectDownloadIcon
    Capture Page Screenshot    CheckInPlaceDownloadLooksShowOnTheList.png

01-7. My favorite-Can add look in my favorite
    [Tags]    WadeCW
    #尚未完成
    Sleep    3
    Click Text    LOOKS
    Randomly_apply_look
    Long Press    ${Variable1}    2000
    ${Look_Location}    Get Element Location    ${Variable1}
    Click A Point    ${Look_Location['x']}    ${Look_Location['y']}    5000
    ${CircleView_Location}    Get Element Location    com.cyberlink.youcammakeup:id/circleView
    Swipe    ${Look_Location['x']}    ${Look_Location['y']}    ${CircleView_Location['x']}    ${CircleView_Location['y']}    2000

01-8. My favorite-Can delete look in my favorite
    [Tags]    WadeCW

01-9. Look with Hair color-Can apply the look with hair color normally
    [Tags]    WadeCW
    Sleep    3
    Click Text    LOOKS
    Randomly_apply_look
    Click Text    HAIR
    Capture Page Screenshot    LOOK_HairColor.png

01-10. YCF Looks-Can show frame normally
    [Tags]    WadeCW
    Sleep    3
    Click Element    com.cyberlink.youcammakeup:id/moreThumbnail
    Scroll down to Find text    Live    0    20    50    70    50    20    2000

01-11. YCF Looks-Can show animation when blink eye

01-12. YCF Looks-Can show animation when open month
