import numpy as np
import matplotlib.pyplot as plt
from sklearn.decomposition import PCA
from sklearn.cluster import KMeans
from tensorflow.keras.datasets import mnist

# Загрузка и подготовка данных
(x_train, y_train), (_, _) = mnist.load_data()
x_data = x_train[:300]  # для читаемой визуализации
y_data = y_train[:300]
x_flat = x_data.reshape((x_data.shape[0], -1)) / 255.0  # нормализация

# PCA до 2 компонент
pca = PCA(n_components=2)
x_pca = pca.fit_transform(x_flat)

# KMeans кластеризация
kmeans = KMeans(n_clusters=10, random_state=42)
clusters = kmeans.fit_predict(x_flat)

# Визуализация: цифры поверх точек
plt.figure(figsize=(10, 8))
for i in range(len(x_pca)):
    plt.text(x_pca[i, 0], x_pca[i, 1], str(y_data[i]),
             color=plt.cm.tab10(clusters[i] / 10.0),
             fontdict={'weight': 'bold', 'size': 9})

plt.title("Кластеризация с отображением цифр")
plt.xlabel("PCA компонент 1")
plt.ylabel("PCA компонент 2")
plt.grid(True)
plt.tight_layout()
plt.show()

