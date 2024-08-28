package main

import (
	"fmt"
	"os"
	"bufio"
)

func handleError(err error) {
	if err != nil {
		panic(err)
	}
}

func readFileBytes(file *os.File) (*[]byte, int, error) {
	stats, err := file.Stat()
	if err != nil {
		return nil, 0, err
	}
	size := int(stats.Size()) // int64, but not needed
	data := make([]byte, size)
	bred := bufio.NewReader(file)
	size, err = bred.Read(data)
	if err != nil {
		return nil, 0, err
	}
	return &data, size, nil
}

func main() {
	args := os.Args[1:]
	for i, fileName := range args {
		file, err := os.Open(fileName)
		handleError(err)
		defer file.Close()
		data, size, err := readFileBytes(file)
		handleError(err)

		fmt.Printf("%v. Crackin %v\n", i+1, fileName)
		for ind := 0; ind < size; ind++ {
			(*data)[ind] ^= byte('x')
		}

		err = os.WriteFile(fileName, *data, 0644)
		handleError(err)
		fmt.Printf("Processed %v bytes\n", len(*data))
	}
}
