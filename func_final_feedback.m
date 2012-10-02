function [global_accuracy_rate global_accuracy_rate_FEATURE global_accuracy_rate_CONJUNCTION] = func_final_feedback(task_type,number_of_trial,MATRIX_data)

global win0 winclear 
%global global_accuracy_rate global_accuracy_rate_FEATURE global_accuracy_rate_CONJUNCTION

global_accuracy_rate = 0;
global_accuracy_rate_FEATURE = 0;
global_accuracy_rate_CONJUNCTION = 0;

matrix_settings;
global_settings;

Screen(win0,'TextSize',16);%settings.LETTER_SIZE
Screen(win0,'TextFont',settings.LETTER_FONT);

if task_type == settings.BLOCKED_SEARCH
    
    matrix_current_part = MATRIX_data(1:number_of_trial, :);
    
    matrix_target_PRESENT = matrix_current_part(MATRIX_data((1:number_of_trial),column_target_presence) == 1, :);
    matrix_target_ABSENT = matrix_current_part(MATRIX_data((1:number_of_trial),column_target_presence) == 0, :);
    
    matrix_target_PRESENT_CORRECT = matrix_target_PRESENT(matrix_target_PRESENT(:,column_accuracy_detection) == 1, :);
    matrix_target_ABSENT_CORRECT = matrix_target_ABSENT(matrix_target_ABSENT(:,column_accuracy_detection) == 1, :);
    
    HIT_rate = sum(matrix_target_PRESENT_CORRECT(:,column_accuracy_detection),1) / size(matrix_target_PRESENT,1) * 100;
    CR_rate = sum(matrix_target_ABSENT_CORRECT(:,column_accuracy_detection),1) / size(matrix_target_ABSENT,1) * 100;

    HIT_rate_string = int2str(floor(HIT_rate));
    CR_rate_string = int2str(floor(CR_rate));
    
    global_accuracy_rate = (HIT_rate + CR_rate)/2;
    global_accuracy_rate_string = int2str(floor(global_accuracy_rate));
    
    average_RT_HIT_string = int2str(floor((sum(matrix_target_PRESENT_CORRECT(:,column_response_time),1))/size(matrix_target_PRESENT_CORRECT,1)));
    average_RT_CR_string = int2str(floor((sum(matrix_target_ABSENT_CORRECT(:,column_response_time),1))/size(matrix_target_ABSENT_CORRECT,1)));
    
    l=0;
    matRT_HIT= ones(1,3);
    matRT_CR = ones(1,3);
    
    for setsize = settings.SET_SIZE
        matrix_target_HIT_setsize = matrix_target_PRESENT_CORRECT(matrix_target_PRESENT_CORRECT(:,column_setsize) == setsize, :);
        matrix_target_CR_setsize = matrix_target_ABSENT_CORRECT(matrix_target_ABSENT_CORRECT(:,column_setsize) == setsize, :);

        average_RT_HIT_setsize = (sum(matrix_target_HIT_setsize(:,column_response_time),1))/size(matrix_target_HIT_setsize,1);
        average_RT_CR_setsize = (sum(matrix_target_CR_setsize(:,column_response_time),1))/size(matrix_target_CR_setsize,1);
        
        l=l+1;
        matRT_HIT(1,l) = average_RT_HIT_setsize;
        matRT_CR(1,l) = average_RT_CR_setsize;
    end
    
    setsize = settings.SET_SIZE';
    matRT_HIT = matRT_HIT';
    matRT_CR = matRT_CR';
    
    mat_intercept_slope_HIT=[ones(3,1) setsize]\matRT_HIT;
    mat_intercept_slope_CR=[ones(3,1) setsize]\matRT_CR;
    
    slope_HIT_string = int2str(floor(mat_intercept_slope_HIT(2,1)));
    slope_CR_string = int2str(floor(mat_intercept_slope_CR(2,1)));
    
    Text_0 = 'Please ask the experimenter for further instructions.';
    Text_1 = strcat('AVERAGE ACCURACY: ',global_accuracy_rate_string);
    
    Text_2 = strcat('HIT rate: ',HIT_rate_string);
    Text_3 = strcat('RT HIT: ',average_RT_HIT_string);
    Text_4 = strcat('Slope HIT: ',slope_HIT_string);

    Text_5 = strcat('Correct rejection rate: ',CR_rate_string);
    Text_6 = strcat('RT Correct rejection: ',average_RT_CR_string);
    Text_7 = strcat('Slope Correct rejection: ',slope_CR_string);

    
    Screen(win0,'DrawText',Text_0,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y  ,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_1,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y+2*settings.CM  ,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_2,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y+4*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_3,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y+5*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_4,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y+6*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_5,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y+8*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_6,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y+9*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_7,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y+10*settings.CM,settings.LETTER_COLOR);
       
    while 1
        if KbCheck == 1
            key = GetChar;
            if lower(key) == settings.NEXT_KEY_FOR_EXPERIMENTER
                break;
            end
        end
    end
    Screen('CopyWindow',winclear,win0);
    
