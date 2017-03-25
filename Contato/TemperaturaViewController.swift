//
//  TemperaturaViewController.swift
//  Contato
//
//  Created by Nando on 23/03/17.
//  Copyright © 2017 Nando. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import AlamofireObjectMapper

class TemperaturaViewController: UIViewController {

    
    @IBOutlet weak var labelCondicaoAtual: UILabel!
    @IBOutlet weak var labelTemperaturaMinima: UILabel!
    @IBOutlet weak var labelTemperaturaMaxima: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var contato:Contato?
    
    let URL_BASE = "http://api.openweathermap.org/data/2.5/weather?APPID=db6e4ee50071d663e42d3dcf8da8a3d6&units=metric"
    let URL_BASE_IMAGE = "http://openweathermap.org/img/w/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let contato = self.contato {
            
            let params = [
                            "lat": contato.latitude,
                            "lon": contato.longitude
                          ]
            
            Alamofire
                .request(URL_BASE,parameters: params)
                .responseObject {  (response: DataResponse<Weather>) in
                    
                    if let weather = response.result.value {
                        
                        self.labelCondicaoAtual.text = weather.condition
                        self.labelTemperaturaMinima.text = weather.min.description + "º"
                        self.labelTemperaturaMaxima.text = weather.max.description + "º"
                        
                        if let image = URL(string: self.URL_BASE_IMAGE + weather.icon + ".png"){
                            self.imageView.af_setImage(withURL: image)
                        }
                        
                        self.labelCondicaoAtual.isHidden = false
                        self.labelTemperaturaMinima.isHidden = false
                        self.labelTemperaturaMaxima.isHidden = false
                        
                    }

                    
                }
            
            
        
//            if let endpoint = URL(string: URL_BASE + "&lat=\(contato.latitude ?? 0)&lon=\(contato.longitude ?? 0)") {
//                
//                let session = URLSession(configuration: .default)
//                print(endpoint)
//                let task = session.dataTask(with: endpoint) { (data, response, error) in
//                    if let httpResponse = response as? HTTPURLResponse {
//                        
//                        
//                        if httpResponse.statusCode == 200 {
//                         
//                            do{
//                                if let json = try JSONSerialization.jsonObject(with: data!, options:[]) as? [String:AnyObject] {
//                                    
//                                    let main = json["main"] as! [String:AnyObject]
//                                    let weather = json["weather"]![0] as! [String:AnyObject]
//                                    let temp_min = main["temp_min"] as! Double
//                                    let temp_max = main["temp_max"] as! Double
//                                    let icon = weather["icon"] as! String
//                                    let condicao = weather["main"] as! String
//                                    
//                                    
//                                    DispatchQueue.main.async {
//                                        
//                                        print(condicao)
//                                        print(temp_min)
//                                        print(temp_max)
//                                        print(icon)
//                                        
//                                        self.labelCondicaoAtual.text = condicao
//                                        self.labelTemperaturaMinima.text = temp_min.description + "º"
//                                        self.labelTemperaturaMaxima.text = temp_max.description + "º"
//                                        self.pegaImagem(icon)
//                                        
//                                        self.labelCondicaoAtual.isHidden = false
//                                        self.labelTemperaturaMinima.isHidden = false
//                                        self.labelTemperaturaMaxima.isHidden = false
//                                        
//                                        
//                                    }
//                                }
//                            }catch let erro as NSError {
//                                print(erro.localizedDescription)
//                            }
//                            
//                            
//                            
//                            
//                        }
//                    }
//                }
//                
//                task.resume()
//                
//            }
            
        }
    }

    private func pegaImagem(_ icon:String){
        if let endpoint = URL(string: URL_BASE_IMAGE + icon + ".png") {                
            self.imageView.af_setImage(withURL: endpoint)
            
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: endpoint){ (data, response, error) in
//                
//                if let httpResponse = response as? HTTPURLResponse {
//                 
//                    if httpResponse.statusCode == 200 {
//                        DispatchQueue.main.async {
//                            print("Exibindo Imagem")
//                            self.imageView.image = UIImage(data: data!)
//                        }
//                    }
//                }
//            }
//            
//            task.resume()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
