function [ID question_ID_subject part_number question_part_number task_presentation task_type block_number ISI number_of_trial] = func_questions

global win0 winclear 

HideCursor;

matrix_settings;
global_settings;


% QUESTIONS FOR EXPERIMENTER **********************************************
GetEchoString(win0,'FOR EXPERIMENTER ONLY - upper case check!',settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y,settings.LETTER_COLOR_INSTRUCTIONS,settings.BACKGROUND_COLOR);

% PARTICIPANT'S INFORMATION ***********************************************
% Subject's ID
question_ID_subject = GetEchoString(win0,'FOR EXPERIMENTER ONLY - Participant''s ID? (digits only)',settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y,settings.LETTER_COLOR_INSTRUCTIONS,settings.BACKGROUND_COLOR);
ID = str2num(question_ID_subject);

% Part number
Screen('CopyWindow',winclear,win0);
question_part_number = GetEchoString(win0,'FOR EXPERIMENTER ONLY - Part?',settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y,settings.LETTER_COLOR_INSTRUCTIONS,settings.BACKGROUND_COLOR);
part_number = str2num(question_part_number);

% Task type
Screen('CopyWindow',winclear,win0);
question_task_presentation = GetEchoString(win0,'FOR EXPERIMENTER ONLY - Task presentation? Blocked [1] or Mixed [2]?',settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y,settings.LETTER_COLOR_INSTRUCTIONS,settings.BACKGROUND_COLOR);
task_presentation = str2num(question_task_presentation);
if task_presentation == 1
    % Search type
    Screen('CopyWindow',winclear,win0);
    question_task_type = GetEchoString(win0,'FOR EXPERIMENTER ONLY - Task type? Feature search [1] or Counting task [2]?',settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y,settings.LETTER_COLOR_INSTRUCTIONS,settings.BACKGROUND_COLOR);
    task_type = str2num(question_task_type);
else
    task_type = 999;
end

% Block number
Screen('CopyWindow',winclear,win0);
question_block_number = GetEchoString(win0,'FOR EXPERIMENTER ONLY - Block?',settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y,settings.LETTER_COLOR_INSTRUCTIONS,settings.BACKGROUND_COLOR);
block_number = str2num(question_block_number);

% ISI
Screen('CopyWindow',winclear,win0);
question_ISI = GetEchoString(win0,'FOR EXPERIMENTER ONLY - ISI duration (number of frame)?',settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y,settings.LETTER_COLOR_INSTRUCTIONS,settings.BACKGROUND_COLOR);
ISI = str2num(question_ISI);

% TOTAL NUMBER OF TRIAL FOR A BLOCK
Screen('CopyWindow',winclear,win0);
question_trial_number = GetEchoString(win0,'FOR EXPERIMENTER ONLY - Number of trials?',settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y,settings.LETTER_COLOR_INSTRUCTIONS,settings.BACKGROUND_COLOR);
number_of_trial = str2num(question_trial_number);

Screen('CopyWindow',winclear,win0);