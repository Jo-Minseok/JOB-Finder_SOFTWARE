-----------------------------------------------------------------------------------------------
------------------------------------------- ���ν��� -------------------------------------------
-----------------------------------------------------------------------------------------------
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


------------------------------------- [ID/PW ã�� FROM] -----------------------------------------
-- ����ȸ��
CREATE OR REPLACE PROCEDURE PASSWORD_PROTECTION_PERSONAL(��ID IN ����ȸ��.ȸ��ID%TYPE, �κк�й�ȣ OUT CHAR)
AS
BEGIN
    SELECT RPAD(SUBSTR(��й�ȣ,1,3),LENGTH(��й�ȣ),'*') INTO �κк�й�ȣ FROM ����ȸ�� WHERE ȸ��ID = ��ID;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        �κк�й�ȣ := '���̵� �������� �ʽ��ϴ�!';
END;
-- ���ȸ��
CREATE OR REPLACE PROCEDURE PASSWORD_PROTECTION_BUSINESS(��ID IN ����ȸ��.ȸ��ID%TYPE, �κк�й�ȣ OUT CHAR)
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
    ȸ��ID IN ����ȸ��.ȸ��ID%TYPE,
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
    ������_ID ����ȸ��.ȸ��ID%TYPE;
BEGIN
    SELECT ȸ��ID INTO ������_ID FROM ����_ȸ��_����_����  WHERE ����_ȸ��_����_����.����_�� = 'Ż��' AND ����_ȸ��_����_����.ȸ��ID = ȸ��ID;
    IF(NOT SQL%NOTFOUND) THEN
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
    
    IF REGEXP_LIKE(ȸ��ID,'\s') OR LENGTH(ȸ��ID) <=6 OR NOT REGEXP_LIKE(ȸ��ID,'[[:alpha:]]') OR NOT REGEXP_LIKE(ȸ��ID,'[[:digit:]]') THEN
        RAISE_APPLICATION_ERROR(-20002, 'ȸ��ID�� ������ �ùٸ��� �ʰų� ID ���̰� 6�ڸ� ���� �ʽ��ϴ�.');
    END IF;
    
     IF REGEXP_LIKE(ȸ��ID,'\s') OR LENGTH(ȸ��ID) <=8 OR NOT REGEXP_LIKE(ȸ��ID,'[[:alpha:]]') OR NOT REGEXP_LIKE(ȸ��ID,'[[:digit:]]') THEN
        RAISE_APPLICATION_ERROR(-20003, '��й�ȣ�� ������ �ùٸ��� �ʰų� ���̰� 8�ڸ� ���� �ʽ��ϴ�.');
    END IF;
    
    IF EXTRACT(YEAR FROM �������) < EXTRACT(YEAR FROM SYSDATE) - 20 THEN
        RAISE_APPLICATION_ERROR(-20004, '�̼����ڴ� ������ �Ұ����մϴ�.'|| TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-20) ||' ���� ��� ���� ���� ����.');
    END IF;
    
    IF NOT (����='��' OR ����='��') THEN
        RAISE_APPLICATION_ERROR(-20005, '������ �ùٸ��� �ʽ��ϴ�.(''��'',''��''�� �Է��ϼ���.)');
    END IF;
    INSERT INTO ����ȸ�� VALUES (ȸ��ID, ��й�ȣ, ȸ���̸�, �������, ����, ��ȯ��_�޴���, ����_����, ��������_��ȿ�Ⱓ, SYSDATE, 0, 0, ���_�̸�, ����,��å);
    INSERT INTO ����_ȸ��_����_���� VALUES (ȸ��ID,'����',NULL);
    �Ϸ�:='ȸ�������� �����߽��ϴ�.';
END;
-- ��� ȸ��
CREATE OR REPLACE PROCEDURE CREATE_ACCOUNT_BUSINESS(
    ����� IN ���ȸ��.�����%TYPE,
    ȸ���̸� IN ���ȸ��.�̸�%TYPE,
    �޴��� IN ���ȸ��.�޴���%TYPE,
    ȸ��ID IN ���ȸ��.ȸ��ID%TYPE,
    ��й�ȣ IN ���ȸ��.��й�ȣ%TYPE,
    ����������ȿ�Ⱓ IN ���ȸ��.��������_��ȿ�Ⱓ%TYPE)
AS
    ��ȯ��_�޴��� ���ȸ��.�޴���%TYPE;
    ������_ID ���ȸ��.ȸ��ID%TYPE;
BEGIN   
    SELECT ȸ��ID INTO ������_ID FROM ���_ȸ��_����_���� WHERE ���_ȸ��_����_����.����_�� = 'Ż��' AND ���_ȸ��_����_����.ȸ��ID = ȸ��ID;
    IF(NOT SQL%NOTFOUND) THEN
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
    
    IF REGEXP_LIKE(ȸ��ID,'\s') OR LENGTH(ȸ��ID) <=6 OR NOT REGEXP_LIKE(ȸ��ID,'[[:alpha:]]') OR NOT REGEXP_LIKE(ȸ��ID,'[[:digit:]]') THEN
        RAISE_APPLICATION_ERROR(-20002, 'ȸ��ID�� ������ �ùٸ��� �ʰų� ID ���̰� 6�ڸ� ���� �ʽ��ϴ�.');
    END IF;
    
     IF REGEXP_LIKE(ȸ��ID,'\s') OR LENGTH(ȸ��ID) <=8 OR NOT REGEXP_LIKE(ȸ��ID,'[[:alpha:]]') OR NOT REGEXP_LIKE(ȸ��ID,'[[:digit:]]') THEN
        RAISE_APPLICATION_ERROR(-20003, '��й�ȣ�� ������ �ùٸ��� �ʰų� ���̰� 8�ڸ� ���� �ʽ��ϴ�.');
    END IF;
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
        UPDATE ä��_�Խñ� SET ����� = (SELECT �����ο� FROM ä��_�Խñ� WHERE �Խñ�_��ȣ = POST_NUMBER)/APPLY_COUNT * 100 WHERE �Խñ�_��ȣ = POST_NUMBER;
    END LOOP;
    CLOSE CURSOR_COMPITION_RATE;
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