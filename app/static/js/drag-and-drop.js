// === Перетаскивание задач ===

function dragTask(event) {
    event.dataTransfer.setData("type", "task");
    event.dataTransfer.setData("taskId", event.target.dataset.taskId);
}

function allowDropTask(event) {
    if (event.dataTransfer.getData("type") === "task") {
        event.preventDefault();
        const tasksContainer = event.target.closest('.tasks-container') || event.target.closest('.col-md-4');
        if (tasksContainer) {
            tasksContainer.classList.add('dragging-over');
        }
    }
}

function dropTask(event) {
    if (event.dataTransfer.getData("type") === "task") {
        event.preventDefault();
        const tasksContainer = event.target.closest('.tasks-container') || event.target.closest('.col-md-4');
        if (tasksContainer) {
            tasksContainer.classList.remove('dragging-over');

            const taskId = event.dataTransfer.getData("taskId");
            const taskElement = document.querySelector(`[data-task-id="${taskId}"]`);
            const column = tasksContainer.closest('.col-md-4');

            if (taskElement && column) {
                const newStatus = column.id; // Новый статус из id столбца

                // Удаляем все старые классы статуса задачи
                taskElement.classList.remove('not-started', 'in-progress', 'completed');

                // Добавляем новый класс статуса задачи
                taskElement.classList.add(newStatus);

                // Перемещаем задачу в новый столбец
                column.querySelector('.tasks-container').appendChild(taskElement);

                // Обновляем статус задачи на сервере
                updateTaskStatusOnServer(taskId, newStatus);
            }
        }
    }
}

function updateTaskStatusOnServer(taskId, status) {
    fetch(`/update_task_status/${taskId}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ status }),
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to update task status');
            }
            return response.json();
        })
        .then(data => {
            console.log(`Task ${taskId} updated successfully:`, data);
        })
        .catch(error => {
            console.error('Error updating task status:', error);
        });
}


function loadTaskPositions() {
    document.querySelectorAll('.task').forEach(taskElement => {
        const taskId = taskElement.dataset.taskId;
        const currentStatus = taskElement.classList.contains('not-started')
            ? 'not-started'
            : taskElement.classList.contains('in-progress')
            ? 'in-progress'
            : 'completed';

        const column = document.getElementById(currentStatus);
        if (column) {
            column.querySelector('.tasks-container').appendChild(taskElement);
        }
    });
}


function removeDragOverStyle(event) {
    const tasksContainer = event.target.closest('.tasks-container') || event.target.closest('.col-md-4');
    if (tasksContainer) {
        tasksContainer.classList.remove('dragging-over');
    }
}


// === Сохранение и восстановление названий столбцов ===

function saveColumnName(columnId) {
    const columnHeader = document.querySelector(`#${columnId} h3`);
    if (columnHeader) {
        const newName = columnHeader.innerText.trim();
        const savedNames = JSON.parse(localStorage.getItem('columnNames')) || {};
        savedNames[columnId] = newName;
        localStorage.setItem('columnNames', JSON.stringify(savedNames));
        console.log(`Название столбца "${columnId}" сохранено как: "${newName}"`);
    }
}

function loadColumnNames() {
    const savedNames = JSON.parse(localStorage.getItem('columnNames'));
    if (savedNames) {
        Object.entries(savedNames).forEach(([columnId, columnName]) => {
            const columnHeader = document.querySelector(`#${columnId} h3`);
            if (columnHeader) {
                columnHeader.innerText = columnName;
            }
        });
        console.log('Названия столбцов восстановлены:', savedNames);
    }
}

// === Функция для установки курсора в конец текста ===

function fixCursorPosition(event) {
    const range = document.createRange();
    const sel = window.getSelection();
    range.selectNodeContents(event.target);
    range.collapse(false); // Установить курсор в конец текста
    sel.removeAllRanges();
    sel.addRange(range);
}

// === Перетаскивание столбцов ===

let draggedColumn = null;

function dragColumn(event) {
    event.dataTransfer.setData("type", "column");
    draggedColumn = event.target.closest('.col-md-4');
    event.dataTransfer.effectAllowed = 'move';
    draggedColumn.classList.add('dragging-column');
}

function allowDropColumn(event) {
    if (event.dataTransfer.getData("type") === "column") {
        event.preventDefault();
    }
}

function dropColumn(event) {
    if (event.dataTransfer.getData("type") === "column") {
        event.preventDefault();

        const targetColumn = event.target.closest('.col-md-4');
        if (draggedColumn && targetColumn && draggedColumn !== targetColumn) {
            const container = document.getElementById('columns-container');
            const draggedIndex = Array.from(container.children).indexOf(draggedColumn);
            const targetIndex = Array.from(container.children).indexOf(targetColumn);

            if (draggedIndex < targetIndex) {
                container.insertBefore(draggedColumn, targetColumn.nextSibling);
            } else {
                container.insertBefore(draggedColumn, targetColumn);
            }
            saveColumnOrder();
        }

        draggedColumn.classList.remove('dragging-column');
        draggedColumn = null;
    }
}

function saveColumnOrder() {
    const columnOrder = Array.from(document.querySelectorAll('.col-md-4')).map(column => column.id);
    localStorage.setItem('columnOrder', JSON.stringify(columnOrder));
}

function loadColumnOrder() {
    const savedOrder = JSON.parse(localStorage.getItem('columnOrder'));
    if (savedOrder) {
        const container = document.getElementById('columns-container');
        savedOrder.forEach(columnId => {
            const column = document.getElementById(columnId);
            if (column) {
                container.appendChild(column);
            }
        });
    }
}

// === Инициализация ===

function initializeEventHandlers() {
    const columns = document.querySelectorAll('.col-md-4');
    const tasks = document.querySelectorAll('.task');
    const headers = document.querySelectorAll('.column-header');

    headers.forEach(header => {
        header.addEventListener('dragstart', dragColumn);
    });

    columns.forEach(column => {
        column.addEventListener('dragover', allowDropColumn);
        column.addEventListener('drop', dropColumn);
        column.querySelector('.tasks-container').addEventListener('dragover', allowDropTask);
        column.querySelector('.tasks-container').addEventListener('drop', dropTask);
        column.addEventListener('dragleave', removeDragOverStyle);
    });

    tasks.forEach(task => {
        task.addEventListener('dragstart', dragTask);
    });

    loadColumnOrder();
    loadTaskPositions();
    loadColumnNames();
}

document.addEventListener('DOMContentLoaded', initializeEventHandlers);
