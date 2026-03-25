/*==============================================================*/
/* Nom de SGBD :  ORACLE Version 10g                            */
/* Date de cr?ation :  26/02/2025 2:23:13 PM                    */
/*==============================================================*/ 
alter table ASSM
   drop constraint FK_ASSM_RECONNAIT_FSM;

alter table CHOISIR
   drop constraint FK_CHOISIR_CHOISIR_EPREUVE;

alter table CHOISIR
   drop constraint FK_CHOISIR_CHOISIR2_COMMISSA;

alter table CHOISIR
   drop constraint FK_CHOISIR_CHOISIR3_CCR;

alter table COMMISSAIRE
   drop constraint FK_COMMISSA_APPARTENI_CCR;

alter table COMMISSAIRE
   drop constraint FK_COMMISSA_AVOIR_LICENCE;

alter table COMMISSAIRE
   drop constraint FK_COMMISSA_INSCRIRE_ASSM;

alter table CONTENIR
   drop constraint FK_CONTENIR_CONTENIR_INCIDENT;

alter table CONTENIR
   drop constraint FK_CONTENIR_CONTENIR2_EPREUVE;

alter table ENCADRER
   drop constraint FK_ENCADRER_ENCADRER_EPREUVE;

alter table ENCADRER
   drop constraint FK_ENCADRER_ENCADRER2_COMMISSA;

alter table EPREUVE
   drop constraint FK_EPREUVE_ORGANISER_ASSM;

alter table INTERVENIR
   drop constraint FK_INTERVEN_INTERVENI_INCIDENT;

alter table INTERVENIR
   drop constraint FK_INTERVEN_INTERVENI_COMMISSA;

alter table LICENCE
   drop constraint FK_LICENCE_ATTRIBUER_FSM;

drop table ASSM cascade constraints;

drop table CCR cascade constraints;

drop table CHOISIR cascade constraints;

drop table COMMISSAIRE cascade constraints;

drop table CONTENIR cascade constraints;

drop table ENCADRER cascade constraints;

drop table EPREUVE cascade constraints;

drop table FSM cascade constraints;

drop table INCIDENT cascade constraints;

drop table INTERVENIR cascade constraints;

drop table LICENCE cascade constraints;

/*==============================================================*/
/* Table : ASSM                                                 */
/*==============================================================*/
create table ASSM  (
   ID_ASSM              NUMBER                          not null,
   ID_FSM               NUMBER                          not null,
   NOM_ASSM             VARCHAR2(20),
   REGION_ASSM          VARCHAR2(20),
   constraint PK_ASSM primary key (ID_ASSM)
);

/*==============================================================*/
/* Table : CCR                                                  */
/*==============================================================*/
create table CCR  (
   ID_CCR               NUMBER                          not null,
   NOM_CCR              VARCHAR2(20),
   REGION_CCR           VARCHAR2(20),
   constraint PK_CCR primary key (ID_CCR)
);

/*==============================================================*/
/* Table : CHOISIR                                              */
/*==============================================================*/
create table CHOISIR  (
   ID_EP                NUMBER                          not null,
   ID_COM               NUMBER                          not null,
   ID_CCR               NUMBER                          not null,
   DATE_INSC            DATE,
   DATE_RES             DATE,
   RESULTAT             VARCHAR2(20),
   constraint PK_CHOISIR primary key (ID_EP, ID_COM, ID_CCR)
);

/*==============================================================*/
/* Table : COMMISSAIRE                                          */
/*==============================================================*/
create table COMMISSAIRE  (
   ID_COM               NUMBER                          not null,
   ID_LIC               NUMBER                          not null,
   ID_CCR               NUMBER                          not null,
   ID_ASSM              NUMBER                          not null,
   NOM_COM              VARCHAR2(20),
   PRENOM_COM           VARCHAR2(20),
   TELEPHONE_COM        NUMBER(8),
   SALAIRE_COM          NUMBER(8),
   constraint PK_COMMISSAIRE primary key (ID_COM)
);

