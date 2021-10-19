using System;
using System.Collections.Generic;
using System.Linq;

namespace Connexus_Functions
{
    class Connexus_Functions
    {
        //easy Linq function
        int[] MoveZerosToTheTailOfArray(int[] inputArray)
        {
            List<int> list = inputArray.Where(x => x != 0).ToList();
            list.AddRange(inputArray.Where(x => x == 0).ToList());
            return list.ToArray();
        }

        //least memory for declaring new variables function
        void MoveZerosToTheTailOfArrayMemory(ref int[] inputArray)
        {
            bool recurseRequired = false;
            for (int i = 0; i < inputArray.Length - 1; i++)
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
                MoveZerosToTheTailOfArrayMemory(ref inputArray);
            }
        }

        double ArrayMedian(int[] inputArray)
        {
            Array.Sort(inputArray);
            int count = inputArray.Length;
            return count % 2 != 0 ? (double)inputArray[count / 2]
                                  : (double)(inputArray[(count - 1) / 2] + inputArray[count / 2]) / 2;
        }
    }
}
