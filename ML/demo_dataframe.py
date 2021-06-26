import streamlit as st
import pandas as pd
from catboost import CatBoostRegressor
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error
import numpy as np


@st.cache()
def get_data():
    df_s = pd.read_csv("/Users/ILYA/Desktop/Python/MachineLearning/Lesson3/ML_3/data/housing.csv")
    return df_s

df = get_data()

st.header('MVP предсказание стоимости жилья')

if st.checkbox('Отобразить данные'):
    st.write(df)
    st.line_chart(df)

a = [10, 15, 20, 25, 30, 35]
result = st.selectbox('Выбрать размер test выборки', (a))



if st.button('Создать модель'):
    X_train, X_test, y_train, y_test = train_test_split(df.drop('MEDV', axis=1), df['MEDV'], test_size= result/100,
                                                        random_state=0)
    st.text('Размер данных-'+str(X_train.shape) + str( X_test.shape))

    st.text('Старт модели')
    model = CatBoostRegressor()
    model.fit(X_train,y_train)
    st.text('Обучили модель')
    pred = model.predict(X_test)
    st.text(str(np.sqrt(mean_squared_error(y_test,pred))))

    st.text('Результат предсказания')
    pred_str = pd.Series(pred).round(decimals=1)
    a = y_test.reset_index(drop=True)
    b = pd.DataFrame({'pred': pred_str, 'y_test': a})
    st.write(pd.DataFrame(b))
