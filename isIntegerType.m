function torf = isIntegerType( theType )
%isIntegerType Return true if theType is a valid type of integer

switch theType
    case {'int8','int16','int32','int64'}
        torf = true;
    case {'uint8','uint16','uint32','uint64'}
        torf = true;
    otherwise
        torf = false;
end
end
