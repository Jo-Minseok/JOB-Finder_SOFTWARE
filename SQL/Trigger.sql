-----------------------------------------------------------------------------------------------
-------------------------------------------- 트리거 --------------------------------------------
-----------------------------------------------------------------------------------------------
DROP TRIGGER 개인_회원정보수정_TRIG_BEFORE;
DROP TRIGGER 기업_회원정보수정_TRIG;

DROP TRIGGER 채용게시글_TRIG;
DROP TRIGGER 채용설명회_TRIG;

DROP TRIGGER 개인_포인트_변경_TRIG;
DROP TRIGGER 기업_포인트_변경_TRIG;

DROP TRIGGER  지원_TRIG;
-- 시퀀스
DROP SEQUENCE POST_NUMBER_SEQ;
DROP TRIGGER POST_NUMBER_TRIG;

-- 회원 정보 수정
CREATE OR REPLACE TRIGGER 개인_회원정보수정_TRIG_BEFORE BEFORE UPDATE ON 개인회원
FOR EACH ROW
BEGIN
    IF :NEW.휴대폰 <> :OLD.휴대폰 THEN
        BEGIN   
            IF LENGTH(:NEW.휴대폰) = 11 THEN
                BEGIN
                    :NEW.휴대폰 := SUBSTR(:NEW.휴대폰, 1,3) || '-' || SUBSTR(:NEW.휴대폰, 4,4) || '-' || SUBSTR(:NEW.휴대폰, 8,4);
                END;
            ELSIF LENGTH(:NEW.휴대폰) <> 13 THEN
                BEGIN
                    RAISE_APPLICATION_ERROR(-20001, '휴대폰 번호의 입력이 올바르지 않습니다.');
                END;
            END IF;
        END;
    END IF;
        
    IF :NEW.비밀번호 <> :OLD.비밀번호 THEN
        BEGIN
            IF REGEXP_LIKE(:NEW.비밀번호,'\s') OR LENGTH(:NEW.비밀번호) <8 OR NOT REGEXP_LIKE(:NEW.비밀번호,'[[:alpha:]]') OR NOT REGEXP_LIKE(:NEW.비밀번호,'[[:digit:]]') THEN
                BEGIN
                    RAISE_APPLICATION_ERROR(-20003, '비밀번호의 형식이 올바르지 않거나 길이가 8자를 넘지 않습니다.');
                END;
            END IF;
        END;
    END IF;
        
    IF :NEW.생년월일 <> :OLD.생년월일 THEN
        BEGIN
            IF EXTRACT(YEAR FROM :NEW.생년월일) > EXTRACT(YEAR FROM SYSDATE) - 20 THEN
                BEGIN
                    RAISE_APPLICATION_ERROR(-20004, '미성년자로 수정이 불가능합니다. '|| TO_CHAR(EXTRACT(YEAR FROM SYSDATE)-20) ||'이전 년생으로 수정 가능.');
                END;
            END IF;
        END;
    END IF;
        
    IF :NEW.성별 <> :OLD.성별 THEN
        BEGIN  
            IF NOT (:NEW.성별='남' OR :NEW.성별='여') THEN
                BEGIN
                    RAISE_APPLICATION_ERROR(-20005, '성별이 올바르지 않습니다.(''남'',''여''로 입력하세요.)');
                END;
            END IF;
        END;
    END IF;
    
    IF :NEW.비밀번호 <> :OLD.비밀번호 THEN
        BEGIN
            INSERT INTO 개인_회원_정보_변경 VALUES (:NEW.회원ID, '비밀번호', :NEW.비밀번호, :OLD.비밀번호);
        END;
    END IF;
        
    IF :NEW.이름 <> :OLD.이름 THEN
        BEGIN
            INSERT INTO 개인_회원_정보_변경 VALUES (:NEW.회원ID, '이름', :NEW.이름, :OLD.이름);
        END;
    END IF;
        
    IF :NEW.생년월일 <> :OLD.생년월일 THEN
        BEGIN
            INSERT INTO 개인_회원_정보_변경 VALUES (:NEW.회원ID, '생년월일', :NEW.생년월일, :OLD.생년월일);
        END;
    END IF;
        
    IF :NEW.성별 <> :OLD.성별 THEN
        BEGIN
            INSERT INTO 개인_회원_정보_변경 VALUES (:NEW.회원ID, '성별', :NEW.성별, :OLD.성별);
        END;
    END IF;
        
    IF :NEW.휴대폰 <> :OLD.휴대폰 THEN
        BEGIN   
            INSERT INTO 개인_회원_정보_변경 VALUES (:NEW.회원ID, '휴대폰', :NEW.휴대폰, :OLD.휴대폰);
        END;
    END IF;
        
    IF :NEW.거주_지역 <> :OLD.거주_지역 THEN
        BEGIN
            INSERT INTO 개인_회원_정보_변경 VALUES (:NEW.회원ID, '거주_지역', :NEW.거주_지역, :OLD.거주_지역);
        END;
    END IF;
        
    IF :NEW.개인정보_유효기간 <> :OLD.개인정보_유효기간 THEN
        BEGIN
            INSERT INTO 개인_회원_정보_변경 VALUES (:NEW.회원ID, '개인정보_유효기간', :NEW.개인정보_유효기간, :OLD.개인정보_유효기간);
        END;
    END IF;
