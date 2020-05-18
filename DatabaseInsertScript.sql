/* Database populeren */

INSERT INTO sync_machine_account (username, password)
VALUES ("gebruikersnaam", "wachtwoord"),
	   ("username", "password"),
	   ("user3", "origine");

INSERT INTO jira_user (user_id, origin_instance_user_key, destination_instance_user_key, auto_sync)
VALUES (1, "JIRAUSER10100", "JIRAUSER10200", true),
	   (2, "JIRAUSER10101", "JIRAUSER10201", false),
	   (3, "JIRAUSER10102", "JIRAUSER10202", true);