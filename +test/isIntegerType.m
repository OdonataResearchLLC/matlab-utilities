classdef isIntegerType < matlab.unittest.TestCase
    %isIntegerType Test the isIntegerType utility function

    properties (TestParameter)
        validTypes = { ...
             'int8',  'int16',  'int32',  'int64', ...
            'uint8', 'uint16', 'uint32', 'uint64' }
        invalidTypes = { 'int1', 'int2', 'int7' }
    end

    methods (Test, ParameterCombination='sequential')
        function testTrue( self, validTypes )
            self.verifyTrue(utility.isIntegerType(validTypes))
        end
        function testFalse( self, invalidTypes )
            self.verifyFalse(utility.isIntegerType(invalidTypes))
        end
    end
end
