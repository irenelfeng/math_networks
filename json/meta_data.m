function [ fields ] = meta_data( filename )
%META_DATA Summary of this function goes here
%   Detailed explanation goes here
%     fid = fopen(filename);
%     raw = fread(fid, inf);
%     str = char(raw');
%     fclose(fid);
    fields = '';
    filename = strcat(filename, '.json');
    try 
        str = fileread(filename);
        %fields = JSON.parse(str).project.fields;
        fields = JSON.parse(str).project.owners{1}.country; 
    catch
        
    end
    % cell array of fields

end

