% This file contains all the necessary settings to run the experiment
settings = struct;

% Experiment's Independant variables
settings.TYPE_OF_TASK = 1:2;
settings.BLOCKED_SEARCH = 1;
settings.MIXED_SEARCH = 2;

settings.TYPE_OF_SEARCH = 1:2;
settings.FEATURE_SEARCH = 1;
settings.CONJUNCTION_SEARCH = 2;

settings.TARGET_PRESENCE = 0:1;
settings.TARGET_ABSENT = 0;
settings.TARGET_PRESENT = 1;

settings.SET_SIZE = [3,7,11];

settings.NON_SWITCH_TRIAL = 0;
settings.SWITCH_TRIAL = 1;

% Number of trials
settings.NUMBER_OF_EXPERIMENTAL_CONDITIONS_BLOCKED_TASK = 6;
settings.NUMBER_OF_EXPERIMENTAL_CONDITIONS_MIXED_TASK = 12;
settings.NUMBER_OF_TRAINING_TRIAL_FOR_BLOCKED_TASK = 12; 
settings.NUMBER_OF_TRAINING_TRIAL_FOR_MIXED_TASK = 24;

% Response keys
settings.LEFT_RESPONSE_KEY = 'a'; 
settings.RIGHT_RESPONSE_KEY = 'p'; 
settings.NEXT_KEY_FOR_EXPERIMENTER = 'n'; 
settings.NEXT_KEY_FOR_PARTICIPANT = 32;

% Presentation times: 15=250ms, 9=150.3ms
settings.DURATION_CUE = 9;% frames = 0.1503 s
settings.DURATION_FIX = 6;
settings.DURATION_BLANK_2 = 6;
settings.DURATION_ERROR_MESSAGE = 6;% frames = 0.100 s
settings.DURATION_ITI = 30;

% Screen settings
settings.COLOR_DEPTH = 32;    % bits
settings.REFRESH_RATE = 60;   % Hz
settings.SCREEN_X = 1280; 
settings.SCREEN_Y = 800;
settings.screenRect = [0 0 settings.SCREEN_X settings.SCREEN_Y]; 
settings.CM = 38.4;% pixels

% Item's spatial location settings
settings.NUMBER_OF_X_CELLS = 4;
settings.NUMBER_OF_Y_CELLS = 4;

% Stimuli settings for dotted lines
settings.NUMBER_OF_DOTS = 3;
settings.DOTS_DIAMETER = 0.14 * settings.CM;    
settings.INTER_DOTS_DISTANCE = 0.2 * settings.CM;
settings.TILT_ANGLE_TARGET = 6; 
settings.TILT_ANGLE_NON_TARGET = 0;

% Stimuli settings for NON dotted lines
settings.LENGTH_LONG_LINE = settings.CM;
settings.LENGTH_SHORT_LINE = 0.8 * settings.CM;
settings.WIDTH_LINE = 3;

% Stimuli settings
settings.WIDTH_CELL = 3.45 * settings.CM; 
settings.MINIMAL_INTER_ITEM_DISTANCE = 0.6 * settings.CM;   

white = [255,255,255]; 
black = [0,0,0];
%grey = [180,180,180];
%light_blue = [0,255,255];
dark_blue = [0,0,255];
red = [255,0,0];
settings.TARGET_COLOR = white;
settings.NON_TARGETS_COLOR = white;
settings.FIX_POINT_COLOR = white;
settings.BACKGROUND_COLOR = black;
settings.BLANK_SCREEN_COLOR = white;

% Text settings
settings.LETTER_SIZE = 20;
settings.LETTER_FONT = 'Tahoma';
settings.LETTER_COLOR = white;
settings.LETTER_COLOR_QUESTIONNAIRES = white;
settings.LETTER_COLOR_INSTRUCTIONS = white;
settings.LETTER_COLOR_right = dark_blue;
settings.LETTER_COLOR_wrong = red;

settings.TEXT_READY_TO_START = 'Remember to answer as FAST and as ACCURATELY as you can! When ready to start, hit the SPACE BAR.';
settings.LOCATION_TEXT_X = 3*settings.CM;
settings.LOCATION_TEXT_Y = 3*settings.CM;

% colors %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
white = [255,255,255]; 
light_grey = [210,210,210]; 
grey = [180,180,180];
dark_grey = [80,80,80];
black = [0,0,0];

red = [255,0,0];
dark_orange = [250,100,50];
orange = [255,153,0];

yellow = [255,255,0];
yellow_1 = [250,200,80];
light_yellow = [237,233,119];

light_green = [0,255,0];
green_1=[50,230,130];
green_2=[50,125,0];
dark_green = [40,140,28];
pastel_green = [157,237,159];

dark_blue = [0,0,255];
light_blue = [0,255,255];
blue_1=[0,100,200];
light_blue_1=[120,229,249];
blue_2=[200,100,255];%mauve
blue_3=[125,200,250];

purple = [255,0,255];%fuschia
purple_1 = [255,0,180];%rose
purple_2 = [199,21,197];%violet
violet_f = [113,87,145];
violet = [159,2,165];

pink = [255,0,180];
rose = [254,2,215];
pastel_pink = [253,204,175];

brown = [179,109,26];
dark_brown = [168,74,30];

% fontNames{1} = 'Bookman Old Style'; 
% fontNames{2} = 'Times New Roman'; 
% fontNames{3} = 'Symbol';
% fontNames{4} = 'Garamond';
% fontNames{5} = 'Tahoma'; 
