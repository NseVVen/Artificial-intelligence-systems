import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt
import os

# Загрузка обученной модели
model_path = "digit_model.h5"
if not os.path.exists(model_path):
    raise FileNotFoundError("❌ Модель digit_model.h5 не найдена. Сначала обучи модель через train_model.py")

model = tf.keras.models.load_model(model_path)
print("✅ Модель загружена.")

# Загрузка тестовой выборки
(_, _), (x_test, y_test) = tf.keras.datasets.mnist.load_data()
x_test = x_test / 255.0  # Нормализация
x_test = x_test[..., tf.newaxis]  # Добавляем канал

# Выбираем случайное изображение
index = np.random.randint(0, len(x_test))
img = x_test[index]
true_label = y_test[index]

# Предсказание
img_input = img.reshape(1, 28, 28, 1)
pred = model.predict(img_input)
predicted_digit = np.argmax(pred)

# Вывод
plt.imshow(img[..., 0], cmap='gray')
plt.title(f"🔍 Предсказано: {predicted_digit}  |  Истинное: {true_label}")
plt.axis('off')
plt.show()

# Результат
print(f"\n✅ Истинная цифра: {true_label}")
print(f"🤖 Предсказанная моделью: {predicted_digit}")
