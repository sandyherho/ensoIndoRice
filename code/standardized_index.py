'''
Standardized rice yield index 

Sandy Herho <herho@umd.edu>
2021/07/04
'''

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.preprocessing import StandardScaler
plt.style.use('ggplot')

df = pd.read_csv('./data/dataset.csv', index_col='date', parse_dates=True)

index = (df['production'] / df['area_harvested']).to_numpy().reshape(-1, 1)

scaler = StandardScaler()
scaled_index = scaler.fit_transform(index).flatten()

df['scaled_yield_idx'] = scaled_index
df.to_csv('../data/new_dataset.csv')

plt.figure(figsize=(15,5));
plt.plot(df.index, df['scaled_yield_idx']);
plt.xlabel('time');
plt.ylabel('Standardized rice yield index');
plt.tight_layout();
plt.savefig('../figures/fig2.eps')
