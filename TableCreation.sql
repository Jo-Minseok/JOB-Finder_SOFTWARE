-----------------------------------------------------------------------------------------------
------------------------------------------- ���̺� ���� -----------------------------------------
-----------------------------------------------------------------------------------------------

-- ���� ��ü ���̺�
DROP TABLE ����ȸ�� CASCADE CONSTRAINTS;
DROP TABLE ��� CASCADE CONSTRAINTS;
DROP TABLE ���ȸ�� CASCADE CONSTRAINTS;
-- �༺ ��ü ���̺�
DROP TABLE �̷¼� CASCADE CONSTRAINTS;
DROP TABLE ä��_�Խñ� CASCADE CONSTRAINTS;
DROP TABLE ä��_����ȸ CASCADE CONSTRAINTS;
-- ���߰� ���̺�
DROP TABLE �̷¼�_�ڰ��� CASCADE CONSTRAINTS;
DROP TABLE �̷¼�_��� CASCADE CONSTRAINTS;
-- ���� ���̺�
DROP TABLE ������_���� CASCADE CONSTRAINTS;
DROP TABLE ���� CASCADE CONSTRAINTS;
-- ��� �� ���� ���̺�
DROP TABLE �Խñۼ� CASCADE CONSTRAINTS;
DROP TABLE ����_����Ʈ_����_���� CASCADE CONSTRAINTS;
DROP TABLE ���_����Ʈ_����_���� CASCADE CONSTRAINTS;
DROP TABLE ����_ȸ��_����_���� CASCADE CONSTRAINTS;
DROP TABLE ���_ȸ��_����_���� CASCADE CONSTRAINTS;
DROP TABLE ����_���_��� CASCADE CONSTRAINTS;

-- ������
DROP SEQUENCE ä��_�Խñ۹�ȣ_SEQ;
-----------------------------------------------------------------------------------------------
------------------------------------------- ���̺� ���� -----------------------------------------
-----------------------------------------------------------------------------------------------

-- ���� ��ü
CREATE TABLE ����ȸ��(
    ȸ��ID NVARCHAR2(32),
    ��й�ȣ NVARCHAR2(32),
    �̸� NCHAR(8),
    ������� DATE,
    ���� NCHAR (2),
    �޴��� NCHAR(13),
    ����_���� NCHAR(6),
    ��������_��ȿ�Ⱓ NUMBER(2,0),
    �������� DATE,
    ����Ʈ NUMBER(38,0),
    �̷¼�_�ۼ��� NUMBER(38,0),
    ���_�̸� NVARCHAR2(60),
    ���� NUMBER(38,0),
    ��å NCHAR(6),
    CONSTRAINT PK_����ȸ�� PRIMARY KEY(ȸ��ID),
    CONSTRAINT UK_����ȸ�� UNIQUE (�޴���)
);

CREATE TABLE ���(
 �̸� NVARCHAR2(60),
 ��� NVARCHAR2(60),
 ������� NVARCHAR2(20),
 �ں��� NUMBER(38,0),
 ��ǥ�� NVARCHAR2(60),
 ����� NUMBER(5,0),
 ������ DATE,
 ����� NUMBER(38,0),
 �������� NUMBER(38,0),
 ���� NCHAR(6),
 CONSTRAINT PK_��� PRIMARY KEY(�̸�)
);

CREATE TABLE ���ȸ��(
    ����� NVARCHAR2 (60),
    ȸ��ID NVARCHAR2(32),
    ��й�ȣ NVARCHAR2(32),
    �̸� NVARCHAR2(8),
    ����ڵ�Ϲ�ȣ NVARCHAR2(12),
    �޴��� NCHAR(13),
    ��������_��ȿ�Ⱓ NUMBER(2,0),
    �������� DATE,
    ����Ʈ NUMBER(38,0),
    �Խñ�_�ۼ��� NUMBER(38,0),
    CONSTRAINT PK_���ȸ�� PRIMARY KEY(ȸ��ID),
    CONSTRAINT FK_���ȸ�� FOREIGN KEY (�����) REFERENCES ���(�̸�)
);

-- �༺ ��ü
CREATE TABLE �̷¼�(
    �ۼ���ID NVARCHAR2(32),
    �̷¼��� NVARCHAR2(40),
    �з� NVARCHAR2(16),
    ���� NUMBER(3,0),
    �ؿ�_����_Ƚ�� NUMBER(2,0),
    �ۼ����� DATE,
    CONSTRAINT PK_�̷¼� PRIMARY KEY (�ۼ���ID, �̷¼���),
    CONSTRAINT FK_�̷¼� FOREIGN KEY(�ۼ���ID) REFERENCES ����ȸ��(ȸ��ID)
);

