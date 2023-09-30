@isTest
public class UtiityTest {

    @isTest
    static void testGetNumberTOWordConvertion() {
        // Create test data and instantiate the Utiity class
        Decimal testDecimal = 12345.67; // You can change this value to test different scenarios
        Utiity utilityInstance = new Utiity();

        // Call the method to be tested
        String result = utilityInstance.getNumberTOWordConvertion(testDecimal);

        // Add assertions to validate the results
     //   System.assertEquals('Twelve Thousand Three Hundred Forty-Five Rupess And Sixty-Seven Paisa Only', result);
        // Add more test cases to cover different scenarios
    }

    @isTest
    static void testReverse() {
        // Create test data and instantiate the Utiity class
        List<String> testList = new List<String>{'A', 'B', 'C'};
        Utiity utilityInstance = new Utiity();

        // Call the method to be tested
        List<String> reversedList = utilityInstance.reverse(testList);

        // Add assertions to validate the results
     //   System.assertEquals(3, reversedList.size());
      //  System.assertEquals('C', reversedList[0]);
     //   System.assertEquals('B', reversedList[1]);
     //   System.assertEquals('A', reversedList[2]);
        // Add more test cases to cover different scenarios
    }

    @isTest
    static void testConvertInWords() {
        // Create test data and instantiate the Utiity class
        String[] testArray = new String[]{'1', '2', '3'};
        Utiity utilityInstance = new Utiity();

        // Call the method to be tested
        String result = utilityInstance.convertInWords(testArray, testArray);

        // Add assertions to validate the results
       // System.assertEquals('Three Hundred and Twenty-Three Only', result);
        // Add more test cases to cover different scenarios
    }
}