/*==============================================================*/
/* Table : CONTENIR                                             */
/*==============================================================*/
create table CONTENIR  (
   ID_INC               NUMBER                          not null,
   ID_EP                NUMBER                          not null,
   constraint PK_CONTENIR primary key (ID_INC, ID_EP)
);

/*==============================================================*/
/* Table : ENCADRER                                             */
/*==============================================================*/
create table ENCADRER  (
   ID_EP                NUMBER                          not null,
   ID_COM               NUMBER                          not null,
   NBR_JOURS            NUMBER(8),
   constraint PK_ENCADRER primary key (ID_EP, ID_COM)
);

/*==============================================================*/
/* Table : EPREUVE                                              */
/*==============================================================*/
create table EPREUVE  (
   ID_EP                NUMBER                          not null,
   ID_ASSM              NUMBER                          not null,
   TYPE_EP              VARCHAR2(20),
   ADRESSE_EP           VARCHAR2(20),
   DATE_FIN_EP          DATE,
   DATE_DEB_EP          DATE,
   constraint PK_EPREUVE primary key (ID_EP)
);

/*==============================================================*/
/* Table : FSM                                                  */
/*==============================================================*/
create table FSM  (
   ID_FSM               NUMBER                          not null,
   NOM_FSM              CHAR(20),
   constraint PK_FSM primary key (ID_FSM)
);

/*==============================================================*/
/* Table : INCIDENT                                             */
/*==============================================================*/
create table INCIDENT  (
   ID_INC               NUMBER                          not null,
   DATE_INC             DATE,
   constraint PK_INCIDENT primary key (ID_INC)
);

/*==============================================================*/
/* Table : INTERVENIR                                           */
/*==============================================================*/
create table INTERVENIR  (
   ID_INC               NUMBER                          not null,
   ID_COM               NUMBER                          not null,
   DESCRIPTION          VARCHAR2(30),
   constraint PK_INTERVENIR primary key (ID_INC, ID_COM)
);

/*==============================================================*/
/* Table : LICENCE                                              */
/*==============================================================*/
create table LICENCE  (
   ID_LIC               NUMBER                          not null,
   ID_FSM               NUMBER                          not null,
   DATE_EXP             DATE,
   DATE_OBT             DATE,
   TYPE_LIC             VARCHAR2(30),
   constraint PK_LICENCE primary key (ID_LIC)
);

alter table ASSM
   add constraint FK_ASSM_RECONNAIT_FSM foreign key (ID_FSM)
      references FSM (ID_FSM);

alter table CHOISIR
   add constraint FK_CHOISIR_CHOISIR_EPREUVE foreign key (ID_EP)
      references EPREUVE (ID_EP);

alter table CHOISIR
   add constraint FK_CHOISIR_CHOISIR2_COMMISSA foreign key (ID_COM)
      references COMMISSAIRE (ID_COM);

alter table CHOISIR
   add constraint FK_CHOISIR_CHOISIR3_CCR foreign key (ID_CCR)
      references CCR (ID_CCR);

alter table COMMISSAIRE
   add constraint FK_COMMISSA_APPARTENI_CCR foreign key (ID_CCR)
      references CCR (ID_CCR);

alter table COMMISSAIRE
   add constraint FK_COMMISSA_AVOIR_LICENCE foreign key (ID_LIC)
      references LICENCE (ID_LIC);

alter table COMMISSAIRE
   add constraint FK_COMMISSA_INSCRIRE_ASSM foreign key (ID_ASSM)
      references ASSM (ID_ASSM);

alter table CONTENIR
   add constraint FK_CONTENIR_CONTENIR_INCIDENT foreign key (ID_INC)
      references INCIDENT (ID_INC);

alter table CONTENIR
   add constraint FK_CONTENIR_CONTENIR2_EPREUVE foreign key (ID_EP)
      references EPREUVE (ID_EP);

alter table ENCADRER
   add constraint FK_ENCADRER_ENCADRER_EPREUVE foreign key (ID_EP)
      references EPREUVE (ID_EP);

