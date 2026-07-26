# C++ Debugging Guide (Neovim DAP)

This configuration uses `nvim-dap` (Debug Adapter Protocol) integrated with **CodeLLDB** (installed via Mason) to support debugging C/C++ (and Rust) files inside Neovim.

---

## 🛠️ Prerequisites

Before you can debug your C++ executable, it must be compiled with **debug symbols** using the `-g` flag:

```bash
g++ -g main.cpp -o main
```

If your file is not compiled with `-g`, breakpoints will not hit and you will not see variable names, values, or code lines in the debugger.

---

## 🐞 Basic Workflow

1. **Set Breakpoints:**
   - Open your C++ source file in Neovim.
   - Navigate to the line where you want execution to pause.
   - Press `<leader>b` to toggle a breakpoint. A breakpoint indicator will appear in the sign column.
   
2. **Start Debugging:**
   - Press `<F5>`.
   - Neovim will prompt you for the target executable:
     ```text
     Executable: /absolute/path/to/your/workspace/main
     ```
   - Input the path to your compiled binary (e.g., `./main` or `/home/user/.../main`) and press `Enter`.
   - The `nvim-dap-ui` layout will slide open, showcasing:
     - **Scopes:** Local and global variables with their current values.
     - **Watches:** Expressions you want to monitor.
     - **Stacks:** Call stack of threads.
     - **Breakpoints:** List of active breakpoints.
     - **REPL:** Interactive debugger command prompt.

3. **Stepping and Control:**
   - Use the stepping keys (`<F10>`, `<F11>`, `<F12>`) to move through execution, view variable updates, and trace logic.
   - Once debug execution terminates or is exited, the UI will close automatically.

---

## ⌨️ Debugger Keymaps

| Key | Action | Description |
| :--- | :--- | :--- |
| `<F5>` | **Start / Continue** | Initializes debugging or resumes execution until the next breakpoint. |
| `<F10>`| **Step Over** | Executed the current line and stops at the next line in the current function. |
| `<F11>`| **Step Into** | Steps into the function call on the current line. |
| `<F12>`| **Step Out** | Finishes the current function and returns to the caller. |
| `<leader>b` | **Toggle Breakpoint** | Sets or removes a breakpoint on the current line. |
| `<leader>B` | **Conditional Breakpoint** | Prompts you for a condition (e.g. `i == 10`). Execution will only stop if the condition is met. |
| `<leader>du` | **Toggle DAP UI** | Manually toggles the debugger UI window layout. |
| `<leader>dr` | **Open DAP REPL** | Opens the interactive Debugger console line. |
| `<leader>dq` | **Terminate Session** | Stops the debugger running session and closes the UI windows. |

---

## ⚠️ Notes & Diagnostics

### Keymap Collision (New Buffer vs Breakpoint)
- **Problem:** `<leader>b` is mapped to `:enew` (new empty buffer) in `core/keymaps.lua` and to `dap.toggle_breakpoint` in `plugins/dap.lua`.
- **Behavior:** By default, lazy-loading plugins will override the global keymap once the configuration loads.
- **Resolution:** If you notice `<leader>b` behavior is inconsistent, change the new buffer map in `lua/core/keymaps.lua` (line 40) to something like `<leader>nb`.

### Re-compilation
Always remember to re-compile your binary after modifying code before running `<F5>` to ensure your debugger runs the latest instruction set.
