function instruction(task_type,search_type,target_key_side)

global win0 win2 winclear

global_settings;

%Instruction reminder
Screen('CopyWindow',winclear,win0);
Screen(win0,'WaitBlanking',settings.REFRESH_RATE * 2/3);

Screen(win2,'TextSize',settings.LETTER_SIZE);
Screen(win2,'TextFont',settings.LETTER_FONT);

if task_type == 1
    Text1='You will see on the screen several vertical dotted lines     and ONE tilted line';
    if target_key_side == 0;
        target_tilted_left_key = [settings.LEFT_RESPONSE_KEY,' key'];
        target_tilted_right_key = [settings.RIGHT_RESPONSE_KEY,' key'];
    else
        target_tilted_left_key = [settings.RIGHT_RESPONSE_KEY,' key'];
        target_tilted_right_key = [settings.LEFT_RESPONSE_KEY,' key'];
    end
    Text2=['- If the tilted line is like this       --> hit the ', target_tilted_left_key];
    Text3=['- If the tilted line is like this       --> hit the ', target_tilted_right_key];
    Text4='You must answer as FAST and as ACCURATELY as you can!!!';
    Text5='If you give a wrong answer you will be notified.';

    Screen(win2,'DrawText',Text1,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y,settings.LETTER_COLOR_INSTRUCTIONS);
    Screen(win2,'DrawText',Text2,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y+2*settings.CM,settings.LETTER_COLOR_INSTRUCTIONS);
    Screen(win2,'DrawText',Text3,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y+4*settings.CM,settings.LETTER_COLOR_INSTRUCTIONS);
    Screen(win2,'DrawText',Text4,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y+5.5*settings.CM,settings.LETTER_COLOR_INSTRUCTIONS);
    Screen(win2,'DrawText',Text5,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y+6.5*settings.CM,settings.LETTER_COLOR_INSTRUCTIONS);
    
    Screen('CopyWindow',win2,win0);
    drawshapes(win0,'vertical_line',16.1*settings.CM,settings.LOCATION_TEXT_Y-0.4*settings.CM,settings.TARGET_COLOR);
    drawshapes(win0,'tilted_line_left',10*settings.CM,settings.LOCATION_TEXT_Y+1.6*settings.CM,settings.NON_TARGETS_COLOR);
    drawshapes(win0,'tilted_line_right',10*settings.CM,settings.LOCATION_TEXT_Y+3.6*settings.CM,settings.NON_TARGETS_COLOR);
else
    Text1='instruction for task 2';
    Screen(win2,'DrawText',Text1,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y,settings.LETTER_COLOR_INSTRUCTIONS);
    Screen('CopyWindow',win2,win0);
end

while 1
    if KbCheck == 1
        key = GetChar;
        if lower(key) == settings.NEXT_KEY_FOR_EXPERIMENTER
            break
        end
    end
end

Screen('CopyWindow',winclear,win0);
Screen('CopyWindow',winclear,win2);
Screen(win0,'WaitBlanking',settings.REFRESH_RATE*2/3);