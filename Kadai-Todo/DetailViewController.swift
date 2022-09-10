//
//  DetailViewController.swift
//  Kadai-Todo
//
//  Created by Yui Ogawa on 2022/09/09.
//

import UIKit

class DetailViewController: UIViewController {

    var todo: Todo!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = todo.title
        contentLabel.text = todo.content
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "yyyy / MM / dd"
        dateLabel.text = dateFormatter.string(from: todo.date)
    }
    
    // 次の編集画面へデータを渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEditSegue" {
            guard let destination = segue.destination as? EditViewController else{
                fatalError("Failed to prepare DetailViewController.")
            }
            destination.todo = self.todo
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
