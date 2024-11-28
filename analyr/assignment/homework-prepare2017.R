### 载入cgssincome数据集，将教育程度（本人、父母）重新进行编码转化为教育年限
###，政治面貌重新进行编码转化为是否党员。
library(haven)
setwd("~/Downloads/rproject/presentation")
load("cgssincome2017.Rdata")

# 如果用菜单方式（会使用haven包），需要去除变量标签，否则有些函数无法使用。
cgssincome <- zap_labels(cgssincome)

# 探索数据设定缺失值，浏览问卷和编码表，对变量取值逐一确认！
summary(cgssincome)

# 问卷中可查到，A8a的信息：9999996.个人全年总收入高于百万位数、9999997.不适用、9999998.不知道、9999999.拒绝回答。
cgssincome$income[cgssincome$income>9999990] <-NA
# 教育程度14为其他，可简单设定为缺失值
cgssincome$edu[cgssincome$edu==14] <-NA
# 政治面貌：9998.不知道、9999.拒绝回答。
cgssincome$polstatus[cgssincome$polstatus>4] <-NA
# 工作年限：98.不知道、99.拒绝回答
cgssincome$workexp[cgssincome$workexp>90] <-NA
# 2017版数据工作经历及状态无缺失值
# cgssincome$workexp[cgssincome$workexp<0] <-NA

cgssincome$fatheredu[cgssincome$fatheredu>=14] <-NA
cgssincome$motheredu[cgssincome$motheredu>=14] <-NA
cgssincome$fatherwork[cgssincome$fatherwork>=16] <-NA
cgssincome$motherwork[cgssincome$motherwork>=16] <-NA

cgssincome$age <- 2017-cgssincome$birth
cgssincome$eduyear[cgssincome$edu==1] <- 0
cgssincome$eduyear[cgssincome$edu==2] <- 3
cgssincome$eduyear[cgssincome$edu==3] <- 6
cgssincome$eduyear[cgssincome$edu==4] <- 9
cgssincome$eduyear[cgssincome$edu==5] <- 12
cgssincome$eduyear[cgssincome$edu==6] <- 12
cgssincome$eduyear[cgssincome$edu==7] <- 13
cgssincome$eduyear[cgssincome$edu==8] <- 13
cgssincome$eduyear[cgssincome$edu==9] <- 15
cgssincome$eduyear[cgssincome$edu==10] <-15
cgssincome$eduyear[cgssincome$edu==11] <- 16
cgssincome$eduyear[cgssincome$edu==12] <- 16
cgssincome$eduyear[cgssincome$edu==13] <- 20

cgssincome$feduyear[cgssincome$fatheredu==1] <- 0
cgssincome$feduyear[cgssincome$fatheredu==2] <- 3
cgssincome$feduyear[cgssincome$fatheredu==3] <- 6
cgssincome$feduyear[cgssincome$fatheredu==4] <- 9
cgssincome$feduyear[cgssincome$fatheredu==5] <- 12
cgssincome$feduyear[cgssincome$fatheredu==6] <- 12
cgssincome$feduyear[cgssincome$fatheredu==7] <- 13
cgssincome$feduyear[cgssincome$fatheredu==8] <- 13
cgssincome$feduyear[cgssincome$fatheredu==9] <- 15
cgssincome$feduyear[cgssincome$fatheredu==10] <-15
cgssincome$feduyear[cgssincome$fatheredu==11] <- 16
cgssincome$feduyear[cgssincome$fatheredu==12] <- 16
cgssincome$feduyear[cgssincome$fatheredu==13] <- 20

cgssincome$meduyear[cgssincome$motheredu==1] <- 0
cgssincome$meduyear[cgssincome$motheredu==2] <- 3
cgssincome$meduyear[cgssincome$motheredu==3] <- 6
cgssincome$meduyear[cgssincome$motheredu==4] <- 9
cgssincome$meduyear[cgssincome$motheredu==5] <- 12
cgssincome$meduyear[cgssincome$motheredu==6] <- 12
cgssincome$meduyear[cgssincome$motheredu==7] <- 13
cgssincome$meduyear[cgssincome$motheredu==8] <- 13
cgssincome$meduyear[cgssincome$motheredu==9] <- 15
cgssincome$meduyear[cgssincome$motheredu==10] <-15
cgssincome$meduyear[cgssincome$motheredu==11] <- 16
cgssincome$meduyear[cgssincome$motheredu==12] <- 16
cgssincome$meduyear[cgssincome$motheredu==13] <- 20

cgssincome$party[cgssincome$polstatus!=4] <- 0
cgssincome$party[cgssincome$polstatus==4] <- 1


# 剔除掉缺失值
cgssincome <- na.omit(cgssincome)

cgssincome$sex <- factor(cgssincome$sex,levels = c(1,2),labels=c("male","female"))
cgssincome$party <- factor(cgssincome$party,levels = c(0,1),labels=c("nonCCP","CCP"))

save(cgssincome, file = "cgssincome2017proc.RData")
