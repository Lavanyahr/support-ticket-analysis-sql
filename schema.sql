CREATE TABLE tickets (
  ticket_id INTEGER PRIMARY KEY,
  created_at DATE,
  resolved_at DATE,
  status TEXT,
  priority TEXT,
  category TEXT,
  agent_id INTEGER,
  sla_hours INTEGER
);


CREATE TABLE agents (
  agent_id INTEGER PRIMARY KEY,
  agent_name TEXT,
  team TEXT
);


CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  region TEXT,
  plan_type TEXT
);


CREATE TABLE ticket_customer_map (
  ticket_id INTEGER,
  customer_id INTEGER
);


INSERT INTO agents VALUES
(1, 'Anita', 'L1 Support'),
(2, 'Rahul', 'L2 Support'),
(3, 'Meena', 'L1 Support');


INSERT INTO customers VALUES
(101, 'India', 'Paid'),
(102, 'US', 'Free'),
(103, 'UK', 'Paid');


INSERT INTO tickets VALUES
(1001, '2024-01-01', '2024-01-02', 'Closed', 'High', 'Login', 1, 24),
(1002, '2024-01-03', '2024-01-05', 'Closed', 'Medium', 'Payment', 2, 48),
(1003, '2024-01-05', NULL, 'Open', 'Low', 'Access', 3, 72);


INSERT INTO ticket_customer_map VALUES
(1001, 101),
(1002, 102),
(1003, 103);
