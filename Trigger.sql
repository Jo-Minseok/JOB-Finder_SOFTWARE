-----------------------------------------------------------------------------------------------
-------------------------------------------- Ʈ���� --------------------------------------------
-----------------------------------------------------------------------------------------------
DROP TRIGGER ����_ȸ����������_TRIG;
DROP TRIGGER ����_ȸ����������_����_TRIG;
DROP TRIGGER ���_ȸ����������_TRIG;
DROP TRIGGER ���_ȸ����������_����_TRIG;
DROP TRIGGER ä��Խñ�_TRIG;
DROP TRIGGER ä�뼳��ȸ_TRIG;
DROP TRIGGER ����_����Ʈ_����_TRIG;
DROP TRIGGER ���_����Ʈ_����_TRIG;
DROP TRIGGER ����_ȸ��_Ż��_TRIG;
DROP TRIGGER ���_ȸ��_Ż��_TRIG;

-- ȸ�� ���� ���� ��� ���� �翬�� �� ���� ���� ���� ����
CREATE OR REPLACE TRIGGER ����_ȸ����������_TRIG BEFORE UPDATE ON ����ȸ��
FOR EACH ROW
DECLARE
    NEW_���� ����ȸ��.����%TYPE;
    OLD_���� ����ȸ��.����%TYPE;
BEGIN
    IF(LENGTH(:NEW.�޴���) = 11) THEN
        BEGIN
            :NEW.�޴��� := SUBSTR(:NEW.�޴���, 1,3) || '-' || SUBSTR(:NEW.�޴���, 4,4) || '-' || SUBSTR(:NEW.�޴���, 8,4);
        END;
    ELSIF LENGTH(:NEW.�޴���) <> 13 THEN
        BEGIN
            RAISE_APPLICATION_ERROR(-20001, '�޴��� ��ȣ�� �Է��� �ùٸ��� �ʽ��ϴ�.');
        END;
    END IF;
    IF REGEXP_LIKE(:NEW.��й�ȣ,'\s') OR LENGTH(:NEW.��й�ȣ) <=8 OR NOT REGEXP_LIKE(:NEW.��й�ȣ,'[[:alpha:]]') OR NOT REGEXP_LIKE(:NEW.��й�ȣ,'[[:digit:]]') THEN
        RAISE_APPLICATION_ERROR(-20003, '��й�ȣ�� ������ �ùٸ��� �ʰų� ���̰� 8�ڸ� ���� �ʽ��ϴ�.');
    END IF;
    IF EXTRACT(YEAR FROM :NEW.�������) < EXTRACT(YEAR FROM SYSDATE) - 20 THEN
        RAISE_APPLICATION_ERROR(-20004, '�̼����ڷ� ������ �Ұ����մϴ�.'||EXTRACT(YEAR FROM SYSDATE)-20 ||'���� ������� ���� ����.');
    END IF;
    IF NOT (:NEW.����='��' OR :NEW.����='��') THEN
        RAISE_APPLICATION_ERROR(-20005, '������ �ùٸ��� �ʽ��ϴ�.(''��'',''��''�� �Է��ϼ���.)');
    END IF;
    
    IF :NEW.���_�̸� <> :OLD.���_�̸� OR :NEW.���� <> :OLD.���� OR :NEW.��å <> :OLD.��å THEN
        SELECT AVG(����) INTO NEW_���� FROM ����ȸ�� WHERE ���_�̸�=:NEW.���_�̸� AND ��å=:NEW.��å;
        SELECT AVG(����) INTO OLD_���� FROM ����ȸ�� WHERE ���_�̸�=:OLD.���_�̸� AND ��å=:OLD.��å;
        UPDATE ����_���_��� SET ��� = NEW_���� WHERE ����� =:NEW.���_�̸� AND ��å=:NEW.��å;
        UPDATE ����_���_��� SET ��� = OLD_���� WHERE ����� =:OLD.���_�̸� AND ��å=:OLD.��å;
    END IF;
    
    IF :NEW.��й�ȣ <> :OLD.��й�ȣ THEN
        INSERT INTO ����_ȸ��_����_���� VALUES (:NEW.ȸ��ID, '��й�ȣ', :NEW.��й�ȣ);
    END IF;
    
    IF :NEW.�̸� <> :OLD.�̸� THEN
        INSERT INTO ����_ȸ��_����_���� VALUES (:NEW.ȸ��ID, '�̸�', :NEW.�̸�);
    END IF;
    
    IF :NEW.������� <> :OLD.������� THEN
        INSERT INTO ����_ȸ��_����_���� VALUES (:NEW.ȸ��ID, '�������', :NEW.�������);
    END IF;
    
    IF :NEW.���� <> :OLD.���� THEN
        INSERT INTO ����_ȸ��_����_���� VALUES (:NEW.ȸ��ID, '����', :NEW.����);
    END IF;
    
    IF :NEW.�޴��� <> :OLD.�޴��� THEN
        INSERT INTO ����_ȸ��_����_���� VALUES (:NEW.ȸ��ID, '�޴���', :NEW.�޴���);
    END IF;
    
    IF :NEW.����_���� <> :OLD.����_���� THEN
        INSERT INTO ����_ȸ��_����_���� VALUES (:NEW.ȸ��ID, '����_����', :NEW.����_����);
    END IF;
    
    IF :NEW.��������_��ȿ�Ⱓ <> :OLD.��������_��ȿ�Ⱓ THEN
        INSERT INTO ����_ȸ��_����_���� VALUES (:NEW.ȸ��ID, '��������_��ȿ�Ⱓ', :NEW.��������_��ȿ�Ⱓ);
    END IF;
    
