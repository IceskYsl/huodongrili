活动日历，让生活更好玩~

### code
```
git clone  git@github.com:IceskYsl/huodongrili.git online_20130919

[root@localhost huodong]# ln -s ./online_20130919 current

[root@li460-81 current]# rvm use ruby-1.9.3-p448
Using /usr/local/rvm/gems/ruby-1.9.3-p448

[root@li460-81 current]# bundle 


RAILS_ENV=production bundle exec  rake assets:precompile


/usr/local/mongodb/bin/mongod --dbpath=/data/dbs/mongodb --logpath=/var/log/mongodb.log --fork

```

## Api

### 1.calendar

GET http://api.huodongrili.com/calendar?last_timestamp=1383406315

```
{"timestamp": "1383406559", "data": [], "result": "ok"}
```

###2.reaction

POST /reaction/

### 3.app

GET /app?last_version=1.2.2
http://api.huodongrili.com//app?last_version=1.2.2

```
{"url": "http://api.huodongrili.com/download/apk/2013-06-18-00-01/huodongrili.apk", "has_new": "1", "result": "ok"}
```

### 4.activities

GET /activities?city=beijing&last_timestamp=1383406508 
http://api.huodongrili.com//activities?city=beijing&last_timestamp=1381906508

```

{	"timestamp": "1383407064", 
	"data": [
			{"weight": 71, "end_date": "2014-01-26", "title": "3小时项目管理实践入门（2小时理论，1小时软件）", 
			"url": "http://m.douban.com/event/19437059/", 
			"start_time": "09:00", 
			"tags": [], 
			"start_date": "2013-11-02", 
			"content": "报名请点击：你想了解项目管理的基础知识吗？\r\n你想做出漂亮的甘特图吗？\r\n你想通过软效的管理项目吗？\r\n你想控制一个项目的成本与充分利用资源吗？\r\n\r\n本次课程将分项目的组织结构 ", 
			"source": "豆瓣", "end_time": "12:00", "id": "31287", "location": "北京 海淀区 中关村 车库咖啡"},{}]
```
