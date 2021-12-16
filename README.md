# RobustaTask

 ## First Commit 
 1. Creating the APIService class:
 
   - In this commit I have used the native way in swift to retrieve the data from the API by using the **URLSession** and **Codable** 
   
    1.1 Simply created a shared instance to be able use the class functionality through it
   
     1.2 Created function and I returned the the response and the error in the completion , Make it escaping as I need it to be called after the function it was passed to returns
   
    1.3 Creating the API related vars/Constants like the url, urlSession, task
   
    1.4 Chcecking if there is an error, then checking if there is data existed
   
    1.5 Using try catch block to decode the response and completion on it or on an error if existed
   
    1.6 Once the task is created it supposed to be in suspended state so that's why we are using .resume to start the task
