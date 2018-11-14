import Foundation

class PseudoGraphics{
    func Output(lib:Library) -> Void{
        print("Existing books:\n")
        print("Name of Book\t Author")
        for i:Book in lib.existingBooks{
            i.Print()
        }
        
        print("-------------------")
        
        print("Available books:\n")
        print("Name of Book\t Author")
        
        for i:Book in lib.availableBooks{
            i.Print()
        }
        
        print("-------------------")
        
        print("Absent books:\n")
        
        for i:Book in lib.absentBooks{
            i.Print()
            i.getMovingHistory()
        }
    }
}
