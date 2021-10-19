using namespace std;

namespace Connexus_Functions_cpp
{
    class Connexus_Functions_cpp
    {
        void MoveZerosToTheTailOfArray(int* inputArray, int arraySize)
        {
            bool recurseRequired = false;
            for (int i = 0; i < arraySize - 1; i++)
            {
                if (inputArray[i] == 0 && inputArray[i + 1] != 0)
                {
                    recurseRequired = true;
                    inputArray[i] = inputArray[i + 1];
                    inputArray[i + 1] = 0;
                }
            }
            if (recurseRequired)
            {
                MoveZerosToTheTailOfArray(inputArray, arraySize);
            }
        }

        double ArrayMedian(int array[], int arraySize)
        {
            int inputArray[arraySize] = {};
            for (int i = 0; i < arraySize - 1; i++)
            {
               inputArray[i] = array[i];
            }
            sort(inputArray, inputArray + arraySize);
            return arraySize % 2 != 0 ? (double)inputArray[arraySize / 2]
                                      : (double)(inputArray[(arraySize - 1) / 2] + inputArray[arraySize / 2]) / 2;
        }
    }
}
