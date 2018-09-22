function simulateCsvRecord( csvFile )
%simulateCsvRecord Simulate the movement of an IMU

    %% Create GUI
    callbacksMap.playPauseCallback = @playPauseCallback;
    callbacksMap.sliderCallback = @sliderCallback;
    callbacksMap.checkboxCallback = @checkboxCallback;
    callbacksMap.clearTracingButtonCallback = @clearTracingButtonCallback;
    callbacksMap.exportTracingButtonCallback = @exportTracingButtonCallback;
    guiComponents = createGui(callbacksMap);
    set(guiComponents.slider, 'Min', 1, 'Max', 10, 'Value', 1);

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
    
    %% Create the tracing points
    guiComponents.tracingPoints = line('Parent', gca, ...
        'LineStyle', 'none', 'Marker', '.', 'Color', 'magenta', ...
        'XData', [], 'YData', [], 'ZData', [], 'Visible', 'off');
    
    %% Create the stamping points
    guiComponents.stampingPoints = line('Parent', gca, ...
        'LineStyle', 'none', 'Marker', '.', 'Color', 'red', ...
        'XData', [], 'YData', [], 'ZData', [], 'Visible', 'on');

    %% Initialization
    handles.M = csvread(csvFile);
    handles.nbFrames = size(handles.M, 1);
    handles.frameNumber = 1;
    
    % For plane stamping
    handles.cumulativeQ = [1; 0; 0; 0];
    handles.cumulativeT = [0; 0; 0];
    handles.chunkDataSize = 2; % Stamp by chunks of this value
    handles.chunkData = NaN(3, handles.chunkDataSize);
    handles.chunkDataIndex = 1;
    
    % Create title based on file name
    handles.title = strsplit(csvFile, '/');
    handles.title = handles.title{2};
    handles.title = strsplit(handles.title, '.');
    handles.title = handles.title{1};
    handles.guiComponents = guiComponents;
    
    set(handles.guiComponents.slider, ...
        'Max', handles.nbFrames, ...
        'SliderStep', [1/handles.nbFrames 10/handles.nbFrames]);
    title = get(guiComponents.a, 'Title');
    set(title, 'String', handles.title);
    
    handles.frameNotifier = ImuEventNotifier();
    addlistener(handles.frameNotifier, 'FrameDisplayed', @testCallback);

    guidata(gcf, handles);
end

function notifyMe(handles)
    frameNotifier = ImuEventNotifier();
    addlistener(frameNotifier, 'FrameDisplayed', @testCallback);
    frameNotifier.notifyForFrameDisplayed(handles);
end

function testCallback(src, eventData)
    handles = guidata(gcf);
    
    handles = updateFrame(handles, handles.frameNumber);
    
    if(handles.frameNumber == size(handles.M, 1))
        set(handles.guiComponents.playPauseButton, 'Value', 0);
        set(handles.guiComponents.playPauseButton, 'String', 'Play');
        
        handles.frameNumber = 1;
        set(handles.guiComponents.slider, 'Value', handles.frameNumber);
        handles = updateFrame(handles, handles.frameNumber);
        guidata(gcf, handles);
        return;
    end
    
    pause((handles.M(handles.frameNumber+1, 1)-handles.M(handles.frameNumber, 1))/1000);
    
    handles.frameNumber = handles.frameNumber+1;
    
    guidata(gcf, handles);
    if(get(handles.guiComponents.playPauseButton, 'Value') == 1)
        notifyMe(handles);
    end
end

function playPauseCallback(hObject, event)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB

    handles = guidata(hObject);
    if(get(hObject, 'Value') == 1)
        set(hObject, 'String', 'Pause');
        set(0, 'RecursionLimit', handles.nbFrames + 1);        
        notifyMe(handles);
%         playSequence(handles);
    else
        set(hObject, 'String', 'Play');
    end
end

function sliderCallback(hObject, event)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB

    handles = guidata(gcf);
    % Get the frame number by rounding the slider value
    % Re-adjust sliderValue to this frameNumber and update the frame
    % graphics
    frameNumber = round(get(hObject, 'Value'));
    set(hObject, 'Value', frameNumber);
    handles = updateFrame(handles, frameNumber);
    
    handles.frameNumber = frameNumber;
    
    guidata(gcf, handles);
end

function checkboxCallback(hObject, event)
    handles = guidata(gcf);
    if(get(hObject, 'Value') == 1)
        set(handles.guiComponents.tracingPoints, 'Visible', 'on');
    else
        set(handles.guiComponents.tracingPoints, 'Visible', 'off');
    end
