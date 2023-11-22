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
            }
            .navigationTitle("Contacts")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText)
            .listStyle(.plain)
        }.onAppear(perform: {
            if contacts.isEmpty {
                do{
                    let marcoContact = Contact(name: "Marco")
                    modelContext.insert(marcoContact)
                    let ascanioContact = Contact(name: "Ascanio")
                    modelContext.insert(ascanioContact)
                    let lucaContact = Contact(name: "Luca")
                    modelContext.insert(lucaContact)
                    let giuliaContact = Contact(name: "Giulia")
                    modelContext.insert(giuliaContact)
                    let alessandroContact = Contact(name: "Alessandro")
                    modelContext.insert(alessandroContact)
                    let francescaContact = Contact(name: "Francesca")
                    modelContext.insert(francescaContact)
                    let simoneContact = Contact(name: "Simone")
                    modelContext.insert(simoneContact)
                    let martinaContact = Contact(name: "Martina")
                    modelContext.insert(martinaContact)
                    let davideContact = Contact(name: "Davide")
                    modelContext.insert(davideContact)
                    let saraContact = Contact(name: "Sara")
                    modelContext.insert(saraContact)
                    let matteoContact = Contact(name: "Matteo")
                    modelContext.insert(matteoContact)
                    let elisaContact = Contact(name: "Elisa")
                    modelContext.insert(elisaContact)
                    let paoloContact = Contact(name: "Paolo")
                    modelContext.insert(paoloContact)
                    let chiaraContact = Contact(name: "Chiara")
                    modelContext.insert(chiaraContact)
                    let federicoContact = Contact(name: "Federico")
                    modelContext.insert(federicoContact)
                    let gianlucaContact = Contact(name: "Gianluca")
                    modelContext.insert(gianlucaContact)
                    let salvatoreContact = Contact(name: "Salvatore")
                    modelContext.insert(salvatoreContact)
                    //                let ascanioGroup = Chat(seenByOther: false, unreadMessages: 2, chatType: .group, contact: nil, messages: [], dateCreated: .now)
                    //                salvatoreContact.createdChats.append(ascanioGroup)
                    //                modelContext.insert(ascanioGroup)
                    let myself = Contact(name: "me",isMyself: true)
                    modelContext.insert(myself)
                    try modelContext.save()
                }
                catch{
                    fatalError("\(error)")
                }
            }
        })
    }
}

#Preview {
    ContactsView()
}
