//
//  ViewController.swift
//  TableViewPractice
//
//  Created by Boris Goncharov on 11/5/20.
//

import UIKit

class TableViewController: UITableViewController {
    
    fileprivate let CELL_ID = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 228/255, green: 230/255, blue: 234/255, alpha: 1)
        
        setupTableView()
    }
    
    fileprivate var sections: [SectionData] = [
        SectionData(
            open: true,
            data: [
                CellData(id: "S_1001", title: "Twitter", featureImage: UIImage(named: "0")!),
                CellData(id: "S_1002", title: "Facebook", featureImage: UIImage(named: "1")!),
                CellData(id: "S_1003", title: "YouTube", featureImage: UIImage(named: "2")!)
            ]
        ),
        SectionData(
            open: true,
            data: [
                CellData(id: "S_1004", title: "Section", featureImage: UIImage(named: "0")!)
            ]
        ),
        SectionData(
            open: true,
            data: [
                CellData(id: "S_1005", title: "Section 2", featureImage: UIImage(named: "2")!),
                CellData(id: "S_1006", title: "Section 2", featureImage: UIImage(named: "1")!)
            ]
        ),
    ]
    
    fileprivate func setupTableView() {
        navigationItem.title = "Spots"
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(CardCell.self, forCellReuseIdentifier: CELL_ID)
    }
    
    // MARK: - Number of sections and rows
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !sections[section].open {
            return 0
        }
        return sections[section].data.count
    }
    
    // MARK: - Heigh or rows
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    // MARK: - Header in section
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton()
        button.tag = section
        button.setTitle("close", for: .normal)
        button.backgroundColor = UIColor(red: 238, green: 242, blue: 247, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(self.openSection), for: .touchUpInside)
        return button
    }
    
    @objc fileprivate func openSection(button: UIButton) {
        let section = button.tag

        var indexPaths = [IndexPath]()
        for row in sections[section].data.indices {
            let indexPathToDelete = IndexPath(row: row, section: section)
            indexPaths.append(indexPathToDelete)
        }
        
        let isOpen = sections[section].open
        sections[section].open = !isOpen
        
        button.setTitle(isOpen ? "open" : "close", for: .normal)
        
        if isOpen {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! CardCell
        let section = sections[indexPath.section]
        let cellData = section.data[indexPath.row]
        cell.cellData = cellData
        cell.animate()
        return cell
    }

    // MARK: - Context menu for 3D Touch
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let data = sections[indexPath.section].data[indexPath.row]
        
        let previewController = ImageController()
        previewController.data = data
        
        return UIContextMenuConfiguration(identifier: data.id as NSString, previewProvider: { previewController }) { _ in
            let shareAction = UIAction(
              title: "Share",
              image: UIImage(systemName: "square.and.arrow.up")) { _ in
                // share the task
            }
            let copyAction = UIAction(
              title: "Copy",
              image: UIImage(systemName: "doc.on.doc")) { _ in
                // copy the task content
            }
            let deleteAction = UIAction(
              title: "Delete",
              image: UIImage(systemName: "trash"),
              attributes: .destructive) { _ in
                // delete the task
            }
            return UIMenu(title: "", children: [shareAction, copyAction, deleteAction])
        }
    }
    
    // MARK: - Cell preview
    
    override func tableView(_ tableView: UITableView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        
//        guard let identifier = (configuration.identifier as? NSString) as String? else { return }
        
        let sectionsNum = sections.count
        var currentSection = Int()
        var currentCell = Int()
        
        for i in sectionsNum {
            for y in sections[i].data.count {
                if sections[i].data[y].id == configuration.identifier as! String {
                    currentSection = i
                    currentCell = y
                }
            }
        }
  
        let data = sections[currentSection].data[currentCell]
        
        animator.addCompletion {
            let previewController = ImageController()
            previewController.data = data
            self.showDetailViewController(previewController, sender: self)

            
        }
    }
}

extension Int: Sequence {
    public func makeIterator() -> CountableRange<Int>.Iterator {
        return (0..<self).makeIterator()
    }
}
