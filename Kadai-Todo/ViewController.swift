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
    var todoArray: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.todoArray = Array(realm.objects(Todo.self))

        // テーブルビューのデータソースメソッドを書く位置を指定
        table.dataSource = self
        // テーブルビューのデリゲートメソッドを書く位置を指定
        table.delegate = self
        
        // editButtonを配置
        navigationItem.leftBarButtonItem = editButtonItem
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
        if table.isEditing == false {
            print("\(String(indexPath.row))が呼ばれました")
        } else {
            print(table.indexPathsForSelectedRows!)
        }
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
        self.todoArray = Array(realm.objects(Todo.self))
        table.reloadData()
    }
    
    // 左スワイプ時の動作
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let d_todo = todoArray[indexPath.row]
        try! realm.write{
            realm.delete(d_todo)
        }
        self.todoArray = Array(realm.objects(Todo.self))
        table.reloadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        //override前の処理を継続してさせる
        super.setEditing(editing, animated: animated)
        //tableViewの編集モードを切り替える
        if table.isEditing {
            if let selectedRows = table.indexPathsForSelectedRows {
                var d_rowArray: [Todo] = []
                
                for d_row in selectedRows {
                    d_rowArray.append(todoArray[d_row[1]])
                }
                print(d_rowArray)
                try! realm.write {
                    realm.delete(d_rowArray)
                }
            }
            self.todoArray = Array(realm.objects(Todo.self))
            table.reloadData()
            table.isEditing = false
            editButtonItem.tintColor = UIColor.systemBlue
        } else {
            table.isEditing = editing
            editButtonItem.title = "delete"
            editButtonItem.tintColor = UIColor.red
        }
        print(table.isEditing)
    }
    
    // editing Modeのときは遷移しない
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if table.isEditing {
            return false
        } else {
            return true
        }
    }
    // 並び替えを可能にする
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
