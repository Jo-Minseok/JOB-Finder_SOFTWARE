-----------------------------------------------------------------------------------------------
-------------------------------------------- Ʈ���� --------------------------------------------
-----------------------------------------------------------------------------------------------
DROP TRIGGER ����_ȸ����������_TRIG_BEFORE;
DROP TRIGGER ���_ȸ����������_TRIG;

DROP TRIGGER ä��Խñ�_TRIG;
DROP TRIGGER ä�뼳��ȸ_TRIG;

DROP TRIGGER ����_����Ʈ_����_TRIG;
DROP TRIGGER ���_����Ʈ_����_TRIG;

DROP TRIGGER  ����_TRIG;
-- ������
DROP SEQUENCE POST_NUMBER_SEQ;
DROP TRIGGER POST_NUMBER_TRIG;

-- ȸ�� ���� ����
CREATE OR REPLACE TRIGGER ����_ȸ����������_TRIG_BEFORE BEFORE UPDATE ON ����ȸ��
FOR EACH ROW
BEGIN
    IF :NEW.�޴��� <> :OLD.�޴��� THEN
        BEGIN   
            IF LENGTH(:NEW.�޴���) = 11 THEN
                BEGIN
                    :NEW.�޴��� := SUBSTR(:NEW.�޴���, 1,3) || '-' || SUBSTR(:NEW.�޴���, 4,4) || '-' || SUBSTR(:NEW.�޴���, 8,4);
                END;
            ELSIF LENGTH(:NEW.�޴���) <> 13 THEN
                BEGIN
                    RAISE_APPLICATION_ERROR(-20001, '�޴��� ��ȣ�� �Է��� �ùٸ��� �ʽ��ϴ�.');
                END;
            END IF;
        END;
    END IF;
        
    IF :NEW.��й�ȣ <> :OLD.��й�ȣ THEN
        BEGIN
            IF REGEXP_LIKE(:NEW.��й�ȣ,'\s') OR LENGTH(:NEW.��й�ȣ) <8 OR NOT REGEXP_LIKE(:NEW.��й�ȣ,'[[:alpha:]]') OR NOT REGEXP_LIKE(:NEW.��й�ȣ,'[[:digit:]]') THEN
                BEGIN
                    RAISE_APPLICATION_ERROR(-20003, '��й�ȣ�� ������ �ùٸ��� �ʰų� ���̰� 8�ڸ� ���� �ʽ��ϴ�.');
                END;
            END IF;
        END;
    END IF;
        
    IF :NEW.������� <> :OLD.������� THEN
        BEGIN
            IF EXTRACT(YEAR FROM :NEW.�������) > EXTRACT(YEAR FROM SYSDATE) - 20 THEN
                BEGIN
                    RAISE_APPLICATION_ERROR(-20004, '�̼����ڷ� ������ �Ұ����մϴ�. '|| TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-20) ||'���� ������� ���� ����.');
                END;
            END IF;
        END;
    END IF;
        
    IF :NEW.���� <> :OLD.���� THEN
        BEGIN  
            IF NOT (:NEW.����='��' OR :NEW.����='��') THEN
                BEGIN
                    RAISE_APPLICATION_ERROR(-20005, '������ �ùٸ��� �ʽ��ϴ�.(''��'',''��''�� �Է��ϼ���.)');
                END;
            END IF;
        END;
    END IF;
    
    IF :NEW.��й�ȣ <> :OLD.��й�ȣ THEN
        BEGIN
            INSERT INTO ����_ȸ��_����_���� VALUES (:NEW.ȸ��ID, '��й�ȣ', :NEW.��й�ȣ, :OLD.��й�ȣ);
        END;
    END IF;
        
    IF :NEW.�̸� <> :OLD.�̸� THEN
        BEGIN
            INSERT INTO ����_ȸ��_����_���� VALUES (:NEW.ȸ��ID, '�̸�', :NEW.�̸�, :OLD.�̸�);
        END;
    END IF;
        
    IF :NEW.������� <> :OLD.������� THEN
        BEGIN
            INSERT INTO ����_ȸ��_����_���� VALUES (:NEW.ȸ��ID, '�������', :NEW.�������, :OLD.�������);
        END;
    END IF;
        
    IF :NEW.���� <> :OLD.���� THEN
        BEGIN
            INSERT INTO ����_ȸ��_����_���� VALUES (:NEW.ȸ��ID, '����', :NEW.����, :OLD.����);
        END;
    END IF;
        
    IF :NEW.�޴��� <> :OLD.�޴��� THEN
        BEGIN   
            INSERT INTO ����_ȸ��_����_���� VALUES (:NEW.ȸ��ID, '�޴���', :NEW.�޴���, :OLD.�޴���);
        END;
    END IF;
        
    IF :NEW.����_���� <> :OLD.����_���� THEN
        BEGIN
            INSERT INTO ����_ȸ��_����_���� VALUES (:NEW.ȸ��ID, '����_����', :NEW.����_����, :OLD.����_����);
        END;
    END IF;
        
    IF :NEW.��������_��ȿ�Ⱓ <> :OLD.��������_��ȿ�Ⱓ THEN
        BEGIN
            INSERT INTO ����_ȸ��_����_���� VALUES (:NEW.ȸ��ID, '��������_��ȿ�Ⱓ', :NEW.��������_��ȿ�Ⱓ, :OLD.��������_��ȿ�Ⱓ);
        END;
    END IF;
END;

