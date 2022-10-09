--creating new table 

SELECT e.emp_no,
	   e.first_name,
	e.last_name,
		ti.title,
		ti.from_date,
		ti.to_date
	INTO retirement_titles
	FROM employees as e
	LEFT JOIN titles as ti
	ON e.emp_no = ti.emp_no
	
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title

INTO unique_emp_titles 
FROM retirement_titles as rt 
WHERE rt.to_date = ('9999-01-01')
ORDER BY rt.emp_no, rt.to_date DESC;

	
-- # emp in current title + emp retiring 
SELECT COUNT (uet.emp_no), uet.title
INTO retiring_titles
FROM unique_emp_titles as uet
GROUP BY uet.title
ORDER BY uet.count DESC;

--mentorship eligibility 

SELECT DISTINCT ON (e.emp_no) e.emp_no,
	    e.first_name,
	    e.last_name,
	e.birth_date,
		de.from_date,
	de.to_date,
		ti.title	
INTO mentorship_eligibilty
FROM employees as e 

INNER JOIN dept_emp as de
	ON (e.emp_no = de.emp_no)
	
INNER JOIN titles as ti
	ON (e.emp_no = ti.emp_no)
	
WHERE ti.to_date = ('9999-01-01')
	AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'

ORDER BY e.emp_no;
		


SELECT * FROM employees
SELECT * FROM dept_emp
SELECT * FROM titles
SELECT * FROM retiring_titles
SELECT * FROM unique_emp_titles
SELECT * FROM mentorship_eligibilty