CREATE TABLE ä��_�Խñ�(
    �Խñ�_��ȣ NUMBER(38,0),
    �ۼ���ID NVARCHAR2(32),
    ���� NVARCHAR2(60),
    ä��_�з� NVARCHAR2(60),
    ������� NVARCHAR2(10),
    �޿� NUMBER(38,0),
    ���� NCHAR(6),
    �ٹ��ð� NUMBER(2,0),
    �����ο� NUMBER(38,0),
    ��å NCHAR(6),
    ������ DATE,
    CONSTRAINT PK_ä��_�Խñ� PRIMARY KEY(�Խñ�_��ȣ),
    CONSTRAINT FK_ä��_�Խñ� FOREIGN KEY (�ۼ���ID) REFERENCES ���ȸ��(ȸ��ID)
);

CREATE TABLE ä��_����ȸ(
    ����� NVARCHAR2(60),
    ����ȸ�� NVARCHAR2(60),
    ȸ�� NUMBER(3,0),
    �Ͻ� DATE,
    ��� NVARCHAR2(60),
    CONSTRAINT PK_ä��_����ȸ PRIMARY KEY(�����, ����ȸ��, ȸ��),
    CONSTRAINT FK_ä��_����ȸ FOREIGN KEY (�����) REFERENCES ���(�̸�)
);

-- ���߰� ���̺�
CREATE TABLE �̷¼�_�ڰ���(
    �̷¼�_�ۼ��� NVARCHAR2(32),
    �̷¼��� NVARCHAR2(40),
    �ڰ����� NVARCHAR2(32),
    CONSTRAINT PK_�̷¼�_�ڰ��� PRIMARY KEY(�̷¼�_�ۼ���,�̷¼���,�ڰ�����),
    CONSTRAINT FK_�̷¼�_�ڰ��� FOREIGN KEY(�̷¼�_�ۼ���,�̷¼���) REFERENCES �̷¼�(�ۼ���ID,�̷¼���)
);

CREATE TABLE �̷¼�_���(
    ȸ��ID NVARCHAR2(32),
    �̷¼��� NVARCHAR2(40),
    ���_��ġ NVARCHAR2(60),
    ��� NUMBER(2,0),
    ���� NCHAR(6),
    ���� NUMBER(11,0),
    CONSTRAINT PK_�̷¼�_��� PRIMARY KEY (ȸ��ID,�̷¼���,���_��ġ),
    CONSTRAINT FK_�̷¼�_��� FOREIGN KEY (ȸ��ID, �̷¼���) REFERENCES �̷¼�(�ۼ���ID, �̷¼���)
);

-- ���� ���̺�
CREATE TABLE ������_����(
    ������ NVARCHAR2(32),
    �̷¼�_�ۼ��� NVARCHAR2(32),
    �̷¼��� NVARCHAR2(40),
    �������� DATE,
    CONSTRAINT FK_������_����_������ FOREIGN KEY(������) REFERENCES ���ȸ��(ȸ��ID),
    CONSTRAINT FK_������_����_�̷¼� FOREIGN KEY(�̷¼�_�ۼ���, �̷¼���) REFERENCES �̷¼�(�ۼ���ID, �̷¼���),
    CONSTRAINT PK_������_���� PRIMARY KEY(������, �̷¼�_�ۼ���,�̷¼���)
);

CREATE TABLE ����(
    �Խñ�_��ȣ NUMBER(38,0),
    ������ NVARCHAR2 (32),
    �̷¼��� NVARCHAR2(40),
    �Ͻ����� DATE,
    �հ�_���� CHAR(1),
    CONSTRAINT FK_����_ä��Խñ� FOREIGN KEY (�Խñ�_��ȣ) REFERENCES ä��_�Խñ�(�Խñ�_��ȣ),
    CONSTRAINT FK_����_�̷¼� FOREIGN KEY (������, �̷¼���) REFERENCES �̷¼�(�ۼ���ID, �̷¼���),
    CONSTRAINT PK_���� PRIMARY KEY(�Խñ�_��ȣ,������,�̷¼���)
);

-- ���泻�� �� ��� ���� ���̺�
CREATE TABLE �Խñۼ�(
    �з� NVARCHAR2(32),
    �Խñۼ� NUMBER(38,0)
);

CREATE TABLE ����_����Ʈ_����_����(
    ȸ��ID NVARCHAR2(32),
    ���� NCHAR(40),
    ����Ʈ NUMBER(38,0),
    CONSTRAINT FK_����_����Ʈ�������� FOREIGN KEY (ȸ��ID) REFERENCES ����ȸ��(ȸ��ID)
);

