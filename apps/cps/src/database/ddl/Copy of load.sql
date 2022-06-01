/**
** load.sql
** $Revision: 
** $Log: cps.sql,v $
** Created 1.0 2005/02/04 3:40:00  rzhtj5
** check in
**
**/

SET DEFINE OFF
SET SCAN OFF

DELETE FROM CPS_USER_ROLE_TO_USER;
DELETE FROM CPS_USER_ROLE;
DELETE FROM CPS_USER;

/** Load CPS_USER Table **/

INSERT INTO CPS_USER (USER_ID,NETID) VALUES (CPS_USER_SEQUENCE.NEXTVAL,'czkshk');
INSERT INTO CPS_USER (USER_ID,NETID) VALUES (CPS_USER_SEQUENCE.NEXTVAL,'vz86k2');

/** Load CPS_USER_ROLE Table **/

INSERT INTO CPS_USER_ROLE (ROLE_ID,ROLE) VALUES (CPS_USER_ROLE_SEQUENCE.NEXTVAL,'Admin');
INSERT INTO CPS_USER_ROLE (ROLE_ID,ROLE) VALUES (CPS_USER_ROLE_SEQUENCE.NEXTVAL,'Scripting');
INSERT INTO CPS_USER_ROLE (ROLE_ID,ROLE) VALUES (CPS_USER_ROLE_SEQUENCE.NEXTVAL,'Analysis');


/** Load CPS_USER_ROLE_TO_USER Table **/

INSERT INTO CPS_USER_ROLE_TO_USER (ROLE_ID,USER_ID) SELECT t1.ROLE_ID, t2.USER_ID FROM CPS_USER_ROLE t1, CPS_USER t2 WHERE t1.ROLE = 'Admin' AND t2.NET_ID = 'vz86k2';
INSERT INTO CPS_USER_ROLE_TO_USER (ROLE_ID,USER_ID) SELECT t1.ROLE_ID, t2.USER_ID FROM CPS_USER_ROLE t1, CPS_USER t2 WHERE t1.ROLE = 'Admin' AND t2.NET_ID = 'czkshk';


/** Load CPS_FILE data **/
INSERT INTO CPS_FILE VALUES (102,103,'AUTOPART','PAUL','17-FEB-2005','Erwin paul can access');


/** Load CPS_ATTRIBUTE_TO_FILE data **/
INSERT INTO CPS_ATTRIBUTE_TO_FILE VALUES(101,1001,102);


/** Load CPS_ATTRIBUTE data **/
INSERT INTO CPS_ATTRIBUTE values (1001,'drimodrange','DRI Model Range');


COMMIT;



