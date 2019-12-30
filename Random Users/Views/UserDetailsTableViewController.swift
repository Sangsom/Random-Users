//
//  UserDetailsTableViewController.swift
//  Random Users
//
//  Created by Rinalds Domanovs on 27/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import UIKit

class UserDetailsTableViewController: UITableViewController {

    var user: Person!
    var headerView: UserDetailsHeaderView!

    override func viewDidLoad() {
        super.viewDidLoad()


//        tableView.tableHeaderView = headerView
//        tableView.tableHeaderView?.backgroundColor = .red
        setupHeader()
    }

    func setupHeader() {
        headerView = UserDetailsHeaderView(frame: .zero, name: "Rinalds Domanovs")
        headerView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView = headerView

       // view.addSubview(headerView)

        let headerViewConstraints = [
            headerView.heightAnchor.constraint(equalToConstant: 50),
        ]

        NSLayoutConstraint.activate(headerViewConstraints)
    }
}

extension UserDetailsTableViewController {
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateHeaderViewHeight(for: tableView.tableHeaderView)
    }

    func updateHeaderViewHeight(for header: UIView?) {
        guard let header = header else { return }
        header.frame.size.height = header.systemLayoutSizeFitting(CGSize(width: view.bounds.width - 32.0, height: 0)).height
    }

}
