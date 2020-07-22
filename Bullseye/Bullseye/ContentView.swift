//
//  ContentView.swift
//  Bullseye
//
//  Created by Josue on 1/13/20.
//  Copyright © 2020 Josue. All rights reserved.
//
import SwiftUI

struct ContentView: View {
  @State var alertShouldBeShown = true
  @State var alertIsVisible = false
  @State var sliderValue = 50.0
  @State var target = Int.random(in: 1...100)
  @State var score = 0
  @State var round = 1
  let midnightBlue = Color(red: 0.0/255.0, green:51.0/255.0,blue:102.0/255.0)
  var alert: Alert {
      Alert(title: Text("iOScreator"), message: Text("Hello SwiftUI"), dismissButton: .default(Text("Dismiss")))
  }
  //@State var alertKnockIsVisible: Bool = false
    struct LabelStyle: ViewModifier{
        func body(content: Content) -> some View{
            return content
         .foregroundColor(Color.white).modifier(Shadow()).font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    struct ValueStyle: ViewModifier{
        func body(content: Content) -> some View{
            return content
            .foregroundColor(Color.yellow).modifier(Shadow()).font(Font.custom("Arial Rounded MT Bold", size: 24))
        }
    }
    struct ButtonLargeTextStyle: ViewModifier{
        func body(content: Content) -> some View{
            return content
            .foregroundColor(Color.black).font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    struct ButtonSmallTextStyle: ViewModifier{
        func body(content: Content) -> some View{
            return content
            .foregroundColor(Color.black).font(Font.custom("Arial Rounded MT Bold", size: 12))
        }
    }

    struct Shadow: ViewModifier{
        func body(content: Content) -> some View{
            return content
            .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
  var body: some View {
    VStack {
        Text("").alert(isPresented: $alertShouldBeShown, content: {

            Alert(title: Text("Josue's Bullseye Game Instructions:"),
                  message: Text("Your goal is to place the slider as close as possible to the target value. The closer you are, the more points you score. Good Luck!"),
                  dismissButton: Alert.Button.default(
                    Text("OK"), action: {

                        //

                  }
                )
            )
        })
      Spacer()
      // Target row
        HStack {
            Text("Put the bullseye as close as you can to:").modifier(LabelStyle())
            Text("\(target)").modifier(ValueStyle())

        }
        Spacer()
      //Slider row
        HStack {
            Text("1")
            .modifier(LabelStyle())
            Slider(value: self.$sliderValue, in: 1...100).accentColor(Color.green)
            Text("100").modifier(LabelStyle())
        }
        Spacer()
      //Button row
      Button(action: {
        self.alertIsVisible = true
      }) {
        Text(/*@START_MENU_TOKEN@*/"Hit Me!"/*@END_MENU_TOKEN@*/).modifier(ButtonLargeTextStyle())
      }
      .alert(isPresented: $alertIsVisible) { () -> Alert in
        return Alert(title: Text(alertTitle()), message: Text("The slider's value is \(sliderValueRounded()).\n" + "You scored \(self.pointsforCurrentRound()) points this round."), dismissButton: .default(Text("Awesome!")){
            self.score += self.pointsforCurrentRound()
            self.target = Int.random(in: 1...100)
            self.round += 1
            })
        }
      .background(Image("Button")).modifier(Shadow())
        Spacer()
        //Score row
        HStack {
            Button(action: {
                self.startNewGame()
            }) {
                HStack {
                    Image("StartOverIcon")
                
                Text("Start Over").modifier(ButtonSmallTextStyle())
                }
            }
           .background(Image("Button")).modifier(Shadow())

            Spacer()
            Text("Score").modifier(LabelStyle())
            Text("\(score)").modifier(ValueStyle())

            Spacer()
            Text("Round").modifier(LabelStyle())
            Text("\(round)").modifier(ValueStyle())

            Spacer()
            NavigationLink(destination: AboutView()){
                HStack{
                   Image("InfoIcon")
                    Text("Info").modifier(ButtonLargeTextStyle())
                }
            }
            .background(Image("Button")).modifier(Shadow())

        }
        .padding(.bottom, 20)
    }
    .background(Image("Background"), alignment: .center)
  .accentColor(midnightBlue)
  .navigationBarTitle("Josue's Bullseye Game")
  }
    func sliderValueRounded() -> Int {
        return Int(sliderValue.rounded())
    }
    func amountOff() -> Int {
        abs(target - sliderValueRounded())
    }
    func pointsforCurrentRound() -> Int {
     let maximumScore = 100
     let bonus: Int
     if amountOff() == 0{
        bonus = 100
     } else if amountOff() == 1{
        bonus = 50
     } else{
      bonus = 0
     }
     return maximumScore - amountOff() + bonus
    }
    func alertTitle() -> String {
        let difference = amountOff()
        let title: String
        if difference == 0 {
            title = "Perfect!"
        } else if difference < 5 {
            title = "You almost had it!"
        } else if difference <= 10{
            title = "Not bad."
        } else {
            title = "Are you even trying?"
        }
        return title
    }
    func startNewGame() {
        score = 0
        round = 1
        sliderValue = 50.0
        target = Int.random(in: 1...100)
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
}
