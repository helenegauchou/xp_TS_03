function matlocperm = func_location(setsize)

matrix_settings;
global_settings;

% Creates 16 possible spatial locations within a 4 by 4 matrix ------------
item_max_width = settings.LENGTH_SHORT_LINE; % A MODIFIER
item_max_heigth = settings.LENGTH_LONG_LINE;

freed_h = round(settings.WIDTH_CELL - settings.MINIMAL_INTER_ITEM_DISTANCE - item_max_width);
freed_v = round(settings.WIDTH_CELL - settings.MINIMAL_INTER_ITEM_DISTANCE - item_max_heigth);
xnoise=randperm(freed_h);
ynoise=randperm(freed_v);

%  l=0;
% matloc = ones(settings.NUMBER_OF_X_CELLS*settings.NUMBER_OF_Y_CELLS,2);
% for x=1:settings.NUMBER_OF_X_CELLS
%     for y=1:settings.NUMBER_OF_Y_CELLS
%         l=l+1;
%         xloc(x) = settings.SCREEN_X/2 - 3*settings.WIDTH_CELL + x*settings.WIDTH_CELL;
%         yloc(y) = settings.SCREEN_Y/2 - 2*settings.WIDTH_CELL + y*settings.WIDTH_CELL;
%         
%         xpositions(l) = xloc(x) + settings.MINIMAL_INTER_ITEM_DISTANCE/2 + xnoise(l);
%         ypositions(l) = yloc(y) - settings.MINIMAL_INTER_ITEM_DISTANCE/2 - ynoise(l);
%         
%         matloc(l,:)=[xpositions(l),ypositions(l)];
%         matlocperm=matloc(randperm(l),:) ;
%     end
% end

l=0;
if setsize == 3
    for x=1:2
        for y=1:2
            l=l+1;
            xloc(x) = settings.SCREEN_X/2 - 2*settings.WIDTH_CELL + x*settings.WIDTH_CELL;
            yloc(y) = settings.SCREEN_Y/2 - 1*settings.WIDTH_CELL + y*settings.WIDTH_CELL;
            
            xpositions(l) = xloc(x) + settings.MINIMAL_INTER_ITEM_DISTANCE/2 + xnoise(l);
            ypositions(l) = yloc(y) - settings.MINIMAL_INTER_ITEM_DISTANCE/2 - ynoise(l);
            
            matloc(l,:)=[xpositions(l),ypositions(l)];
            matlocperm=matloc(randperm(l),:);
        end
    end
end

if setsize == 7
    rand_height = randperm(3);
    height = (rand_height(1))-1;
    for x=1:4
        for y=1:2
            l=l+1;
            xloc(x) = settings.SCREEN_X/2 - 3*settings.WIDTH_CELL + x*settings.WIDTH_CELL;
            yloc(y) = settings.SCREEN_Y/2 - height*settings.WIDTH_CELL + y*settings.WIDTH_CELL;
            
            xpositions(l) = xloc(x) + settings.MINIMAL_INTER_ITEM_DISTANCE/2 + xnoise(l);
            ypositions(l) = yloc(y) - settings.MINIMAL_INTER_ITEM_DISTANCE/2 - ynoise(l);
            
            matloc(l,:)=[xpositions(l),ypositions(l)];
            matlocperm=matloc(randperm(l),:);
        end
    end
end

if setsize == 11
    rand_height = randperm(2);
    height = rand_height(1);
    for x=1:4
        for y=1:3
            l=l+1;
            xloc(x) = settings.SCREEN_X/2 - 3*settings.WIDTH_CELL + x*settings.WIDTH_CELL;
            yloc(y) = settings.SCREEN_Y/2 - height*settings.WIDTH_CELL + y*settings.WIDTH_CELL;
            
            xpositions(l) = xloc(x) + settings.MINIMAL_INTER_ITEM_DISTANCE/2 + xnoise(l);
            ypositions(l) = yloc(y) - settings.MINIMAL_INTER_ITEM_DISTANCE/2 - ynoise(l);
            
            matloc(l,:)=[xpositions(l),ypositions(l)];
            matlocperm=matloc(randperm(l),:);
        end
    end
end