alter table ENCADRER
   add constraint FK_ENCADRER_ENCADRER2_COMMISSA foreign key (ID_COM)
      references COMMISSAIRE (ID_COM);

alter table EPREUVE
   add constraint FK_EPREUVE_ORGANISER_ASSM foreign key (ID_ASSM)
      references ASSM (ID_ASSM);

alter table INTERVENIR
   add constraint FK_INTERVEN_INTERVENI_INCIDENT foreign key (ID_INC)
      references INCIDENT (ID_INC);

alter table INTERVENIR
   add constraint FK_INTERVEN_INTERVENI_COMMISSA foreign key (ID_COM)
      references COMMISSAIRE (ID_COM);

alter table LICENCE
   add constraint FK_LICENCE_ATTRIBUER_FSM foreign key (ID_FSM)
      references FSM (ID_FSM);

INSERT INTO FSM VALUES (1, 'FSM Tunisie');
INSERT INTO FSM VALUES (2, 'FSM R�gionale Nord');
INSERT INTO FSM VALUES (3, 'FSM R�gionale Sud');
INSERT INTO FSM VALUES (4, 'FSM R�gionale Est');
INSERT INTO FSM VALUES (5, 'FSM R�gionale Ouest');
INSERT INTO FSM VALUES (6, 'FSM Moto-Cross');
INSERT INTO FSM VALUES (7, 'FSM Endurance');
INSERT INTO FSM VALUES (8, 'FSM Rallye');
INSERT INTO FSM VALUES (9, 'FSM Vitesse');
INSERT INTO FSM VALUES (10, 'FSM Superbike');

INSERT INTO ASSM VALUES (1, 1, 'ASSM Tunis', 'Nord');
INSERT INTO ASSM VALUES (2, 1, 'ASSM Sfax', 'Sud');
INSERT INTO ASSM VALUES (3, 2, 'ASSM Bizerte', 'Nord');
INSERT INTO ASSM VALUES (4, 3, 'ASSM Gab�s', 'Sud');
INSERT INTO ASSM VALUES (5, 4, 'ASSM Sousse', 'Est');
INSERT INTO ASSM VALUES (6, 5, 'ASSM Kasserine', 'Ouest');
INSERT INTO ASSM VALUES (7, 1, 'ASSM Hammamet', 'Est');
INSERT INTO ASSM VALUES (8, 1, 'ASSM Monastir', 'Est');
INSERT INTO ASSM VALUES (9, 2, 'ASSM Tabarka', 'Nord');
INSERT INTO ASSM VALUES (10, 3, 'ASSM Djerba', 'Sud');

INSERT INTO CCR VALUES (1, 'CCR Tunis','Nord');
INSERT INTO CCR VALUES (2, 'CCR Sfax', 'Centre');
INSERT INTO CCR VALUES (3, 'CCR Sousse', 'Est');
INSERT INTO CCR VALUES (4, 'CCR Bizerte', 'Nord');
INSERT INTO CCR VALUES (5, 'CCR Gab�s', 'Sud');
INSERT INTO CCR VALUES (6, 'CCR Monastir', 'Est');
INSERT INTO CCR VALUES (7, 'CCR Kairouan', 'Centre');
INSERT INTO CCR VALUES (8, 'CCR Gafsa', 'Sud');
INSERT INTO CCR VALUES (9, 'CCR Nabeul', 'Est');
INSERT INTO CCR VALUES (10, 'CCR Jendouba', 'Nord');

