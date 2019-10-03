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
    private var chartRecord = ChartViewModel()
    private var instantDate = CustomDateViewModel()
    
    @IBOutlet private weak var tableView: UITableView!
    @IBAction private func addItemPressed(_ sender: Any) {
        performSegue(withIdentifier: "SummaryScreen_AddItemScreen", sender: self)
    }
    
    private var totalExpenseAmount:Float=0
    private var totalIncomeAmount:Float=0
    //private let datePicker = UIDatePicker()
    
    private var sections:[Section] = []
    
    
    private let viewModel = SummaryScreenViewModel()
    private var index:Int = 0
    private var itemInfo:(ids:[UUID], titles:[String] ,dates:[String], amounts:[String], types:[String], categories:[String], descriptions:[String])?
    
    private var ids:[UUID] = []
    private var titles:[String] = []
    private var dates:[String] = []
    private var amounts:[String] = []
    private var types:[String] = [] // "expense", "income"
    private var categories:[String] = []
    private var descriptions:[String] = []
    
    
    private var expenses:[(id:UUID, title:String, date:String, amount:String, type:String, category:String, description:String)] = []
    private var incomes:[(id:UUID, title:String, date:String, amount:String, type:String, category:String, description:String)] = []
    
    
    private (set) var now = Date()
    private (set) var tomorrow = Date()
    
    //define a data structure to track when a section is open or close
    fileprivate func setupDateComponent() {
        now = instantDate.getInstantDate()
        instantDate.addDate(day: 1)
        tomorrow = instantDate.getInstantDate()
        instantDate.addDate(day: -1)
        let formatter = DateFormatter()
        formatter.dateFormat = "E(dd/MM)"
        let timeString = "\(formatter.string(from: now))  -  \(formatter.string(from: tomorrow))"
        datePickerLabel.text = String(timeString)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveDataFromDatabase()
        if ids.count > 0  {
            classifyItems()
        }
        addSection() // set up sections and tableview for expenses and income items.
        
        setupDateComponent() // set up date formatter for date label
        // Set Data for Charts
        updateChart()
        
        setChart(from: now, to: tomorrow)
       
    }
    
    // Mark Core Data
    private func retrieveDataFromDatabase(){
        itemInfo = viewModel.retrieveItemInfo(username: TempData.usernameInput)
        
        ids = itemInfo!.ids
        titles = itemInfo!.titles
        dates = itemInfo!.dates
        amounts = itemInfo!.amounts
        types = itemInfo!.types
        categories = itemInfo!.categories
        descriptions = itemInfo!.descriptions
    }
    
    private func classifyItems() {
        for index in stride(from: ids.count - 1, to: -1, by: -1){
            if types[index] == CustomItemType.income.name {
                incomes.append((ids[index], titles[index], dates[index], amounts[index], types[index], categories[index], descriptions[index]))
            } else if types[index] == CustomItemType.expense.name  {
                expenses.append((ids[index], titles[index], dates[index], amounts[index], types[index], categories[index], descriptions[index]))
            }
        }
    }
    
    private func addSection(){
        sections.append(Section(type: "Expenses", items: expenses, expanded: true))
        sections.append(Section(type: "Incomes", items: incomes, expanded: true))
    }
    
    // MARK: -ITEM
    @IBAction private func nextDayButton(_ sender: Any) {
        instantDate.addDate(day: 1)
        now = instantDate.getInstantDate()
        instantDate.addDate(day: 1)
        tomorrow = instantDate.getInstantDate()
        instantDate.addDate(day:-1)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E(dd/MM)"
        let timeString = "\(formatter.string(from: now))  -  \(formatter.string(from: tomorrow))"
        datePickerLabel.text = String(timeString)
        
        setChart(from: now, to:tomorrow)
        
    }
    @IBAction private func previousDayButton(_ sender: Any) {
        tomorrow = instantDate.getInstantDate()
        instantDate.addDate(day: -1)
        now = instantDate.getInstantDate()
    
        let formatter = DateFormatter()
        formatter.dateFormat = "E(dd/MM)"
        let timeString = "\(formatter.string(from: now))  -  \(formatter.string(from: tomorrow))"
        datePickerLabel.text = String(timeString)
        
        setChart(from: now, to:tomorrow)
    }
    
    @IBAction private func didTapMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController2 else {return }
        
        menuViewController.modalPresentationStyle = .overFullScreen
        
        present(menuViewController, animated: false)
        
    }
    
    @IBOutlet private weak var datePickerLabel: UILabel!
    
    @objc func doneClicked() {
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let timeString = "\(dateFormatter.string(from: Date() as Date))"
        datePickerLabel.text = String(timeString)
    }
    
    
    //Mark: gesture recognizer
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.section == 0 {
                let itemID = self.expenses[indexPath.row].id
                
                
                expenses.remove(at: indexPath.row)
                self.deleteDataInArray(itemID: itemID, username: TempData.usernameInput)
                
                self.tableView.beginUpdates()
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                viewModel.deleteItemInfo(id: itemID, username: TempData.usernameInput)
                self.tableView.endUpdates()
                updateChart()
                
                
            } else if indexPath.section == 1 {
                let itemID = self.incomes[indexPath.row].id
                
                
                
                self.incomes.remove(at: indexPath.row)
                self.deleteDataInArray(itemID: itemID, username: TempData.usernameInput)
                self.tableView.beginUpdates()
                
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                self.viewModel.deleteItemInfo(id: itemID, username: TempData.usernameInput)
                self.tableView.endUpdates()
                
                self.updateChart()
            }
        }
    }
    
   
    
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
            //UITableView.animate(withDuration: 0.3, animations: )
            return expenses.count
        }
        else {
            return incomes.count
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (sections[indexPath.section].expanded) {
            return 60
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
        let itemTitle = cell.viewWithTag(1001) as? UILabel
        let itemAmount = cell.viewWithTag(1002) as? UILabel
        let itemDate = cell.viewWithTag(1003) as? UILabel
        
      
        
        let records = indexPath.section == 0 ? getExpenseRecord(index: indexPath.row) : getIncomeRecord(index: indexPath.row)
     
        //  Configure the cell...
        if let imageView = imageView, let itemTitle = itemTitle, let itemDate = itemDate,let itemAmount = itemAmount  {
    
            imageView.image = records.image
            itemTitle.text = records.title
            itemAmount.text = records.amount
            itemDate.text = records.date
        }
        
        return cell
    }
    
    func toggleSection(header: ExpandableHeaderViewNew, section: Int) {
        if ids.count != 0 {
            sections[section].expanded = !sections[section].expanded
            print("toggle pressed")
            tableView.reloadData()
            UIView.transition(with: tableView,
                                      duration: 0.35,
                                      options: .transitionCrossDissolve,
                                      animations:
                { () -> Void in
                    self.tableView.reloadData()
            },
                                      completion: nil);
//            self.tableView.beginUpdates()
//            for i in 0 ..< sections[section].items.count {
//                tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .middle)
//            }
//            self.tableView.endUpdates()
        }
       
        // next we gonna reload the row in the table view and depend on the size of item array
        
     
    }
    
    //Mark: gesture recognizer
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedRow = self.tableView.indexPathForSelectedRow else {return}
     
        let selectedSection = selectedRow.section
        if segue.destination is ItemDescriptionScreenViewController {
            let destination = segue.destination as! ItemDescriptionScreenViewController
            
            if selectedSection == 0 {
                let selectedItem = getExpenseRecord(index: selectedRow.row)
                destination.selectedItem = selectedItem
            }
            else
            {
                let selectedItem = getIncomeRecord(index: selectedRow.row)
                destination.selectedItem = selectedItem
            }
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
        var final: [Date: (Double, Double)] = [:]
        
        var instantDate = CustomDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        var instantDateArr:[String] = []
        
        if ids.count > 1 {
            // get unique date
            for index in 00..<dates.count {
                if !instantDateArr.contains(dates[index]) {
                    instantDateArr.append(dates[index])
                }
            }
            
            // filter date for income and expense
            for date in instantDateArr {
                var totalIncome:Double = 0.0
                var totalExpense:Double = 0.0
                
                for item in incomes {
                    if item.date == date, item.type == CustomItemType.income.name {
                        totalIncome += Double(item.amount) ?? 0
                    }
                }
                
                for item in expenses {
                    if item.date == date, item.type == CustomItemType.expense.name {
                        totalExpense += Double(item.amount) ?? 0
                    }
                }
                instantDate.setDate(date: dateFormatter.date(from: date)!)
                final.updateValue((totalIncome, totalExpense), forKey: instantDate.getDate())
            }
            
            if final.count > 0 {
                for item in final {
                    chartRecord.update(at: item.key, income: item.value.0, expense: item.value.1)
                }
            }
        }
    }
    
    
    private func getExpenseRecord(index: Int) -> (id: UUID, title:String, date:String, amount:String , category:String, description:String, image:UIImage?) {
        let id = expenses[index].id
        let title = expenses[index].title
        let amount = expenses[index].amount
        let date = expenses[index].date
        let category = expenses[index].category
        let description = expenses[index].description
        let image:UIImage
       
        switch category {
        case "Food":
            image = Category.food.image
        case "Drink":
            image = Category.drink.image
        case "Medication":
            image = Category.medication.image
        case "Education":
            image = Category.education.image
        case "Transportation":
            image = Category.transportation.image
        case "Rent":
            image = Category.rent.image
        case "Utilities":
            image = Category.utilities.image
        case "Others":
            image = Category.others.image
        default:
            image = Category.none.image
        }
        
        return (id: id, title: title, date: date, amount: amount, category: category, description: description, image: image)
    }
    private func getIncomeRecord(index: Int) -> (id: UUID, title:String, date:String, amount: String, category:String, description:String, image:UIImage?) {
        let id = incomes[index].id
        let title = incomes[index].title
        let amount = incomes[index].amount
        let date = incomes[index].date
        let category = incomes[index].category
        let description = incomes[index].description
        let image:UIImage
    
        switch category {
        case "Salary":
            image = Category.salary.image
        case "Donation":
            image = Category.donation.image
        case "Others":
            image = Category.others.image
        default:
            image = Category.none.image
        }
        
        return (id: id, title: title, date: date, amount: amount, category: category, description: description, image: image)
    }
    
    
    private func deleteDataInArray(itemID:UUID, username: String){
        guard let index = ids.firstIndex(of: itemID) else { return }
        
        ids.remove(at: index)
        titles.remove(at: index)
        dates.remove(at: index)
        amounts.remove(at: index)
        types.remove(at: index)
        categories.remove(at: index)
        descriptions.remove(at: index)
    }
}
