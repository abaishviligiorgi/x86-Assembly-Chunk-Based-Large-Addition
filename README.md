# 20-Digit Big Number Addition via Stack-Allocated Chunk Processing (x86 MASM)

An advanced 32-bit x86 Assembly algorithm that performs high-precision math by breaking down 20-digit numbers into smaller, manageable 4-digit chunks directly within local stack memory blocks.

## ⚙️ How the Algorithm Works

1. **Local Memory Allocation:** The procedure allocates a safe local execution block on the hardware stack (`sub esp, 100`) to load input segments.
2. **Chunked Addition Pipeline:** Instead of reading individual characters byte-by-byte, it adds numbers in parallel using 4-digit numeric chunks (up to 9999).
3. **Low-Level Overflow Checks:** Compares chunks against `9999`. If an overflow occurs, a custom look-ahead carry mechanism increments the previous high-order segment.
4. **Iterative ASCII Streaming:** Decoupled loops divide the chunked numerical answers by 10 to dynamically build individual ASCII bytes and pipe them to native standard library printing (`putchar`).

## 🚀 Key Features

* **Segmented Processing Loop:** Shows a highly optimized strategy for big number arithmetic without long string loops.
* **Manual Base-10 Digit Extraction:** Features custom character synthesis using low-level remainder isolation (`div`/`xor edx, edx`).
* **Clean Memory Cleanup:** Implements programmatic internal stack zeroing before starting the data output stage.

## 🛠️ Environment Requirements

* **Assembler:** Microsoft Macro Assembler (MASM)
* **Linker Targets:** Configured for x86 runtime with standard MSVCRT library attachments (`msvcrt.lib` / `ucrt.lib`).