INSERT INTO LICENCE VALUES (1, 1, TO_DATE('31-12-2028', 'DD-MM-YYYY'), TO_DATE('01-01-2018', 'DD-MM-YYYY'), 'commissaire');
INSERT INTO LICENCE VALUES (2, 1, TO_DATE('31-12-2025', 'DD-MM-YYYY'), TO_DATE('15-02-2015', 'DD-MM-YYYY'), 'commissaire f�d�ral');
INSERT INTO LICENCE VALUES (3, 2, TO_DATE('31-12-2026', 'DD-MM-YYYY'), TO_DATE('20-03-2019', 'DD-MM-YYYY'), 'commissaire stagiaire');
INSERT INTO LICENCE VALUES (4, 3, TO_DATE('31-12-2026', 'DD-MM-YYYY'), TO_DATE('05-04-2019', 'DD-MM-YYYY'), 'commissaire stagiaire');
INSERT INTO LICENCE VALUES (5, 4, TO_DATE('31-12-2027', 'DD-MM-YYYY'), TO_DATE('10-01-2022', 'DD-MM-YYYY'), 'commissaire d�l�gu�');
INSERT INTO LICENCE VALUES (6, 1, TO_DATE('31-12-2025', 'DD-MM-YYYY'), TO_DATE('12-06-2022', 'DD-MM-YYYY'), 'commissaire');
INSERT INTO LICENCE VALUES (7, 5, TO_DATE('31-12-2026', 'DD-MM-YYYY'), TO_DATE('22-07-2023', 'DD-MM-YYYY'), 'commissaire');
INSERT INTO LICENCE VALUES (8, 2, TO_DATE('31-12-2026', 'DD-MM-YYYY'), TO_DATE('30-08-2016', 'DD-MM-YYYY'), 'commissaire d�l�gu�');
INSERT INTO LICENCE VALUES (9, 3, TO_DATE('31-12-2028', 'DD-MM-YYYY'), TO_DATE('05-09-2019', 'DD-MM-YYYY'), 'commissaire');
INSERT INTO LICENCE VALUES (10, 1, TO_DATE('31-12-2029', 'DD-MM-YYYY'), TO_DATE('14-10-2013', 'DD-MM-YYYY'), 'commissaire f�d�ral');

INSERT INTO COMMISSAIRE VALUES (1, 2, 1, 1, 'Ben Ali', 'Mohamed', 25512345, 3500);
INSERT INTO COMMISSAIRE VALUES (2, 4, 2, 2, 'Trabelsi', 'Ahmed', 50234567, 3200);
INSERT INTO COMMISSAIRE VALUES (3, 7, 3, 3, 'Arfaoui', 'Karim', 55345678, 3800);
INSERT INTO COMMISSAIRE VALUES (4, 10, 4, 4, 'Sassi', 'Bassem', 99456789, 3400);
INSERT INTO COMMISSAIRE VALUES (5, 8, 5, 5, 'Chaabane', 'Riadh', 55567890, 3600);
INSERT INTO COMMISSAIRE VALUES (6, 2, 6, 6, 'Gharbi', 'Sami', 53678901, 3700);
INSERT INTO COMMISSAIRE VALUES (7, 4, 7, 7, 'Rahmani', 'Hedi', 53789012, 3300);
INSERT INTO COMMISSAIRE VALUES (8, 7, 8, 8, 'Cherni', 'Tarek', 98890123, 3900);
INSERT INTO COMMISSAIRE VALUES (9, 10, 9, 9, 'Kaabi', 'Walid', 21901234, 3450);
INSERT INTO COMMISSAIRE VALUES (10, 8, 10, 10, 'Mahjoub', 'Sofien', 55012345, 3550);
INSERT INTO COMMISSAIRE VALUES (11, 10, 9, 9, 'Kiabi', 'amir', 21901234, 3450);
INSERT INTO COMMISSAIRE VALUES (12, 8, 10, 10, 'Moldi', 'ramzi', 55012345, 3550);

