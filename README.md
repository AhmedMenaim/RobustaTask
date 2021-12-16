# RobustaTask

 ## First Commit 
 1. Creating the APIService class + Model:
 
   - In this commit I have used the native way in swift to retrieve the data from the API by using the **URLSession** and **Codable** 
   
    1.1 Simply created a shared instance to be able use the class functionality through it
   
    1.2 Created function and I returned the the response and the error in the completion , Make it escaping as I need it to be called after the function it was passed to returns
   
    1.3 Creating the API related vars/Constants like the url, urlSession, task
   
    1.4 Chcecking if there is an error, then checking if there is data existed
   
    1.5 Using try catch block to decode the response and completion on it or on an error if existed
   
    1.6 Once the task is created it supposed to be in suspended state so that's why we are using .resume to start the task
    
 2. Repo.swift

     2.1 Create owner struct with preperty for the owner name and adapt from Codable.
     
     2.2 Creat the main struct for the response which is called Repo and add the requested properies inside it ( Note: Can't find the date in the data passed )
  
  ## Second Commit
 3. Create the design for the tableView and it's functionalities
    
    3.1 Create a new nib file called **ReposViewController** to have a tableView and searchBar
    
    3.2 Take the outlets for these designs
    
    3.3 Set the tableViewDelegate and DataSource

    3.4 Call the functions of the tabkeView Delegate and DataSource

    3.5 Create a dummy xib cell to be used in the future

    3.6 In AppDelegate set the **ReposViewController** as the rootViewController
    
    3.7 Remove the Main.storyBoard file and remove it from the app general settings and from info.Plist as well
