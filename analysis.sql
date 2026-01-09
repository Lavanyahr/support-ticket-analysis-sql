-- 1. Counts how many tickets exist in each category
SELECT category,
       COUNT(*) AS total_tickets
FROM tickets
GROUP BY category;


-- 2. Counts how many tickets fall under each priority
 SELECT priority,
       COUNT(*) AS ticket_count
FROM tickets
GROUP BY priority;


-- 3. Calculates how long each ticket took to resolve

SELECT ticket_id,
       created_at,
       resolved_at,
       ROUND(julianday(resolved_at) - julianday(created_at), 2) AS resolution_days
FROM tickets
WHERE resolved_at IS NOT NULL;



-- 4. Compares resolution time against SLA limit
SELECT ticket_id,
       CASE
         WHEN resolved_at IS NOT NULL
              AND (julianday(resolved_at) - julianday(created_at)) > sla_hours / 24.0
         THEN 'SLA Breached'
         ELSE 'Within SLA'
       END AS sla_status
FROM tickets;



-- 5. Counts how many breached SLA per category
SELECT category,
       COUNT(*) AS total_tickets,
       SUM(CASE
           WHEN (julianday(resolved_at) - julianday(created_at)) > sla_hours / 24.0
           THEN 1 ELSE 0
       END) AS sla_breaches
FROM tickets
WHERE resolved_at IS NOT NULL
GROUP BY category;


-- 6. Counts number of tickets per agent
SELECT a.agent_name,
       COUNT(t.ticket_id) AS tickets_handled
FROM tickets t
JOIN agents a ON t.agent_id = a.agent_id
GROUP BY a.agent_name;



-- 7. Calculates average time each agent takes to resolve tickets

SELECT a.agent_name,
       ROUND(AVG(julianday(t.resolved_at) - julianday(t.created_at)), 2) AS avg_resolution_days
FROM tickets t
JOIN agents a ON t.agent_id = a.agent_id
WHERE t.resolved_at IS NOT NULL
GROUP BY a.agent_name;




-- 8. Groups tickets by customer plan

SELECT c.plan_type,
       COUNT(t.ticket_id) AS total_tickets
FROM tickets t
JOIN ticket_customer_map tc ON t.ticket_id = tc.ticket_id
JOIN customers c ON tc.customer_id = c.customer_id
GROUP BY c.plan_type;



-- 9. Counts tickets coming from each region

SELECT c.region,
       COUNT(t.ticket_id) AS total_tickets
FROM tickets t
JOIN ticket_customer_map tc ON t.ticket_id = tc.ticket_id
JOIN customers c ON tc.customer_id = c.customer_id
GROUP BY c.region;



-- 10. Ranks agents based on ticket volume

SELECT a.agent_name,
       COUNT(t.ticket_id) AS tickets_handled,
       RANK() OVER (ORDER BY COUNT(t.ticket_id) DESC) AS agent_rank
FROM tickets t
JOIN agents a ON t.agent_id = a.agent_id
GROUP BY a.agent_name;