CREATE TABLE ���_����Ʈ_����_����(
    ȸ��ID NVARCHAR2(32),
    ���� NCHAR(40),
    ����Ʈ NUMBER(38,0),
    CONSTRAINT FK_���_����Ʈ�������� FOREIGN KEY (ȸ��ID) REFERENCES ���ȸ��(ȸ��ID)
);

CREATE TABLE ����_ȸ��_����_����(
    ȸ��ID NVARCHAR2(32),
    ����_�� NCHAR(40),
    ����_������ NVARCHAR2(76),
    CONSTRAINT FK_����_����_�������� FOREIGN KEY (ȸ��ID) REFERENCES ���ȸ��(ȸ��ID)
);

CREATE TABLE ���_ȸ��_����_����(
    ȸ��ID NVARCHAR2(32),
    ����_�� NCHAR(40),
    ����_������ NVARCHAR2(76),
    CONSTRAINT FK_���_����_�������� FOREIGN KEY (ȸ��ID) REFERENCES ���ȸ��(ȸ��ID)
);

CREATE TABLE ����_���_���(
    ����� NVARCHAR2(60),
    ��å NCHAR(6),
    ��� NUMBER(38,0),
    CONSTRAINT FK_����_���_��� FOREIGN KEY (�����) REFERENCES ���(�̸�),
    CONSTRAINT PK_����_���_��� PRIMARY KEY (�����, ��å)
);
-----------------------------------------------------------------------------------------------
-------------------------------------------- ������ --------------------------------------------
-----------------------------------------------------------------------------------------------
-- ������: �Խñ� ��ȣ �ڵ� �ο�
CREATE SEQUENCE ä��_�Խñ۹�ȣ_SEQ
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 99999999
CYCLE;

-----------------------------------------------------------------------------------------------
-------------------------------------------- Ʈ���� --------------------------------------------
-----------------------------------------------------------------------------------------------
-- ������: �Խñ� ��ȣ �ڵ� �ο�
CREATE OR REPLACE TRIGGER ä��_�Խñ۹�ȣ_SEQ_TRIG BEFORE INSERT ON ä��_�Խñ�
FOR EACH ROW
BEGIN
    SELECT ä��_�Խñ۹�ȣ_SEQ.NEXTVAL INTO :NEW.�Խñ�_��ȣ FROM DUAL;
END;

-- ȸ�� ���� ���� ��� ���� �翬�� �� ���� ���� ���� ����

-- ä��/����ȸ �Խñ� �ۼ�

-- ����Ʈ ���� �� ���

-- ȸ�� Ż��
-----------------------------------------------------------------------------------------------
------------------------------------------- ���ν��� -------------------------------------------
-----------------------------------------------------------------------------------------------
------------------------------------- [ID/PW ã�� FROM] -----------------------------------------
-- ����ȸ��
CREATE OR REPLACE PROCEDURE PASSWROD_PROTECTION_PERSONAL(��ID IN ����ȸ��.ȸ��ID%TYPE, �κк�й�ȣ OUT CHAR)
AS
BEGIN
    SELECT RPAD(SUBSTR(��й�ȣ,1,3),LENGTH(��й�ȣ),'*') INTO �κк�й�ȣ FROM ����ȸ�� WHERE ȸ��ID = ��ID;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        �κк�й�ȣ := '���̵� �������� �ʽ��ϴ�!';
END;
-- ���ȸ��
CREATE OR REPLACE PROCEDURE PASSWROD_PROTECTION_BUSINESS(��ID IN ����ȸ��.ȸ��ID%TYPE, �κк�й�ȣ OUT CHAR)
AS
BEGIN
    SELECT RPAD(SUBSTR(��й�ȣ,1,3),LENGTH(��й�ȣ),'*') INTO �κк�й�ȣ FROM ���ȸ�� WHERE ȸ��ID = ��ID;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        �κк�й�ȣ := '���̵� �������� �ʽ��ϴ�!';
END;

-------------------------------------- [ȸ������ FROM] ------------------------------------------
-- ���� ȸ��
CREATE OR REPLACE PROCEDURE CREATE_ACCOUNT_PERSONAL(
    ȸ���̸� IN ����ȸ��.�̸�%TYPE,
    ��ȭ��ȣ IN ����ȸ��.��ȭ��ȣ%TYPE,
    ȸ��ID IN ����ȸ��.ȸ��ID%TYPE,
    ��й�ȣ IN ����ȸ��.��й�ȣ%TYPE,
    ������� IN ����ȸ��.�������%TYPE,
    ���� IN ����ȸ��.����%TYPE)
