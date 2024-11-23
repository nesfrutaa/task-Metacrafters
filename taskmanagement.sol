// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TaskManager {
    struct Task {
        uint256 id;          // Unique task ID
        string description;  // Description of the task
        bool isCompleted;    // Status of the task
    }

    address public owner; // The owner of the contract
    uint256 private nextTaskId; // Counter for generating unique task IDs
    mapping(uint256 => Task) private tasks; // Mapping of taskId to Task
    uint256[] private taskIds; // List of all task IDs (for iteration)

    // Constructor to set the owner
    constructor() {
        owner = msg.sender;
        nextTaskId = 1; // Start task IDs from 1
    }

    // Modifier to ensure only the owner can make changes
    modifier onlyOwner() {
        require(msg.sender == owner, "You are not authorized!");
        _;
    }

    // Function to add a new task
    function addTask(string calldata _description) external onlyOwner {
        require(bytes(_description).length > 0, "Task description cannot be empty!");

        uint256 taskId = nextTaskId++;
        tasks[taskId] = Task({ id: taskId, description: _description, isCompleted: false });
        taskIds.push(taskId); // Add to the list of task IDs
    }

    // Function to mark a task as completed
    function markTaskCompleted(uint256 _taskId) external onlyOwner {
        require(tasks[_taskId].id != 0, "Task ID does not exist!");
        require(!tasks[_taskId].isCompleted, "Task is already completed!");

        tasks[_taskId].isCompleted = true;

        // Assert to validate critical state
        assert(tasks[_taskId].isCompleted == true);
    }

    // Function to delete a task
    function deleteTask(uint256 _taskId) external onlyOwner {
        require(tasks[_taskId].id != 0, "Task ID does not exist!");

        // Revert if the task is already completed
        if (tasks[_taskId].isCompleted) {
            revert("Cannot delete a completed task!");
        }

        // Delete the task from the mapping
        delete tasks[_taskId];

        // Remove the task ID from the list
        for (uint256 i = 0; i < taskIds.length; i++) {
            if (taskIds[i] == _taskId) {
                taskIds[i] = taskIds[taskIds.length - 1]; // Replace with the last ID
                taskIds.pop(); // Remove the last element
                break;
            }
        }
    }

    // Function to get the task details
    function getTask(uint256 _taskId) external view returns (uint256 id, string memory description, bool isCompleted) {
        require(tasks[_taskId].id != 0, "Task ID does not exist!");

        Task memory task = tasks[_taskId];
        return (task.id, task.description, task.isCompleted);
    }

    // Function to get the total number of tasks
    function getTotalTasks() external view returns (uint256) {
        return taskIds.length;
    }

    // Function to display all tasks with their IDs
    function getAllTasks() external view returns (uint256[] memory, string[] memory, bool[] memory) {
        uint256 totalTasks = taskIds.length;
        uint256[] memory ids = new uint256[](totalTasks);
        string[] memory descriptions = new string[](totalTasks);
        bool[] memory statuses = new bool[](totalTasks);

        for (uint256 i = 0; i < totalTasks; i++) {
            uint256 taskId = taskIds[i];
            ids[i] = tasks[taskId].id;
            descriptions[i] = tasks[taskId].description;
            statuses[i] = tasks[taskId].isCompleted;
        }

        return (ids, descriptions, statuses);
    }
}
