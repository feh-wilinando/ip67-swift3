//
//  ViewController.swift
//  Contato
//
//  Created by Nando on 03/11/16.
//  Copyright © 2016 Nando. All rights reserved.
//

import UIKit
import CoreLocation

class FormularioContatoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {

    
    var contato:Contato!
    var dao:ContatoDAO!
    
    var delegate:FormularioContatoDelegate?
    
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var enderecoTextField: UITextField!
    @IBOutlet weak var telefoneTextField: UITextField!
    @IBOutlet weak var siteTextField: UITextField!
    
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        dao = ContatoDAO.sharedInstance()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.enderecoTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(selecionarFoto(_:)))
        self.imageView.isUserInteractionEnabled = true
        self.imageView.addGestureRecognizer(tap)
        self.imageView.layer.cornerRadius = 50.0
        self.imageView.clipsToBounds = true
        
        
        if contato != nil {
            nomeTextField.text = contato.nome
            enderecoTextField.text = contato.endereco
            telefoneTextField.text = contato.telefone
            siteTextField.text = contato.site
            latitudeTextField.text = contato.latitude!.description
            longitudeTextField.text = contato.longitude!.description
            
            if contato.foto != nil{
                self.imageView.image = self.contato.foto
            }
            
            let botaoAlterar = UIBarButtonItem(title: "Confirmar", style: .plain, target: self, action: #selector(atualizar))
            
            self.navigationItem.rightBarButtonItem = botaoAlterar
            
        }else{
            self.contato = dao.novoContato()
        }
    }
    
    //MARK: Foto
    @IBOutlet weak var botaoFoto: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func selecionarFoto(_ sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            let alert = UIAlertController(title: "Escolha foto do contato", message: self.contato.nome, preferredStyle: .actionSheet)
            
            
            let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            let tirarFoto = UIAlertAction(title: "Tirar Foto", style: .default){ (action) in
                imagePicker.sourceType =
                    .camera
            }
            
            let escolherFoto = UIAlertAction(title: "Escolher da biblioteca", style: .default){ (action) in
                imagePicker.sourceType = .photoLibrary
            }
            
            
            alert.addAction(cancelar)
            alert.addAction(tirarFoto)
            alert.addAction(escolherFoto)
            
            self.present(alert, animated: true, completion: nil)
            
            
        }else{
            imagePicker.sourceType = .photoLibrary            
        }
        
        self.present(imagePicker, animated: true, completion: nil)
        
        
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        let imagemSelecionada = info[UIImagePickerControllerEditedImage] as! UIImage
        self.imageView.image = imagemSelecionada
        
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    //MARK: Salvar
    @IBAction func salvar(){
        pegaContatoDoFormulario();
        
        dao.adiciona(self.contato)
        
        if delegate != nil {
            delegate?.contatoAdicionado(contato)
        }
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    func pegaContatoDoFormulario(){
        
        
        self.contato.foto = self.imageView.image
        
        
        self.contato.nome = nomeTextField.text
        self.contato.endereco = enderecoTextField.text
        self.contato.telefone = telefoneTextField.text
        self.contato.site = siteTextField.text
        self.contato.latitude = NSDecimalNumber(value: Double(latitudeTextField.text!)!)
        self.contato.longitude = NSDecimalNumber(value: Double(longitudeTextField.text!)!)
        
    }
    
    
    func atualizar(){
        pegaContatoDoFormulario();
        
        if delegate != nil {
            delegate?.contatoAtualizado(contato)
        }
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: buscando coordenadas
    
    @IBAction func buscaCordenadas(_ sender: UIButton) {
        
        self.spinner.startAnimating()
        
        sender.isEnabled = false
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(self.enderecoTextField.text!){ resultado, error in
        
            if error == nil && resultado!.count > 0 {
                let placemark = resultado![0]
                let coordenada = placemark.location!.coordinate
                
                self.latitudeTextField.text = coordenada.latitude.description
                self.longitudeTextField.text = coordenada.longitude.description                
            }
            
            self.spinner.stopAnimating()
            sender.isEnabled = true
        }
        
        
    }
    
    
    
    //MARK: - textfield delegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("DidEndEditing")
    }
    
}

