-----------------------------------------------------------------------------------------------
------------------------------------------- ���ν��� -------------------------------------------
-----------------------------------------------------------------------------------------------
DROP PROCEDURE MAIN_FIND;
DROP PROCEDURE PASSWORD_PROTECTION_PERSONAL;
DROP PROCEDURE PASSWORD_PROTECTION_BUSINESS;
DROP PROCEDURE CREATE_ACCOUNT_PERSONAL;
DROP PROCEDURE CREATE_ACCOUNT_BUSINESS;

DBMS_SCHEDULER.DROP_JOB('����_����_�̷¼�_����');
DBMS_SCHEDULER.DROP_JOB('����_����_������_����_����');
DBMS_SCHEDULER.DROP_JOB('����_����_ä��_�Խñ�_����');
DROP PROCEDURE DELETE_RESUME_DEADLINE;
DROP PROCEDURE DELETE_POSITION_DEADLINE;
DROP PROCEDURE DELETE_JOB_VACANCY;

------------------------------------- [Edit_Info] ----------------------------------------------
CREATE OR REPLACE PROCEDURE RECALCULATE(
�ֱ�_ȸ�� NVARCHAR2,
����_ȸ�� NVARCHAR2,
�ֱ�_��å NVARCHAR2,
����_��å NVARCHAR2,
�ֱ�_���� NUMBER,
����_���� NUMBER)
AS
TMP_���� NUMBER;
BEGIN
        SELECT AVG(����) INTO TMP_���� FROM ����ȸ�� WHERE ���_�̸� = �ֱ�_ȸ��;
        UPDATE ����_���_��� SET ��� = TMP_���� WHERE ����� = �ֱ�_ȸ�� AND ��å= �ֱ�_��å;
        SELECT AVG(����) INTO TMP_���� FROM ����ȸ�� WHERE ���_�̸�= ����_ȸ�� AND ��å= ����_��å;
        UPDATE ����_���_��� SET ��� = TMP_���� WHERE ����� = ����_ȸ�� AND ��å= ����_��å;
END;
-------------------------------------- [Main Form] ---------------------------------------------
CREATE OR REPLACE PROCEDURE MAIN_FIND(
��� IN NVARCHAR2,
��ID IN ����ȸ��.ȸ��ID%TYPE,
������ IN DATE,
���_�̸� OUT ����ȸ��.�̸�%TYPE,
���_����Ʈ OUT NUMBER,
���_�Խñ�_�ۼ��� OUT NUMBER,
����_���� OUT NUMBER,
����_�Խñ� OUT NUMBER)
AS
BEGIN
    IF ��� = '����' THEN
        BEGIN
            SELECT �̸�, ����Ʈ, �̷¼�_�ۼ��� INTO ���_�̸�, ���_����Ʈ, ���_�Խñ�_�ۼ��� FROM ����ȸ�� WHERE ȸ��ID = ��ID;
            SELECT COUNT(*) INTO ����_���� FROM ������_���� WHERE �̷¼�_�ۼ��� = ��ID;
        END;
    ELSE
        BEGIN
            SELECT �̸�, ����Ʈ, �Խñ�_�ۼ��� INTO ���_�̸�, ���_����Ʈ, ���_�Խñ�_�ۼ��� FROM ���ȸ�� WHERE ȸ��ID = ��ID;
            SELECT COUNT(*) INTO ����_���� FROM ���� WHERE �Խñ�_��ȣ IN (SELECT �Խñ�_��ȣ FROM ä��_�Խñ� WHERE �ۼ���ID = ��ID);
        END;
    END IF;
    SELECT COUNT(*) INTO ����_�Խñ� FROM ä��_�Խñ� WHERE ������ > ������;
END;

------------------------------------- [ID/PW ã�� FROM] -----------------------------------------
-- ����ȸ��
CREATE OR REPLACE PROCEDURE PASSWORD_PROTECTION_PERSONAL(��ID IN ����ȸ��.ȸ��ID%TYPE, �κк�й�ȣ OUT NVARCHAR2)
AS
BEGIN
    SELECT RPAD(SUBSTR(��й�ȣ,1,3),LENGTH(��й�ȣ),'*') INTO �κк�й�ȣ FROM ����ȸ�� WHERE ȸ��ID = ��ID;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        �κк�й�ȣ := '���̵� �������� �ʽ��ϴ�!';
