library(TSP)                #TSP问题求解包
library(maps)               #用于绘制地图
library(maptools)           #用于添加文本标签 
pr=read.csv("province.csv") #读取数据
f.dis=function(x,y){        #该函数计算地球上两点之间的球面距离
  R=6371                    #地球的平均半径
  x=x*pi/180;y=y*pi/180     #角度化弧度
  a=c(cos(x[2])*cos(x[1]),cos(x[2])*sin(x[1]),sin(x[2])) #x点的直角坐标
  b=c(cos(y[2])*cos(y[1]),cos(y[2])*sin(y[1]),sin(y[2])) #y点的直角坐标
  cosg=sum(a*b)/sqrt(sum(a^2)*sum(b^2))  #计算球面两点过大圆的圆心角的余弦
  dis=R*acos(cosg)                       #得到两点的球面距离
}
k=cbind(pr$jd,pr$wd)                     #获取经度纬度数据
dis.mat=matrix(NA,34,34)                 #预定义矩阵，存放距离数据
for(i in 1:34){
  for(j in 1:34){
    dis.mat[i,j]=f.dis(k[i,],k[j,])
  }
}                                        #计算34个城市两两之间的距离
colnames(dis.mat)=rownames(dis.mat)=pr[,1]              #行列名为城市名
tsp=TSP(dis.mat)                                        #格式转换为TSP
tour=solve_TSP(tsp,method="2-opt")                      #求解TSP问题
path=as.integer(tour)                                   #得出数字路线
tour_length(tsp, tour)                                  #计算总路线长度
map("world", "China", fill=T, col="lightgray")          #绘制中国地图
map.axes()                                              #加上坐标
xx=pr[path,]                                              
attach(xx) 
points(c(jd,jd[1]),c(wd,wd[1]),col=2,pch=19,type="o")   #绘制路线           
pointLabel(jd,wd,city,col=4,cex=0.74)                   #标出城市
detach(xx) 