CREATE OR REPLACE TRIGGER ���_ȸ����������_TRIG BEFORE UPDATE ON ���ȸ��
FOR EACH ROW
BEGIN
    IF :NEW.�޴��� <> :OLD.�޴��� THEN
        IF(LENGTH(:NEW.�޴���) = 11) THEN
            BEGIN
                :NEW.�޴��� := SUBSTR(:NEW.�޴���, 1,3) || '-' || SUBSTR(:NEW.�޴���, 4,4) || '-' || SUBSTR(:NEW.�޴���, 8,4);
            END;
        ELSIF LENGTH(:NEW.�޴���) <> 13 THEN
            BEGIN
                RAISE_APPLICATION_ERROR(-20001, '��ȭ��ȣ�� �Է��� �ùٸ��� �ʽ��ϴ�.');
            END;
        END IF;
    END IF;
    
    IF :NEW.��й�ȣ <> :OLD.��й�ȣ THEN
        IF REGEXP_LIKE(:NEW.��й�ȣ,'\s') OR LENGTH(:NEW.��й�ȣ) <8 OR NOT REGEXP_LIKE(:NEW.��й�ȣ,'[[:alpha:]]') OR NOT REGEXP_LIKE(:NEW.��й�ȣ,'[[:digit:]]') THEN
            RAISE_APPLICATION_ERROR(-20003, '��й�ȣ�� ������ �ùٸ��� �ʰų� ���̰� 8�ڸ� ���� �ʽ��ϴ�.');
        END IF;
    END IF;

    IF :NEW.�̸� <> :OLD.�̸� THEN
        INSERT INTO ���_ȸ��_����_���� VALUES (:NEW.ȸ��ID, '�̸�', :NEW.�̸�, :OLD.�̸�);
    END IF;
    IF :NEW.��������_��ȿ�Ⱓ <> :OLD.��������_��ȿ�Ⱓ THEN
        INSERT INTO ���_ȸ��_����_���� VALUES (:NEW.ȸ��ID, '��������_��ȿ�Ⱓ', :NEW.��������_��ȿ�Ⱓ, :OLD.��������_��ȿ�Ⱓ);
    END IF;
    IF :NEW.�޴��� <> :OLD.�޴��� THEN
        INSERT INTO ���_ȸ��_����_���� VALUES (:NEW.ȸ��ID, '�޴���', :NEW.�޴���, :OLD.�޴���);
    END IF;
    IF :NEW.��й�ȣ <> :OLD.��й�ȣ THEN
        INSERT INTO ���_ȸ��_����_���� VALUES (:NEW.ȸ��ID, '��й�ȣ', :NEW.��й�ȣ, :OLD.��й�ȣ);
    END IF;
END;

-- ä��/����ȸ �Խñ� �ۼ�
CREATE OR REPLACE TRIGGER ä��Խñ�_TRIG AFTER INSERT ON ä��_�Խñ�
FOR EACH ROW
BEGIN
    IF(:NEW.������ < SYSDATE) THEN
        RAISE_APPLICATION_ERROR(-20008, '���� ��¥���� ���� ���� ������ �� �����ϴ�!' || SYSDATE || '���ķ� �����ּ���');
    END IF;
END;

CREATE OR REPLACE TRIGGER ä�뼳��ȸ_TRIG AFTER INSERT ON ä��_����ȸ
FOR EACH ROW
BEGIN
    IF(:NEW.�Ͻ� < SYSDATE) THEN
        RAISE_APPLICATION_ERROR(-20009, '���� ��¥���� ���� ���� ������ �� �����ϴ�!' || SYSDATE || '���ķ� �����ּ���');
    END IF;
END;

CREATE OR REPLACE TRIGGER ����_����Ʈ_����_TRIG AFTER UPDATE ON ����ȸ��
FOR EACH ROW
BEGIN
    IF(:NEW.����Ʈ < 0) THEN
        RAISE_APPLICATION_ERROR(-20007, '����Ʈ�� �����մϴ�.');
    ELSIF(:NEW.����Ʈ > :OLD.����Ʈ) THEN
        INSERT INTO ����_����Ʈ_����_���� VALUES (:NEW.ȸ��ID,'�߰�',:NEW.����Ʈ - :OLD.����Ʈ);
    END IF;
END;

CREATE OR REPLACE TRIGGER ���_����Ʈ_����_TRIG AFTER UPDATE ON ���ȸ��
FOR EACH ROW
BEGIN
    IF(:NEW.����Ʈ < 0) THEN
        RAISE_APPLICATION_ERROR(-20007, '����Ʈ�� �����մϴ�.');
    ELSIF(:NEW.����Ʈ > :OLD.����Ʈ) THEN
        INSERT INTO ���_����Ʈ_����_���� VALUES (:NEW.ȸ��ID,'�߰�',:NEW.����Ʈ - :OLD.����Ʈ);
    END IF;
END;
----------------------------------------------------------------------- ������ ------------------------------------------------------------
CREATE SEQUENCE POST_NUMBER_SEQ
MINVALUE 1
NOMAXVALUE
INCREMENT BY 1 START WITH 1
NOCYCLE;

CREATE OR REPLACE TRIGGER POST_NUMBER_TRIG BEFORE INSERT ON ä��_�Խñ�
FOR EACH ROW
BEGIN
    SELECT POST_NUMBER_SEQ.NEXTVAL INTO :NEW.�Խñ�_��ȣ FROM DUAL;
END;