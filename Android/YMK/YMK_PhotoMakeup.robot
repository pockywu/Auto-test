*** Settings ***
Suite Setup       Open App
Resource          resource/YMK_Keyword.robot
Library           AppiumLibrary

*** Test Cases ***
0.1 Switch Country to US
    [Tags]    Pocky
    PASS Tutorial
    Switch Country    United Status

0.2 Set photo quality to Smart HD and Subscribe
    [Tags]    Pocky
    Set photo quality    Smart HD
    Subscribe
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/aboutBackBtn
    Click Element    com.cyberlink.youcammakeup:id/aboutBackBtn
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/btn_setting_back
    Click Element    com.cyberlink.youcammakeup:id/btn_setting_back

1.1 Apply all Perfect effects and Save
    [Tags]    Pocky
    Select Sample photo
    Sleep    3
    Click    Mouth
    Select PERFECT Brand
    Apply Color    1
    Click    Smile
    Adjust Horizontal Seekbar
    Click    Teeth Whitener
    Adjust Horizontal Seekbar
    Click    Lip Art
    Apply Lip Art Pattern    3
    Scroll Makeup Menu
    Click    Face
    Adjust Horizontal Seekbar
    Click    Foundation
    Select PERFECT Brand
    Apply Color    0
    Adjust Vertical Seekbar
    Click    Blush
    Select PERFECT Brand
    Apply Color    2
    Scroll Makeup Menu
    Click    Contour
    Select PERFECT Brand
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/room_tab_color
    Click Element    com.cyberlink.youcammakeup:id/room_tab_color
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/colorView
    Click Element    com.cyberlink.youcammakeup:id/colorView
    Adjust Vertical Seekbar
    Click    Highlight
    Select PERFECT Brand
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/room_tab_color
    Click Element    com.cyberlink.youcammakeup:id/room_tab_color
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/colorView
    Click Element    com.cyberlink.youcammakeup:id/colorView
    Adjust Vertical Seekbar
    Click    Face Paint
    Apply Pattern    0
    Apply Pattern    3
    Click    Face Shaper
    Adjust Horizontal Seekbar
    Scroll Makeup Menu
    Click    Nose Enhance
    Adjust Horizontal Seekbar
    Click    Blemish
    Click Switch Button
    Click    Shine Removal
    Adjust Horizontal Seekbar
    Scroll Makeup Menu
    Click    Eye
    Select PERFECT Brand
    Apply Color    4
    Click    PATTERN
    Apply Pattern    1
    Adjust Vertical Seekbar
    Click    Eyelashes
    Select PERFECT Brand
    Apply Pattern    1
    Click    Eye Shadow
    Select PERFECT Brand
    Click    5 Colors
    Click    Eyebrows
    Select PERFECT Brand
    Apply Color    0
    Click    PATTERN
    Apply Pattern    1
    Scroll Makeup Menu
    Click    Eye Color
    Apply Pattern    4
    Click    Eye Bag
    Adjust Horizontal Seekbar
    Click    Eye Tuner
    Adjust Horizontal Seekbar
    Scroll Makeup Menu
    Click    Brighten
    Adjust Horizontal Seekbar
    Click    Double Eyelid
    Apply Pattern    0
    Adjust Horizontal Seekbar
    Click    Red-Eye
    Click Switch Button
    Sleep    3
    Scroll Makeup Menu
    Click    Hair
    Select PERFECT Brand
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/colorContainer
    Click Element    com.cyberlink.youcammakeup:id/colorContainer
    Click    Hair Style
    Apply Pattern    0
    Click    Accessories
    Apply Pattern    4
    Click    Headband
    Apply Pattern    1
    Click    Necklace
    Apply Pattern    3
    Click    Earrings
    Apply Pattern    2
    Save

1.2 Share look to BC
    Close Rating Dialog
    Scroll down to Find    SHARE
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/descriptionText
    Click Element    com.cyberlink.youcammakeup:id/descriptionText
    Log in    bb@bb.com    bbbbbb
    Wait Until Page Does Not Contain    CANCEL    timeout=30

1.3 Share photo to Facebook
    Select Sample photo
    Save
    Close Rating Dialog
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/sharePageContinueEditing
    Click Element    com.cyberlink.youcammakeup:id/sharePageContinueEditing
    Click    Facebook
    Sleep    5
    Click    POST

1.4 Share photo to Instagram
    Select Sample photo
    Save
    Close Rating Dialog
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/sharePageContinueEditing
    Click Element    com.cyberlink.youcammakeup:id/sharePageContinueEditing
    Click    Instagram
    Click Element    com.instagram.android:id/save
    Click Element    com.instagram.android:id/next_button_textview
    Click Element    com.instagram.android:id/next_button_textview
    Sleep    3
    Press Keycode    4

1.5 Share photo to WeChat
    Select Sample photo
    Save
    Close Rating Dialog
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/sharePageContinueEditing
    Click Element    com.cyberlink.youcammakeup:id/sharePageContinueEditing
    Click    WeChat
    Wait Until Element Is Visible    com.tencent.mm:id/rc
    Click Element    com.tencent.mm:id/rc
    Click    Share
    Wait Until Element Is Visible    com.tencent.mm:id/b1u
    Click Element    com.tencent.mm:id/b1u

1.6 Share photo to WeChat Moments
    Select Sample photo
    Save
    Close Rating Dialog
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/sharePageContinueEditing
    Click Element    com.cyberlink.youcammakeup:id/sharePageContinueEditing
    Click    WeChat Moments
    Click    Post
    Click    Share

1.7 Share photo to BC post
    Select Sample photo
    Save
    Close Rating Dialog
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/sharePageContinueEditing
    Click Element    com.cyberlink.youcammakeup:id/sharePageContinueEditing
    Click    YouCam Community
    Click    Share post
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/write_post_title
    Input Text    com.cyberlink.youcammakeup:id/write_post_title    Share photo by auto-test
    Click Element    com.cyberlink.youcammakeup:id/top_bar_right_text_btn
    Wait Until Page Does Not Contain Element    com.cyberlink.youcammakeup:id/bc_upload_dialog_message    timeout=30

1.8 Share photo to BC Message
    Select Sample photo
    Save
    Close Rating Dialog
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/sharePageContinueEditing
    Click Element    com.cyberlink.youcammakeup:id/sharePageContinueEditing
    Click    YouCam Community
    Click    Share messages
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/checkBox
    Click Element    com.cyberlink.youcammakeup:id/checkBox
    Click Element    com.cyberlink.youcammakeup:id/done

1.9 Share photo to Weibo
    Select Sample photo
    Save
    Close Rating Dialog
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/sharePageContinueEditing
    Click Element    com.cyberlink.youcammakeup:id/sharePageContinueEditing
    Scroll down to find    New Weibo
    Wait Until Element Is Visible    com.sina.weibo:id/titleSave
    Click Element    com.sina.weibo:id/titleSave

1.10 Share photo to Twitter
    Select Sample photo
    Save
    Close Rating Dialog
    Wait Until Element Is Visible    com.cyberlink.youcammakeup:id/sharePageContinueEditing
    Scroll down to find    Tweet
    Wait Until Element Is Visible    com.twitter.android:id/button_tweet
    Click Element    com.twitter.android:id/button_tweet

1.11 Share photo to Collage
    Select Sample photo
    Save
    Close Rating Dialog
    Scroll down to find    MORE
    Click    SAVE

test
    Select Sample photo
    Sleep    3
    Click    Mouth
    Select PERFECT Brand
    Apply Color    1
    Click    Lip Art
    Apply Lip Art Pattern    3
