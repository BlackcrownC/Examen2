//
//  Film.swift
//  Examen2
//
//  Created by Mac11 on 2021-05-24.
//

import Foundation

public class Film {
    internal init(id: Int, title: String, releaseDate: String, genreId: Int, posterURL: String, numberOfReviews: Int, likes: Int) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.genreId = genreId
        self.posterURL = posterURL
        self.numberOfReviews = numberOfReviews
        self.likes = likes
    }
    internal init(id: Int, title: String, releaseDate: String, genreId: Int, numberOfReviews: Int, likes: Int) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.genreId = genreId
        self.numberOfReviews = numberOfReviews
        self.likes = likes
        self.posterURL = ""
    }
    
    var id: Int
    var title: String
    var releaseDate: String
    var genreId: Int
    var posterURL: String
    var numberOfReviews: Int
    var likes: Int
}