INSERT INTO EPREUVE VALUES (1, 1, 'Motocyclisme', 'Circuit Tunis',   TO_DATE('15-03-2025', 'DD-MM-YYYY'), TO_DATE('13-03-2025', 'DD-MM-YYYY'));
INSERT INTO EPREUVE VALUES (2, 2, 'Automobile', 'Circuit Sfax',      TO_DATE('25-04-2025', 'DD-MM-YYYY'), TO_DATE('22-04-2025', 'DD-MM-YYYY'));
INSERT INTO EPREUVE VALUES (3, 3, 'Automobile', 'Route Bizerte',     TO_DATE('10-05-2025', 'DD-MM-YYYY'), TO_DATE('08-05-2025', 'DD-MM-YYYY'));
INSERT INTO EPREUVE VALUES (4, 4, 'Automobile', 'Dunes Gab�s',      TO_DATE('20-06-2025', 'DD-MM-YYYY'), TO_DATE('18-06-2025', 'DD-MM-YYYY'));
INSERT INTO EPREUVE VALUES (5, 5, 'Motocyclisme', 'Circuit Sousse',  TO_DATE('15-07-2025', 'DD-MM-YYYY'), TO_DATE('13-07-2025', 'DD-MM-YYYY'));
INSERT INTO EPREUVE VALUES (6, 6, 'Automobile', 'Route Kasserine',   TO_DATE('12-08-2025', 'DD-MM-YYYY'), TO_DATE('10-08-2025', 'DD-MM-YYYY'));
INSERT INTO EPREUVE VALUES (7, 7, 'Automobile', 'Circuit Hammamet',  TO_DATE('05-09-2025', 'DD-MM-YYYY'), TO_DATE('03-09-2025', 'DD-MM-YYYY'));
INSERT INTO EPREUVE VALUES (8, 8, 'Motocyclisme', 'Plage Monastir',  TO_DATE('18-10-2025', 'DD-MM-YYYY'), TO_DATE('16-10-2025', 'DD-MM-YYYY'));
INSERT INTO EPREUVE VALUES (9, 9, 'Automobile', 'For�t Tabarka',     TO_DATE('08-11-2025', 'DD-MM-YYYY'), TO_DATE('06-11-2025', 'DD-MM-YYYY'));
INSERT INTO EPREUVE VALUES (10, 10, 'Motocyclisme', 'Circuit Djerba', TO_DATE('12-12-2025', 'DD-MM-YYYY'), TO_DATE('10-12-2025', 'DD-MM-YYYY'));

INSERT INTO INCIDENT VALUES (1, TO_DATE('13-03-2025', 'DD-MM-YYYY'));
INSERT INTO INCIDENT VALUES (2, TO_DATE('22-04-2025', 'DD-MM-YYYY'));
INSERT INTO INCIDENT VALUES (3, TO_DATE('09-05-2025', 'DD-MM-YYYY'));
INSERT INTO INCIDENT VALUES (4, TO_DATE('18-06-2025', 'DD-MM-YYYY'));
INSERT INTO INCIDENT VALUES (5, TO_DATE('14-07-2025', 'DD-MM-YYYY'));
INSERT INTO INCIDENT VALUES (6, TO_DATE('11-08-2025', 'DD-MM-YYYY'));
INSERT INTO INCIDENT VALUES (7, TO_DATE('04-09-2025', 'DD-MM-YYYY'));
INSERT INTO INCIDENT VALUES (8, TO_DATE('17-10-2025', 'DD-MM-YYYY'));
INSERT INTO INCIDENT VALUES (9, TO_DATE('07-11-2025', 'DD-MM-YYYY'));
INSERT INTO INCIDENT VALUES (10,TO_DATE('11-12-2025', 'DD-MM-YYYY'));

INSERT INTO CONTENIR VALUES (1, 1);
INSERT INTO CONTENIR VALUES (2, 2);
INSERT INTO CONTENIR VALUES (3, 3);
INSERT INTO CONTENIR VALUES (4, 4);
INSERT INTO CONTENIR VALUES (5, 5);
INSERT INTO CONTENIR VALUES (6, 6);
INSERT INTO CONTENIR VALUES (7, 7);
INSERT INTO CONTENIR VALUES (8, 8);
INSERT INTO CONTENIR VALUES (9, 9);
INSERT INTO CONTENIR VALUES (10, 10);

