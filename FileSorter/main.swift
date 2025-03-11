//
//  main.swift
//  FileSorter
//
//  Created by Pankaj Kulkarni on 7/3/25.
//

import Foundation

func sortFile(inputPath: String, outputPath: String? = nil) {
    let fileManager = FileManager.default

    // Check if inputPath is a file or a directory
    var isDirectory: ObjCBool = false
    if fileManager.fileExists(atPath: inputPath, isDirectory: &isDirectory) {
        if isDirectory.boolValue {
            // Input is a directory, process all files within it
            do {
                let files = try fileManager.contentsOfDirectory(atPath: inputPath)
                for file in files {
                    let inputFilePath = inputPath + "/" + file
                    let outputFilePath = outputPath ?? inputPath + "/" + file.replacingOccurrences(of: ".", with: "_output.")
                    sortFile(inputPath: inputFilePath, outputPath: outputFilePath)
                }
            } catch {
                print("Error: \(error)")
            }
        } else {
            // Input is a file, process it directly
            do {
                let fileContent = try String(contentsOfFile: inputPath, encoding: .utf8)
                let lines = fileContent.components(separatedBy: "\n").filter { !$0.isEmpty }
                let sortedLines = lines.sorted { $0.lowercased() < $1.lowercased() }

                // Determine the output file path if not provided
                let outputFilePath: String
                if let outputPath = outputPath {
                    outputFilePath = outputPath
                } else {
                    let fileName = inputPath.components(separatedBy: "/").last!
                    let fileExtension = fileName.components(separatedBy: ".").last!
                    outputFilePath = inputPath.replacingOccurrences(of: fileName, with: fileName.replacingOccurrences(of: ".", with: "_output."))
                }

                try sortedLines.joined(separator: "\n").write(toFile: outputFilePath, atomically: true, encoding: .utf8)
                print("File sorted successfully and saved to \(outputFilePath)!")
            } catch {
                print("Error: \(error)")
            }
        }
    } else {
        print("Error: Input path does not exist: \(inputPath)")
    }
}

// Command-line argument handling
if CommandLine.arguments.count < 2 || CommandLine.arguments.count > 3 {
    print("Usage: FileSorter <input_file_or_folder> [output_folder]")
    exit(1)
}

let inputPath = CommandLine.arguments[1]
let outputPath = CommandLine.arguments.count == 3 ? CommandLine.arguments[2] : nil

sortFile(inputPath: inputPath, outputPath: outputPath)
