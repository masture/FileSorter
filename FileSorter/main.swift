//
//  main.swift
//  FileSorter
//
//  Created by Pankaj Kulkarni on 7/3/25.
//

import Foundation

func sortFile(inputFilePath: String, outputFilePath: String) {
    // 1. Read the file
    do {
        let fileContent = try String(contentsOfFile: inputFilePath, encoding: .utf8)
        let lines = fileContent.components(separatedBy: "\n")

        // 2. Sort the lines alphabetically
        let sortedLines = lines.sorted()
        
        // 3. Write the sorted lines to the output file
        try sortedLines.joined(separator: "\n").write(toFile: outputFilePath, atomically: true, encoding: .utf8)

        print("File sorted successfully!")
    } catch {
        print("Error: \(error)")
    }
}

// 4. Command-line argument handling
if CommandLine.arguments.count != 3 {
    print("Usage: FileSorter <input_file> <output_file>")
    exit(1)
}

let inputFilePath = CommandLine.arguments[1]
let outputFilePath = CommandLine.arguments[2]

sortFile(inputFilePath: inputFilePath, outputFilePath: outputFilePath)


