////////////////////////////////////////////////////////////////////////////////
//
// B L I N K
//
// Copyright (C) 2016-2019 Blink Mobile Shell Project
//
// This file is part of Blink.
//
// Blink is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Blink is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Blink. If not, see <http://www.gnu.org/licenses/>.
//
// In addition, Blink is also subject to certain additional terms under
// GNU GPL version 3 section 7.
//
// You should have received a copy of these additional terms immediately
// following the terms and conditions of the GNU General Public License
// which accompanied the Blink Source Code. If not, see
// <http://www.github.com/blinksh/blink>.
//
////////////////////////////////////////////////////////////////////////////////

import Foundation
import SwiftUI

struct LegacyMigrationView: View {
  var horizontal: Bool
  @ObservedObject var model: ReceiptMigrationProgress
  
  init(horizontal: Bool, model: ReceiptMigrationProgress) {
    self.horizontal = horizontal
    self.model = model
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      header()
      Spacer().frame(maxHeight: horizontal ? 20 : 30)
      rows()
      Spacer().frame(maxHeight: horizontal ? 20 : 54)
      HStack {
        Spacer()
        switch model.state {
        case .initial:
          EmptyView()
        case .done:
          Button("Continue") { model.openMigrationTokenUrl() }
          .buttonStyle(.borderedProminent)
        case .locatingReceipt, .validatingReceipt, .generatingMigrationToken:
          ProgressView()
        case .receiptFetchFailure:
          VStack {
            Text("Could not fetch the receipt for the app.")
            Button("Try Again") { model.load() }
            .buttonStyle(.borderedProminent)
          }
        case .requestFailure:
          VStack {
            Text("Error performing your migration request.")
            Button("Try Again") { model.load() }
            .buttonStyle(.borderedProminent)
          }
        case .migrationFailure(let err):
          VStack {
            Text(err.localizedDescription)
            VStack {
              Button("Try Again") { model.load() }
              .buttonStyle(.borderedProminent)
            }
          }
        }
        Spacer()
      }
      Spacer()
      HStack {
        Spacer()
        Button("Privacy Policy", action: {
          blink_openurl(URL(string: "https://blink.sh/pp")!)
        }).padding(.trailing)
        Button("Terms of Use", action: {
          blink_openurl(URL(string: "https://blink.sh/blink-gpl")!)
        }).padding(.trailing)
        Button("Help", action: {
          blink_openurl(URL(string: "https://blink.sh/docs")!)
        })
        Spacer()
      }
      .font(.footnote)
      .padding(.bottom, self.horizontal ? 32 : 40)
    }.padding()
      .frame(maxWidth: horizontal ? 700 : 460)
  }
  
  func header() -> some View {
    Group {
      Spacer()
      Text("Purchase validation")
        .fontWeight(.bold)
        .font(.largeTitle)
      
      Spacer().frame(maxHeight: horizontal ? 24 : 30)
      
      Text("Checking your app receipt with the AppStore")
        .font(.title2)
    }
  }
  
  func status() -> String {
    switch self.model.state {
    case .locatingReceipt: return "Locating receipt"
    case .validatingReceipt: return "Validating receipt"
    case .generatingMigrationToken: return "Generating migration token"
    case .done: return "All done"
    default: return ""
    }
  }
  
  func rows() -> some View {
    GroupBox() {
      CheckmarkRow(text: "Locating receipt within Blink Shell 14 app.", checked: model.receiptLocated, failed: model.state.receiptLocateFailed)
      Spacer().frame(maxHeight: 10)
      CheckmarkRow(text: "Validating receipt.", checked: model.receiptValidated, failed: model.state.receiptValidationFailed)
      Spacer().frame(maxHeight: 10)
      CheckmarkRow(text: "Generating migration token.", checked: model.migrationTokenGenerated)
    }
  }
}
