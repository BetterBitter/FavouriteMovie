//
//  CinemaAppTests.swift
//  CinemaAppTests
//
//  Created by Riko Pratama Laimena on 9/28/17.
//  Copyright © 2017 Riko Pratama Laimena. All rights reserved.
//

import XCTest
@testable import CinemaApp

class CinemaAppTests: XCTestCase {
    
    func testGetCurrentMovieMethod() {
        var arrayFakeMovies = [Movie]()
        var fakeMovie = Movie()

        fakeMovie.id = 123
        fakeMovie.imageUrl = "asdf"
        fakeMovie.overview = "empty"
        fakeMovie.release = "ABC"
        fakeMovie.title = "TEst1"
        arrayFakeMovies.append(fakeMovie)
        fakeMovie.id = 456
        fakeMovie.imageUrl = "abcd"
        fakeMovie.overview = "abcd"
        fakeMovie.release = "abcd"
        fakeMovie.title = "abcd"
        arrayFakeMovies.append(fakeMovie)
        
        let count = Model.get.movieCount(movies: arrayFakeMovies)
        XCTAssertEqual(count, 2)
        
    }
}
