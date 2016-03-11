function fileC = file2cell( fileName )
%file2cell Read a file and store each line as a column in a cell array.

if nargin == 0
    % Use a global FilterSpec
    [ fname, fpath ] = uigetfile('*');
    fileName = fullfile(fpath,fname);
elseif fileName(1) == '*'
    % The fileName is a FilterSpec
    [ fname, fpath ] = uigetfile(fileName);
    fileName = fullfile(fpath,fname);
else
    fname = 1;
end

% Read the file
if fname ~= 0
    fileC = strsplit(fileread(fileName), '\n');
else
    fileC = cell(0);
end

end
