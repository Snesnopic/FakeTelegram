//
//  ContactsView.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 19/11/23.
//

import SwiftUI
import SwiftData

struct ContactsView: View {
    @State var searchText = ""
    @Query(filter: #Predicate<Contact> { !($0.isMyself) },
           sort: [SortDescriptor(\Contact.name)] ) var contacts: [Contact]
    @Environment(\.modelContext) var modelContext
    var body: some View {
        NavigationStack{
            List(contacts.filter{ contact in
                return searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                contact.name.lowercased().contains(searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased())}){ contact in
                    HStack{
                        if contact.imageName != "DEFAULTIMAGE" {
                            Image(contact.imageName).resizable().frame(width: 40,height: 40).clipShape(Circle())
                        }
                        else {
                            Image(systemName: ChatTypeEnum.personal.defaultImage).frame(width: 40,height: 40).clipShape(Circle())
                        }
                        
                        VStack(alignment: .leading){
                            Text(contact.name)
                            Text("Something else...").font(.subheadline)
                        }
                        Spacer()
                    }
                    .listRowInsets(.none)
                    .accessibilityLabel("\(contact.name)")
                }
                .navigationTitle("Contacts")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $searchText)
                .listStyle(.plain)
        }
    }
}


#Preview {
    ContactsView()
}