END;

CREATE OR REPLACE TRIGGER 기업_회원정보수정_TRIG BEFORE UPDATE ON 기업회원
FOR EACH ROW
BEGIN
    IF :NEW.휴대폰 <> :OLD.휴대폰 THEN
        IF(LENGTH(:NEW.휴대폰) = 11) THEN
            BEGIN
                :NEW.휴대폰 := SUBSTR(:NEW.휴대폰, 1,3) || '-' || SUBSTR(:NEW.휴대폰, 4,4) || '-' || SUBSTR(:NEW.휴대폰, 8,4);
            END;
        ELSIF LENGTH(:NEW.휴대폰) <> 13 THEN
            BEGIN
                RAISE_APPLICATION_ERROR(-20001, '전화번호의 입력이 올바르지 않습니다.');
            END;
        END IF;
    END IF;
    
    IF :NEW.비밀번호 <> :OLD.비밀번호 THEN
        IF REGEXP_LIKE(:NEW.비밀번호,'\s') OR LENGTH(:NEW.비밀번호) <8 OR NOT REGEXP_LIKE(:NEW.비밀번호,'[[:alpha:]]') OR NOT REGEXP_LIKE(:NEW.비밀번호,'[[:digit:]]') THEN
            RAISE_APPLICATION_ERROR(-20003, '비밀번호의 형식이 올바르지 않거나 길이가 8자를 넘지 않습니다.');
        END IF;
    END IF;

    IF :NEW.이름 <> :OLD.이름 THEN
        INSERT INTO 기업_회원_정보_변경 VALUES (:NEW.회원ID, '이름', :NEW.이름, :OLD.이름);
    END IF;
    IF :NEW.개인정보_유효기간 <> :OLD.개인정보_유효기간 THEN
        INSERT INTO 기업_회원_정보_변경 VALUES (:NEW.회원ID, '개인정보_유효기간', :NEW.개인정보_유효기간, :OLD.개인정보_유효기간);
    END IF;
    IF :NEW.휴대폰 <> :OLD.휴대폰 THEN
        INSERT INTO 기업_회원_정보_변경 VALUES (:NEW.회원ID, '휴대폰', :NEW.휴대폰, :OLD.휴대폰);
    END IF;
    IF :NEW.비밀번호 <> :OLD.비밀번호 THEN
        INSERT INTO 기업_회원_정보_변경 VALUES (:NEW.회원ID, '비밀번호', :NEW.비밀번호, :OLD.비밀번호);
    END IF;
END;

-- 채용/설명회 게시글 작성
CREATE OR REPLACE TRIGGER 채용게시글_TRIG AFTER INSERT ON 채용_게시글
FOR EACH ROW
BEGIN
    IF(:NEW.마감일 < SYSDATE) THEN
        RAISE_APPLICATION_ERROR(-20008, '현재 날짜보다 이전 날로 마감할 수 없습니다!' || SYSDATE || '이후로 맞춰주세요');
    END IF;
END;

CREATE OR REPLACE TRIGGER 채용설명회_TRIG AFTER INSERT ON 채용_설명회
FOR EACH ROW
BEGIN
    IF(:NEW.일시 < SYSDATE) THEN
        RAISE_APPLICATION_ERROR(-20009, '현재 날짜보다 이전 날로 개최할 수 없습니다!' || SYSDATE || '이후로 맞춰주세요');
    END IF;
END;

CREATE OR REPLACE TRIGGER 개인_포인트_변경_TRIG AFTER UPDATE ON 개인회원
FOR EACH ROW
BEGIN
    IF(:NEW.포인트 < 0) THEN
        RAISE_APPLICATION_ERROR(-20007, '포인트가 부족합니다.');
    ELSIF(:NEW.포인트 > :OLD.포인트) THEN
        INSERT INTO 개인_포인트_수정_내역 VALUES (:NEW.회원ID,'추가',:NEW.포인트 - :OLD.포인트);
    END IF;
END;

CREATE OR REPLACE TRIGGER 기업_포인트_변경_TRIG AFTER UPDATE ON 기업회원
FOR EACH ROW
BEGIN
    IF(:NEW.포인트 < 0) THEN
        RAISE_APPLICATION_ERROR(-20007, '포인트가 부족합니다.');
    ELSIF(:NEW.포인트 > :OLD.포인트) THEN
        INSERT INTO 기업_포인트_수정_내역 VALUES (:NEW.회원ID,'추가',:NEW.포인트 - :OLD.포인트);
    END IF;
END;
----------------------------------------------------------------------- 시퀀스 ------------------------------------------------------------
CREATE SEQUENCE POST_NUMBER_SEQ
MINVALUE 1
NOMAXVALUE
INCREMENT BY 1 START WITH 1
NOCYCLE;

CREATE OR REPLACE TRIGGER POST_NUMBER_TRIG BEFORE INSERT ON 채용_게시글
FOR EACH ROW
BEGIN
    SELECT POST_NUMBER_SEQ.NEXTVAL INTO :NEW.게시글_번호 FROM DUAL;
END;