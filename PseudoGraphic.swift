import Foundation

class PseudoGraphics{
    func Output(lib:Library) -> Void{
        print("Existing books:\n")
        
        for i:Book in lib.ebookList{
            i.Print()
        }
        
        print("-------------------")
        
        print("Available books:\n")
        
        for i:Book in lib.abookList{
            i.Print()
        }
        
        print("-------------------")
        
        print("Absent books:\n")
        
        for i:Book in lib.nbookList{
            i.Print()
            i.getMovingHistory()
        }
    }
}
