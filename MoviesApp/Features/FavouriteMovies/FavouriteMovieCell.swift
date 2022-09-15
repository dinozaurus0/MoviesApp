//
//  FavouriteMovieCell.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 15.09.2022.
//

import SwiftUI

internal struct FavouriteMovieCell: View {
    internal let dataSource: PresentableFavouriteMovieCard

    internal var body: some View {
        VStack {
            Text(dataSource.title)
                .font(Font.title)
                .fontWeight(.bold)
            Text(dataSource.description)
                .font(Font.body)
                .multilineTextAlignment(.center)
        }
    }
}

internal struct FavouriteMovieCell_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteMovieCell(dataSource: dataSource)
            .previewLayout(.fixed(width: 250, height: 300))
    }

    private static var dataSource = PresentableFavouriteMovieCard(
        title: "Game of Thrones",
        description: "In the mythical continent of Westeros, several powerful families fight for control of the Seven Kingdoms. As conflict erupts in the kingdoms of men, an ancient enemy rises once again to threaten them all. Meanwhile, the last heirs of a recently usurped dynasty plot to take back their homeland from across the Narrow Sea.",
        image: Data(),
        rating: 3.5)
}

/*
 if let filePath = Bundle.main.path(forResource: "imageName", ofType: "jpg"), let image = UIImage(contentsOfFile: filePath) {
     imageView.contentMode = .scaleAspectFit
     imageView.image = image
 }


 */
