//
//  ViewController.swift
//  Kadai-Todo
//
//  Created by Yui Ogawa on 2022/09/09.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    // StoryBoardで扱うTableViewを宣言
    @IBOutlet var table: UITableView!
    
    // Realmの変数を宣言
    let realm = try! Realm()
    var todoArray: Results<Todo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.todoArray = realm.objects(Todo.self)

        // テーブルビューのデータソースメソッドを書く位置を指定
        table.dataSource = self
        // テーブルビューのデリゲートメソッドを書く位置を指定
        table.delegate = self
    }
    
    // セルの数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = todoArray[indexPath.row].title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy / MM / dd"
        cell?.detailTextLabel?.text = dateFormatter.string(from: todoArray[indexPath.row].date)
        return cell!
    }
    
    // セルが押されたときに呼ばれるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(String(indexPath.row))が呼ばれました")
    }
    
    // 次の遷移画面へデータを渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDatailSegue" {
            if let indexPath = table.indexPathForSelectedRow {
                guard let destination = segue.destination as? DetailViewController else{
                    fatalError("Failed to prepare DetailViewController.")
                }
                destination.todo = todoArray[indexPath.row]
            }
        }
    }
    
    // セルの反転を治す
    override func viewWillAppear(_ animated: Bool) {
        if let indexPath = table.indexPathForSelectedRow {
            table.deselectRow(at: indexPath, animated: true)
        }
        table.reloadData()
    }
    
    // 左スワイプ時の動作
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let d_todo = todoArray[indexPath.row]
        try! realm.write{
            realm.delete(d_todo)
        }
        table.deleteRows(at: [indexPath], with: .automatic)
    }
}
