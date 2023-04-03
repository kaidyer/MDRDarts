import numpy as np
from matplotlib import pyplot as plt

dists = [
4.950,
7.280,
5.946,
4.717,
15.133,
7.811,
13.153,
13.416,
12.728,
17.912,
1.000,
8.732,
0.400,
5.546,
19.416,
6.139,
7.159,
7.000,
19.235,
2.000
]

x = np.arange(0, len(dists))

average = np.average(dists)
std = np.std(dists)
var = np.var(dists)
# print(responses)
print("Average: ", average)
print("Standard Deviation: ", std)
print("Variance: ", var)

plt.hist(dists)
plt.xlabel("Distances (mm)")
plt.ylabel("Number of Hits")
plt.title("Plotting Distances vs. Number of Hits")
plt.show()