INSERT INTO INTERVENIR VALUES (1, 1, 'Accident l�ger');
INSERT INTO INTERVENIR VALUES (2, 2, 'Panne m�canique');
INSERT INTO INTERVENIR VALUES (3, 3, 'Collision');
INSERT INTO INTERVENIR VALUES (4, 4, 'Sortie de piste');
INSERT INTO INTERVENIR VALUES (5, 5, 'Probl�me technique');
INSERT INTO INTERVENIR VALUES (6, 6, 'Accident sans gravit�');
INSERT INTO INTERVENIR VALUES (7, 7, 'Probl�me de s�curit�');
INSERT INTO INTERVENIR VALUES (8, 8, 'D�rapage');
INSERT INTO INTERVENIR VALUES (9, 9, 'Panne moteur');
INSERT INTO INTERVENIR VALUES (10, 10, 'Chute l�g�re');

INSERT INTO ENCADRER VALUES (1, 1, 3);
INSERT INTO ENCADRER VALUES (2, 2, 4);
INSERT INTO ENCADRER VALUES (3, 3, 3);
INSERT INTO ENCADRER VALUES (4, 4, 3);
INSERT INTO ENCADRER VALUES (5, 5, 3);
INSERT INTO ENCADRER VALUES (6, 6, 3);
INSERT INTO ENCADRER VALUES (7, 7, 3);
INSERT INTO ENCADRER VALUES (8, 8, 4);
INSERT INTO ENCADRER VALUES (9, 9, 3);
INSERT INTO ENCADRER VALUES (10, 10, 3);

INSERT INTO CHOISIR VALUES (1, 1, 1, TO_DATE('01-02-2025', 'DD-MM-YYYY'), TO_DATE('10-02-2025', 'DD-MM-YYYY'), 'Accept�');
INSERT INTO CHOISIR VALUES (2, 2, 2, TO_DATE('05-03-2025', 'DD-MM-YYYY'), TO_DATE('15-03-2025', 'DD-MM-YYYY'), 'Accept�');
INSERT INTO CHOISIR VALUES (3, 3, 3, TO_DATE('10-04-2025', 'DD-MM-YYYY'), TO_DATE('20-04-2025', 'DD-MM-YYYY'), 'Accept�');
INSERT INTO CHOISIR VALUES (4, 4, 4, TO_DATE('15-05-2025', 'DD-MM-YYYY'), TO_DATE('25-05-2025', 'DD-MM-YYYY'), 'Accept�');
INSERT INTO CHOISIR VALUES (5, 5, 5, TO_DATE('20-06-2025', 'DD-MM-YYYY'), TO_DATE('30-06-2025', 'DD-MM-YYYY'), 'Accept�');
INSERT INTO CHOISIR VALUES (6, 6, 6, TO_DATE('25-07-2025', 'DD-MM-YYYY'), TO_DATE('05-08-2025', 'DD-MM-YYYY'), 'Accept�');
INSERT INTO CHOISIR VALUES (7, 7, 7, TO_DATE('01-08-2025', 'DD-MM-YYYY'), TO_DATE('10-08-2025', 'DD-MM-YYYY'), 'Accept�');
INSERT INTO CHOISIR VALUES (8, 8, 8, TO_DATE('05-09-2025', 'DD-MM-YYYY'), TO_DATE('15-09-2025', 'DD-MM-YYYY'), 'Accept�');
INSERT INTO CHOISIR VALUES (9, 9, 9, TO_DATE('10-10-2025', 'DD-MM-YYYY'), TO_DATE('20-10-2025', 'DD-MM-YYYY'), 'Accept�');
INSERT INTO CHOISIR VALUES (10, 10, 10, TO_DATE('15-11-2025', 'DD-MM-YYYY'), TO_DATE('25-11-2025', 'DD-MM-YYYY'), 'Refuse');
INSERT INTO CHOISIR VALUES (10, 11, 9, TO_DATE('15-11-2025', 'DD-MM-YYYY'), TO_DATE('25-11-2025', 'DD-MM-YYYY'), 'Refuse');
INSERT INTO CHOISIR VALUES (10, 12, 10, TO_DATE('15-11-2025', 'DD-MM-YYYY'), TO_DATE('25-11-2025', 'DD-MM-YYYY'), 'Refuse');



















select* from commissaire ;