END;
-- ���ȸ��
CREATE OR REPLACE PROCEDURE PASSWORD_PROTECTION_BUSINESS(��ID IN ����ȸ��.ȸ��ID%TYPE, �κк�й�ȣ OUT NVARCHAR2)
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
    �޴��� IN ����ȸ��.�޴���%TYPE,
    �Է�ȸ��ID IN ����ȸ��.ȸ��ID%TYPE,
    ��й�ȣ IN ����ȸ��.��й�ȣ%TYPE,
    ������� IN ����ȸ��.�������%TYPE,
    ���� IN ����ȸ��.����%TYPE,
    ����_���� IN ����ȸ��.����_����%TYPE,
    ��������_��ȿ�Ⱓ IN ����ȸ��.��������_��ȿ�Ⱓ%TYPE,
    ���_�̸� IN ����ȸ��.���_�̸�%TYPE,
    ���� IN ����ȸ��.����%TYPE,
    ��å IN ����ȸ��.��å%TYPE,
    �Ϸ� OUT NVARCHAR2)
AS
    ��ȯ��_�޴��� ����ȸ��.�޴���%TYPE;
    ROW_COUNT NUMBER;
BEGIN
    SELECT COUNT(ȸ��ID) INTO ROW_COUNT FROM ����_ȸ��_����_���� WHERE ����_ȸ��_����_����.ȸ��ID = �Է�ȸ��ID AND ����_ȸ��_����_����.����_�� = 'Ż��';
    IF (ROW_COUNT!=0) THEN
        RAISE_APPLICATION_ERROR(-20008, '�̹� Ż���� ȸ���Դϴ�.');
    END IF;
    IF(LENGTH(�޴���) = 11) THEN
        BEGIN
            ��ȯ��_�޴��� := SUBSTR(�޴���, 1,3) || '-' || SUBSTR(�޴���, 4,4) || '-' || SUBSTR(�޴���, 8,4);
        END;
    ELSIF(LENGTH(�޴���) = 13) THEN
        BEGIN
            ��ȯ��_�޴��� := �޴���;
        END;
    ELSE
        BEGIN
            RAISE_APPLICATION_ERROR(-20001, '��ȭ��ȣ�� �Է��� �ùٸ��� �ʽ��ϴ�.');
        END;
    END IF;
    
    IF REGEXP_LIKE(�Է�ȸ��ID,'\s') OR LENGTH(�Է�ȸ��ID) <6 OR NOT REGEXP_LIKE(�Է�ȸ��ID,'[[:alpha:]]') OR NOT REGEXP_LIKE(�Է�ȸ��ID,'[[:digit:]]') THEN
        RAISE_APPLICATION_ERROR(-20002, 'ȸ��ID�� ������ �ùٸ��� �ʰų� ID ���̰� 6�ڸ� ���� �ʽ��ϴ�.');
    END IF;
    
     IF REGEXP_LIKE(��й�ȣ,'\s') OR LENGTH(��й�ȣ) <8 OR NOT REGEXP_LIKE(��й�ȣ,'[[:alpha:]]') OR NOT REGEXP_LIKE(��й�ȣ,'[[:digit:]]') THEN
        RAISE_APPLICATION_ERROR(-20003, '��й�ȣ�� ������ �ùٸ��� �ʰų� ���̰� 8�ڸ� ���� �ʽ��ϴ�.');
    END IF;
    
    IF EXTRACT(YEAR FROM �������) > EXTRACT(YEAR FROM SYSDATE) - 20 THEN
        RAISE_APPLICATION_ERROR(-20004, '�̼����ڴ� ������ �Ұ����մϴ�. '|| TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-20) ||' ���� ��� ���� ���� ����.');
    END IF;
    
    IF NOT (����='��' OR ����='��') THEN 
        RAISE_APPLICATION_ERROR(-20005, '������ �ùٸ��� �ʽ��ϴ�.(''��'',''��''�� �Է��ϼ���.)');
    END IF;
    INSERT INTO ����ȸ�� VALUES (�Է�ȸ��ID, ��й�ȣ, ȸ���̸�, �������, ����, ��ȯ��_�޴���, ����_����, ��������_��ȿ�Ⱓ, SYSDATE, 0, 0, ���_�̸�, ����,��å);
    INSERT INTO ����_ȸ��_����_���� VALUES (�Է�ȸ��ID,'����',NULL,NULL);
    �Ϸ�:='ȸ�������� �����߽��ϴ�.';
