//
//  CarrViewController.swift
//  CarritoDeComprasP1
//
//  Created by Emiliano Alfredo Martínez Vázquez on 3/30/19.
//  Copyright © 2019 Emiliano Alfredo Martínez Vázquez All rights reserved.

import UIKit

class CarrViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var buttonComprar: UIButton!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var tabla: UITableView!
    @IBOutlet weak var back: UIButton!
    var firstViewController: ViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        tabla.delegate = self
        tabla.dataSource = self
        tabla.backgroundColor = .clear
        total.text = String(calTotal())
        // Do any additional setup after loading the view.
    }
    
    func calTotal () -> Double {
        var total: Double = 0.0
        for productsInCar in (firstViewController?.buy)! {
            total += productsInCar.price*Double(productsInCar.qty)
        }
        if (total == 0.0){
            buttonComprar.isEnabled = false
        }
        else {
            buttonComprar.isEnabled = true
        }
        return total
    }
    
    func exito() {
        let alert = UIAlertController(title: "Compra Realizada!", message: "Gracias por tu compra!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert,animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (firstViewController?.buy.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value2, reuseIdentifier: "celda")
     
        let articleTot = (firstViewController?.buy[indexPath.row].price)! * Double((firstViewController?.buy[indexPath.row].qty)!)
        cell.textLabel?.text = String((firstViewController?.buy[indexPath.row].qty)!) + " " + (firstViewController?.buy[indexPath.row].name)!
        cell.detailTextLabel?.text = "----------- Precio: " + String(articleTot)
        cell.backgroundColor = .clear
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Borar") { (action, sourceView, completionHandler) in
            self.firstViewController?.buy.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.total.text = String(self.calTotal())
            completionHandler(true)
        }
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfiguration
    }
    @IBAction func comprar(_ sender: UIButton) {
        let alert = UIAlertController(title: "Pagar", message: "Estas seguro de terminar tu compra?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Atras", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "✅ Si", style: .default, handler: { (action) in
            //here actions buy complete
            self.firstViewController?.buy.removeAll()
            self.total.text = String(self.calTotal())
            self.tabla.reloadData()
            self.exito()
        }))
        present(alert,animated: true, completion: nil)
     
    }
    @IBAction func cerrar(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
