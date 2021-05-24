//
//  ViewController.swift
//  Examen2
//
//  Created by Mac11 on 2021-05-24.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    // PickerView
    var genresData: [Genre] = []
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genresData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genresData[row].name
        }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
    inComponent component: Int) {
        filmsData = FilmDAO.shared.getFilms(genreId: row + 1)
        filmTableView.reloadData()
    }
    
    // TableView
    var filmsData: [Film] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = filmTableView.dequeueReusableCell(withIdentifier: "filmCell")!
        let rating: Float = (Float(self.filmsData[indexPath.row].likes) / Float(self.filmsData[indexPath.row].numberOfReviews)) * 100
        
        cell.textLabel?.text = self.filmsData[indexPath.row].title
        cell.detailTextLabel?.text = rating.description
                
        return cell
    }
    
    // Autre
    override func viewDidLoad() {
        super.viewDidLoad()
        genresData = FilmDAO.shared.getGenres()
        filmsData = FilmDAO.shared.getFilms(genreId: 1)
        // Do any additional setup after loading the view.
        
        /*
        print(FilmDAO.shared.getGenres().first?.name as Any)
        print(FilmDAO.shared.getFilms(genreId: 1) as Any)
        FilmDAO.shared.sendlike(filmId: 1, isLiked: true)
        */
        
        self.genrePicker.delegate = self
        self.genrePicker.dataSource = self
        self.filmTableView.delegate = self
        self.filmTableView.dataSource = self
    }

    @IBOutlet weak var genrePicker: UIPickerView!
    @IBOutlet weak var filmTableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "filmDetailsSegue" {
            let cell = (sender as? UITableViewCell)!
            let index = filmTableView.indexPath(for: cell)?.row
            let destination = segue.destination as? FilmDetailViewController
            destination?.film = filmsData[index!]
            destination?.genre = genresData[genrePicker.selectedRow(inComponent: 0)].name
        }
    }
}
