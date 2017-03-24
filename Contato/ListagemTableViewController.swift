//
//  ListagemTableViewController.swift
//  Contato
//
//  Created by Nando on 03/11/16.
//  Copyright © 2016 Nando. All rights reserved.
//

import UIKit

class ListagemTableViewController: UITableViewController, FormularioContatoDelegate {
    
    var dao:ContatoDAO
    var linhaDestacada: IndexPath?
    static let cellIdentifier:String = "Cell"
    
    
    
    // MARK: - Life Cycle
    required init?(coder aDecoder: NSCoder) {
        dao = ContatoDAO.sharedInstance()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(exibirMaisAcoes(gesture:)))
        self.tableView.addGestureRecognizer(longPress)
//        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if let linha = self.linhaDestacada {
            self.tableView.selectRow(at: linha, animated: true, scrollPosition: .middle)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                self.tableView.deselectRow(at: linha, animated: true)
                self.linhaDestacada = .none
            }
            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dao.list().count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ContatoTableViewCell
        
        let contato = dao.findById(indexPath.row)
        
        
        cell.nomeLabel?.text = contato.nome
        cell.fotoImageView.image = contato.foto
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            dao.deleteById(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contato = dao.findById(indexPath.row)
        
        exibeFormulario(contato)
        
    }
    
    // MARK: - segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if segue.identifier == "AddSegue" {
//            let point = segue.accessibilityActivationPoint
            
            
            if let formulario = segue.destination as? FormularioContatoViewController{
                formulario.delegate = self
            }
            
            
            
        }
        
    }
    
    
    func exibeFormulario(_ contato:Contato) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let formulario = storyBoard.instantiateViewController(withIdentifier: "Form-Contato") as! FormularioContatoViewController
        
        formulario.contato = contato
        formulario.delegate = self
        
        self.navigationController?.pushViewController(formulario, animated: true)
        
    }
    
    func contatoAdicionado(_ contato: Contato) {
        self.linhaDestacada = getIndexPath(of: contato)
    }
    
    
    func contatoAtualizado(_ contato: Contato) {
        self.linhaDestacada = getIndexPath(of: contato)
    }
    
    
    func getIndexPath(of contato:Contato) -> IndexPath {
        return IndexPath(row: dao.IndexOf(contato), section: 0)
    }
    
    func exibirMaisAcoes(gesture:UIGestureRecognizer){
        
        if gesture.state == .began {
            let point = gesture.location(in: self.tableView)
            
            
            if let indexPath = self.tableView.indexPathForRow(at: point){
                
                let contato = self.dao.findById(indexPath.row)
                let acoes = GerenciadorDeAcoes(do: contato)
                acoes.exibirAcoes(em: self)
                
            }
            
        }
        
        
    }
    
    

}
