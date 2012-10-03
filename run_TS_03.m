function run_TS_03

global win0 win1 win2 winclear winCue winFeedback

HideCursor;

matrix_settings;
global_settings;

% Creates on and offscreen windows
win0 = Screen(0,'OpenWindow',settings.BACKGROUND_COLOR,settings.screenRect,settings.COLOR_DEPTH);
win1 = Screen(win0,'OpenOffscreenWindow',settings.BACKGROUND_COLOR,settings.screenRect,settings.COLOR_DEPTH);
win2 = Screen(win0,'OpenOffscreenWindow',settings.BACKGROUND_COLOR,settings.screenRect,settings.COLOR_DEPTH);
winclear = Screen(win0,'OpenOffscreenWindow',settings.BACKGROUND_COLOR,settings.screenRect,settings.COLOR_DEPTH);
winCue = Screen(win0,'OpenOffscreenWindow',settings.BACKGROUND_COLOR,settings.screenRect,settings.COLOR_DEPTH);
winFeedback = Screen(win0,'OpenOffscreenWindow',settings.BACKGROUND_COLOR,settings.screenRect,settings.COLOR_DEPTH);

Screen(win0,'TextSize',settings.LETTER_SIZE);
Screen(win0,'TextFont',settings.LETTER_FONT);

% Displays QUESTIONS for experimenter *************************************
[ID question_ID_subject part_number question_part_number task_presentation task_type block_number ISI number_of_trial] = func_questions;

% VISUAL SEARCH TASK ******************************************************
% Instructions
instruction(task_presentation,task_type,1);
%
% % Training
% if block_number == 1
% func_training(task_presentation,task_type,ISI);
% end

% Instructions reminder
readytostart;

% MATRIX ******************************************************************
if task_presentation == settings.MIXED_SEARCH
    number_of_experimental_conditions = settings.NUMBER_OF_EXPERIMENTAL_CONDITIONS_MIXED_TASK;
    task_type = settings.TYPE_OF_TASK;
else
    number_of_experimental_conditions = settings.NUMBER_OF_EXPERIMENTAL_CONDITIONS_BLOCKED_TASK;
end
matrix_block = create_block(task_presentation,task_type,number_of_trial,number_of_experimental_conditions);

% Creates matrix for data export
MATRIX_data = ones(number_of_trial,CONST_number_columns) * CONST_default_value;

% Displays trials and retrieves data
for current_trial = 1:number_of_trial;
    if task_presentation == settings.BLOCKED_SEARCH
        current_trial_parameters = matrix_block(current_trial,:);
    else
        current_trial_parameters = get_matrix_line(current_trial, matrix_block(:,:,settings.TASK_1), matrix_block(:,:,settings.TASK_2));
    end
    [response accuracy response_time response_time_log excentricity quadrant] = Exp(current_trial_parameters(1,1),...
        current_trial_parameters(1,2),...
        current_trial_parameters(1,3),...
        ISI);
    if task_presentation == settings.MIXED_SEARCH
        if mod(current_trial,2)== 1
            trial_type = settings.SWITCH_TRIAL;
        else
            trial_type = settings.NON_SWITCH_TRIAL;
        end
    else
        trial_type = CONST_no_value;
    end
    
    MATRIX_data(current_trial,column_ID:column_quadrant) = ...
        [ID,...
        ISI,...
        part_number,...
        block_number,...
        task_presentation,...
        current_trial_parameters(1,1),...
        current_trial_parameters(1,2),...
        current_trial_parameters(1,3),...
        current_trial,...
        trial_type,...
        response,...
        accuracy,...
        response_time,...
        response_time_log,...
        excentricity,...
        quadrant];
end

% SAVE data ***************************************************************
filename = (strcat('Matrix_Subject_',question_ID_subject,'_part_',question_part_number));
save(filename,'MATRIX_data');

filename_csv = strcat( filename,'.csv');
csvwrite(filename_csv,MATRIX_data);

% POST BLOCK FEEDBACK *****************************************************
func_final_feedback(task_presentation,task_type,number_of_trial,MATRIX_data);

% END screen **************************************************************
Screen('CopyWindow', winclear, win0);
Text_end = ['END OF PART ',num2str(part_number)];
Screen(win0,'DrawText',Text_end,settings.LOCATION_TEXT_X+9*settings.CM,settings.LOCATION_TEXT_Y+3*settings.CM,settings.LETTER_COLOR_INSTRUCTIONS);
WaitSecs(1);

ShowCursor;

clear mex;