活动日历，让生活更好玩~

### code
git clone  git@github.com:IceskYsl/huodongrili.git online_20130919

[root@localhost huodong]# ln -s ./online_20130919 current

RAILS_ENV=production bundle exec  rake assets:precompile


/usr/local/mongodb/bin/mongod --dbpath=/data/dbs/mongodb --logpath=/var/log/mongodb.log --fork