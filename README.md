## Построение DWH по Кимбалу


## В таблицах измерений новые значения добавляются отдельной строкой. Для отслеживания изменений - колонки актуальности записи (valid_from, valid_to, active, version)


Строим потоки для загрузки таблиц измерений


Строим поток для загрузки таблицы фактов. 
В таблицу фактов необходимо загрузить суррогатные ключи, поэтому сначала загружаем таблицы измерений


customer_key, product_key, date_key - ключи, которые создаются каждый раз для каждой новой записи или для каждого изменения существующей записи (для отслеживания историчности)

updated_at_src - колонка хранит информацию последнего обновления на стороне источника данных


`my_company_dwh.sql` - создание таблиц измерений и таблицы фактов



# Создаю таблицы измерений и таблицу фактов, затем с помошью Pentaho наполняю таблицы измерений и таблицу фактов данными

`dim_date.ktr` - наполняет данными таблицу dim_date

![dim_date](https://github.com/romantitovmephi/DWH_Kimball_Model/blob/main/screens/dim_date.png)


`dim_product.ktr` - наполняет данными таблицу dim_product

![dim_product](https://github.com/romantitovmephi/DWH_Kimball_Model/blob/main/screens/dim_product.png)


Если в источнике данных появилась новая запись или изменилось какое-либо значение (например unit_price), то подгружаться будет только эта запись, при этом старая также останется.
До изменения:

![before_chng](https://github.com/romantitovmephi/DWH_Kimball_Model/blob/main/screens/before_chng.png)

Вносим изменение в unit_price:

![chng](https://github.com/romantitovmephi/DWH_Kimball_Model/blob/main/screens/chng.png)

После изменений `dim_product.ktr` отрабатывает следующим образом:

![after_chng_1](https://github.com/romantitovmephi/DWH_Kimball_Model/blob/main/screens/after_chng_1.png)

В таблице dim_product появилась одна новая запись:

![after_chng_2](https://github.com/romantitovmephi/DWH_Kimball_Model/blob/main/screens/after_chng_2.png)


`dim_customer.ktr` - наполняет данными таблицу dim_customer

![dim_customer](https://github.com/romantitovmephi/DWH_Kimball_Model/blob/main/screens/dim_customer.png)


`fct_sales.ktr` - наполняет данными таблицу fct_sales

![fct_sales](https://github.com/romantitovmephi/DWH_Kimball_Model/blob/main/screens/fct_sales.png)


`etl_sales.kjb` - финальный job, где собраны все трансформации

![etl_sales](https://github.com/romantitovmephi/DWH_Kimball_Model/blob/main/screens/etl_sales.png)
