
# See Fruit
See Fruit is an iOS app that recognizes fruit using customized pre-trained CoreML model. We are managed to obtain the accuracy of nearly 90% with fruits that are in the training set.  The fruit info will be popped up for user references.

This project is a part of our Aloha Fruit iOS app which takes care of the fruit recognition before popping up the AR info and 3D model.

## How this works
First, we used [Turi-Create](https://github.com/apple/turicreate) as a Machine Learning tool to train customized [CoreML](https://developer.apple.com/documentation/coreml) model. We collected, analyzed and cleaning fruit images for machine learning part using Xcode, Python and Turin Create. 

Since the app needs to recognize the fruit with iPhone camera, we trained our model based on two different data set: images and AR scanning object. Using AT scanning object increases our accuracy significantly while we are using camera to detect the fruit.

We also need to determine the number of training iterations and size of our data set so that the accuracy is maximized. 

![giphy](https://user-images.githubusercontent.com/35791349/46707052-27899c00-cc06-11e8-8cc4-962fb3de23a2.gif)

![ezgif com-video-to-gif](https://user-images.githubusercontent.com/35791349/46707085-5b64c180-cc06-11e8-8251-8fb44af81570.gif)
![giphy](https://media.giphy.com/media/vvV86S4mskESSUanvc/giphy.gif)

## Installation
No Installation required, just make sure you have Xcode 10 with iOS 12.

## Built with

`Turi-Create`

`CoreML`

`createml`

`Xcode`

`Swift`

`Python`

`ARkit2`



## Author

[An Q Tran](https://www.linkedin.com/in/an-q-tran/)

[Kiet Tran](https://github.com/kiettran95)

[An Nguyen](https://github.com/an-nguyen239)

[Luan Nguyen](https://github.com/luannguyen2603)

[Duc Le](https://github.com/Ducle141)	
 
[Loc Le](https://github.com/ln60)


