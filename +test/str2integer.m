classdef str2integer < matlab.unittest.TestCase
    %isdigit Test the isdigit utility function
    
    properties (TestParameter)
        txtIntegers = { '-1', '1', '+1', '-123', '123', '+123'}
        expIntegers = { -1, 1, 1, -123, 123, 123 }
        notIntegers = { '-1.0', '2.3E-4', '100.' }
    end
    
    methods (Test, ParameterCombination='sequential')
        function testIntegers( self, txtIntegers, expIntegers )
            self.verifyEqual(utility.str2integer(txtIntegers), ...
                int32(expIntegers))
        end
        function testOther( self, notIntegers )
            self.verifyError( ...
                @() utility.str2integer(notIntegers), ...
                'str2integer:NotInteger');
        end
    end    
end
