classdef FortranIO < handle
    %FortranIO Read and write Fortran unformatted files
    %   Operate on records.
    
    properties
        fileID, wordsize
    end
    
    methods
        % Constructor
        function instance = FortranIO( varargin )
            function torf = validWordSize( theWord )
                torf = any(validatestring(theWord, ...
                    {'uint', 'uint32', 'uint64'}));
            end
            % Input validation
            ip = inputParser;
            ip.addParameter('FileName', '');
            ip.addParameter('WordSize', 'uint', @validWordSize);
            ip.parse(varargin{:});
            % Store the data
            instance.fileID = fopen(ip.Results.FileName);
            instance.wordsize = ip.Results.WordSize;
        end
        % Raw read function
        function record = readRecord( self )
            %readRecord Read a single record from the Fortran file
            
            % Record length
            reclen = fread(self.fileID,1,self.wordsize);
            
            % Record data
            [ record, count ] = fread(self.fileID,reclen,'*ubit8');
            if count ~= reclen
                error('Expected %i bytes, but read %i.', reclen, count);
            end
            
            % Suffix record length
            endlen = fread(self.fileID,1,'uint');
            if endlen ~= reclen
                error('Suffix record length, %i, does not equal prefix, %i.', ...
                    endlen, reclen);
            end
        end
        % Buffer the entire file
        function buffer = readFile( self )
            %readFile Read all records into a buffer
            
            fseek(self.fileID,-1,'eof');
            eofpos = ftell(self.fileID);
            frewind(self.fileID);
            
            count = 1;
            buffer = cell(16,1);
            while ftell(self.fileID) < eofpos;
                buffer{count} = self.readRecord;
                count = count + 1;
            end
        end
    end
end
