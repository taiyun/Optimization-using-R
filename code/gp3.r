> coefficients = matrix(c(1,1,5,1,1,0,3,1), 4)
> coefficients              #输出硬约束变量的系数矩阵
     [,1] [,2]
[1,]    1    1
[2,]    1    0
[3,]    5    3
[4,]    1    1
> targets = c(10,4,56,12)
> targets                   #输出约束系数矩阵对应的约束向量
[1] 10  4 56 12
> achievements = data.frame(objective=1:4, priority=c(1,1,2,3),
+                           p=c(2,3,0,1), n=c(0,0,1,0))
> achievements              #输出偏差变量相关信息数据框
  objective priority p n
1         1        1 2 0
2         2        1 3 0
3         3        2 0 1
4         4        3 1 0
> soln = llgp(coefficients, targets, achievements)
> soln$converged            #若为TRUE，则表示求得最优解
[1] TRUE
> soln$out                  #得到的解

Decision variables
                X
X1   4.000000e+00
X2   6.000000e+00