END;
-- ��� ȸ��
CREATE OR REPLACE PROCEDURE CREATE_ACCOUNT_BUSINESS(
    ����� IN ���ȸ��.�����%TYPE,
    ȸ���̸� IN ���ȸ��.�̸�%TYPE,
    �޴��� IN ���ȸ��.�޴���%TYPE,
    �Է�ȸ��ID IN ���ȸ��.ȸ��ID%TYPE,
    ��й�ȣ IN ���ȸ��.��й�ȣ%TYPE,
    ����������ȿ�Ⱓ IN ���ȸ��.��������_��ȿ�Ⱓ%TYPE,
    ����ڵ�Ϲ�ȣ IN ���ȸ��.����ڵ�Ϲ�ȣ%TYPE,
    �Ϸ� OUT NVARCHAR2)
AS
    ��ȯ��_�޴��� ���ȸ��.�޴���%TYPE;
    ROW_COUNT NUMBER;
BEGIN   
    SELECT COUNT(ȸ��ID) INTO ROW_COUNT FROM ���_ȸ��_����_���� WHERE ���_ȸ��_����_����.����_�� = 'Ż��' AND ���_ȸ��_����_����.ȸ��ID = �Է�ȸ��ID;
    IF(ROW_COUNT <> 0) THEN
        RAISE_APPLICATION_ERROR(-20008, '�̹� Ż���� ȸ���Դϴ�.');
    END IF;
    IF(LENGTH(�޴���) = 11) THEN
        BEGIN
            ��ȯ��_�޴��� := SUBSTR(�޴���, 1,3) || '-' || SUBSTR(�޴���, 4,4) || '-' || SUBSTR(�޴���, 8,4);
        END;
    ELSIF(LENGTH(�޴���) = 13) THEN
        BEGIN
            ��ȯ��_�޴��� := �޴���;
        END;
    ELSE
        BEGIN
            RAISE_APPLICATION_ERROR(-20001, '��ȭ��ȣ�� �Է��� �ùٸ��� �ʽ��ϴ�.');
        END;
    END IF;
    
    IF REGEXP_LIKE(�Է�ȸ��ID,'\s') OR LENGTH(�Է�ȸ��ID) <=6 OR NOT REGEXP_LIKE(�Է�ȸ��ID,'[[:alpha:]]') OR NOT REGEXP_LIKE(�Է�ȸ��ID,'[[:digit:]]') THEN
        RAISE_APPLICATION_ERROR(-20002, 'ȸ��ID�� ������ �ùٸ��� �ʰų� ID ���̰� 6�ڸ� ���� �ʽ��ϴ�.');
    END IF;
    
     IF REGEXP_LIKE(��й�ȣ,'\s') OR LENGTH(��й�ȣ) <=8 OR NOT REGEXP_LIKE(��й�ȣ,'[[:alpha:]]') OR NOT REGEXP_LIKE(��й�ȣ,'[[:digit:]]') THEN
        RAISE_APPLICATION_ERROR(-20003, '��й�ȣ�� ������ �ùٸ��� �ʰų� ���̰� 8�ڸ� ���� �ʽ��ϴ�.');
    END IF;
    INSERT INTO ���ȸ�� VALUES (�����, �Է�ȸ��ID, ��й�ȣ, ȸ���̸�, ����ڵ�Ϲ�ȣ, ��ȯ��_�޴���, ����������ȿ�Ⱓ, SYSDATE, 0, 0);
    INSERT INTO ���_ȸ��_����_���� VALUES (�Է�ȸ��ID,'����',NULL,NULL);
    �Ϸ�:='ȸ�������� �����߽��ϴ�.';
