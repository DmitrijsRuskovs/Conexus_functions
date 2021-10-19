using System;
using System.Collections.Generic;
using System.Linq;

namespace Connexus_Functions
{
    class Connexus_Functions
    {
        int[] MoveZerosToTheTailOfArray(int[] inputArray)
        {
            List<int> list = inputArray.Where(x => x != 0).ToList();
            list.AddRange(inputArray.Where(x => x == 0).ToList());
            return list.ToArray();
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
