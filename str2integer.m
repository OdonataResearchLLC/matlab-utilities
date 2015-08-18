function result = str2integer( varargin )
%str2integer Convert a string to an integer
%   Signal an error if the string is not an integer representation.

% Parse the input
ip = inputParser;
ip.addRequired('theString', @ischar)
ip.addOptional('iType', 'int32', @utility.isIntegerType)
ip.parse(varargin{:})

theString = strtrim(ip.Results.theString);
switch theString(1)
    case '+'
        sgn = 1.0;
        theString = theString(2:end);
    case '-'
        sgn = -1.0;
        theString = theString(2:end);
    otherwise
        sgn = 1.0;
end

if utility.isdigit(theString)
    result = cast(sgn*str2double(theString), ip.Results.iType);
else
    error('str2integer:NotInteger', ...
        '%s is not an integer.', ip.Results.theString)
end
end
