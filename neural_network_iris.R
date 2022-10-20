library(nnet)
library(NeuralNetTools)

# Get data
data(iris)
summary(iris)

# Learning and test bases
n=nrow(iris) # dataset size
ntrain=floor(2*n/3) # learning base size
ntest=n-ntrain # test base size

index=sample(1:n,ntrain,replace=F) # draw without discount
train=iris[index,] # learning base
test=iris[-index,] # test base
summary(train)

# Center and Reduce
mean=apply(train[,1:4],2,mean) # average over the columns of the quantitative variables
deviation=apply(train[,1:4],2,sd) # idem for deviation
tmp=scale(train[,1:4],center=mean,scale=deviation)
train[,1:4]=tmp

#Train the neural network
#model=nnet(Species~.,data=train,size=5)
model=nnet(Species~.,data=train,size=2)
weights=modele$wts
plotnet(model) 
# black= positive
# grey = negative
# big line = important in absolu value
summary(model)

# test base transformation
temp=scale(test[,1:4],center=mean,scale=deviation)
apply(temp,2,mean) 
apply(temp,2,sd) 
test[,1:4]=temp

# give probability for each class
predict(modele,test) 
# give predicted class
prev=predict(modele,test,type='class') 
MatConf=table(test$Species,prev)
MatConf

# Rate of right classed 
tb=sum(diag(MatConf))/sum(MatConf)
tb
# Rate of right classed  per class
diag(MatConf)/apply(MatConf,1,sum)
