'''
Dynamic Time Warping

Sandy Herho <herho@umd.edu>
2021/07/04
'''

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from dtw import dtw,accelerated_dtw
plt.style.use('ggplot')

df = pd.read_csv('../data/new_dataset.csv', index_col='date', parse_dates=True)

d1 = df['mei'].values
d2 = df['scaled_yield_idx'].values

d, cost_matrix, acc_cost_matrix, path = accelerated_dtw(d1, d2, dist='euclidean')
print(f'DTW Minimum Path with minimum distance: {np.round(d,2)}');

plt.figure(figsize=(10, 10))
plt.imshow(acc_cost_matrix.T, origin='lower', cmap='gist_heat', interpolation='nearest')
plt.plot(path[0], path[1], 'w')
plt.xlabel('Multivariate ENSO Index')
plt.ylabel('Standardized rice yield index')
plt.savefig('../figures/fig3.eps')
