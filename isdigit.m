function torf = isdigit( theString )
%isdigit Return true if the string only contains digits

if isempty(regexp(theString, '\D', 'once'))
    torf = true;
else
    torf = false;
end
end
