//
//  TestViewController.swift
//  coredatatest
//
//  Created by nohjaesuk on 2018. 8. 11..
//  Copyright © 2018년 nohjaesuk. All rights reserved.
//

import UIKit
import CoreData

class TestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var managedObjectContext: NSManagedObjectContext?
    var tableView = UITableView()
    let cellId = "cellId"
    
    // The fetched results controller instance variable with the
    // pretended entity type we want to fetch from the Core Data.
    var _fetchedResultsController: NSFetchedResultsController<UserMetaData>? = nil
    
    // The proxy variable to serve as a lazy getter to our
    // fetched results controller.
    lazy var fetchedResultsController: NSFetchedResultsController<UserMetaData> =
    {
        // If the variable is already initialized we return that instance.
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
//        let context = self.persistentContainer.viewContext
//        let afetchRequest: NSFetchRequest<User> = User.fetchRequest()
//        afetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
//        afetchRequest.predicate = NSPredicate(format: "name == %@", "friend2")
//        do {
//            let results = try self.managedObjectContext?.fetch(afetchRequest)
//            if results?.count != 0 {
//                results![0].name = "myself"
//            } else {
//                print("result 0")
//            }
//            try self.managedObjectContext?.save()
//        } catch {
//            print("error")
//        }
//
        // If not, lets build the required elements for the fetched
        // results controller.
        
        // First we need to create a fetch request with the pretended type.
//        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let fetchRequest: NSFetchRequest<UserMetaData> = UserMetaData.fetchRequest()
        fetchRequest.relationshipKeyPathsForPrefetching = ["user"]
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "identity", ascending: false), NSSortDescriptor(key: "user.name", ascending: true)]
        
        // Set the batch size to a suitable number (optional).
        fetchRequest.fetchBatchSize = 20
        
        // Create at least one sort order attribute and type (ascending\descending)
//        let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
//
//        // Set the sort objects to the fetch request.
//        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Optionally, let's create a filter\predicate.
        // The goal of this predicate is to fetch Tasks that are not yet completed.
//        let predicate = NSPredicate(format: "completed == FALSE")
        
        // Set the created predicate to our fetch request.
//        fetchRequest.predicate = predicate
        
        // Create the fetched results controller instance with the defined attributes.
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        
   
        print(aFetchedResultsController.sectionIndexTitle(forSectionName: "aa"))
//        aFetchedResultsController.section(forSectionIndexTitle: "friends", at: 0)
//        aFetchedResultsController.section(forSectionIndexTitle: "me", at: 1)
//        aFetchedResultsController.sections.
        // Set the delegate of the fetched results controller to the view controller.
        // with this we will get notified whenever occurs changes on the data.
        aFetchedResultsController.delegate = self
        
        // Setting the created instance to the view controller instance.
        _fetchedResultsController = aFetchedResultsController
        
        do {
            // Perform the initial fetch to Core Data.
            // After this step, the fetched results controller
            // will only retrieve more records if necessary.
            try _fetchedResultsController!.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }()
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        // Whenever a change occurs on our data, we refresh the table view.
        self.tableView.reloadData()
    }
    
    private let persistentContainer = NSPersistentContainer(name: "coredatatest")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //delete
//        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
//        if let result = try? managedObjectContext?.fetch(fetchRequest) {
//            for object in result! {
//                managedObjectContext?.delete(object)
//            }
//        }
        
//        let newUser = User(context: managedObjectContext!)
//        newUser.id = "1"
//        newUser.name = "ariend3"
//        newUser.voice = true
//        newUser.status = "aa"
//        newUser.image = "aa"
//        newUser.background = "aa"
//        
//        let userMetaData = UserMetaData(context: managedObjectContext!)
//        userMetaData.identity = "friend"
//        userMetaData.following = false
//        userMetaData.vollowing = false
//        newUser.metadata = userMetaData
//
//        do {
//            try managedObjectContext?.save()
//        } catch {
//            print("Failed saving")
//        }
        print("start")
        view.addSubview(tableView)
        setupTableView()
    }
    private func setupTableView() {
        tableView.backgroundColor = UIColor.white
        tableView.separatorColor = UIColor.white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int
    {
        // We will use the proxy variable to our fetched results
        // controller and from that we try to get the sections
        // from it. If not available we will ignore and return none (0).
        print("section : \(self.fetchedResultsController.sections?.count)")
        return self.fetchedResultsController.sections?.count ?? 0
    }

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ((section == 0) ? "aaa" : "bbb")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let quotes = fetchedResultsController.fetchedObjects else { return 0 }
        return self.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath ) as! UserCell
        let userMetadata = self.fetchedResultsController.object(at: indexPath)
       
        
        // Configure Cell
        cell.nameLabel.text = userMetadata.user?.name
        cell.textBubble.text = userMetadata.user?.status
        cell.textBubble.sizeToFit()
        let textBubbleWidth = estimateFrame(text: (userMetadata.user?.status)!, width: 150, fontsize: 14).width + 24
        let textBubbleHeight = estimateFrame(text: (userMetadata.user?.status)!, width: 150, fontsize: 14).height + 12
        cell.textWidthAnchor?.constant = textBubbleWidth > 160 ? 160 : textBubbleWidth
        cell.textHeightAnchor?.constant = textBubbleHeight > 50 ? 50 : textBubbleHeight
        if userMetadata.user?.voice == true {
            print("black?")
            cell.musicButton.tintColor = UIColor.black
        } else {
            print("lightGray?")
            cell.musicButton.tintColor = UIColor.lightGray
        }

//        if let profileImageUrl = user.image {
//            cell.profileImageView.loadImageUsingLocalDirectoryWithUrlString(urlString: profileImageUrl, whichImage: "default")
//        }
        return cell
        
    }
    
    public func estimateFrame(text: String, width: CGFloat, fontsize: CGFloat) -> CGRect {
        
        let size = CGSize(width: width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontsize)], context: nil)
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return ["aaa", "bb"]
    }
    
    
}




