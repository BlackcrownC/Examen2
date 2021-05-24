//
//  FilmDetailViewController.swift
//  Examen2
//
//  Created by Mac11 on 2021-05-24.
//

import UIKit

class FilmDetailViewController: UIViewController {

    var film: Film?
    var genre: String?
    @IBOutlet weak var titreLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var reviewSwitch: UISwitch!
    @IBAction func submitReview(_ sender: Any) {
        let alert = UIAlertController(title: "Posted review update", message: FilmDAO.shared.sendlike(filmId: film!.id, isLiked: reviewSwitch.isOn), preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titreLabel.text = film?.title
        genreLabel.text = genre
        dateLabel.text = film?.releaseDate
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
