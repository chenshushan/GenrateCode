https://www.cnblogs.com/FromSnatch/archive/2012/05/20/2510682.html
js面向对象，多种创建对象方法！
　1.对象字面量。

 var clock={
  hour:12,
  minute:10,
  second:10,
  showTime:function(){
   alert(this.hour+":"+this.minute+":"+this.second);
  }
 }
 clock.showTime();//调用

2.创建Object实例

 var clock = new Object();
 clock.hour=12;
 clock.minute=10;
 clock.showHour=function(){alert(clock.hour);};

 clock.showHour();//调用

由此可见 属性是可以动态添加，修改的

1.工厂模式：就是一个函数，然后放入参数，返回对象，流水线工作

 function createClock(hour,minute,second){
  var clock = new Object();
   clock.hour=hour;
   clock.minute=minute;
   clock.second=second;
   clock.showHour=function(){
   alert(this.hour+":"+this.minute+":"+this.second);
  };
  return clock;
 };
 var newClock = createClock(12,12,12);//实例化
 newClock.showHour();//调用

优点：总算优点抽象的概念了。但是不能识别对象的类型呢！

2.构造函数模式

 function clock(hour,minute,second){
  this.hour = hour;
  this.minute = minute;
  this.second = second;
  this.showTime = function(){
   alert(this.hour+":"+this.minute+":"+this.second);
  }
 }
 var newClock =new  clock(12,12,12); 
 alert(newClock.hour);
 
 分业优化（走主键索引）
 SELECT * FROM product WHERE ID > =(select id from product limit 866613, 1) limit 20
 
 SELECT * FROM product a JOIN (select id from product limit 866613, 20) b ON a.ID = b.id
 
 admin/123456