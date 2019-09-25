//
//  SummaryViewController.swift
//  To-Do app
//
//  Created by Jason Mach on 9/10/19.
//  Copyright © 2019 Bang Mach. All rights reserved.
//

import UIKit
import Charts

class SummaryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,ExpandableHeaderViewDelegate {
    var chartRecord = ChartViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    var expenseTableisExpanded:Bool = false
    var incomeTableisExpanded:Bool = false
    
    var totalExpenseAmount:Float=0
    var totalIncomeAmount:Float=0
    let datePicker = UIDatePicker()
    
    var sections:[Section] = []
    
    
    private let viewModel = SummaryScreenViewModel()
    private var index:Int = 0
    private var itemInfo:(ids:[UUID], dates:[String], amounts:[String], itemTypes:[String], expenseTypes:[String], incomeTypes:[String], descriptions:[String])?
    
    private var ids:[UUID] = []
    private var dates:[String] = []
    private var amounts:[String] = []
    private var itemTypes:[String] = [] // "expense", "income"
    private var expenseTypes:[String] = []
    private var incomeTypes:[String] = []
    private var descriptions:[String] = []
    private var expenses:[(id:UUID, date:String, amount:String, itemType:String, expenseType:String, incomeType:String, description:String)] = []
    private var incomes:[(id:UUID, date:String, amount:String, itemType:String, expenseType:String, incomeType:String, description:String)] = []
    
    
    private (set) var now = Date()
    
    func getCurrentDate() ->Date  {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return now
    }
    
    private (set) var tomorrow = Date()
    
    func getTomorrowDate() ->Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return tomorrow+3600*24
        
    }
    
    
    
    
   // private var itemViewModel = ItemViewModel()
    //define a data structure to track when a section is open or close
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveDataFromDatabase()
        if ids.count > 1 {
            classifyItems()
        }
        addSection()
        updateChart()
//        chartRecord.updateDataForChart(dates: dates, amounts: amounts, itemTypes: itemTypes)
        
        tomorrow = now + 3600*24
        let formatter = DateFormatter()
        formatter.dateFormat = "E(dd/MM)"
        let timeString = "\(formatter.string(from: now))  -  \(formatter.string(from: tomorrow))"
        datePickerLabel.text = String(timeString)
        print("today is:  ")
        print(self.getCurrentDate())
        print(self.getTomorrowDate())
        
        // Set Data for Charts
        
        
        //let customDate = chartRecord.getDate()
        chartRecord.update(at: self.getCurrentDate(), income: 110, expense: 150)

        var instant = ChartViewModel()
        instant.addDate(day: 1)

