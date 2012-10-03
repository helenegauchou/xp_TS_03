function func_training(task_presentation,task_type,ISI)

matrix_settings;
global_settings;

training = 0;

while training == 0;
    % Instructions reminder
    readytostart;
    
    % MATRIX ******************************************************************
    if task_presentation == settings.MIXED_SEARCH
        number_of_experimental_conditions = settings.NUMBER_OF_EXPERIMENTAL_CONDITIONS_MIXED_TASK;
        task_type = settings.TYPE_OF_SEARCH;
        number_of_trial = settings.NUMBER_OF_TRAINING_TRIAL_FOR_MIXED_TASK;
    else
        number_of_experimental_conditions = settings.NUMBER_OF_EXPERIMENTAL_CONDITIONS_BLOCKED_TASK;
        number_of_trial = settings.NUMBER_OF_TRAINING_TRIAL_FOR_BLOCKED_TASK;
    end
    MATRIX_block_training = create_block(task_presentation,task_type,number_of_trial,number_of_experimental_conditions);
    
    % Creates matrix for data export
    MATRIX_data_training = ones(number_of_trial,CONST_number_columns) * CONST_default_value;
    
    % Displays trials and retrieves data
    for current_trial = 1:number_of_trial;
        if task_presentation == settings.BLOCKED_SEARCH
            current_trial_parameters = MATRIX_block_training(current_trial,:);
        else
            current_trial_parameters = get_matrix_line(current_trial, MATRIX_block_training(:,:,settings.FEATURE_SEARCH), MATRIX_block_training(:,:,settings.CONJUNCTION_SEARCH));
        end 
        [response accuracy response_time ] = ...
        Exp(current_trial_parameters(1,1),...
            current_trial_parameters(1,2),...
            current_trial_parameters(1,3),...
            ISI);
        
        MATRIX_data_training(current_trial,column_ISI:column_response_time) = ...
            [ISI,...
            111,...
            111,...
            task_presentation,...
            current_trial_parameters(1,1),...
            current_trial_parameters(1,2),...
            current_trial_parameters(1,3),...
            current_trial,...
            111,...
            response,...
            accuracy,...
            response_time];
    end
    
    % POST BLOCK FEEDBACK *****************************************************
     [global_accuracy_rate global_accuracy_rate_FEATURE global_accuracy_rate_TASK_2] = ...
         func_final_feedback(task_presentation,task_type,number_of_trial,MATRIX_data_training);
       
    if task_presentation == settings.BLOCKED_SEARCH
        if global_accuracy_rate >= 90
            training = 1;
        end
    else
        if (global_accuracy_rate_FEATURE >= 90) || (global_accuracy_rate_TASK_2 >= 90)
            training = 1;
        end
    end
end