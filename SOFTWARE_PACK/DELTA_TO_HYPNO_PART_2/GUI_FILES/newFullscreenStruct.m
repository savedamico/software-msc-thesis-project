function [myStruct] = newFullscreenStruct()
%NEWFULLSCREENSTRUCT Summary of this function goes here
%   Generates an empty structure to be passed to GUI_FullScreen
myStruct = struct();
myStruct.data = struct('time',{},'signal',{},'info',{},'prop',{});
    % time is the array plotted as x-axis
    % signal is the array plotted as y-axis
    % info is the command string of the plot
    % prop is a cell array with the property strings on the first row and
    %   the values on the second
myStruct.fs = 0;
myStruct.title = '';
myStruct.xlabel = '';
myStruct.ylabel = '';
myStruct.events = false;
myStruct.nParts = 0;

end

