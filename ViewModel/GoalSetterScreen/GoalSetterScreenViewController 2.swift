//
//  ChartGoalSetter.swift
//  SpendWiseApp
//
//  Created by Hieu Ha on 20/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation
import UIKit
import Charts

class ChartGoalSetterController: UIViewController {
    var chartRecord = GoalSetterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setChart()
    }
    
    @IBOutlet weak var PieChartView: PieChartView!
    
    func setChart()
    {
        chartRecord.setGoal(goal: 500)
        PieChartView.data = chartRecord.createPie()
        PieChartView.animate(yAxisDuration: 3.0, easingOption: .easeInBounce)
    }
}
