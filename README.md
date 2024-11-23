# TaskManager Smart Contract

A **simple and efficient Task Manager** smart contract written in Solidity. This contract allows the owner to add, complete, delete, and view tasks, offering a decentralized solution for managing to-do lists.

---

## Features

- **Add Tasks**: Add tasks with a unique ID and description.
- **Complete Tasks**: Mark tasks as completed.
- **Delete Tasks**: Delete tasks (only if they are not completed).
- **View Tasks**: Retrieve a single task or all tasks with details.
- **Ownership Control**: Only the contract owner can manage tasks.
- **Error Handling**: Uses `require`, `assert`, and `revert` for secure operations.

---

## Smart Contract Details

### Task Structure
```solidity
struct Task {
    uint256 id;          // Unique task ID
    string description;  // Description of the task
    bool isCompleted;    // Status of the task
}
```

### Functions Overview

| Function             | Description                                                                          |
|----------------------|--------------------------------------------------------------------------------------|
| `addTask(string)`    | Adds a new task with a description.                                                 |
| `markTaskCompleted(uint256)` | Marks a specific task as completed.                                          |
| `deleteTask(uint256)`| Deletes a task (if not completed).                                                  |
| `getTask(uint256)`   | Returns details of a specific task by its ID.                                       |
| `getTotalTasks()`    | Returns the total number of tasks.                                                  |
| `getAllTasks()`      | Returns arrays of all task IDs, descriptions, and completion statuses.              |

---

## Requirements

- Solidity version: `^0.8.0`
- Ethereum development tools: [Remix](https://remix.ethereum.org/), [Hardhat](https://hardhat.org/), or [Truffle](https://trufflesuite.com/)

---

## Deployment Instructions

1. Clone the repository and open the contract in [Remix](https://remix.ethereum.org/).
2. Ensure you are using a Solidity compiler version `^0.8.0`.
3. Deploy the contract on a local test network, such as Ganache, or a public testnet like Rinkeby.

---

## Usage

### Adding a Task
```solidity
addTask("Buy groceries");
// Task added with ID 1: "Buy groceries"
```

### Marking a Task as Completed
```solidity
markTaskCompleted(1);
// Task with ID 1 is now marked as completed
```

### Deleting a Task
```solidity
deleteTask(1);
// Task with ID 1 deleted (if not completed)
```

### Viewing a Single Task
```solidity
getTask(1);
// Returns: (1, "Buy groceries", true)
```

### Viewing All Tasks
```solidity
getAllTasks();
// Returns:
// IDs: [1, 2, 3]
// Descriptions: ["Buy groceries", "Finish project", "Call mom"]
// Statuses: [true, false, false]
```

---

## Error Handling

- **Adding Tasks**: Rejects empty descriptions.
- **Completing Tasks**: Ensures the task exists and is not already completed.
- **Deleting Tasks**: Ensures the task exists and is not completed.
- **General**: Ensures only the owner can manage tasks.

---

## Testing

Run unit tests using a development framework like Hardhat or Truffle to ensure all functions behave as expected. Example test scenarios:
1. Add tasks and retrieve their details.
2. Mark tasks as completed.
3. Attempt to delete completed tasks and observe reverts.

---

## License

This project is licensed under the MIT License. See the LICENSE file for more details.

---

## Contributing

Feel free to submit pull requests or report issues. Contributions are welcome!
