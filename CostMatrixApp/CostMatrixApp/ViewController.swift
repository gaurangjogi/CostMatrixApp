//
//  ViewController.swift
//  CostMatrixApp
//
//  Created by Gaurang Jogi on 06/12/17.
//  Copyright © 2017 Gaurang Jogi. All rights reserved.
//

import UIKit
import CostMatrixFramework;

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var rowTextField:UITextField! ;
    @IBOutlet var columnTextField:UITextField!;
    @IBOutlet var matrixView:UIView!;
    @IBOutlet var pathMadeAllTheWayThrough:UILabel!;
    @IBOutlet var pathCost:UILabel!;
    @IBOutlet var pathValue:UIStackView!;
    
    var matrix:Matrix?;
    
    @IBAction func evaluateLeastCostPathInMatrix(button:UIButton) -> Void
    {
        /*
         *  Here we need to fork new thread and then find out the value. But as this happens only when there is high number of column ignoring for this excercise.
         */
        self.clearOutPut();
       
        let returnValue = matrix?.evaluateCostMatrixForMinimumCost();
        pathMadeAllTheWayThrough.text = (returnValue?.completeMatrixPath)! ? "YES" : "NO";
        guard let costOfPath:Int = returnValue?.costOfPath else{
            return;
        }
        pathCost.text = "\(costOfPath)";
        for i in (returnValue?.pathArray)!
        {
            let pathLabel:UILabel = UILabel();
            pathLabel.text = "\(i)";
            pathValue.addArrangedSubview(pathLabel);
        }
        
    }
    
    @IBAction func generateMatrixButtonTapped(button:UIButton) -> Void
    {
        self.clearMatrix();
        self.clearOutPut();
        guard  let numberOfRows:Int = Int(rowTextField.text!) else {
            self.showAlert();
            
            return
        }
        guard let numberOfColumns:Int = Int(columnTextField.text!) else {
            self.showAlert();
            return
        }
        
        if(numberOfRows > 0 && numberOfColumns > 0)
        {
            self.matrix =   Matrix(rows:numberOfRows,columns:numberOfColumns); /// Here not passing value for maximum cost for path as it will be default to 50;
            var rows:Array<UIView> = Array<UIView>();
            
            for i in 0..<numberOfRows
            {
                
                var columns:Array<UIView> = Array<UIView>();
                for j in 0..<numberOfColumns
                {
                    let textField = UITextField();
                    textField.tag = 1000 * i + j;
                    textField.delegate = self;
                    textField.text = "0";
                    columns.append(textField);
                }
                let stackView = UIStackView(arrangedSubviews: columns);
                stackView.axis = UILayoutConstraintAxis.horizontal;
                stackView.alignment = UIStackViewAlignment.center;
                stackView.distribution = UIStackViewDistribution.fillEqually;
                rows.append(stackView);
            }
            let stackView = UIStackView(frame: (matrixView?.bounds)!);
            stackView.axis = UILayoutConstraintAxis.vertical;
            stackView.alignment = UIStackViewAlignment.center;
            stackView.distribution = UIStackViewDistribution.fillEqually;
            for i in 0..<rows.count
            {
                stackView.addArrangedSubview(rows[i]);
            }
            matrixView?.addSubview(stackView);
        }
        else{
            self.showAlert();
        }
        
    }
    
    func clearMatrix() -> Void {
        for i in (matrixView?.subviews)!
        {
            i.removeFromSuperview();
        }
    }
    
    func clearOutPut()->Void {
        pathMadeAllTheWayThrough.text = nil;
        pathCost.text = nil;
        for i in pathValue.arrangedSubviews
        {
            pathValue.removeArrangedSubview(i);
        }
    }
    
    func showAlert()
    {
        let alertView:UIAlertController = UIAlertController(title: "Invalid matrix", message: "Please provide valid rows and column value", preferredStyle: UIAlertControllerStyle.alert);
        alertView.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (alertAction) in
            alertView.dismiss(animated: true, completion: {
                
            });
        }));
        self.present(alertView, animated: true, completion: {
            
        });
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(string==""||string=="-")
        {
            return true;
        }
        guard let valueIsNumeric:Int = Int(string) else{
            return false;
        }
        guard let costInTextField:Int = Int(textField.text!+string) else
        {
            return false;
        }
        let row = Int (textField.tag / 1000);
        let column = textField.tag % 1000;
        matrix?.assignMatrixValueAt(row: row, column: column, cost: costInTextField);
        return true;
    }
    override func viewDidLoad() {
        let tapGestureRecognizer:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.viewTouched(_:)));
        self.view.addGestureRecognizer(tapGestureRecognizer);
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @objc func viewTouched(_ sender:UITapGestureRecognizer) -> Void {
        self.view.endEditing(true);
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

