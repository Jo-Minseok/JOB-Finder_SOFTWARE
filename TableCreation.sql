-----------------------------------------------------------------------------------------------
------------------------------------------- ������ ���� -----------------------------------------
-----------------------------------------------------------------------------------------------
TRUNCATE TABLE ����;
TRUNCATE TABLE ����_���_���;
TRUNCATE TABLE ���_ȸ��_����_����;
TRUNCATE TABLE ����_ȸ��_����_����;
TRUNCATE TABLE ���_����Ʈ_����_����;
TRUNCATE TABLE ����_����Ʈ_����_����;
TRUNCATE TABLE �Խñۼ�;
TRUNCATE TABLE ����;
TRUNCATE TABLE ������_����;
TRUNCATE TABLE �̷¼�_���;
TRUNCATE TABLE �̷¼�_�ڰ���;
TRUNCATE TABLE ä��_����ȸ;
TRUNCATE TABLE ä��_�Խñ�;
TRUNCATE TABLE �̷¼�;
TRUNCATE TABLE ���ȸ��;
TRUNCATE TABLE ����ȸ��;
TRUNCATE TABLE ���;
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
-- ��� �� ����, ��Ÿ ������ ���̺�
DROP TABLE �Խñۼ� CASCADE CONSTRAINTS;
DROP TABLE ����_����Ʈ_����_���� CASCADE CONSTRAINTS;
DROP TABLE ���_����Ʈ_����_���� CASCADE CONSTRAINTS;
DROP TABLE ����_ȸ��_����_���� CASCADE CONSTRAINTS;
DROP TABLE ���_ȸ��_����_���� CASCADE CONSTRAINTS;
DROP TABLE ����_���_��� CASCADE CONSTRAINTS;
DROP TABLE ����;
-----------------------------------------------------------------------------------------------
------------------------------------------- ���̺� ���� -----------------------------------------
-----------------------------------------------------------------------------------------------

-- ���� ��ü
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
    CONSTRAINT UK_����ȸ�� UNIQUE (�޴���),
    CONSTRAINT FK_����ȸ�� FOREIGN KEY (���_�̸�) REFERENCES ���(�̸�) ON DELETE SET NULL
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
    CONSTRAINT FK_���ȸ�� FOREIGN KEY (�����) REFERENCES ���(�̸�) ON DELETE CASCADE
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
    CONSTRAINT FK_�̷¼� FOREIGN KEY(�ۼ���ID) REFERENCES ����ȸ��(ȸ��ID) ON DELETE CASCADE
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
    ����� NUMBER(3,0),
    CONSTRAINT PK_ä��_�Խñ� PRIMARY KEY(�Խñ�_��ȣ),
    CONSTRAINT FK_ä��_�Խñ� FOREIGN KEY (�ۼ���ID) REFERENCES ���ȸ��(ȸ��ID) ON DELETE CASCADE
);

CREATE TABLE ä��_����ȸ(
    ����� NVARCHAR2(60),
    ����ȸ�� NVARCHAR2(60),
    ȸ�� NUMBER(3,0),
    �Ͻ� DATE,
    ��� NVARCHAR2(60),
    CONSTRAINT PK_ä��_����ȸ PRIMARY KEY(�����, ����ȸ��, ȸ��),
    CONSTRAINT FK_ä��_����ȸ FOREIGN KEY (�����) REFERENCES ���(�̸�) ON DELETE CASCADE
);

-- ���߰� ���̺�
CREATE TABLE �̷¼�_�ڰ���(
    �̷¼�_�ۼ��� NVARCHAR2(32),
    �̷¼��� NVARCHAR2(40),
    �ڰ����� NVARCHAR2(32),
    CONSTRAINT PK_�̷¼�_�ڰ��� PRIMARY KEY(�̷¼�_�ۼ���,�̷¼���,�ڰ�����),
    CONSTRAINT FK_�̷¼�_�ڰ��� FOREIGN KEY(�̷¼�_�ۼ���,�̷¼���) REFERENCES �̷¼�(�ۼ���ID,�̷¼���) ON DELETE CASCADE
);

CREATE TABLE �̷¼�_���(
    ȸ��ID NVARCHAR2(32),
    �̷¼��� NVARCHAR2(40),
    ���_��ġ NVARCHAR2(60),
    ��� NUMBER(2,0),
    ���� NCHAR(6),
    ���� NUMBER(11,0),
    CONSTRAINT PK_�̷¼�_��� PRIMARY KEY (ȸ��ID,�̷¼���,���_��ġ),
    CONSTRAINT FK_�̷¼�_��� FOREIGN KEY (ȸ��ID, �̷¼���) REFERENCES �̷¼�(�ۼ���ID, �̷¼���) ON DELETE CASCADE
);

-- ���� ���̺�
CREATE TABLE ������_����(
    ������ NVARCHAR2(32),
    �̷¼�_�ۼ��� NVARCHAR2(32),
    �̷¼��� NVARCHAR2(40),
    �������� DATE,
    CONSTRAINT FK_������_����_������ FOREIGN KEY(������) REFERENCES ���ȸ��(ȸ��ID) ON DELETE CASCADE,
    CONSTRAINT FK_������_����_�̷¼� FOREIGN KEY(�̷¼�_�ۼ���, �̷¼���) REFERENCES �̷¼�(�ۼ���ID, �̷¼���) ON DELETE CASCADE,
    CONSTRAINT PK_������_���� PRIMARY KEY(������, �̷¼�_�ۼ���,�̷¼���)
);

CREATE TABLE ����(
    �Խñ�_��ȣ NUMBER(38,0),
    ������ NVARCHAR2 (32),
    �̷¼��� NVARCHAR2(40),
    �Ͻ����� DATE,
    �հ�_���� CHAR(1),
    CONSTRAINT FK_����_ä��Խñ� FOREIGN KEY (�Խñ�_��ȣ) REFERENCES ä��_�Խñ�(�Խñ�_��ȣ) ON DELETE CASCADE,
    CONSTRAINT FK_����_�̷¼� FOREIGN KEY (������, �̷¼���) REFERENCES �̷¼�(�ۼ���ID, �̷¼���) ON DELETE CASCADE,
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
    CONSTRAINT FK_����_����Ʈ�������� FOREIGN KEY (ȸ��ID) REFERENCES ����ȸ��(ȸ��ID) ON DELETE CASCADE
);

CREATE TABLE ���_����Ʈ_����_����(
    ȸ��ID NVARCHAR2(32),
    ���� NCHAR(40),
    ����Ʈ NUMBER(38,0),
    CONSTRAINT FK_���_����Ʈ�������� FOREIGN KEY (ȸ��ID) REFERENCES ���ȸ��(ȸ��ID) ON DELETE CASCADE
);

CREATE TABLE ����_ȸ��_����_����(
    ȸ��ID NVARCHAR2(32),
    ����_�� NCHAR(40),
    ����_������ NVARCHAR2(76)
);

CREATE TABLE ���_ȸ��_����_����(
    ȸ��ID NVARCHAR2(32),
    ����_�� NCHAR(40),
    ����_������ NVARCHAR2(76)
);

CREATE TABLE ����_���_���(
    ����� NVARCHAR2(60),
    ��å NCHAR(6),
    ��� NUMBER(38,0),
    CONSTRAINT FK_����_���_��� FOREIGN KEY (�����) REFERENCES ���(�̸�) ON DELETE CASCADE,
    CONSTRAINT PK_����_���_��� PRIMARY KEY (�����, ��å)
);

CREATE TABLE ����(
    ������ NCHAR(4)
);