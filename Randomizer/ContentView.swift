//
//  ContentView.swift
//  Randomizer
//
//  Created by Josh Hubbard on 12/11/20.
//

import SwiftUI

struct ContentView: View {
    @State var items = [String]()
    @State var enteredText = ""
    var body: some View {
        VStack(alignment: .trailing, spacing: 15) {
          HStack() {
              // textfield and save/load button at top
            TextField("Enter text here",
                      text: $enteredText,
                      onCommit:  {
                        items.append(enteredText)
                        
                      }
            )
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(10)
            
            Button("Save/Load", action: {saveLoad()})
          }
          VStack() {
              // tableview and label above enter button
            if items.count > 0 {
                List(0..<items.count) { item in
                    Text("help")
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            } else {
                List(0..<10) { item in
                    Text("")
                }.listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 50))
            }
          }
          VStack() {
              // enter button
            Button ("Enter", action: {enterButtonAction()})
              HStack() {
                  // choose buttons
                Button ("Choose x1", action: {choose1ButtonAction()})
                Button ("Choose x5", action: {choose5ButtonAction()})
                Button ("Choose x10", action: {choose10ButtonAction()})
              }
              // clear button
            Button ("Clear", action: {clearButtonAction()})
          }
      }
    }
    func choose1ButtonAction() {
        if items.count > 0 {
            print(items.randomElement()!)
        }
        
    }
    func choose5ButtonAction() {    // this doesn't work yet
        if items.count > 0 {
            var choiceCount = [Int]()
            for _ in 0..<items.count {
                choiceCount.append(0)
            }
            
            var chosenItem = items.randomElement()
            for _ in 0..<5 {
                chosenItem = items.randomElement()
                for x in 0..<items.count {
                    if chosenItem == items[x] {
                        choiceCount[x] += 1
                    }
                }
            }
            
            for item in 0..<items.count {
                items[item] = "\(items[item]): \(choiceCount[item])"
            }
//            print(items.randomElement()!)
        }
        
    }
    func choose10ButtonAction() {
        if items.count > 0 {
            print(items.randomElement()!)
        }
        
    }
    func clearButtonAction() {
        items.removeAll()
    }
    func saveLoad() {
        
    }
    func enterButtonAction() {
        
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
