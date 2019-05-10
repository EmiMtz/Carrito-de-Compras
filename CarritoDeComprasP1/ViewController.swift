//
//  ViewController.swift
//  CarritoDeComprasP1
//
//  Created by Emiliano Alfredo Martínez Vázquez on 3/30/19.
//  Copyright © 2019 Emiliano Alfredo Martínez Vázquez All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tabla: UITableView!
    @IBOutlet weak var carr: UIBarButtonItem!
    var firstViewController: ViewController?
    var buy : [Buy] = []
    var products: [Products] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        getProducts()
        setupUI()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        tabla.reloadData()
        getSaveCar()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = CustomTableViewCell(style: CustomTableViewCell.CellStyle.subtitle, reuseIdentifier: "celda")
        cell.textLabel?.text = products[indexPath.row].name
        cell.detailTextLabel?.text = products[indexPath.row].detail
        cell.imageView?.image = UIImage(named: products[indexPath.row].image)
        

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tabla.indexPathForSelectedRow
        if segue.identifier == "detail" {
            let detailView = segue.destination as? DetailViewController
            //se crea instancia de producto seleccionado
            let selectProduct = Product(name: products[indexPath!.row].name, description: products[indexPath!.row].description, detail: products[indexPath!.row].detail, imageName: products[indexPath!.row].image, price: products[indexPath!.row].price)
            //se carga la vista con el articulo seleccionado del tableview
            detailView?.detailedProduct = selectProduct
            detailView?.firstViewController = self
        }
        if segue.identifier == "carrito" {
            let carritoView = segue.destination as? CarrViewController
            carritoView?.firstViewController = self
        }
    }

    func setupUI(){
        
        tabla.separatorStyle = .singleLine
        tabla.rowHeight = 150.0
        tabla.backgroundColor = .clear
        
    }
    

    func getProducts(){
        let jsonDecod = JSONDecoder()
        
        if let path = Bundle.main.path(forResource: "DataBase", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try jsonDecod.decode(Results.self, from: data)
    
                var temp: [Products] = []
                for product in jsonObj.results{
                
                    temp.append(product)
                }
                products = temp
                
            } catch let error {
                print("error: \(error.localizedDescription)")
            }
        } else {
            print("Error al abrir archivo json")
        }
    }
    
    func getSaveCar(){
        var total: Double = 0.0
        for productsInCar in buy{
            total += productsInCar.price*Double(productsInCar.qty)
        }
        carr.title = String(buy.count) + " 🛒     Total: " + String(total)
        
        
    }
    
}

