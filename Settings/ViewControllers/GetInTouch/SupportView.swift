//////////////////////////////////////////////////////////////////////////////////
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


import SwiftUI

struct SupportView: View {
    var body: some View {
      List {
        Section(header: Text("Tracker")) {
          HStack {
            Button {
              BKLinkActions.send(toGitHub: "blink/issues")
            } label: {
              Label("Known Issues", systemImage: "magnifyingglass")
            }
            
            Spacer()
            Text("").foregroundColor(.secondary)
          }
          HStack {
            Button {
              BKLinkActions.send(toGitHub: "blink/issues/new")
            } label: {
              Label("Report a Problem", systemImage: "plus")
            }
            
            Spacer()
            Text("").foregroundColor(.secondary)
          }
        }
        
        Section(header:Text("Contact us")) {
          HStack {
            Button {
              BKLinkActions.sendToEmailApp()
            } label: {
              Label("Email", systemImage: "mail")
            }
            
            Spacer()
            Text("support@blink.sh").foregroundColor(.secondary)
          }
          HStack {
            Button {
              BKLinkActions.sendToDiscordSupport()
            } label: {
              Label("Discord", systemImage: "ellipsis.bubble")
            }
            
            Spacer()
            Text("#support").foregroundColor(.secondary)
          }
        }
      }
      .listStyle(.grouped)
      .navigationTitle("Support")
    }
}
