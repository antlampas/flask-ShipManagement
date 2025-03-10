CREATE TABLE IF NOT EXISTS Personal_base_informations(
    First_name CHAR(255),
    Last_name  CHAR(255),
    Nickname   CHAR(32),
    PRIMARY KEY(Firstname,Lastname,Nickname)
);
CREATE TABLE IF NOT EXISTS Duty(
    Name        CHAR(64),
    Description VARCHAR(65535),
    PRIMARY KEY(Name)
);
CREATE TABLE IF NOT EXISTS Rank_t(
    Name        CHAR(64),
    Description VARCHAR(65535),
    PRIMARY KEY(Name)
);
CREATE TABLE IF NOT EXISTS Division(
    Name        CHAR(64),
    Description VARCHAR(65535),
    PRIMARY KEY(Name)
);
CREATE TABLE IF NOT EXISTS Crew_member(
    Nickname CHAR(32),
    Duty     CHAR(64),
    Rank_t   CHAR(64),
    Division CHAR(64),
    FOREIGN KEY (Nickname) REFERENCES Personal_base_informations(Nickname),
    FOREIGN KEY (Duty)     REFERENCES Duty(Name),
    FOREIGN KEY (Rank_t)   REFERENCES Rank_t(Name),
    FOREIGN KEY (Division) REFERENCES Division(Name)
);
CREATE TABLE IF NOT EXISTS Task(
    Name              CHAR(64),
    Description       VARCHAR(65535),
    Objective         CHAR(64),
    Required_duration INT(10),
    Started_at        INT(14),
    Ended_at          INT(14),
    Status            CHAR(16),
    PRIMARY KEY(Name)
);
CREATE TABLE IF NOT EXISTS Mission_base_informations(
    Name              CHAR(64),
    Description       VARCHAR(65535),
    Required_duration INT(10),
    Started_at        INT(14),
    Ended_at          INT(14),
    Status            CHAR(16),
    PRIMARY KEY(Name)
);
CREATE TABLE IF NOT EXISTS Mission(
    Mission CHAR(64),
    Task    CHAR(64),
    FOREIGN KEY (Mission) REFERENCES Mission_base_information(Name),
    FOREIGN KEY (Task)    REFERENCES Task(Name)
);
CREATE TABLE IF NOT EXISTS Member_duty_log_entry(
    Crew_member CHAR(32),
    Duty        CHAR(64),
    Period      INT(14),
    Status      CHAR(16),
    Grade       CHAR(16),
    FOREIGN KEY (Crew_member) REFERENCES Crew_member(Nickname),
    FOREIGN KEY (Duty)        REFERENCES Duty(Name)
);
CREATE TABLE IF NOT EXISTS Member_onboard_log_entry(
    Crew_member CHAR(32),
    Period      INT(14),
    FOREIGN KEY (Crew_member) REFERENCES Crew_member(Nickname)
);
CREATE TABLE IF NOT EXISTS Member_rank_log_entry(
    Crew_member CHAR(32),
    Rank_t      CHAR(64),
    Period      INT(10),
    Status      CHAR(16),
    Grade       CHAR(16),
    FOREIGN KEY (Crew_member) REFERENCES Crew_member(Nickname),
    FOREIGN KEY (Rank_t)      REFERENCES Rank_t(Name)
);
CREATE TABLE IF NOT EXISTS Member_division_log_entry(
    Crew_member CHAR(32),
    Division    CHAR(64),
    Period      INT(14),
    Status      CHAR(16),
    Grade       CHAR(16),
    FOREIGN KEY (Crew_member) REFERENCES Crew_member(Nickname),
    FOREIGN KEY (Division)    REFERENCES Division(Name)
);
CREATE TABLE IF NOT EXISTS Member_task_log_entry(
    Crew_member CHAR(32),
    Task        CHAR(64),
    Period      INT(14),
    Status      CHAR(16),
    Grade       CHAR(16),
    FOREIGN KEY (Crew_member) REFERENCES Crew_member(Nickname),
    FOREIGN KEY (Task)        REFERENCES Task(Name)
);
CREATE TABLE IF NOT EXISTS Member_mission_log_entry(
    Crew_member CHAR(32),
    Mission     CHAR(64),
    Period      INT(14),
    Status      CHAR(16),
    Grade       CHAR(16),
    FOREIGN KEY (Crew_member) REFERENCES Crew_member(Nickname),
    FOREIGN KEY (Mission)     REFERENCES Mission(Name)
);
CREATE VIEW Onboard_Log AS
SELECT DISTINCT Crew_member.Nickname AS Member
FROM Crew_member
UNION ALL
SELECT Member_onboard_log_entry.Period AS Onboard_log_entry
FROM Crew_member,Member_onboard_log_entry
WHERE Member_onboard_log_entry.Period = Crew_member.Nickname
UNION ALL
SELECT Member_duty_log_entry.Duty AS Duty_log_entry
FROM Crew_member,Member_duty_log_entry
WHERE Member_duty_log_entry.Duty = Crew_member.Nickname
UNION ALL
SELECT Member_duty_log_entry.Period AS DutyPeriod
FROM Crew_member,Member_duty_log_entry
WHERE Member_duty_log_entry.Period = Crew_member.Nickname
UNION ALL
SELECT Member_rank_log_entry.Rank_t AS Rank_log_entry
FROM Crew_member,Member_rank_log_entry
WHERE Member_rank_log_entry.Rank_t = Crew_member.Nickname
UNION ALL
SELECT Member_rank_log_entry.Period AS Rank_Period
FROM Crew_member,Member_rank_log_entry
WHERE Member_rank_log_entry.Period = Crew_member.Nickname
UNION ALL
SELECT Member_division_log_entry.Division AS Division_log_entry
FROM Crew_member,Member_division_log_entry
WHERE Member_division_log_entry.Division = Crew_member.Nickname
UNION ALL
SELECT Member_division_log_entry.Period AS Division_period
FROM Crew_member,Member_division_log_entry
WHERE Member_division_log_entry.Period = Crew_member.Nickname
UNION ALL
SELECT Member_task_log_entry.Task AS Task_log_entry
FROM Crew_member,Member_task_log_entry
WHERE Member_task_log_entry.Task = Crew_member.Nickname
UNION ALL
SELECT Member_task_log_entry.Period AS Task_period
FROM Crew_member,Member_task_log_entry
WHERE Member_task_log_entry.Period = Crew_member.Nickname;
