# support-ticket-analysis-sql
SQL project to analyze support ticket data, SLA performance, and agent efficiency

# Objective
Analyze customer support tickets to evaluate SLA performance, agent efficiency, and issue trends.

# Tools Used
- SQL (SQLite)

# Key Analysis
- Ticket volume by category
- SLA breach analysis
- Agent performance metrics
- Priority-wise resolution trends

# Skills Demonstrated
- JOINs
- GROUP BY
- CASE WHEN
- Date calculations

# Schema Description
1. tickets Table : Stores core support ticket information, including timelines, priority, SLA, and assigned agent.

- ticket_id	: INTEGER	 - Unique identifier for each support ticket
- created_at :	DATE	- Date when the ticket was created
- resolved_at :	DATE	- Date when the ticket was resolved (NULL if open)
- status	: TEXT	- Current ticket status (Open, Closed, Resolved)
- priority	: TEXT	- Ticket urgency (Low, Medium, High)
- category	: TEXT	- Issue type (Login, Payment, Access, Bug, etc.)
- agent_id	: INTEGER	- ID of the support agent handling the ticket
- sla_hours	: INTEGER	- SLA time limit in hours for ticket resolution

2. agents Table : Stores information about support agents responsible for handling tickets.

- agent_id	: INTEGER	- Unique identifier for each agent
- agent_name : TEXT -	Name of the support agent
- team	: TEXT - Support level or team (L1 Support, L2 Support)
  
3.customers Table : Contains details about customers who raised support tickets.
- customer_id	: INTEGER -	Unique identifier for each customer
- region	: TEXT -	Customer geographic region
- plan_type :	TEXT- Subscription plan (Free or Paid)

4.ticket_customer_map Table : Maps tickets to customers, enabling a many-to-one relationship between tickets and customers.
- ticket_id :	INTEGER -	Ticket identifier
- customer_id :	INTEGER -	Customer identifier
