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
        ZStack {
            Image(data: dataSource.image)?
                .resizable()
            VStack {
                Spacer()
                textStacks
                ratingView
            }
        }
    }

    private var textStacks: some View {
        VStack(spacing: 10.0) {
            Text(dataSource.title)
                .font(Font.title)
                .fontWeight(.bold)
            Text(dataSource.description)
                .font(Font.body)
                .multilineTextAlignment(.center)
        }.foregroundColor(.white)
    }

    private var ratingView: some View {
        HStack(spacing: 0.0) {
            Spacer()
            Image("Rating")
                .resizable()
                .scaledToFit()
                .frame(width: 35.0, height: 35.0)
            Text(dataSource.rating)
                .padding(.trailing, 20.0)
                .foregroundColor(.white)
        }
    }
}

internal struct FavouriteMovieCell_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteMovieCell(dataSource: dataSource)
            .previewLayout(.fixed(width: 250, height: 450))
    }

    private static var dataSource = PresentableFavouriteMovieCard(
        title: "Game of Thrones",
        description: "In the mythical continent of Westeros, several powerful families fight for control of the Seven Kingdoms. As conflict erupts in the kingdoms of men, an ancient enemy rises once again to threaten them all. Meanwhile, the last heirs of a recently usurped dynasty plot to take back their homeland from across the Narrow Sea.",
        image: imageData,
        rating: "9.1")

    private static var imageData = UIImage(contentsOfFile: imagePath)?.pngData() ?? Data()

    private static var imagePath = Bundle.main.path(forResource: "GOTImage", ofType: "jpeg") ?? ""
}
