function readytostart

global win0 winclear

global_settings;

Screen(win0,'TextSize',settings.LETTER_SIZE);
Screen(win0,'TextFont',settings.LETTER_FONT);

Screen(win0,'DrawText',settings.TEXT_READY_TO_START,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y,settings.LETTER_COLOR);
while 1
    if KbCheck == 1
        key = GetChar;
        if key == settings.NEXT_KEY_FOR_PARTICIPANT
            break;
        end
    end
end
Screen('CopyWindow',winclear,win0);