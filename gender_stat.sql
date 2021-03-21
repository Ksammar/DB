SELECT 
	gender,
    COUNT(gender) 
FROM user_info
GROUP BY gender