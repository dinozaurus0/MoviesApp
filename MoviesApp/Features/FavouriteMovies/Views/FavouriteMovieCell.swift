//
//  FavouriteMovieCell.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 15.09.2022.
//

import SwiftUI

private struct Constants {
    private static let componentHex = 80.0/255.0
    internal static let borderColor = Color(red: componentHex, green: componentHex, blue: componentHex)
}

internal struct FavouriteMovieCell: View {
    // MARK: - Properties
    private let dataSource: PresentableFavouriteMovieCard
    private let didTapDislike: (UUID) -> Void

    // MARK: - Init
    internal init(dataSource: PresentableFavouriteMovieCard, didTapDislike: @escaping (UUID) -> Void) {
        self.dataSource = dataSource
        self.didTapDislike = didTapDislike
    }

    // MARK: - Body
    internal var body: some View {
        VStack {
            imageView
            textStacks
            ratingView
        }
        .border(Constants.borderColor, width: 2.0)
        .cornerRadius(5.0)
    }

    private var imageView: some View {
        Image(data: dataSource.image)?
            .resizable()
            .scaledToFit()
            .frame(height: 250.0)
    }

    private var textStacks: some View {
        VStack(spacing: 10.0) {
            Text(dataSource.title)
                .font(Font.title)
                .fontWeight(.bold)
                .lineLimit(1)
            Text(dataSource.description)
                .font(Font.body)
                .multilineTextAlignment(.leading)
                .lineLimit(5)
        }.padding(.horizontal, 10.0)
    }

    private var ratingView: some View {
        HStack(alignment: .center, spacing: 5.0) {
            Image("RatingImage")
                .resizable()
                .frame(width: 40.0, height: 40.0)
            Text(dataSource.rating)
            Spacer()
            Button {
                didTapDislike(dataSource.id)
            } label: {
                Image("DislikeImage")
                    .resizable()
                    .frame(width: 45.0, height: 45.0)
            }
        }
        .padding(.horizontal, 10.0)
        .padding(.bottom, 10.0)
    }
}

internal struct FavouriteMovieCell_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteMovieCell(dataSource: dataSource, didTapDislike: { _ in })
            .previewLayout(.fixed(width: 250, height: 450))
    }

    private static var dataSource = PresentableFavouriteMovieCard(
        id: UUID(),
        title: "Game of Thrones",
        description: "In the mythical continent of Westeros, several powerful families fight for control of the Seven Kingdoms. As conflict erupts in the kingdoms of men, an ancient enemy rises once again to threaten them all. Meanwhile, the last heirs of a recently usurped dynasty plot to take back their homeland from across the Narrow Sea.",
        image: loadImageData(from: loadImagePath(for: "GOTImage", type: "jpeg")),
        rating: "9.1")
}
