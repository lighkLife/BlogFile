---
title: "python操作数据库封装"
date: "2017-07-13 11:07"
categories:
  - python
tags:
  - python
  - SQL
---



起因：主要是解决`单表`增删改查时，遇到字段比较多的表，写出的sql比较难维护，而且代码不够整洁。（就是因为有两个table都有一百个字段，很难维护）
特点便是操作可以使用简单实体，查询返回的结果集合也是简单实体。如下：

<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [初始化，数据库连接与关闭](#初始化数据库连接与关闭)
- [直接执行sql与获取游标](#直接执行sql与获取游标)
- [查询](#查询)
- [修改数据](#修改数据)
- [添加数据](#添加数据)
- [删除数据](#删除数据)

<!-- /TOC -->

<!-- more -->

# 初始化，数据库连接与关闭
这里使用PooledDB作为连接池， 通过`Tools.get_host_pwd()`可以获取不同运行环境需要连接数据库地址和密码
```python
class DB(object):
    def __init__(self,db_name):
        host, pwd = Tools.get_host_pwd()
        config = {
            'user': 'root',
            'password': pwd,
            'host': host,
            'port': 3306,
            'database': db_name,
            'charset': 'utf8'
        }
        self._pool = PooledDB(pymysql, mincached=4, maxcached=10, setsession=['SET AUTOCOMMIT = 1'], **config)
        self._conn = self._pool.connection()
        self._cur = self._conn.cursor()

    def close_db(self):
        self._cur.close()
        self._conn.close()
```

# 直接执行sql与获取游标
```python
    def execute(self, sql):
        return self._cur.execute(sql)


    def get_cur(self):
        return self._cur
```

# 查询

这里添加了三种查询方式
  * select 根据where刷选条件返回查询到的所有实体
  * select_one 最多返回一个实体
  * select_by_sql 使用自己编写的sql去查询

这样单表查询就显得代码很整洁清晰，修改维护也更加方便
```python
if __name__ == '__main__':
    db = DB('car_db')
    brand = Brand()
    brand.auto_brand_id = '35'
    brand.letter = 'M'
    brand.brand_name = '--阿斯顿·马丁'
    db_brand = db.select_one('car_brand', where_model=brand)
    print(brand.__dict__)
```

其中需要定义对应数据库表的实体
```python
class Brand(object):
    id = None
    auto_id = None
    auto_brand_id = None
    letter = None
    brand_name = None
    logo_url = None
    update_time = None
    country = None
    sort = None

    def __init__(self):
        pass

    @classmethod
    def get_field(cls):
        return ['id', 'auto_brand_id', 'letter', 'brand_name', 'logo_url',
                'update_time', 'country', 'sort']
```

这里将sql查询出来结果转成实体最关键的两部是
```python
result = [dict((k, row[i]) for i, k in enumerate(fields)) for row in result]

Tools.dict_to_model(data, where_model)
```

先将查询结果转成表`dict`，字段名对应其值，然后将dict转成实体，方法如下
```python
def dict_to_model(a_dict, model):
    if not isinstance(model, object):
        logging.error("model 不是类")
        return None
    instance = copy.deepcopy(model)
    for k, v in a_dict.items():
        instance.__setattr__(k, v)
    return instance
```

```python
    def select(self, table, where_model, fields=None):
        """
        查询数据
        :param table:
        :param where_model: 查询条件，类型为要查询的model实例
        :param fields: 可选，需要查出的model的字段列表，默认查询model所有字段，
        :return: 满足条件的model的generator
        """
        if fields is None:
            fields = where_model.get_field()
        where = '1=1'
        if where_model.__dict__:
            where = " and ".join(["%s='%s'" % (k, v) for k, v in where_model.__dict__.items()])
        sql = "select %s from %s where %s order by id" % (",".join(fields), table, where)
        try:
            self._cur.execute(sql)
            result = self._cur.fetchall()
            if result:
                result = [dict((k, row[i]) for i, k in enumerate(fields)) for row in result]
            else:
                result = []
            for data in result:
                yield Tools.dict_to_model(data, where_model)
        except Exception as e:
            self.close_db()
            logging.error("Execute '%s' error: %s" % (sql, traceback.format_exc()))
            logging.error(e)

    def select_by_sql(self, model, sql):
        """
        查询数据
        """
        try:
            self._cur.execute(sql)
            result = self._cur.fetchall()
            if result:
                fields = model.get_field()
                result = [dict((k, row[i]) for i, k in enumerate(fields)) for row in result]
            else:
                result = []
            for data in result:
                yield Tools.dict_to_model(data, model)
        except Exception as e:
            self.close_db()
            logging.error("Execute '%s' error: %s" % (sql, traceback.format_exc()))
            logging.error(e)

    def select_one(self, table, where_model):
        """
            查询数据
            :param table:
            :param where_model: 查询条件，类型为要查询的model实例
            :return: 满足条件的model的generator
            """
        fields = where_model.get_field()
        where = '1=1'
        if where_model.__dict__:
            where = " and ".join(["%s='%s'" % (k, v) for k, v in where_model.__dict__.items()])
        sql = "select %s from %s where %s order by id limit 1" % (",".join(fields), table, where)
        try:
            self.execute(sql)
            result = self._cur.fetchall()
            if result:
                result = [dict((k, row[i]) for i, k in enumerate(fields)) for row in result]
                return Tools.dict_to_model(result[0], where_model)
            else:
                return None
        except Exception as e:
            self.close_db()

            logging.error("Execute '%s' error: %s" % (sql, traceback.format_exc()))
            logging.error(e)
```

# 修改数据
```python
    # 更新数据
    def update(self, table, model, where_model):
        """
        更新
        :param table: 表名
        :param model: 更新的实例
        :param where_model: 条件，类型与model相同
        :return:
        """
        where = ''
        if where_model.__dict__:
            where = " and ".join(["%s='%s'" % (k, v) for k, v in where_model.__dict__.items()])
        else:
            logging.error('where_model 不能为空')
        fields = model.__dict__
        data = ",".join(["%s='%s'" % (k, v) for k, v in fields.items()])
        sql = 'update %s set %s where' ' %s ' % (table, data, where)
        try:
            return self.execute(sql)
        except Exception as e:
            self.close_db()
            logging.error("Execute '%s' error: %s" % (sql, traceback.format_exc()))
            logging.error(e)

```

# 添加数据
```python
    def insert(self, table, model):
        """
        insert data into table
        :param model:
        :param table: table name
        :return: The result of insert sql execute
        """
        data = model.__dict__
        fields, values = [], []
        for k, v in data.items():
            fields.append(k)
            values.append("'%s'" % v)
        sql = "insert into %s (%s) values (%s)" % (table, ",".join(fields), ",".join(values))
        try:
            return self.execute(sql)
        except Exception as e:
            self.close_db()
            logging.error("Execute '%s' error: %s" % (sql, traceback.format_exc()))
            logging.error(e)
```
# 删除数据
```python
    def delete(self, table, where_model):
        """
        delete rows from table with the condition where
        :param table: table name (String)
        :param where_model: condition (dict example: {'id': 1, 'name': 'lighk'})
        :return: The count of deleted rows
        """
        where = where_model.__dict__
        conditions = []
        if where and isinstance(where, dict):
            for k, v in where.items():
                conditions.append("%s='%s'" % (k, v))
        sql = "delete from %s where %s" % (table, ' AND '.join(conditions))
        try:
            return self.execute(sql)
        except Exception as e:
            self.close_db()
            logging.error("Execute '%s' error: %s" % (sql, traceback.format_exc()))
            logging.error(e)

```
