//
//  ContatoDAO.swift
//  Contato
//
//  Created by Nando on 03/11/16.
//  Copyright © 2016 Nando. All rights reserved.
//

import UIKit
import CoreData

class ContatoDAO: CoreDataUtil {
    
    
    private var contatos:[Contato]
    static private var daoInstance:ContatoDAO!
    
    
    override private init() {
        
        
        
        self.contatos = [Contato]()
        super.init()
        self.cargaInicial()
        self.carregaContatos()
        
    }
    
    static func sharedInstance() -> ContatoDAO {
        
        if self.daoInstance == nil {
            self.daoInstance = ContatoDAO()
        }
        
        return self.daoInstance
        
    }
    
    
    func novoContato() -> Contato {
        return NSEntityDescription.insertNewObject(forEntityName: "Contato", into: self.persistentContainer.viewContext) as! Contato
    }
    
    private func carregaContatos() {
        let busca = NSFetchRequest<Contato>(entityName: "Contato")
        let orderPorNome = NSSortDescriptor(key: "nome", ascending: true)
        
        busca.sortDescriptors = [orderPorNome]
        
        
        do {
            self.contatos = try self.persistentContainer.viewContext.fetch(busca)
        }catch let error as NSError {
            print("Fetch Falhou: \(error.localizedDescription)")
        }
        
    }
    
    private func cargaInicial(){
        let configuracoes = UserDefaults.standard
        let dadosInseridos = configuracoes.bool(forKey: "dados_inseridos")
        
        if !dadosInseridos {
            
            print("Carga inicial")
            
            let caelum = self.novoContato()
            caelum.nome = "Caelum SP"
            caelum.endereco = "Rua vergueiro, 3185, São Paulo - SP"
            caelum.telefone = "01155712751"
            caelum.site = "http://www.caelum.com.br"
            caelum.latitude = -23.5883034
            caelum.longitude = -46.632369
            
            self.saveContext()
            
            configuracoes.set(true, forKey: "dados_inseridos")
            
            configuracoes.synchronize()
        }
    }
    
    func adiciona(_ contato:Contato){
        contatos.append(contato)
        self.saveContext()
    }
    
    
    func findById(_ id:Int) -> Contato {
        return contatos[id]
    }
    
    func list() -> [Contato] {
        
        return self.contatos
    }
    
    
    func deleteById(_ id:Int){
        self.persistentContainer.viewContext.delete(contatos[id])
        self.contatos.remove(at: id)
        self.saveContext()
    }
    
    func IndexOf(_ contato:Contato) -> Int {
        contatos.removeLast()
        return contatos.index(of: contato)!
    }
    
    
}
