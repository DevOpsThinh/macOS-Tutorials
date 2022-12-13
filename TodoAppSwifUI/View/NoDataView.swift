//
//  NoDataView.swift
//  TodoAppSwifUI
//
//  Created by Nguyễn Trường Thịnh on 05/12/2022.
//

import SwiftUI

struct NoDataView: View {
    // MARK: - SOME SORT OF VIEW
    var body: some View {
        Image("emptydata")
            .resizable()
            .scaledToFit()
    }
}

struct NoDataView_Previews: PreviewProvider {
    static var previews: some View {
        NoDataView()
    }
}