AS
    ��ȯ��_��ȭ��ȣ ����ȸ��.��ȭ��ȣ%TYPE;
BEGIN   

    IF((SELECT LENGTH(��ȭ��ȣ) FROM DUAL) != 13) THEN
        BEGIN
            ��ȯ��_��ȭ��ȣ := SUBSTR(��ȭ��ȣ, 1,3) || '-' || SUBSTR(��ȭ��ȣ, 4,4) || '-' || SUBSTR(��ȭ��ȣ, 8,4);
    RETURN 'ȸ������ �Ϸ�';
END;
-- ��� ȸ��
CREATE OR REPLACE PROCEDURE CREATE_ACCOUNT_BUSINESS()
AS
BEGIN
END;
-------------------------------------- [�̷¼� ��ȸ FROM] ------------------------------------------
CREATE OR REPLACE PROCEDURE 
------------------------------------ [�����췯 + ���ν���] ------------------------------------------
-- �̷¼� ���� ���ν���
CREATE OR REPLACE PROCEDURE DELETE_RESUME_DEADLINE()
AS
    ����_��¥ DATE := SYSDATE;
BEGIN
    DELETE FROM �̷¼� WHERE �ۼ����� < (����_��¥ - INTERVAL '3' YEAR);
END;

CREATE OR REPLACE PROCEDURE DELETE_POSITION_DEADLINE()
AS
    ����_��¥ DATE := SYSDATE;
BEGIN
    DELETE FROM ������_���� WHERE �������� < ����_��¥;
END;

CREATE OR REPLACE PROCEDURE DELETE_JOB_VACANCY()
AS
    ����_��¥ DATE := SYSDATE;
BEGIN
    DELETE FROM WHERE ������ < ����_��¥;
END;
-----------------------------------------------------------------------------------------------
------------------------------------------- �����ٷ� -------------------------------------------
-----------------------------------------------------------------------------------------------
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        -- 
        JOB_NAME => '����_����_�̷¼�_����',
        JOB_TYPE => 'PLSQL_BLOCK',
        JOB_ACTION => 'BEGIN DELETE_RESUME_DEADLINE; END;',
        -- START_DATE : �������� �۵��� ���� �� �ð�. �Է��� �������� �����췯�� ���۵ȴ�. AM 00�÷� ������
        START_DATE => TRUNC(SYSDATE) + INTERVAL '1' DAY,
        -- REPEAT_INTERVAL => �������� �۵��ϴ� �ֱ�. �Ϸ� �ѹ� ���� ����.
        REPEAT_INTERVAL => 'FREQ=DAILY; BYHOUR=0; BYMINUTE=0; BYSECOND=0',
        END_DATE => NULL,
        ENABLED => TRUE
    );
    
    DBMS_SCHEDULER.CREATE_JOB(
        -- 
        JOB_NAME => '����_����_������_����_����',
        JOB_TYPE => 'PLSQL_BLOCK',
        JOB_ACTION => 'BEGIN DELETE_POSITION_DEADLINE; END;',
        -- START_DATE : �������� �۵��� ���� �� �ð�. �Է��� �������� �����췯�� ���۵ȴ�. AM 00�÷� ������
        START_DATE => TRUNC(SYSDATE) + INTERVAL '1' DAY,
        -- REPEAT_INTERVAL => �������� �۵��ϴ� �ֱ�. �Ϸ� �ѹ� ���� ����.
        REPEAT_INTERVAL => 'FREQ=DAILY; BYHOUR=0; BYMINUTE=0; BYSECOND=0',
        END_DATE => NULL,
        ENABLED => TRUE
    );
    
    DBMS_SCHEDULER.CREATE_JOB(
        -- 
        JOB_NAME => '����_����_ä��_�Խñ�_����',
        JOB_TYPE => 'PLSQL_BLOCK',
        JOB_ACTION => 'BEGIN DELETE_JOB_VACANCY; END;',
        -- START_DATE : �������� �۵��� ���� �� �ð�. �Է��� �������� �����췯�� ���۵ȴ�. AM 00�÷� ������
        START_DATE => TRUNC(SYSDATE) + INTERVAL '1' DAY,
        -- REPEAT_INTERVAL => �������� �۵��ϴ� �ֱ�. �Ϸ� �ѹ� ���� ����.
        REPEAT_INTERVAL => 'FREQ=DAILY; BYHOUR=0; BYMINUTE=0; BYSECOND=0',
        END_DATE => NULL,
        ENABLED => TRUE
    );
END;