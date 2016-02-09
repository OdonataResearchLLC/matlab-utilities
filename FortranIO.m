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
            ip.addParameter('WordSize', 'uint', @validWordSize);
            ip.parse(varargin{:});
            % Store the data
            instance.fileID = 0;
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
        function records = readFile( self, FortranBinaryFile )
            %readFile Read all records into a buffer
            
            % Open the file
            self.fileID = fopen(FortranBinaryFile, 'r');
            if self.fileID < 0
                error('Unable to open %s.', FortranBinaryFile);
            end
            
            try
                % Find the end-of-file
                fseek(self.fileID,-1,'eof');
                eofpos = ftell(self.fileID);
                frewind(self.fileID);
                
                % Read the records
                count = 1;
                buffer = cell(8192,1);
                while ftell(self.fileID) < eofpos;
                    buffer{count} = self.readRecord;
                    count = count + 1;
                end
                
                % Close the file
                self.fileID = fclose(self.fileID);
                
                % Return the records
                records = buffer(1:count-1);
            catch ERR
                self.fileID = fclose(self.fileID);
                rethrow(ERR)
            end
        end
    end
end