//        let nextCustomDate = instant.getDate()
//        chartRecord.update(at: self.getTomorrowDate(), income: 200, expense: 300)
        
        chartRecord.updateDataForChart(dates: dates, amounts: amounts, itemTypes: itemTypes)
        
        setChart(from: self.getCurrentDate(), to: self.getTomorrowDate())
        
    }
    
    // Mark Core Data
    private func retrieveDataFromDatabase(){
        itemInfo = viewModel.getItemDataFromCoreData()
        
        ids = itemInfo!.ids
        dates = itemInfo!.dates
        amounts = itemInfo!.amounts
        itemTypes = itemInfo!.itemTypes
        expenseTypes = itemInfo!.expenseTypes
        incomeTypes = itemInfo!.incomeTypes
        descriptions = itemInfo!.descriptions
    }
    
    private func classifyItems() {
        print(ids.count)
        for index in 0...ids.count-1 {
            if itemTypes[index] == "income" {
                incomes.append((ids[index], dates[index], amounts[index], itemTypes[index], expenseTypes[index],
                                incomeTypes[index], descriptions[index]))
            } else if itemTypes[index] == "expense" {
                expenses.append((ids[index], dates[index], amounts[index], itemTypes[index], expenseTypes[index],
                                 incomeTypes[index], descriptions[index]))
            }
        }
    }
    
    private func addSection(){
        sections.append(Section(type: "Expense", items: expenses, expanded: true))
        sections.append(Section(type: "Income", items: incomes, expanded: true))
    }
    
    // MARK: -ITEM
    @IBAction func nextDayButton(_ sender: Any) {
        tomorrow = now + 3600*24
        let dayAfterTomorrow = now + 3600*48
        let formatter = DateFormatter()
        formatter.dateFormat = "E(dd/MM)"
        let timeString = "\(formatter.string(from: tomorrow))  -  \(formatter.string(from: dayAfterTomorrow))"
        datePickerLabel.text = String(timeString)
        now = tomorrow
        print("Next Button pressed")
        print(self.getCurrentDate())
        print(self.getTomorrowDate() )
        
        updateChart()
        chartRecord.updateDataForChart(dates: dates, amounts: amounts, itemTypes: itemTypes)
        setChart(from: self.getCurrentDate(), to:self.getTomorrowDate())
        
    }
    @IBAction func previousDayButton(_ sender: Any) {
        let yesterday = now - 3600*24
        let formatter = DateFormatter()
        formatter.dateFormat = "E(dd/MM)"
        let timeString = "\(formatter.string(from: yesterday))  -  \(formatter.string(from: now))"
        datePickerLabel.text = String(timeString)
        now = yesterday
        print("Previous Button pressed")
        //        print("Current Date: \(yesterday)" )
        print(self.getCurrentDate())
        
        updateChart()
        chartRecord.updateDataForChart(dates: dates, amounts: amounts, itemTypes: itemTypes)
        setChart(from: self.getCurrentDate(), to:self.getTomorrowDate())
    }
    
    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController2 else {return }
        
        menuViewController.modalPresentationStyle = .overFullScreen
        
        present(menuViewController, animated: false)
        
    }
    
    @IBOutlet weak var datePickerLabel: UILabel!
    
    @IBAction func datePickerBt(_ sender: UIButton) {
        print("datepicker button pressed")
        //        datePicker.datePickerMode = .date
        //        //assign date picker to our textfield
        //        //datePickerLabel.inputView = datePicker
        //        let toolbar = UIToolbar()
        //        toolbar.sizeToFit()
        //
        //        let doneButton = UIBarButtonItem(barButtonSystemItem:. done,target: nil, action: #selector(doneClicked))
        //        toolbar.setItems([doneButton],animated: true)
        //        //datePickerLabel.inputAccessoryView = toolbar
        //
        
        
    }
    @objc func doneClicked() {
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let timeString = "\(dateFormatter.string(from: Date() as Date))"
        datePickerLabel.text = String(timeString)
    }
    
    
    //Mark: gesture recognizer
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let delete = deleteAction(at: indexPath)
//        return UISwipeActionsConfiguration(actions: [delete])
//    }
//
//
//
//
//    func deleteAction(at indexPath:IndexPath)-> UIContextualAction{
//        let action = UIContextualAction(style: .destructive, title: "Delete"){
//            (action,view,completion) in
//            // let currentItem = self.itemViewModel.getItem(byIndex: indexPath.row)
//            //currentItem.remove(at indexPath.row)
//            self.tableView.deleteRows(at: [indexPath], with: .automatic)
//            //.items.remove(at: indexPath.row)
//        }
//        action.image = UIImage(imageLiteralResourceName: "Trash")
//        action.backgroundColor = .red
//        return action
//    }
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let complete = completeAction(at:indexPath)
//        return UISwipeActionsConfiguration(actions:[complete])
//    }
    
//    func completeAction(at indexPath:IndexPath) -> UIContextualAction {
//        let action = UIContextualAction(style: .destructive, title: "Delete"){
//            (action,view,completion) in
//
//            self.tableView.deleteRows(at: [indexPath], with: .automatic)
//            //.items.remove(at: indexPath.row)
//        }
//        action.image = UIImage(imageLiteralResourceName: "Check")
//        action.backgroundColor = .green
//        return action
//    }
//    
    
    
    @objc func viewTapped(gestureRecognizer: UIGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    
    
    // Table properties
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return sections[section].items.count
        if section == 0 {
            return expenses.count
        }
        else {
            return incomes.count
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (sections[indexPath.section].expanded) {
            return 44
        } else {
            return 0
        }
    }
    // add height for footer to make it easier to see
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 4
    }
    
    private func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderViewNew()
        header.customInit(type: sections[section].type, section: section, delegate: self)
        return header
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseCell", for: indexPath)
        let imageView = cell.viewWithTag(1000) as? UIImageView
        let itemDescription = cell.viewWithTag(1001) as? UILabel
        let itemAmount = cell.viewWithTag(1002) as? UILabel
        let itemDate = cell.viewWithTag(1003) as? UILabel
        
       
        //let record = indexPath.section == 0 ? viewModel.getRecord(index: indexPath.row): view
        
      
        
        let finance3 = indexPath.section == 0 ? getExpenseRecord(index: indexPath.row) : getIncomeRecord(index: indexPath.row)
        
        //let curr
        //         Configure the cell...
        if let imageView = imageView, let itemDescription = itemDescription, let itemDate = itemDate,let itemAmount = itemAmount  {// are you really you and not optional zombie (.)_(.)
            //let currentItem = finance
            let currentItem = finance3
            imageView.image = currentItem.image
            itemDescription.text = currentItem.description
            itemAmount.text = currentItem.amount
            itemDate.text = currentItem.date
        }
        
        return cell
    }
    
    func toggleSection(header: ExpandableHeaderViewNew, section: Int) {
        sections[section].expanded = !sections[section].expanded
        print("toggle pressed")
        // next we gonna reload the row in the table view and depend on the size of item array
        tableView.beginUpdates()
        for i in 0 ..< sections[section].items.count {
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .middle)
        }
        tableView.endUpdates()
    }
    
    
    
    
    
    //Mark: gesture recognizer
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedRow = self.tableView.indexPathForSelectedRow else {return}
        //n set the informtation to where are you going
        let destination = segue.destination as? ItemDetailViewController
        // have access to selectedCharacter in LKDetailViewController
        let selectedColumn = selectedRow.section
        
        if selectedColumn == 0 {
            let  selectedItem = getExpenseRecord(index: selectedRow.row)
            destination?.selectedItem = selectedItem
            
        }
        else
        {
            let  selectedItem = getIncomeRecord(index: selectedRow.row)
            destination?.selectedItem = selectedItem
        }
    }
    
    // MARK: - BarChart
    @IBOutlet weak var BarChartView: BarChartView!
    
    func setChart(from fromDay: Date, to toDay: Date)
    {
        BarChartView.noDataText = "You need to provide data"
        
        let ChartData = chartRecord.createBar(fromDay: fromDay, toDay: toDay)
        
        BarChartView.data = ChartData
        BarChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        BarChartView.xAxis.labelPosition = .bottom
        //BarChartView.groupBars(fromX: 0, groupSpace: 2, barSpace: 0)
        BarChartView.isUserInteractionEnabled = false
    }
    
