function simulateCsvRecord( csvFile )
%simulateCsvRecord Simulate the movement of an IMU

    %% Create GUI
    guiComponents = createGui(@playPauseCallback);

    %% Create the identity frame (that corresponds to the identity quaternion)
    % and customize its graphics
    guiComponents.identityFrame = createFrame(guiComponents.a);
    set(guiComponents.identityFrame.x, 'Color', 'red', 'LineStyle', '--');
    set(guiComponents.identityFrame.y, 'Color', 'green', 'LineStyle', '--');
    set(guiComponents.identityFrame.z, 'Color', 'blue', 'LineStyle', '--');
    % And stick an invisible rectangle to it
    guiComponents.identityRectangle = createRectangle(guiComponents.a, [0.3 0 0], [0 0.7 0], [0 0 0]);
    set(guiComponents.identityRectangle, 'Visible', 'off');

    %% Create the moving IMU frame and stick a rectangle on it
    guiComponents.imuFrame = createFrame(guiComponents.a);
    guiComponents.imuRectangle = copyobj(guiComponents.identityRectangle, guiComponents.a);
    set(guiComponents.imuRectangle, 'Visible', 'on');

    %% Initialization
    handles.isPlaying = 0;
    handles.M = csvread(csvFile);
    handles.nbFrames = size(handles.M, 1);
    handles.currentFrame = 1;
    handles.guiComponents = guiComponents;

    guidata(gcf, handles);

end

function playPauseCallback(hObject, event)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB

    handles = guidata(gcf);
    if(get(hObject, 'Value') == 1)
        set(hObject, 'String', 'Pause');
        handles.isPlaying = 1;
        playSequence(handles);
    else
        set(hObject, 'String', 'Play');
        handles.isPlaying = 0;
    end
    
    guidata(gcf, handles);
end

function playSequence(handles)
    % sequence : Nx4 matrix where N is the total number of frames
    i = handles.currentFrame;
    while i < handles.nbFrames && handles.isPlaying
%         handles = guidata(gcf);
        
        set(handles.guiComponents.timestampText, 'String', sprintf('%d', handles.M(i, 1)));
        q = handles.M(i, 2:end);
        q = q/norm(q);

        % Rotate the frame
        rotateFrame(handles.guiComponents.identityFrame, handles.guiComponents.imuFrame, q);
        % Rotate the rectangle sticked to the imuFrame
        rotateRectangle(handles.guiComponents.identityRectangle, handles.guiComponents.imuRectangle, q);

        pause(0.25);
        i = i + 1;
        
        % Stop playing, update the playPauseButton and rewind at the end of
        % the sequence
        if i == handles.nbFrames
            resetSequence(handles);
        end
        
        guidata(gcf, handles);
    end
end

function resetSequence(handles)
    set(handles.guiComponents.playPauseButton, 'String', 'Play');
    handles.isPlaying = 0;
end

