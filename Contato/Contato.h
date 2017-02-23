//
//  Contato.h
//  Contato
//
//  Created by Nando on 03/11/16.
//  Copyright © 2016 Nando. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreData/CoreData.h>

@interface Contato : NSManagedObject<MKAnnotation>

@property (strong) NSString* nome;
@property (strong) NSString* endereco;
@property (strong) NSString* telefone;
@property (strong) NSString* site;
@property (strong) UIImage* foto;
@property (strong) NSNumber* latitude;
@property (strong) NSNumber* longitude;

-(instancetype)initWithNome:(NSString*)nome andEndereco:(NSString*)endereco andTelefone:(NSString*)telefone andSite:(NSString*)site;

@end