end

function clearTracingButtonCallback(src, event)
    handles = guidata(gcf);
    set(handles.guiComponents.tracingPoints, 'XData', []);
    set(handles.guiComponents.tracingPoints, 'YData', []);
    set(handles.guiComponents.tracingPoints, 'ZData', []);
end

function exportTracingButtonCallback(src, event)
    handles = guidata(gcf);
    xData = get(handles.guiComponents.tracingPoints, 'XData');
    yData = get(handles.guiComponents.tracingPoints, 'YData');
    zData = get(handles.guiComponents.tracingPoints, 'ZData');
    tracing.xData = xData;
    tracing.yData = yData;
    tracing.zData = zData;
    
    save(sprintf('tracings/%s.mat', handles.title), 'tracing');
end

function playSequence(handles)
    % sequence : Nx4 matrix where N is the total number of frames
    i = handles.frameNumber;
    set(handles.guiComponents.slider, 'Enable', 'off');
    
    while i <= handles.nbFrames
        % Update the frame graphics
        handles = updateFrame(handles, i);
        
        % Refresh graphics at the same rate as given by the timestamps
        if(i == handles.nbFrames)
            drawnow;
        else
            pause((handles.M(i+1, 1)-handles.M(i, 1))/1000);
        end
        i = i + 1;
        
        % Stop playing, update the playPauseButton and rewind at the end of
        % the sequence
        if i > handles.nbFrames
            resetSequence(handles);
        end
        
        guidata(gcf, handles);
    end
    
    set(handles.guiComponents.slider, 'Enable', 'on');
end

function resetSequence(handles)
    set(handles.guiComponents.playPauseButton, 'String', 'Play');
    set(handles.guiComponents.playPauseButton, 'Value', 0);
end

function handles = updateFrame(handles, i)
    set(handles.guiComponents.timestampText, 'String', sprintf('%d', handles.M(i, 1)));
    set(handles.guiComponents.frameText, 'String', sprintf('%d/%d', i, handles.nbFrames));

    q = handles.M(i, 2:5);
    q = q/norm(q);

    % Rotate the frame
    rotateFrame(handles.guiComponents.identityFrame, handles.guiComponents.imuFrame, q);
    % Rotate the rectangle sticked to the imuFrame
    rotateRectangle(handles.guiComponents.identityRectangle, handles.guiComponents.imuRectangle, q);
    
    % Tracing points
    displayTracing = handles.M(i, 6);
    if(displayTracing == 1)
        xData = get(handles.guiComponents.tracingPoints, 'XData');
        yData = get(handles.guiComponents.tracingPoints, 'YData');
        zData = get(handles.guiComponents.tracingPoints, 'ZData');
        pointX = get(handles.guiComponents.imuFrame.y, 'XData');
        pointY = get(handles.guiComponents.imuFrame.y, 'YData');
        pointZ = get(handles.guiComponents.imuFrame.y, 'ZData');
        xData(end+1) = pointX(2);
        yData(end+1) = pointY(2);
        zData(end+1) = pointZ(2);
        set(handles.guiComponents.tracingPoints, 'XData', xData);
        set(handles.guiComponents.tracingPoints, 'YData', yData);
        set(handles.guiComponents.tracingPoints, 'ZData', zData);
        
        % For stamping
        handles.chunkData(:, handles.chunkDataIndex) = [pointX(2);pointY(2);pointZ(2)];
        if handles.chunkDataIndex == handles.chunkDataSize
            handles.chunkDataIndex = 1;
            [temp, handles.cumulativeQ, handles.cumulativeT] = stampSphericalDataInitialized(handles.chunkData, handles.cumulativeQ, handles.cumulativeT);
            xData = get(handles.guiComponents.stampingPoints, 'XData');
            yData = get(handles.guiComponents.stampingPoints, 'YData');
            zData = get(handles.guiComponents.stampingPoints, 'ZData');
            
            chunkData = [temp; ones(1, size(temp, 2))];
            
            xData = [xData chunkData(1, :)];
            yData = [yData chunkData(2, :)];
            zData = [zData chunkData(3, :)];
            set(handles.guiComponents.stampingPoints, 'XData', xData);
            set(handles.guiComponents.stampingPoints, 'YData', yData);
            set(handles.guiComponents.stampingPoints, 'ZData', zData);
        else
            handles.chunkDataIndex = handles.chunkDataIndex+1;
        end
        
    end
    
    % Update slider
    set(handles.guiComponents.slider, 'Value', i);
end

