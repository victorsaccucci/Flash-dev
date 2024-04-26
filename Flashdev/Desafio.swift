import SwiftUI

let timer = Timer
    .publish(every: 1, on: .main, in: .common)
    .autoconnect()

//class ProgressoStore: ObservableObject {
//    @Published var linguagensProgresso: [Linguagens] = []
//    @Published var progresso: Double = 0.0
//}

struct Desafio: View {
    
    @State var counter: Int = 0
    @State var respostaSelecionada: Int? = nil
    @State var currentQuestionIndex: Int = 0
    
   // @EnvironmentObject var progressoStore: ProgressoStore
    
    
    var totalQuestions: Int {
        linguagem.perguntas.count
    }
    
    var countTo: Int = 45
    
    let linguagem: Linguagens
    
    
    var progressPercentage: Double {
        let currentQuestion = Double(currentQuestionIndex + 1)
        let total = Double(totalQuestions)
        return (currentQuestion / total) * 100
    }
    
    var progressoBinding: Binding<Double> {
        Binding<Double>(
            get: { self.progressPercentage },
            set: { _ in }
        )
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(linguagem.linguagem)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading, 30)
                Spacer()
                VStack{
                    ZStack{
                        Circle()
                            .fill(Color.clear)
                            .frame(width: 40, height: 40)
                            .overlay(
                                Circle().stroke(Color.white, lineWidth: 25)
                            )
                        
                        Circle()
                            .fill(Color.clear)
                            .frame(width: 40, height: 40)
                            .overlay(
                                Circle().trim(from:0, to: progress())
                                    .stroke(
                                        style: StrokeStyle(
                                            lineWidth: 7,
                                            lineCap: .round,
                                            lineJoin:.round
                                        )
                                    )
                                    .foregroundColor(
                                        (completed() ? Color.red : Color.red)
                                    ).animation(
                                        .easeInOut(duration: 0.2)
                                    )
                            )
                        
                        Clock(counter: counter, countTo: countTo)
                    }
                }.onReceive(timer) { time in
                    if (self.counter < self.countTo) {
                        self.counter += 1
                    }
                }
                .padding(.trailing, 30)
            }
            HStack {
                Text("\(Int(progressPercentage))%")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding(.leading, 30)
                Spacer()
            }
            Divider()
                .background(Color.gray)
                .frame(maxWidth: .infinity)
                .padding(.leading, 30)
                .padding(.trailing, 30)
            
            VStack {
                ZStack {
                    Rectangle()
                                      .fill(
                                          LinearGradient(gradient: Gradient(colors: [Color(linguagem.colorDark), Color(linguagem.colorLight)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                      )
                                      .frame(width: 320, height: 260)
                                      .cornerRadius(20)
                                      .shadow(radius: 5)
                                      .padding(.top, 10)
                                      .shadow(radius: 2, y: 4)
                    
                    VStack {
                        HStack {
                            Text(linguagem.linguagem)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.top, 50)
                                .padding(.leading, 40)
                            Spacer()
                        }
                        HStack {
                            Text("Progresso:")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.leading, 40)
                            Text("\(currentQuestionIndex + 1)/\(totalQuestions)")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding()
                            Spacer()
                        }
                        Divider()
                            .background(Color.gray)
                            .frame(maxWidth: .infinity)
                            .padding(.leading, 40)
                            .padding(.trailing, 40)
                        Text(linguagem.perguntas[currentQuestionIndex].pergunta)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: 270)
                            .padding(.top, 8)
                        Spacer()
                    }
                }
                HStack {
                    Text("Selecione a opção correta: ")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.leading, 30)
                        .padding(.bottom, 8)
                    
                    Spacer()
                }
                VStack {
                    VStack {
                        HStack {
                            Button(action: {
                                if let resposta = linguagem.perguntas[currentQuestionIndex].respostas.first {
                                    self.respostaSelecionada = 0
                                    checkAnswer(resposta)
                                    print("Clicou no primeiro retângulo: \(resposta.valor)")
                                    
                                }
                            }) {
                                RectangleButtonView(resposta: linguagem.perguntas[currentQuestionIndex].respostas.first, isSelected: respostaSelecionada == 0, gradient: linguagem.gradient)
                                
                            }
                            
                            Button(action: {
                                if let resposta = linguagem.perguntas[currentQuestionIndex].respostas.dropFirst().first {
                                    self.respostaSelecionada = 1
                                    checkAnswer(resposta)
                                    print("Clicou no segundo retângulo: \(resposta.valor)")
                                    
                                }
                            }) {
                                RectangleButtonView(resposta: linguagem.perguntas[currentQuestionIndex].respostas.dropFirst().first, isSelected: respostaSelecionada == 1, gradient: linguagem.gradient)
                            }
                        }
                        HStack {
                            Button(action: {
                                if let resposta = linguagem.perguntas[currentQuestionIndex].respostas.dropFirst(2).first {
                                    self.respostaSelecionada = 2
                                    checkAnswer(resposta)
                                    print("Clicou no terceiro retângulo: \(resposta.valor)")
                                    
                                }
                            }) {
                                RectangleButtonView(resposta: linguagem.perguntas[currentQuestionIndex].respostas.dropFirst(2).first, isSelected: respostaSelecionada == 2, gradient: linguagem.gradient)
                            }
                            Button(action: {
                                if let resposta = linguagem.perguntas[currentQuestionIndex].respostas.dropFirst(3).first {
                                    self.respostaSelecionada = 3
                                    checkAnswer(resposta)
                                    print("Clicou no quarto retângulo: \(resposta.valor)")
                                    
                                }
                            }) {
                                RectangleButtonView(resposta: linguagem.perguntas[currentQuestionIndex].respostas.dropFirst(3).first, isSelected: respostaSelecionada == 3, gradient: linguagem.gradient)
                            }
                        }
                    }
                    .padding(.bottom, 20)
                    
                }
            }.padding(.top, 20)
            Spacer()
        }
    }
    
    
    
    func completed() -> Bool {
        return progress() == 1
    }
    
    func progress() -> CGFloat {
        return (CGFloat(counter) / CGFloat(countTo))
    }
    
    func nextQuestion() {
        if currentQuestionIndex < linguagem.perguntas.count - 1 {
            currentQuestionIndex += 1
            counter = 0
           // progressoStore.progresso = progressPercentage
        } else {
        }
    }
    
    
    func checkAnswer(_ resposta: Respostas) {
        if resposta.valor == true {
            nextQuestion()
        } else {
        }
    }
}

