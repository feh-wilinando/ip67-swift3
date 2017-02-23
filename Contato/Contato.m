//
//  Contato.m
//  Contato
//
//  Created by Nando on 03/11/16.
//  Copyright © 2016 Nando. All rights reserved.
//

#import "Contato.h"


@implementation Contato

@dynamic nome,telefone,endereco,site,latitude,longitude,foto;

-(instancetype)initWithNome:(NSString *)nome andEndereco:(NSString *)endereco andTelefone:(NSString *)telefone andSite:(NSString *)site{
    
    
    Contato* contato = [Contato new];
    contato.nome = nome;
    contato.endereco = endereco;
    contato.telefone = telefone;
    contato.site = site;
    
    return contato;
}


-(NSString *)description{
    
    return [NSString stringWithFormat:@"{ Nome: %@ Telefone: %@ Endereço: %@ Site: %@ }",
                                        self.nome,
                                        self.telefone,
                                        self.endereco,
                                        self.site];
    
}


-(CLLocationCoordinate2D)coordinate{
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

-(NSString *)title{
    return self.nome;
}

-(NSString *)subtitle{
    return self.site;
}

@end
