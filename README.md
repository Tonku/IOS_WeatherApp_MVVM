# README #

![Simulator Screen Shot 11-Apr-2016 7.37.57 am.png](https://bitbucket.org/repo/KpyKbx/images/1622827225-Simulator%20Screen%20Shot%2011-Apr-2016%207.37.57%20am.png)

### WestpacSample  info ###

* Sample made using ObjectiveC
* All the data from the weather web service is consumed
* A part of the data in the data model  is displayed in a meaningful way.
* Unit tests are provided.
* Only one third party library is used.Mantle is a popular library for JSON object mapping
* The project uses carthage for dependancy management.(I am using an older version
  of Xcode so the cocoapods version have some issue with my Xcode, so cocoapods not used)

### How to build? ###

* Clone the project and build 
* Carthage output also added to the repo, to make things easy to setup

### Architecture ###

The applcation follows 3 tier architecture. We are not using local persitance model becaue 
its better to give no weather than an irrelevant weather report of the past.

* The layers are 

    * Services (Location and REST services)
    * ViewModel 
    * View  

The ViewController is treated as a part of view as per MVVM.
ViewController is in has a relation with view model and view 
The view model communicate with the view controller using KVO and
notification center.