//    var instantDate = CustomDate()
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "dd/MM/yyyy"
//
//    for date in dates {
//    instantDate.setDate(date: dateFormatter.date(from: date)!)
//    record.update(day: instantDate.getDate(), income: totalIncome, expense: totalExpense)
//    }
    
    func updateChart() {
//        var final: [Date: (Double, Double)] = [:]
//
//
//        var instantDate = CustomDate()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd/MM/yyyy"
//
//        var totalIncome: Double = 0
//        var totalExpense: Double = 0
//
//        for index in 0..<dates.count {
//            instantDate.setDate(date: dateFormatter.date(from: dates[index])!)
//
//            let coreDate = expenses[index].date
//
//            for item in expenses {
//                if item.date == coreDate {
//                    totalExpense += Double(item.amount) ?? 0.0
//                    print("expense")
//                    print(totalExpense)
//                }
//            }
//
//            final.updateValue((totalIncome, totalExpense), forKey: instantDate.getDate())
//            print("final is")
//            print(final)
//            }
//
//        for index in 0..<dates.count {
//            instantDate.setDate(date: dateFormatter.date(from: dates[index])!)
//
//            let coreDate = incomes[index].date
//
//                for item in incomes {
//                    if item.date == coreDate {
//                        totalIncome += Double(item.amount) ?? 0.0
//                        print("income")
//                        print(totalIncome)
//                    }
//
//            final.updateValue((totalIncome, totalExpense), forKey: instantDate.getDate())
//            print("final is")
//            print(final)
//        }
//
//
//        }
//
//        for item in final {
//            chartRecord.update(at: item.key, income: item.value.0, expense: item.value.1)
//            print(chartRecord.getRecord())
//        }
        
    }
    
    
    func getExpenseRecord(index: Int) -> (description:String,amount:String,date:String,image:UIImage?) {
        
        
        let description = expenses[index].description
        let amount = expenses[index].amount
        //let amountFloat = Float(amount) ?? 0
        let date = expenses[index].date
        let category = expenses[index].expenseType
        
        let image:UIImage
        //let category = info.itemTypes[index]
        //var image:UIImage
        switch category {
        case "food":
            image = UIImage(named: "food-icon")!
        case "drink":
            image = UIImage(named: "drink-icon")!
        case "medication":
            image = UIImage(named: "medication-icon")!
        case "education":
            image = UIImage(named: "education-icon")!
        case "transportation":
            image = UIImage(named: "transportation-icon")!
        case "rent":
            image = UIImage(named: "rent-icon")!
        case "utilities":
            image = UIImage(named: "utilites-icon")!
        case "others":
            image = UIImage(named: "others-icon")!
        default:
            image = UIImage(named: "no-image")!
        }
        
        
        return (description,amount,date,image)
        
        
        
    }
    func getIncomeRecord(index: Int) -> (description:String,amount:String,date:String,image:UIImage?) {
        
        
        let description = incomes[index].description
        let amount = incomes[index].amount
        //let amountFloat = Float(amount) ?? 0
        let date = incomes[index].date
        let category = incomes[index].incomeType
        
        let image:UIImage
        //let category = info.itemTypes[index]
        //var image:UIImage
        switch category {
        case "salary":
            image = UIImage(named: "salary-icon")!
        case "donation":
            image = UIImage(named: "donation-icon")!
        case "others":
            image = UIImage(named: "others-icon")!
        default:
            image = UIImage(named: "icon-2")!
        }
        //        case .salary: return "salary-icon"
        //        case .donation: return "donation-icon"
        //        case .others: return "others-icon"
        //        case .none: return "No image"
        
        
        return (description,amount,date,image)
    }
    
}