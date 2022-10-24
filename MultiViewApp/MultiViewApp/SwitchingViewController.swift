import UIKit

class SwitchingViewController: UIViewController {
    
    private var yellowViewController: YellowViewController!
    private var blueViewController: BlueViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        blueViewController =
        storyboard?.instantiateViewController(withIdentifier: "Blue")
        as! BlueViewController

        blueViewController.view.frame = view.frame
        switchViewController(from: nil, to: blueViewController)
        // helper method
    }
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
            
            if blueViewController != nil
                && blueViewController!.view.superview == nil {
                blueViewController = nil
            }
            if yellowViewController != nil
                && yellowViewController!.view.superview == nil {
                yellowViewController = nil
            }
        }
    
    @IBAction func switchViews(sender : UIBarButtonItem)
    {
        // Create the new view controller, if required
                if yellowViewController?.view.superview == nil {
                    if yellowViewController == nil {
                        yellowViewController =
                            storyboard?.instantiateViewController(withIdentifier: "Yellow")
                            as? YellowViewController
                    }
                }
                else if blueViewController?.view.superview == nil {
                    if blueViewController == nil {
                        blueViewController =
                            storyboard?.instantiateViewController(withIdentifier: "Blue")
                            as? BlueViewController
                    }
                }
                
                UIView.beginAnimations("View Flip", context: nil)
                UIView.setAnimationDuration(0.4)
                UIView.setAnimationCurve(.easeInOut)
                
                // Switch view controllers
                if blueViewController != nil
                && blueViewController!.view.superview != nil {
                yellowViewController.view.frame = view.frame
                switchViewController(from: blueViewController,
                                         to: yellowViewController)
                } else {
                    blueViewController.view.frame = view.frame
                    switchViewController(from: yellowViewController,
                                         to: blueViewController)
                }
                UIView.commitAnimations()
    }
    
    private func switchViewController(from fromVC:UIViewController?,
                                          to toVC:UIViewController?) {
            if fromVC != nil {
                fromVC!.willMove(toParent: nil)
                fromVC!.view.removeFromSuperview()
                fromVC!.removeFromParent()
            }
            
            if toVC != nil {
                self.addChild(toVC!)
                self.view.insertSubview(toVC!.view, at: 0)
                toVC!.didMove(toParent: self)
            }
        }

}
