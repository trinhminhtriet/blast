package requester

import (
	"syscall"
	"time"
	"unsafe"
)

// now returns time.Duration using queryPerformanceCounter
func now() time.Duration {
	var now int64
	syscall.Syscall(queryPerformanceCounterProc.Addr(), 1, uintptr(unsafe.Pointer(&now)), 0, 0)
	return time.Duration(now) * time.Second / (time.Duration(qpcFrequency) * time.Nanosecond)
}

// precision timing
var (
	modkernel32                   = syscall.NewLazyDLL("kernel32.dll")
	queryPerformanceFrequencyProc = modkernel32.NewProc("QueryPerformanceFrequency")
	queryPerformanceCounterProc   = modkernel32.NewProc("QueryPerformanceCounter")

	qpcFrequency = queryPerformanceFrequency()
)

// queryPerformanceFrequency returns frequency in ticks per second
func queryPerformanceFrequency() int64 {
	var freq int64
	r1, _, _ := syscall.Syscall(queryPerformanceFrequencyProc.Addr(), 1, uintptr(unsafe.Pointer(&freq)), 0, 0)
	if r1 == 0 {
		panic("call failed")
	}
	return freq
}