END;
-------------------------------------- [�̷¼� ��ȸ FROM] ------------------------------------------
CREATE OR REPLACE PROCEDURE COMPITITION_RATE
AS
    POST_NUMBER ä��_�Խñ�.�Խñ�_��ȣ%TYPE;
    APPLY_COUNT NUMBER(38,0);
    CURSOR CURSOR_COMPITION_RATE IS SELECT �Խñ�_��ȣ, COUNT(�Խñ�_��ȣ) FROM ���� GROUP BY �Խñ�_��ȣ;
BEGIN
    OPEN CURSOR_COMPITION_RATE;
    LOOP
        FETCH CURSOR_COMPITION_RATE INTO POST_NUMBER, APPLY_COUNT;
        EXIT WHEN CURSOR_COMPITION_RATE%NOTFOUND;
        UPDATE ä��_�Խñ� SET ����� = APPLY_COUNT/(SELECT �����ο� FROM ä��_�Խñ� WHERE �Խñ�_��ȣ = POST_NUMBER) * 100 WHERE �Խñ�_��ȣ = POST_NUMBER;
    END LOOP;
    CLOSE CURSOR_COMPITION_RATE;
END;

CREATE OR REPLACE PROCEDURE POST_COUNT_PERSONAL
AS
    TMP_ID ����ȸ��.ȸ��ID%TYPE;
    CURSOR CURSOR_PERSONAL IS SELECT ȸ��ID FROM ����ȸ��;
BEGIN
    OPEN CURSOR_PERSONAL;
    LOOP
        FETCH CURSOR_PERSONAL INTO TMP_ID;
        EXIT WHEN CURSOR_PERSONAL%NOTFOUND;
        UPDATE ����ȸ�� SET �̷¼�_�ۼ��� = (SELECT COUNT(*) FROM �̷¼� WHERE �ۼ���ID = TMP_ID) WHERE ȸ��ID = TMP_ID;
    END LOOP;
    CLOSE CURSOR_PERSONAL;
END;

CREATE OR REPLACE PROCEDURE POST_COUNT_BUSINESS
AS
    TMP_ID ���ȸ��.ȸ��ID%TYPE;
    CURSOR CURSOR_PERSONAL IS SELECT ȸ��ID FROM ���ȸ��;
BEGIN
    OPEN CURSOR_PERSONAL;
    LOOP
        FETCH CURSOR_PERSONAL INTO TMP_ID;
        EXIT WHEN CURSOR_PERSONAL%NOTFOUND;
        UPDATE ���ȸ�� SET �Խñ�_�ۼ��� = (SELECT COUNT(*) FROM ä��_�Խñ� WHERE �ۼ���ID = TMP_ID) WHERE ȸ��ID = TMP_ID;
    END LOOP;
    CLOSE CURSOR_PERSONAL;
END;

EXEC COMPITITION_RATE;
EXEC POST_COUNT_PERSONAL;
EXEC POST_COUNT_BUSINESS;
COMMIT;
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

------------------------------------ [�����췯 + ���ν���] ------------------------------------------
-- �̷¼� ���� ���ν���
CREATE OR REPLACE PROCEDURE DELETE_RESUME_DEADLINE
AS
    ����_��¥ DATE := SYSDATE;
BEGIN
    DELETE FROM �̷¼� WHERE �ۼ����� < (����_��¥ - INTERVAL '3' YEAR);
END;

-- ������ ���� ���� ���ν���
CREATE OR REPLACE PROCEDURE DELETE_POSITION_DEADLINE
AS
    ����_��¥ DATE := SYSDATE;
BEGIN
    DELETE FROM ������_���� WHERE �������� < ����_��¥;
END;

-- ä�� �Խñ� ���� ���ν���
CREATE OR REPLACE PROCEDURE DELETE_JOB_VACANCY
AS
    ����_��¥ DATE := SYSDATE;
BEGIN
    DELETE FROM ä��_�Խñ� WHERE ������ < ����_��¥;
END;