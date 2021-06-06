import Foundation

final class FillWithColor {
    
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        if image.first == nil {
            return image
        }
        let rowsCount = image.count
        let columnsCount = image[0].count
        
        if (row < 0 || row >= rowsCount || column < 0 || column >= columnsCount) {
            return image
        }
        
        var visited: [[Bool]] = [[]]
        var newImage = image
        let oldColor = image[row][column]

        visited = Array(repeating: Array(repeating: false, count: columnsCount), count: rowsCount)
        visited[row][column] = true
        var peaks = [(row, column)]
        newImage[row][column] = newColor
        while peaks.count > 0 {
            let (row, column) = peaks[peaks.count - 1]
            peaks.remove(at:peaks.count - 1)
            let neighbours = FillWithColor.evalNeighbours(row, column, rowsCount, columnsCount)
            for (r,c) in neighbours {
                if !visited[r][c] && image[r][c] == oldColor {
                    visited[r][c] = true
                    newImage[r][c] = newColor
                    peaks.append((r,c))
                }
            }
        }
        return newImage
    }
    
    static func evalNeighbours(_ row:Int, _ column:Int, _ rowsCount:Int, _ columnsCount:Int) -> [(Int,Int)] {
        var result:[(Int, Int)] = []
        for (r,c) in [(row, column - 1), (row, column + 1), (row - 1, column), (row + 1, column)] {
                if (r >= 0  && c >= 0 && r < rowsCount && c < columnsCount) {
                    result.append((r, c))
                }
        }
        return result
    }
}
