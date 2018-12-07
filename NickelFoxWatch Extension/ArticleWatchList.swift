//
//  ArticleWatchList.swift
//  NickelFoxWatch Extension
//
//  Created by Ruchin Somal on 07/12/18.
//  Copyright © 2018 Ruchin Somal. All rights reserved.
//

import WatchKit
import Foundation


class ArticleWatchList: WKInterfaceController {
    @IBOutlet weak var lblTitle: WKInterfaceLabel!
    @IBOutlet weak var lblSubTitle: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        lblTitle.setText("Watch kit extension")
        lblSubTitle.setText("Welcome to apple watch")
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
