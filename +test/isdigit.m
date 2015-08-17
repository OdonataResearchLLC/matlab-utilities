classdef isdigit < matlab.unittest.TestCase
    %isdigit Test the isdigit utility function
    
    properties (TestParameter)
        digits = {'1', '123', '1234567890'}
        notdigits = { '1a', '123abc', 'abc098', '123.456' };
    end
    
    methods (Test)
        function testTrue( self, digits )
            self.verifyTrue(utility.isdigit(digits))
        end
        function testFalse( self, notdigits )
            self.verifyFalse(utility.isdigit(notdigits))
        end
    end
    
end
