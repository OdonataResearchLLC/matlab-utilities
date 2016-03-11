classdef dataParser < handle
    %dataParser Parsing object for files with irregular data
    
    properties
        line, dataCell, lastline
    end
    
    methods
        function instance = dataParser( varargin )
            % Input validation
            ip = inputParser;
            ip.addOptional('theData', cell(0), @iscellstr)
            ip.parse(varargin{:})
            % Initialize the instance
            instance.line = 0;
            instance.dataCell = ip.Results.theData;
            instance.lastline = numel(ip.Results.theData);
        end
        function theLine = next( self, count )
            % Default to 1 line
            if nargin == 1
                count = 1;
            end
            % Increment and return the next line
            lineNumber = self.line + count;
            if lineNumber < self.lastline
                self.line = lineNumber;
                theLine = self.dataCell{lineNumber};
            else
                % FIXME: Create a proper exception
                error('Next line, %i, exceeds lastline, %i.', ...
                    lineNumber, self.lastline)
            end
        end
        function rewind( self, count )
            if nargin == 1
                self.line = 0;
            else
                self.line = self.line - count;
            end
        end
        function torf = eod( self, count )
            if nargin == 1
                count = 1;
            end
            torf = self.lastline <= self.line + count;
        end
    end
    
end
