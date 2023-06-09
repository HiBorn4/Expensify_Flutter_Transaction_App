
  <h1>My Transaction App</h1>
  
  <h2>Transaction List</h2>
  <p>This is a list of transactions:</p>
  <ul>
    <li>
      <strong>Name:</strong> John Doe
      <strong>Title:</strong> Purchase
      <strong>Date:</strong> 2023-06-01
      <strong>Amount:</strong> $50.00
    </li>
    <li>
      <strong>Name:</strong> Jane Smith
      <strong>Title:</strong> Payment
      <strong>Date:</strong> 2023-06-02
      <strong>Amount:</strong> $30.00
    </li>
    <li>
      <strong>Name:</strong> Mark Johnson
      <strong>Title:</strong> Expense
      <strong>Date:</strong> 2023-06-03
      <strong>Amount:</strong> $20.00
    </li>
  </ul>
  
  <h2>Weekly Transaction Chart</h2>
  <p>This chart represents the transactions in the past week:</p>
  <div id="chart-container">
    <!-- Add your chart bar component here -->
  </div>
  
  <h2>Add Transaction</h2>
  <form>
    <label for="name">Name:</label>
    <input type="text" id="name" name="name" required>
    
    <label for="title">Title:</label>
    <input type="text" id="title" name="title" required>
    
    <label for="date">Date:</label>
    <input type="date" id="date" name="date" required>
    
    <label for="amount">Amount:</label>
    <input type="number" id="amount" name="amount" required>
    
    <button type="submit">Add Transaction</button>
  </form>
  
  <h2>Delete Transaction</h2>
  <p>To delete a transaction, click on the transaction and confirm the deletion.</p>
  <ul id="transaction-list">
    <!-- Add your transaction list here -->
  </ul>
  
  <h2>Screenshots</h2>
  
  <h3>Transaction List</h3>
  <img src="screenshots/transaction_list.png" alt="Transaction List">
  
  <h3>Weekly Transaction Chart</h3>
  <img src="screenshots/weekly_chart.png" alt="Weekly Transaction Chart">
  
  <h3>Add Transaction</h3>
  <img src="screenshots/add_transaction.png" alt="Add Transaction">
  
  <h3>Delete Transaction</h3>
  <img src="screenshots/delete_transaction.png" alt="Delete Transaction">
  
