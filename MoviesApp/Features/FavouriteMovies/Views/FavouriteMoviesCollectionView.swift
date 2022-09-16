//
//  FavouriteMoviesCollection.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 15.09.2022.
//

import SwiftUI

internal struct FavouriteMoviesCollectionView: View {
    private var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    internal let cards: [PresentableFavouriteMovieCard]

    internal init(cards: [PresentableFavouriteMovieCard]) {
        self.cards = cards
    }

    var body: some View {
        ScrollView() {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(cards) { card in
                    FavouriteMovieCell(dataSource: card)
                }
            }
        }
    }
}

internal struct FavouriteMoviesCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteMoviesCollectionView(cards: cards)
    }

    private static var cards = [
        PresentableFavouriteMovieCard(
            id: UUID(),
            title: "Vikings",
            description: "The adventures of a Ragnar Lothbrok: the greatest hero of his age. The series tells the saga of Ragnar's band of Viking brothers and his family as he rises to become King of the Viking tribes. As well as being a fearless warrior, Ragnar embodies the Norse traditions of devotion to the gods: legend has it that he was a direct descendant of Odin, the god of war and warriors.",
            image: loadImageData(from: loadImagePath(for: "VikingsImage", type: "jpg")),
            rating: "8.5"),
        PresentableFavouriteMovieCard(
            id: UUID(),
            title: "Game of Thrones",
            description: "In the mythical continent of Westeros, several powerful families fight for control of the Seven Kingdoms. As conflict erupts in the kingdoms of men, an ancient enemy rises once again to threaten them all. Meanwhile, the last heirs of a recently usurped dynasty plot to take back their homeland from across the Narrow Sea.",
            image: loadImageData(from: loadImagePath(for: "GOTImage", type: "jpeg")),
            rating: "9.1"),
        PresentableFavouriteMovieCard(
            id: UUID(),
            title: "Game of Thrones",
            description: "In the mythical continent of Westeros, several powerful families fight for control of the Seven Kingdoms. As conflict erupts in the kingdoms of men, an ancient enemy rises once again to threaten them all. Meanwhile, the last heirs of a recently usurped dynasty plot to take back their homeland from across the Narrow Sea.",
            image: loadImageData(from: loadImagePath(for: "GOTImage", type: "jpeg")),
            rating: "9.1"),
        PresentableFavouriteMovieCard(
            id: UUID(),
            title: "Vikings",
            description: "The adventures of a Ragnar Lothbrok: the greatest hero of his age. The series tells the saga of Ragnar's band of Viking brothers and his family as he rises to become King of the Viking tribes. As well as being a fearless warrior, Ragnar embodies the Norse traditions of devotion to the gods: legend has it that he was a direct descendant of Odin, the god of war and warriors.",
            image: loadImageData(from: loadImagePath(for: "VikingsImage", type: "jpg")),
            rating: "8.5")
    ]
}