extension Linguagens {
    var gradient: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color(colorDark), Color(colorLight)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}


struct Clock: View {
    var counter: Int
    var countTo: Int
    
    var body: some View {
        VStack {
            Text(counterToMinutes())
                .font(.system(size: 10))
                .fontWeight(.black)
        }
    }
    
    func counterToMinutes() -> String {
        let currentTime = countTo - counter
        let seconds = currentTime % 60
        let minutes = Int(currentTime / 60)
        
        return "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
    }
}

struct RectangleButtonView: View {
    var resposta: Respostas?
    var isSelected: Bool
    let gradient: LinearGradient

    init(resposta: Respostas?, isSelected: Bool, gradient: LinearGradient) {
        self.resposta = resposta
        self.isSelected = isSelected
        self.gradient = gradient
    }

    var body: some View {
        let backgroundColor: Color = isSelected ? (resposta?.valor == true ? .green : .red) : .clear
        
        return Rectangle()
            .fill(backgroundColor)
            .frame(width: 150, height: 70)
            .background(gradient)
            .cornerRadius(8)
            .padding(2)
            .shadow(radius: 2, y: 4)
            .overlay (
                Text(resposta?.resposta ?? "")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)


        )
    }
}
//struct Desafio_Previews: PreviewProvider {
//    static var previews: some View {
//     
//         var pLinguagem : Linguagens =
//        Linguagens(
//            _id: "1597a59c797e5b7f238765f34f1bc592",
//            _rev: "1-eaf70256358bef2b381a2013cd8f96bf",
//            linguagem: "Python",
//            perguntas: [
//                Perguntas(pergunta: "Qual é a estrutura de dados básica para armazenar múltiplos itens em Python?",
//                          respostas: [
//                            Respostas(resposta: "Lista", valor: true),
//                            Respostas(resposta: "Dicionário", valor: false),
//                            Respostas(resposta: "Tupla", valor: false),
//                            Respostas(resposta: "Conjunto", valor: false)
//                          ]
//                         ),
//                Perguntas(pergunta: "Qual é a estrutura de dados básica para armazenar múltiplos itens em Python? 2",
//                          respostas: [
//                            Respostas(resposta: "Lista", valor: true),
//                            Respostas(resposta: "Dicionário", valor: false),
//                            Respostas(resposta: "Tupla", valor: false),
//                            Respostas(resposta: "Conjunto", valor: false)
//                          ]
//                         ),
//                Perguntas(pergunta: "Qual é a estrutura de dados básica para armazenar múltiplos itens em Python? 3",
//                          respostas: [
//                            Respostas(resposta: "Lista 2", valor: true),
//                            Respostas(resposta: "Dicionário", valor: false),
//                            Respostas(resposta: "Tupla", valor: false),
//                            Respostas(resposta: "Conjunto", valor: false)
//                          ]
//                         )
//            ],
//            flashcards: [
//                FlashCards(descricao: "Definição de função", hint:"Usando a palavra-chave 'def'"),
//                FlashCards(descricao: "Estrutura de dados básica 2 ", hint: "Lista"),
//                FlashCards(descricao: "Estrutura de dados básica 4", hint: "Lista 2")
//            ],
//            categoria: "backend",
//            colorDark: "PythonDark",
//            colorLight: "PythonLight",
//            imagem: "https://ojt.com/wp-content/uploads/2021/08/python-programming-language.png",
//            progresso: 0
//        )
//        
//        return Desafio(linguagem: pLinguagem)
//            .environmentObject(ProgressoStore())
//    }
//}
