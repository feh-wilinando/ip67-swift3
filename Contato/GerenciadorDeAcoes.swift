//
//  GerenciadorDeAcoes.swift
//  Contato
//
//  Created by Nando on 04/11/16.
//  Copyright © 2016 Nando. All rights reserved.
//

import UIKit

class GerenciadorDeAcoes: NSObject {

    let contato:Contato
    var controller:UIViewController!
    
    init(do contato:Contato) {
        self.contato = contato
    }
    
    
    func exibirAcoes(em controller:UIViewController){
        self.controller = controller
        
        let alertView = UIAlertController(title: self.contato.nome, message: nil, preferredStyle: .actionSheet)
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        
        let ligarParaContato = UIAlertAction(title: "Ligar", style: .default){ action in
            self.ligar()
        }
        
        let exibirContatoNoMapa = UIAlertAction(title: "Visualizar No Mapa", style: .default) { action in
            self.abrirMapa()
        }
        
        
        let exibirSiteDoContato = UIAlertAction(title: "Visualizar Site", style: .default){ action in
            self.abrirNavegador()
        }
        
        let exibeTemperatura = UIAlertAction(title: "Visualizar Temperatura", style: .default) { action in
            
            let myView = MyView(coder: <#T##NSCoder#>)
            
            
            let temperaturaController = TemperaturaViewController(nibName: "TemperaturaViewController", bundle: Bundle.main)
            temperaturaController.contato = self.contato
            
            controller.navigationController?.pushViewController(temperaturaController, animated: true)
        }
        
        alertView.addAction(cancelar)
        alertView.addAction(ligarParaContato)
        alertView.addAction(exibirContatoNoMapa)
        alertView.addAction(exibirSiteDoContato)
        alertView.addAction(exibeTemperatura)
        
        
        self.controller.present(alertView, animated: true, completion: nil)
        
    }
    
    
    private func ligar(){
        let device = UIDevice.current
        
        if device.model == "iPhone"{
            print("UUID \(device.identifierForVendor!)")
            abrirAplicativo(com: "tel:" + self.contato.telefone!)
        }else{
            let alert = UIAlertController(title: "Impossivel fazer Ligações", message: "Seu dispositivo não é um IPhone", preferredStyle: .alert)
            
            self.controller.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    
    private func abrirNavegador(){
        var url = contato.site!
        
        if !url.hasPrefix("http://") {
            url = "http://" + url
        }
        
        abrirAplicativo(com: url)
        
    }
    
    private func abrirMapa(){
        let url = ("http://maps.google.com/maps?q=" + self.contato.endereco!).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        abrirAplicativo(com: url)
        
    }
    
    
    private func abrirAplicativo(com url:String){
        
        
        UIApplication
            .shared
            .open(URL(string: url)!, options: [:]){
                (success) in
                print("Passei aquiiiii!!!")
                if (success){
                    print("\\o/")
                }else{
                    print("/o\\")
                }
        }
        
    }
    
    
    
}
