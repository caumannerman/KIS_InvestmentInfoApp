//
//  SwiftUIChartView.swift
//  KIS_InvestmentInfoApp
//
//  Created by 양준식 on 2023/01/09.
//


import SwiftUI
import Charts

//struct SecurityInfo: Identifiable{
//    var id = UUID().uuidString
//
//    // 날짜정보 ex) 20221228
//    var basDt: String
//    // 종목코드
//    var strnCd: String
//    // 종목명 ex) 삼성전자
//    var itmsNm: String
//    // 상장된 시장명 KOSPI, KOSDAQ, KONEX 중 하나mrktCtg
//    var mrktCtg: String
//
//    //시가 ( 9시 )
//    var mkp: String
//    //종가
//    var clpr: String
//    //하루 중 최고가
//    var hipr: String
//    //하루 중 최저가
//    var lopr: String
//}


//struct SiteView: Identifiable{
//    var id = UUID().uuidString
//    var hour: Date
//    var views: Double
//    var animate: Bool = false
//}


struct SwiftUIChartView: View {
    
    @State var securityName: String
    @State var securityInfoArr: [SecurityInfo] = []
    
    @State var sampleAnalytics: [SiteView] = sample_analytics
    // MARK: View Properties
    @State var currentTab: String = "종가"
    // MARK: Gesture Properties
    @State var currentActiveItem: SiteView?
    @State var plotWidth: CGFloat = 0
    
    @State var isLineGraph: Bool = false
    
    init(title: String ,securityArr: [SecurityInfo]){
        self._securityName = State<String>(initialValue: title)
        self._securityInfoArr = State<[SecurityInfo]>(initialValue: securityArr)
        
        for i in securityArr{
            print("su에서!!!!!!!!!!!!")
            print(i)
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                // MARK: New Chart API
                VStack(alignment: .leading, spacing: 12){
                    HStack{
                        // MARK: 시장 이름
                        Text(securityInfoArr[0].mrktCtg)
                            .fontWeight(.semibold)
                        Picker("", selection: $currentTab){
                            Text("종가")
                                .tag("종가")
                            Text("최저가")
                                .tag("최저가")
                            Text("최고가")
                                .tag("최고가")
                        }
                        .pickerStyle(.segmented)
                        .padding(.leading, 80)
                    }
                    
                    let totalValue = sampleAnalytics.reduce(0.0){ partialResult, item in
                        item.views + partialResult
                    }
                    // MARK: 여기 원래 totalValue.stringFormat이었음
                    Text(securityName)
                        .font(.largeTitle.bold())
                    
                    AnimatedChart()
                }
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white.shadow(.drop(radius: 2)))
                }
                
                Toggle("Line Graph", isOn: $isLineGraph)
                    .padding(.top)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding()
            .navigationTitle("주식 정보")
            //MARK: Simply Updating values for segmented Tabs
            .onChange(of: currentTab){ newValue in
                sampleAnalytics = sample_analytics
                if newValue != "종가"{
                    for (index, _) in sampleAnalytics.enumerated(){
                        sampleAnalytics[index].views = .random(in: 1500...10000)
                    }
                }
                // Re-Animating View
                animateGraph(fromChange: true)
            }
        }
    }
    
    @ViewBuilder
    func AnimatedChart()->some View{
        let max = sampleAnalytics.max{ item1, item2 in
            return item2.views > item1.views
        }?.views ?? 0
        
        Chart{
            ForEach(sampleAnalytics){ item in
                
                //MARK: Bar Graph
                // MARK: Animating Graph
                if isLineGraph{
                    LineMark(x: .value("Day", item.hour, unit: .day),
                            y: .value("종가", item.animate ? item.views : 0)
                    )
                    // MARK: 그래프를 곡선으로
                    .interpolationMethod(.catmullRom)
                    
                } else {
                    BarMark(x: .value("Day", item.hour  , unit: .hour),
                            y: .value("종가", item.animate ? item.views : 0)
                    )
                }
                
                if isLineGraph {
                    AreaMark(x: .value("Day", item.hour, unit: .hour),
                            y: .value("종가", item.animate ? item.views : 0)
                    )
                    .foregroundStyle(Color("Blue").opacity(0.1).gradient)
                    // MARK: 그래프를 곡선으로
                    .interpolationMethod(.catmullRom)
                }
                
                
                // Applying Gradient Style
                // From SwiftUI 4.0 We can directly Craete Gradient from color
                // MARK: Rule Mark For Currently Dragging Item
                if let currentActiveItem, currentActiveItem.id == item.id{
                    RuleMark(x: .value("Hour", currentActiveItem.hour))
                    // Dotted Style
                        .lineStyle(.init(lineWidth: 2, miterLimit: 2, dash: [2], dashPhase: 5))
                    // MARK: Setting In middle of each bars
                        .offset(x: (plotWidth / CGFloat(sampleAnalytics.count)) / 2)
                        .annotation(position: .top){
                            VStack(alignment: .leading, spacing: 6){
                                Text("value")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text(currentActiveItem.views.stringFormat)
                                    .font(.title3.bold())
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background{
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .fill(.white.shadow(.drop(radius: 2)))
                            }
                        }
                }
                
            }
        }
        .chartYScale(domain: 0...(max + 5000))
        // MARK: Gesture To Hilight Current Bar
        .chartOverlay(content: { proxy in
            GeometryReader{ innerProxy in
                Rectangle()
                    .fill(.clear).contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .onChanged{ value in
                                // MARK: Getting Current Location
                                let location = value.location
                                // Extracting Value From the location
                                //Swift Charts Gives the direct Ability to do that
                                //going to Extract the Date in A-Axis then with the help of That Date Value We-re extracting the current Item
                                
                                //Don't forget to include the perfect Data Type
                                if let date: Date = proxy.value(atX: location.x){
                                    // Extracting Hour
                                    let calendar = Calendar.current
                                    let hour = calendar.component(.hour, from: date)
                                    if let currentItem = sampleAnalytics.first(where: { item in
                                        calendar.component(.hour, from: item.hour) == hour
                                        
                                    }){
//                                        print(currentItem.views)
                                        self.currentActiveItem = currentItem
                                        self.plotWidth = proxy.plotAreaSize.width
                                    }
                                    print(hour)
                                }
                            }.onEnded{ value in
                                self.currentActiveItem = nil
                            }
                    
                    )
                
            }
            
        })
        .frame(height: 250)
        .onAppear{
            animateGraph()
        }
    }
    // MARK: Animating Graph
    func animateGraph(fromChange: Bool = false){
        for (index, _) in sampleAnalytics.enumerated(){
            //For some reason delay is not working
            // using Dispatch Queue Delay/
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * (fromChange ? 0.03 : 0.05)){
                withAnimation(fromChange ? .easeInOut(duration: 0.8): .interactiveSpring(response: 0.8, dampingFraction: 0.8, blendDuration:  0.8)){
                    sampleAnalytics[index].animate = true
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIChartView(title:  "종목 이름s", securityArr: [])
//        ContentView()
    }
}


// MARK: Extension To convert douvle to String with K,M Number Values

extension Double {
    var stringFormat: String{
        if self > 10000 && self < 999999{
            return String(format: "%.1fK", self / 1000).replacingOccurrences(of: ".0", with: "")
        }
        if self > 999999{
            return String(format: "%.1fM", self / 1000000).replacingOccurrences(of: ".0", with: "")
        }
        return String(format: "%.0f", self)
    }
}
