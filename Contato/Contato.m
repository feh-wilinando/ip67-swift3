//
//  Contato.m
//  Contato
//
//  Created by Nando on 03/11/16.
//  Copyright © 2016 Nando. All rights reserved.
//

#import "Contato.h"
#import <CoreData/CoreData.h>
#import "Contato-swift.h"

@implementation Contato

@dynamic nome,telefone,endereco,site,latitude,longitude,foto;


//- (instancetype)init
//{
//    ContatoDAO* dao = [ContatoDAO new];
//    
//    NSManagedObjectContext* context = [[dao persistentContainer] viewContext];
//    
//    self = (Contato *)[NSEntityDescription insertNewObjectForEntityForName:@"Contato" inManagedObjectContext: context];
//    
//    return self;
//}

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