END;

CREATE OR REPLACE TRIGGER ���_ȸ����������_TRIG BEFORE UPDATE ON ���ȸ��
FOR EACH ROW
BEGIN
    IF(LENGTH(:NEW.�޴���) = 11) THEN
        BEGIN
            :NEW.�޴��� := SUBSTR(:NEW.�޴���, 1,3) || '-' || SUBSTR(:NEW.�޴���, 4,4) || '-' || SUBSTR(:NEW.�޴���, 8,4);
        END;
    ELSIF LENGTH(:NEW.�޴���) <> 13 THEN
        BEGIN
            RAISE_APPLICATION_ERROR(-20001, '��ȭ��ȣ�� �Է��� �ùٸ��� �ʽ��ϴ�.');
        END;
    END IF;
    IF REGEXP_LIKE(:NEW.��й�ȣ,'\s') OR LENGTH(:NEW.��й�ȣ) <=8 OR NOT REGEXP_LIKE(:NEW.��й�ȣ,'[[:alpha:]]') OR NOT REGEXP_LIKE(:NEW.��й�ȣ,'[[:digit:]]') THEN
        RAISE_APPLICATION_ERROR(-20003, '��й�ȣ�� ������ �ùٸ��� �ʰų� ���̰� 8�ڸ� ���� �ʽ��ϴ�.');
    END IF;
    
    IF :NEW.��й�ȣ <> :OLD.��й�ȣ THEN
        INSERT INTO ���_ȸ��_����_���� VALUES (:NEW.ȸ��ID, '��й�ȣ', :NEW.��й�ȣ);
    END IF;
    IF :NEW.�̸� <> :OLD.�̸� THEN
        INSERT INTO ���_ȸ��_����_���� VALUES (:NEW.ȸ��ID, '�̸�', :NEW.�̸�);
    END IF;
    IF :NEW.�޴��� <> :OLD.�޴��� THEN
        INSERT INTO ���_ȸ��_����_���� VALUES (:NEW.ȸ��ID, '�޴���', :NEW.�޴���);
    END IF;
    IF :NEW.��������_��ȿ�Ⱓ <> :OLD.��������_��ȿ�Ⱓ THEN
        INSERT INTO ���_ȸ��_����_���� VALUES (:NEW.ȸ��ID, '��������_��ȿ�Ⱓ', :NEW.��������_��ȿ�Ⱓ);
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
    ELSE
        INSERT INTO ����_����Ʈ_����_���� VALUES (:NEW.ȸ��ID,'���',:NEW.����Ʈ);
    END IF;
    IF(:NEW.����Ʈ > :OLD.����Ʈ) THEN
        INSERT INTO ����_����Ʈ_����_���� VALUES (:NEW.ȸ��ID,'�߰�',:NEW.����Ʈ);
    END IF;
END;

CREATE OR REPLACE TRIGGER ���_����Ʈ_����_TRIG AFTER UPDATE ON ���ȸ��
FOR EACH ROW
BEGIN
    IF(:NEW.����Ʈ < 0) THEN
        RAISE_APPLICATION_ERROR(-20007, '����Ʈ�� �����մϴ�.');
    ELSE
        INSERT INTO ���_����Ʈ_����_���� VALUES (:NEW.ȸ��ID,'���',:NEW.����Ʈ);
    END IF;
    IF(:NEW.����Ʈ > :OLD.����Ʈ) THEN
        INSERT INTO ���_����Ʈ_����_���� VALUES (:NEW.ȸ��ID,'�߰�',:NEW.����Ʈ);
    END IF;
END;

-- ȸ�� Ż��
CREATE OR REPLACE TRIGGER ����_ȸ��_Ż��_TRIG BEFORE DELETE ON ����ȸ��
FOR EACH ROW
BEGIN
    INSERT INTO ����_ȸ��_����_���� VALUES (:OLD.ȸ��ID,'Ż��',NULL);
END;

CREATE OR REPLACE TRIGGER ���_ȸ��_Ż��_TRIG BEFORE DELETE ON ���ȸ��
FOR EACH ROW
BEGIN
    INSERT INTO ���_ȸ��_����_���� VALUES (:OLD.ȸ��ID,'Ż��',NULL);
END;