elseif task_type == settings.MIXED_SEARCH
    matrix_current_part = MATRIX_data(1:number_of_trial, :);
    
    matrix_FEATURE = matrix_current_part(MATRIX_data((1:number_of_trial),column_search_type) == settings.FEATURE_SEARCH, :);
    matrix_CONJUNCTION = matrix_current_part(MATRIX_data((1:number_of_trial),column_search_type) == settings.CONJUNCTION_SEARCH, :);

    matrix_FEATURE_PRESENT = matrix_FEATURE(matrix_FEATURE(:,column_target_presence) == 1, :);
    matrix_FEATURE_PRESENT_NON_SWITCH = matrix_FEATURE_PRESENT(matrix_FEATURE_PRESENT(:,column_trial_type) == 0, :);
    matrix_FEATURE_PRESENT_SWITCH = matrix_FEATURE_PRESENT(matrix_FEATURE_PRESENT(:,column_trial_type) == 1, :);

    matrix_FEATURE_ABSENT = matrix_FEATURE(matrix_FEATURE(:,column_target_presence) == 0, :);
    matrix_FEATURE_ABSENT_NON_SWITCH = matrix_FEATURE_ABSENT(matrix_FEATURE_ABSENT(:,column_trial_type) == 0, :);
    matrix_FEATURE_ABSENT_SWITCH = matrix_FEATURE_ABSENT(matrix_FEATURE_ABSENT(:,column_trial_type) == 1, :);

    
    matrix_CONJUNCTION_PRESENT = matrix_CONJUNCTION(matrix_CONJUNCTION(:,column_target_presence) == 1, :);
    matrix_CONJUNCTION_PRESENT_NON_SWITCH = matrix_CONJUNCTION_PRESENT(matrix_CONJUNCTION_PRESENT(:,column_trial_type) == 0, :);
    matrix_CONJUNCTION_PRESENT_SWITCH = matrix_CONJUNCTION_PRESENT(matrix_CONJUNCTION_PRESENT(:,column_trial_type) == 1, :);
    
    matrix_CONJUNCTION_ABSENT = matrix_CONJUNCTION(matrix_CONJUNCTION(:,column_target_presence) == 0, :);
    matrix_CONJUNCTION_ABSENT_NON_SWITCH = matrix_CONJUNCTION_ABSENT(matrix_CONJUNCTION_ABSENT(:,column_trial_type) == 0, :);
    matrix_CONJUNCTION_ABSENT_SWITCH = matrix_CONJUNCTION_ABSENT(matrix_CONJUNCTION_ABSENT(:,column_trial_type) == 1, :);

    matrix_FEATURE_HIT = matrix_FEATURE_PRESENT(matrix_FEATURE_PRESENT(:,column_accuracy_detection) == 1, :);
    matrix_feature_HIT_NON_SWITCH = matrix_FEATURE_HIT(matrix_FEATURE_HIT(:,column_trial_type) == 0, :);
    matrix_feature_HIT_SWITCH = matrix_FEATURE_HIT(matrix_FEATURE_HIT(:,column_trial_type) == 1, :);
    
    matrix_FEATURE_CR = matrix_FEATURE_ABSENT(matrix_FEATURE_ABSENT(:,column_accuracy_detection) == 1, :);
    matrix_feature_CR_NON_SWITCH = matrix_FEATURE_CR(matrix_FEATURE_CR(:,column_trial_type) == 0, :);
    matrix_feature_CR_SWITCH = matrix_FEATURE_CR(matrix_FEATURE_CR(:,column_trial_type) == 1, :);
    
    matrix_CONJUNCTION_HIT = matrix_CONJUNCTION_PRESENT(matrix_CONJUNCTION_PRESENT(:,column_accuracy_detection) == 1, :);
    matrix_conjunction_HIT_NON_SWITCH = matrix_CONJUNCTION_HIT(matrix_CONJUNCTION_HIT(:,column_trial_type) == 0, :);
    matrix_conjunction_HIT_SWITCH = matrix_CONJUNCTION_HIT(matrix_CONJUNCTION_HIT(:,column_trial_type) == 1, :);

    matrix_CONJUNCTION_CR = matrix_CONJUNCTION_ABSENT(matrix_CONJUNCTION_ABSENT(:,column_accuracy_detection) == 1, :);
    matrix_conjunction_CR_NON_SWITCH = matrix_CONJUNCTION_CR(matrix_CONJUNCTION_CR(:,column_trial_type) == 0, :);
    matrix_conjunction_CR_SWITCH = matrix_CONJUNCTION_CR(matrix_CONJUNCTION_CR(:,column_trial_type) == 1, :);
    
    HIT_rate_FEATURE = sum(matrix_FEATURE_HIT(:,column_accuracy_detection),1) / size(matrix_FEATURE_PRESENT,1) * 100;
    HIT_rate_feature_NON_SWITCH_string = int2str(floor(sum(matrix_feature_HIT_NON_SWITCH(:,column_accuracy_detection),1) / size(matrix_FEATURE_PRESENT_NON_SWITCH,1)* 100));
    HIT_rate_feature_SWITCH_string = int2str(floor(sum(matrix_feature_HIT_SWITCH(:,column_accuracy_detection),1) / size(matrix_FEATURE_PRESENT_SWITCH,1)* 100));

    HIT_rate_CONJUNCTION = sum(matrix_CONJUNCTION_HIT(:,column_accuracy_detection),1) / size(matrix_CONJUNCTION_PRESENT,1) * 100;
    HIT_rate_conjunction_NON_SWITCH_string = int2str(floor(sum(matrix_conjunction_HIT_NON_SWITCH(:,column_accuracy_detection),1) / size(matrix_CONJUNCTION_PRESENT_NON_SWITCH,1)* 100));
    HIT_rate_conjunction_SWITCH_string = int2str(floor(sum(matrix_conjunction_HIT_SWITCH(:,column_accuracy_detection),1) /  size(matrix_CONJUNCTION_PRESENT_SWITCH,1)* 100));
  
    CR_rate_FEATURE = sum(matrix_FEATURE_CR(:,column_accuracy_detection),1) / size(matrix_FEATURE_ABSENT,1) * 100;
    CR_rate_feature_NON_SWITCH_string = int2str(floor(sum(matrix_feature_CR_NON_SWITCH(:,column_accuracy_detection),1) / size(matrix_FEATURE_ABSENT_NON_SWITCH,1)* 100));
    CR_rate_feature_SWITCH_string = int2str(floor(sum(matrix_feature_CR_SWITCH(:,column_accuracy_detection),1) / size(matrix_FEATURE_ABSENT_SWITCH,1)* 100));
    
    CR_rate_CONJUNCTION = sum(matrix_CONJUNCTION_CR(:,column_accuracy_detection),1) / size(matrix_CONJUNCTION_ABSENT,1) * 100;
    CR_rate_conjunction_NON_SWITCH_string = int2str(floor(sum(matrix_conjunction_CR_NON_SWITCH(:,column_accuracy_detection),1) / size(matrix_CONJUNCTION_ABSENT_NON_SWITCH,1)* 100));
    CR_rate_conjunction_SWITCH_string = int2str(floor(sum(matrix_conjunction_CR_SWITCH(:,column_accuracy_detection),1) / size(matrix_CONJUNCTION_ABSENT_SWITCH,1)* 100));

    HIT_rate_FEATURE_string = int2str(floor(HIT_rate_FEATURE));
    HIT_rate_CONJUNCTION_string = int2str(floor(HIT_rate_CONJUNCTION));
    CR_rate_FEATURE_string = int2str(floor(CR_rate_FEATURE));
    CR_rate_CONJUNCTION_string = int2str(floor(CR_rate_CONJUNCTION));
    
    global_accuracy_rate_FEATURE = floor((HIT_rate_FEATURE + CR_rate_FEATURE)/2);
    global_accuracy_rate_CONJUNCTION = floor((HIT_rate_CONJUNCTION + CR_rate_CONJUNCTION)/2);
    
    global_accuracy_rate_FEATURE_string = int2str(floor((HIT_rate_FEATURE + CR_rate_FEATURE)/2));
    global_accuracy_rate_CONJUNCTION_string = int2str(floor((HIT_rate_CONJUNCTION + CR_rate_CONJUNCTION)/2));
    
    average_RT_HIT_FEATURE_string = int2str(floor((sum(matrix_FEATURE_HIT(:,column_response_time),1))/size(matrix_FEATURE_HIT,1)));
    average_RT_HIT_feature_NON_SWITCH_string = int2str(floor((sum(matrix_feature_HIT_NON_SWITCH(:,column_response_time),1))/size(matrix_feature_HIT_NON_SWITCH,1)));
    average_RT_HIT_feature_SWITCH_string = int2str(floor((sum(matrix_feature_HIT_SWITCH(:,column_response_time),1))/size(matrix_feature_HIT_SWITCH,1)));
    
    average_RT_HIT_CONJUNCTION_string = int2str(floor((sum(matrix_CONJUNCTION_HIT(:,column_response_time),1))/size(matrix_CONJUNCTION_HIT,1)));
    average_RT_HIT_conjunction_NON_SWITCH_string = int2str(floor((sum(matrix_conjunction_HIT_NON_SWITCH(:,column_response_time),1))/size(matrix_conjunction_HIT_NON_SWITCH,1)));
    average_RT_HIT_conjunction_SWITCH_string = int2str(floor((sum(matrix_conjunction_HIT_SWITCH(:,column_response_time),1))/size(matrix_conjunction_HIT_SWITCH,1)));

    
    average_RT_CR_FEATURE_string = int2str(floor((sum(matrix_FEATURE_CR(:,column_response_time),1))/size(matrix_FEATURE_CR,1)));
    average_RT_CR_feature_NON_SWITCH_string = int2str(floor((sum(matrix_feature_CR_NON_SWITCH(:,column_response_time),1))/size(matrix_feature_CR_NON_SWITCH,1)));
    average_RT_CR_feature_SWITCH_string = int2str(floor((sum(matrix_feature_CR_SWITCH(:,column_response_time),1))/size(matrix_feature_CR_SWITCH,1)));

    average_RT_CR_CONJUNCTION_string = int2str(floor((sum(matrix_CONJUNCTION_CR(:,column_response_time),1))/size(matrix_CONJUNCTION_CR,1)));
    average_RT_CR_conjunction_NON_SWITCH_string = int2str(floor((sum(matrix_conjunction_CR_NON_SWITCH(:,column_response_time),1))/size(matrix_conjunction_CR_NON_SWITCH,1)));
    average_RT_CR_conjunction_SWITCH_string = int2str(floor((sum(matrix_conjunction_CR_SWITCH(:,column_response_time),1))/size(matrix_conjunction_CR_SWITCH,1)));

    l=0;
    matRT_HIT_FEATURE = ones(1,3);
    matRT_HIT_CONJUNCTION = ones(1,3);
    matRT_CR_FEATURE = ones(1,3);
    matRT_CR_CONJUNCTION = ones(1,3);
    
    for setsize = settings.SET_SIZE
        matrix_FEATURE_HIT_setsize = matrix_FEATURE_HIT(matrix_FEATURE_HIT(:,column_setsize) == setsize, :);
        matrix_FEATURE_CR_setsize = matrix_FEATURE_CR(matrix_FEATURE_CR(:,column_setsize) == setsize, :);
        matrix_CONJUNCTION_HIT_setsize = matrix_CONJUNCTION_HIT(matrix_CONJUNCTION_HIT(:,column_setsize) == setsize, :);
        matrix_CONJUNCTION_CR_setsize = matrix_CONJUNCTION_CR(matrix_CONJUNCTION_CR(:,column_setsize) == setsize, :);

        average_RT_FEATURE_HIT_setsize = (sum(matrix_FEATURE_HIT_setsize(:,column_response_time),1))/size(matrix_FEATURE_HIT_setsize,1);
        average_RT_FEATURE_CR_setsize = (sum(matrix_FEATURE_CR_setsize(:,column_response_time),1))/size(matrix_FEATURE_CR_setsize,1);
        average_RT_CONJUNCTION_HIT_setsize = (sum(matrix_CONJUNCTION_HIT_setsize(:,column_response_time),1))/size(matrix_CONJUNCTION_HIT_setsize,1);
        average_RT_CONJUNCTION_CR_setsize = (sum(matrix_CONJUNCTION_CR_setsize(:,column_response_time),1))/size(matrix_CONJUNCTION_CR_setsize,1);
        
        l=l+1;
        
        matRT_HIT_FEATURE (1,l)= average_RT_FEATURE_HIT_setsize;
        matRT_HIT_CONJUNCTION (1,l)= average_RT_FEATURE_CR_setsize;
        matRT_CR_FEATURE (1,l)= average_RT_CONJUNCTION_HIT_setsize;
        matRT_CR_CONJUNCTION (1,l)= average_RT_CONJUNCTION_CR_setsize;
    end
    
    setsize = settings.SET_SIZE';
    matRT_HIT_FEATURE = matRT_HIT_FEATURE';
    matRT_HIT_CONJUNCTION = matRT_HIT_CONJUNCTION';
    matRT_CR_FEATURE = matRT_CR_FEATURE';
    matRT_CR_CONJUNCTION = matRT_CR_CONJUNCTION';
    
    mat_intercept_slope_HIT_FEATURE=[ones(3,1) setsize]\matRT_HIT_FEATURE;
    mat_intercept_slope_CR_FEATURE=[ones(3,1) setsize]\matRT_CR_FEATURE;
    mat_intercept_slope_HIT_CONJUNCTION=[ones(3,1) setsize]\matRT_HIT_CONJUNCTION;
    mat_intercept_slope_CR_CONJUNCTION=[ones(3,1) setsize]\matRT_CR_CONJUNCTION;
    
    slope_HIT_FEATURE_string = int2str(floor(mat_intercept_slope_HIT_FEATURE(2,1)));
    slope_CR_FEATURE_string = int2str(floor(mat_intercept_slope_CR_FEATURE(2,1)));
    slope_HIT_CONJUNCTION_string = int2str(floor(mat_intercept_slope_HIT_CONJUNCTION(2,1)));
    slope_CR_CONJUNCTION_string = int2str(floor(mat_intercept_slope_CR_CONJUNCTION(2,1)));

    Text_0 = 'Please ask the experimenter for further instructions.';
    
    Text_1 = strcat('FEATURE SEARCH AVERAGE ACCURACY: ',global_accuracy_rate_FEATURE_string);
    Text_2 = strcat('CONJUNCTION SEARCH AVERAGE ACCURACY: ',global_accuracy_rate_CONJUNCTION_string);
        
    Text_3 = strcat('FEATURE - HIT rate: ',HIT_rate_FEATURE_string);
    Text_3a = strcat('--- Non switch: ',HIT_rate_feature_NON_SWITCH_string);
    Text_3b = strcat('--- Switch: ',HIT_rate_feature_SWITCH_string);
    
    Text_4 = strcat('FEATURE - HIT rt: ',average_RT_HIT_FEATURE_string);
    Text_4a = strcat('--- Non switch: ',average_RT_HIT_feature_NON_SWITCH_string);
    Text_4b = strcat('--- Switch: ',average_RT_HIT_feature_SWITCH_string);

    Text_5 = strcat('FEATURE - HIT slope: ',slope_HIT_FEATURE_string);

    Text_6 = strcat('FEATURE - CR rate: ',CR_rate_FEATURE_string );
    Text_6a = strcat('--- Non switch: ',CR_rate_feature_NON_SWITCH_string);
    Text_6b = strcat('--- Switch: ',CR_rate_feature_SWITCH_string);

    Text_7 = strcat('FEATURE - CR rt: ',average_RT_CR_FEATURE_string);
    Text_7a = strcat('--- Non switch: ',average_RT_CR_feature_NON_SWITCH_string);
    Text_7b = strcat('--- Switch: ',average_RT_CR_feature_SWITCH_string);

    Text_8 = strcat('FEATURE - CR slope: ',slope_CR_FEATURE_string);

    Text_9 = strcat('CONJUNCTION - HIT rate: ',HIT_rate_CONJUNCTION_string);
    Text_9a = strcat('--- Non switch: ',HIT_rate_conjunction_NON_SWITCH_string);
    Text_9b = strcat('--- Switch: ',HIT_rate_conjunction_SWITCH_string);
    
    Text_10 = strcat('CONJUNCTION - HIT rt: ',average_RT_HIT_CONJUNCTION_string);
    Text_10a = strcat('--- Non switch: ', average_RT_HIT_conjunction_NON_SWITCH_string);
    Text_10b = strcat('--- Switch: ',average_RT_HIT_conjunction_SWITCH_string);
   
    Text_11 = strcat('CONJUNCTION - HIT slope: ',slope_HIT_CONJUNCTION_string);
    
    Text_12 = strcat('CONJUNCTION - CR rate: ',CR_rate_CONJUNCTION_string );
    Text_12a = strcat('--- Non switch: ',CR_rate_conjunction_NON_SWITCH_string); 
    Text_12b = strcat('--- Switch: ',CR_rate_conjunction_SWITCH_string);

    Text_13 = strcat('CONJUNCTION - CR rt: ',average_RT_CR_CONJUNCTION_string);
    Text_13a = strcat('--- Non switch: ',average_RT_CR_conjunction_NON_SWITCH_string);
    Text_13b = strcat('--- Switch: ',average_RT_CR_conjunction_SWITCH_string);
    
    Text_14 = strcat('CONJUNCTION - CR slope: ',slope_CR_CONJUNCTION_string);
    
    Screen(win0,'DrawText',Text_0,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y  ,settings.LETTER_COLOR);
   
    
    Screen(win0,'DrawText',Text_1,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y+2*settings.CM  ,settings.LETTER_COLOR);
    
    Screen(win0,'DrawText',Text_3,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y+3.5*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_3a,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y+4.5*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_3b,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y+5.5*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_4,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y+6.5*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_4a,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y+7.5*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_4b,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y+8.5*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_5,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y+9.5*settings.CM,settings.LETTER_COLOR);
    
    Screen(win0,'DrawText',Text_6,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y+11*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_6a,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y+12*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_6b,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y+13*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_7,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y+14*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_7a,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y+15*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_7b,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y+16*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_8,settings.LOCATION_TEXT_X,settings.LOCATION_TEXT_Y+17*settings.CM,settings.LETTER_COLOR);
    
    
    Screen(win0,'DrawText',Text_2,settings.LOCATION_TEXT_X+13*settings.CM,settings.LOCATION_TEXT_Y+2*settings.CM,settings.LETTER_COLOR);

    Screen(win0,'DrawText',Text_9,settings.LOCATION_TEXT_X+13*settings.CM,settings.LOCATION_TEXT_Y+3.5*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_9a,settings.LOCATION_TEXT_X+13*settings.CM,settings.LOCATION_TEXT_Y+4.5*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_9b,settings.LOCATION_TEXT_X+13*settings.CM,settings.LOCATION_TEXT_Y+5.5*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_10,settings.LOCATION_TEXT_X+13*settings.CM,settings.LOCATION_TEXT_Y+6.5*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_10a,settings.LOCATION_TEXT_X+13*settings.CM,settings.LOCATION_TEXT_Y+7.5*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_10b,settings.LOCATION_TEXT_X+13*settings.CM,settings.LOCATION_TEXT_Y+8.5*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_11,settings.LOCATION_TEXT_X+13*settings.CM,settings.LOCATION_TEXT_Y+9.5*settings.CM,settings.LETTER_COLOR);
    
    Screen(win0,'DrawText',Text_12,settings.LOCATION_TEXT_X+13*settings.CM,settings.LOCATION_TEXT_Y+11*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_12a,settings.LOCATION_TEXT_X+13*settings.CM,settings.LOCATION_TEXT_Y+12*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_12b,settings.LOCATION_TEXT_X+13*settings.CM,settings.LOCATION_TEXT_Y+13*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_13,settings.LOCATION_TEXT_X+13*settings.CM,settings.LOCATION_TEXT_Y+14*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_13a,settings.LOCATION_TEXT_X+13*settings.CM,settings.LOCATION_TEXT_Y+15*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_13b,settings.LOCATION_TEXT_X+13*settings.CM,settings.LOCATION_TEXT_Y+16*settings.CM,settings.LETTER_COLOR);
    Screen(win0,'DrawText',Text_14,settings.LOCATION_TEXT_X+13*settings.CM,settings.LOCATION_TEXT_Y+17*settings.CM,settings.LETTER_COLOR);

       
    while 1
        if KbCheck == 1
            key = GetChar;
            if lower(key) == settings.NEXT_KEY_FOR_EXPERIMENTER
                break;
            end
        end
    end
    Screen('CopyWindow',winclear,win0);
end