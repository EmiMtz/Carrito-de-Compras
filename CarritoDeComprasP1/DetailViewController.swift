//
//  DetailViewController.swift
//  CarritoDeComprasP1
//
//  Created by Emiliano Alfredo Martínez Vázquez on 3/30/19.
//  Copyright © 2019 Emiliano Alfredo Martínez Vázquez All rights reserved.

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var boton: UIButton!
    @IBOutlet var tapTouch: UITapGestureRecognizer!
    @IBOutlet weak var nameProd: UILabel!
    @IBOutlet weak var imageProd: UIImageView!
    @IBOutlet weak var descriptionProd: UILabel!
    @IBOutlet weak var priceProd: UILabel!
    @IBOutlet weak var quantyProd: UITextField!
    var detailedProduct = Product()
    var firstViewController: ViewController?
    let minProducts: Int = 1
    let maxProducts: Int = 1000
    override func viewDidLoad() {
        super.viewDidLoad()
        quantyProd.delegate = self
     
        loadProps()
        // Do any additional setup after loading the view.
    }
    func loadProps() {
        nameProd.text = detailedProduct.name
        imageProd.image = UIImage(named: detailedProduct.imageName)
        descriptionProd.text = detailedProduct.description
        priceProd.text = String(detailedProduct.price)
        quantyProd.text = String(minProducts)
        //mostrando solo teclado numerico
        quantyProd.keyboardType = .numberPad
        //cambiando tema del teclado
        quantyProd.keyboardAppearance = .dark
        
        
        boton.layer.cornerRadius = boton.frame.size.width / 8
        imageProd.layer.cornerRadius = imageProd.frame.size.width / 8
    
       
    }
    func convertStringToInt(numbersCadena: String) -> Int{
        var numb: Int = 0
        if(numbersCadena.isEmpty){
            numb = 0
        }
        else{
            numb = Int(numbersCadena)!
        }
        return numb
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //se setea el textfield para solo paso de caracteres numericos por medio de teclado
        let onlyNumbers = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        if(onlyNumbers.isSuperset(of: characterSet)){
            //en esta variable almacenamos del textfield ... se suma el valor actual mas el valor que se esta escribiendo
            let numb: Int = convertStringToInt(numbersCadena: quantyProd.text!+string)
            //bloqueamos la edicion del textfield si el valor es mayor que el maximo o menor que el minimo
            if(numb<=maxProducts && numb>=minProducts){
                //se permite el paso de caracteres por teclado al textfield
                return true
            }
            else{
                //se bloquea el paso de caracteres por teclado al textfield
                return false
            }
        }
        else{
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //si el campo textfield esta vacio al terminar la edicion, se rellena con el minimo valor
        if(quantyProd.text!.isEmpty){
            quantyProd.text = String(minProducts)
            priceProd.text = String(detailedProduct.price)
        }else{
            let numb: Int = convertStringToInt(numbersCadena: quantyProd.text!)
            priceProd.text = String(detailedProduct.price*Double(numb))
        }
    }
    @IBAction func exitEdit(_ sender: UITapGestureRecognizer) {
        //se cierra teclado al dar click fuera
        view.endEditing(true)
    }


    @IBAction func mas(_ sender: UIButton) {
        var numb: Int = convertStringToInt(numbersCadena: quantyProd.text!)
        if(numb<maxProducts){
            numb += 1
        }
        else{
            numb = maxProducts
        }
        quantyProd.text = String(numb)
        priceProd.text = String(detailedProduct.price*Double(numb))
    }
    
    @IBAction func menos(_ sender: UIButton) {
        var numb: Int = convertStringToInt(numbersCadena: quantyProd.text!)
        if(numb>minProducts){
            numb -= 1
        }
        else{
            numb = minProducts
        }
        quantyProd.text = String(numb)
        
        priceProd.text = String(detailedProduct.price*Double(numb))
    }
    

    @IBAction func buy(_ sender: UIButton) {
        let product = Buy(name: detailedProduct.name, qty: Int(quantyProd.text!)!, price: detailedProduct.price)
        let alert = UIAlertController(title: "Compra de \(detailedProduct.name)", message: "Deseas agregarlo a tu carrito?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Atras", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "✅ Ok", style: .default, handler: { (action) in
            self.firstViewController?.buy.append(product)
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert,animated: true, completion: nil)
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
