//
//  FormularioContatoDelegate.swift
//  Contato
//
//  Created by Nando on 03/11/16.
//  Copyright © 2016 Nando. All rights reserved.
//

import Foundation

protocol FormularioContatoDelegate {
    func contatoAdicionado(_ contato:Contato)
    func contatoAtualizado(_ contato:Contato)
}

