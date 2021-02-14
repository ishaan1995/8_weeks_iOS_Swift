//
//  ViewController.swift
//  HelloWorld Networking
//
//  Created by Ishaan Kakkar on 14/02/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func refreshBtnClicked(_ sender: UIButton) {
        fetchWeather()
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func fetchWeather() {
        let session = URLSession.shared
        let url = URL(string: "https://www.metaweather.com/api/location/28743736")!
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            let httpResponse = response as? HTTPURLResponse
            if error != nil || httpResponse?.statusCode != 200 || data == nil {
                self.showErrorAlert(title: "Oops!", message: "Could not fetch weather. Please try again.")
                return
            }
            
            do {
                let weatherResponse = try JSONDecoder().decode(MetaWeatherResponse.self, from: data!)
                print("Place: \(weatherResponse.title), Country: \(weatherResponse.parent.title)")
                print(Int(weatherResponse.consolidatedWeather[0].minTemp))
                print(Int(weatherResponse.consolidatedWeather[0].maxTemp.rounded()))
                print(Int(weatherResponse.consolidatedWeather[0].theTemp.rounded()))
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
                self.showErrorAlert(title: "Oops!", message: "Invalid response. Please try again")
            }
        })
        task.resume()
    }
    
    func showErrorAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

