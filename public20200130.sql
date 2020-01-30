/*
 Navicat Premium Data Transfer

 Source Server         : local_postgre
 Source Server Type    : PostgreSQL
 Source Server Version : 100010
 Source Host           : localhost:5432
 Source Catalog        : devon_drugs
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 100010
 File Encoding         : 65001

 Date: 30/01/2020 09:11:36
*/


-- ----------------------------
-- Sequence structure for date_dim_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."date_dim_id_seq";
CREATE SEQUENCE "public"."date_dim_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for dept_dim_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."dept_dim_id_seq";
CREATE SEQUENCE "public"."dept_dim_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for doc_dim_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."doc_dim_id_seq";
CREATE SEQUENCE "public"."doc_dim_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for drg_dim_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."drg_dim_id_seq";
CREATE SEQUENCE "public"."drg_dim_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for drgsdeptkpi_fact_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."drgsdeptkpi_fact_id_seq";
CREATE SEQUENCE "public"."drgsdeptkpi_fact_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for drgsdepts_fact_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."drgsdepts_fact_id_seq";
CREATE SEQUENCE "public"."drgsdepts_fact_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for drgsdeptscmi_fact_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."drgsdeptscmi_fact_id_seq";
CREATE SEQUENCE "public"."drgsdeptscmi_fact_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for drgsdeptscore_fact_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."drgsdeptscore_fact_id_seq";
CREATE SEQUENCE "public"."drgsdeptscore_fact_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for drgshosp_fact_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."drgshosp_fact_id_seq";
CREATE SEQUENCE "public"."drgshosp_fact_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for drgshospkpi_fact_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."drgshospkpi_fact_id_seq";
CREATE SEQUENCE "public"."drgshospkpi_fact_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for drgsopdepts_fact_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."drgsopdepts_fact_id_seq";
CREATE SEQUENCE "public"."drgsopdepts_fact_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for drgspatient_fact_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."drgspatient_fact_id_seq";
CREATE SEQUENCE "public"."drgspatient_fact_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for icd10_dim_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."icd10_dim_id_seq";
CREATE SEQUENCE "public"."icd10_dim_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for icd9_dim_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."icd9_dim_id_seq";
CREATE SEQUENCE "public"."icd9_dim_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for month_dim_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."month_dim_id_seq";
CREATE SEQUENCE "public"."month_dim_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for patient_dim_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."patient_dim_id_seq";
CREATE SEQUENCE "public"."patient_dim_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Table structure for DRGsDeptKPI_FACT
-- ----------------------------
DROP TABLE IF EXISTS "public"."DRGsDeptKPI_FACT";
CREATE TABLE "public"."DRGsDeptKPI_FACT" (
  "id" int8 NOT NULL DEFAULT nextval('drgsdeptkpi_fact_id_seq'::regclass),
  "data_month" varchar(20) COLLATE "pg_catalog"."default",
  "dept_code" varchar(20) COLLATE "pg_catalog"."default",
  "hosp_dischg_case" float4,
  "tot_amt" float4,
  "tot_medicine_amt" float4,
  "tot_material_amt" float4,
  "tot_therapy_amt" float4,
  "avg_patient_amt" float4,
  "avg_patient_med_amt" float4,
  "avg_patient_mtrl_amt" float4,
  "avg_days" float4,
  "tot_admit_days" float4,
  "bed_rotaion_tqty" float4,
  "bed_occupancy" float4,
  "medicine_percent" float4,
  "material_percent" float4,
  "therapy_percent" float4,
  "avg_physican_amt" float4,
  "avg_nursing_amt" float4,
  "avg_technician_amt" float4,
  "avg_mgmt_amt" float4
)
;

-- ----------------------------
-- Table structure for DRGsDeptScore_FACT
-- ----------------------------
DROP TABLE IF EXISTS "public"."DRGsDeptScore_FACT";
CREATE TABLE "public"."DRGsDeptScore_FACT" (
  "id" int8 NOT NULL DEFAULT nextval('drgsdeptscore_fact_id_seq'::regclass),
  "data_month" varchar(20) COLLATE "pg_catalog"."default",
  "dept_code" varchar(20) COLLATE "pg_catalog"."default",
  "dept_tot_score" float4,
  "dept_capacity_score" float4,
  "dept_efficiency_score" float4,
  "dept_specialty_score" float4,
  "dept_ranking" float4
)
;

-- ----------------------------
-- Table structure for DRGsDeptsCMI_FACT
-- ----------------------------
DROP TABLE IF EXISTS "public"."DRGsDeptsCMI_FACT";
CREATE TABLE "public"."DRGsDeptsCMI_FACT" (
  "id" int8 NOT NULL DEFAULT nextval('drgsdeptscmi_fact_id_seq'::regclass),
  "data_month" varchar(20) COLLATE "pg_catalog"."default",
  "dept_code" varchar(20) COLLATE "pg_catalog"."default",
  "dischg_case" float4,
  "dept_drg_case" float4,
  "dept_drgs_weight" float4,
  "dept_drgs_cmi" float4,
  "dept_drgs_avg_days" float4,
  "dept_drgs_cost_index" float4,
  "dept_drgs_time_index" float4,
  "dept_low_expire_case" float4,
  "dept_low_medium_expire_case" float4,
  "dept_medium_risk_cure" float4,
  "dept_high_risk_cure" float4
)
;

-- ----------------------------
-- Table structure for DRGsDepts_FACT
-- ----------------------------
DROP TABLE IF EXISTS "public"."DRGsDepts_FACT";
CREATE TABLE "public"."DRGsDepts_FACT" (
  "id" int8 NOT NULL DEFAULT nextval('drgsdepts_fact_id_seq'::regclass),
  "data_month" varchar(20) COLLATE "pg_catalog"."default",
  "dept_code" varchar(20) COLLATE "pg_catalog"."default",
  "drg_code" varchar(20) COLLATE "pg_catalog"."default",
  "dischg_case" float4,
  "tot_drg_weight" float4,
  "avg_drg_amt" float4,
  "std_drg_amt" float4,
  "over_std_tot_amt" float4,
  "avg_admit_days" float4,
  "std_admit_days" float4,
  "over_std_admit_days" float4,
  "over_60_days" float4,
  "cost_index" float4,
  "time_index" float4,
  "low_expire_case" float4,
  "medium_expire_case" float4,
  "medium_risk_cure" float4,
  "high_risk_cure" float4
)
;

-- ----------------------------
-- Table structure for DRGsHospKPI_FACT
-- ----------------------------
DROP TABLE IF EXISTS "public"."DRGsHospKPI_FACT";
CREATE TABLE "public"."DRGsHospKPI_FACT" (
  "id" int8 NOT NULL DEFAULT nextval('drgshospkpi_fact_id_seq'::regclass),
  "data_month" varchar(20) COLLATE "pg_catalog"."default",
  "hosp_dischg_case" float4,
  "tot_amt" float4,
  "tot_medicine_amt" float4,
  "tot_material_amt" float4,
  "tot_therapy_amt" float4,
  "avg_patient_amt" float4,
  "avg_patient_med_amt" float4,
  "avg_patient_mtrl_amt" float4,
  "avg_days" float4,
  "tot_admit_days" float4,
  "bed_rotaion_tqty" float4,
  "bed_occupancy" float4,
  "medicine_percent" float4,
  "material_percent" float4,
  "therapy_percent" float4,
  "avg_physican_amt" float4,
  "avg_nursing_amt" float4,
  "avg_technician_amt" float4,
  "avg_mgmt_amt" float4
)
;

-- ----------------------------
-- Table structure for DRGsHosp_FACT
-- ----------------------------
DROP TABLE IF EXISTS "public"."DRGsHosp_FACT";
CREATE TABLE "public"."DRGsHosp_FACT" (
  "id" int8 NOT NULL DEFAULT nextval('drgshosp_fact_id_seq'::regclass),
  "data_month" varchar(20) COLLATE "pg_catalog"."default",
  "hosp_dischg_case" float4,
  "hosp_avg_drg_amt" float4,
  "hosp_drg_case" float4,
  "hosp_drgs_weight" float4,
  "hosp_drgs_cmi" float4,
  "hosp_drgs_avg_days" float4,
  "hosp_low_expire_case" float4,
  "hosp_low_medium_expire_case" float4,
  "hosp_medium_risk_cure" float4,
  "hosp_high_risk_cure" float4,
  "hosp_drgs_cost_index" float4,
  "hosp_drgs_time_index" float4,
  "doc_per_weight" float4,
  "bed_per_weight" float4,
  "patient_index" float4
)
;

-- ----------------------------
-- Table structure for DRGsOpDepts_FACT
-- ----------------------------
DROP TABLE IF EXISTS "public"."DRGsOpDepts_FACT";
CREATE TABLE "public"."DRGsOpDepts_FACT" (
  "id" int8 NOT NULL DEFAULT nextval('drgsopdepts_fact_id_seq'::regclass),
  "data_month" varchar(20) COLLATE "pg_catalog"."default",
  "dept_code" varchar(20) COLLATE "pg_catalog"."default",
  "op_case" float4,
  "level_1_op_case" float4,
  "level_2_op_case" float4,
  "level_3_op_case" float4,
  "level_4_op_case" float4,
  "before_op_days" float4,
  "after_op_days" float4,
  "avg_op_duration" float4,
  "op_cc_percent" float4,
  "doc_code" varchar(20) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Table structure for DRGsPatient_FACT
-- ----------------------------
DROP TABLE IF EXISTS "public"."DRGsPatient_FACT";
CREATE TABLE "public"."DRGsPatient_FACT" (
  "id" int8 NOT NULL DEFAULT nextval('drgspatient_fact_id_seq'::regclass),
  "data_month" varchar(20) COLLATE "pg_catalog"."default",
  "parent_id" varchar(20) COLLATE "pg_catalog"."default",
  "admit_date" varchar(20) COLLATE "pg_catalog"."default",
  "admit_dept" varchar(20) COLLATE "pg_catalog"."default",
  "diag_icd10" varchar(20) COLLATE "pg_catalog"."default",
  "op_icd9" varchar(20) COLLATE "pg_catalog"."default",
  "doc_code" varchar(20) COLLATE "pg_catalog"."default",
  "dischg_date" varchar(20) COLLATE "pg_catalog"."default",
  "dischg_dept" varchar(20) COLLATE "pg_catalog"."default",
  "ward_dept" varchar(20) COLLATE "pg_catalog"."default",
  "drg_code" varchar(20) COLLATE "pg_catalog"."default",
  "drg_weight" float4,
  "drg_amt" float4,
  "std_drg_amt" float4,
  "over_std_tot_amt" float4,
  "admit_days" float4,
  "std_admit_days" float4,
  "over_std_admit_days" float4,
  "over_60_days" float4,
  "nod_drgs_case" float4,
  "drg_case" float4,
  "dischg_reason" varchar(20) COLLATE "pg_catalog"."default",
  "low_risk_case" float4,
  "low_medium_risk_case" float4,
  "medium_high_risk_case" float4,
  "high_risk_case" float4
)
;

-- ----------------------------
-- Table structure for Date_Dim
-- ----------------------------
DROP TABLE IF EXISTS "public"."Date_Dim";
CREATE TABLE "public"."Date_Dim" (
  "id" int8 NOT NULL DEFAULT nextval('date_dim_id_seq'::regclass),
  "yyyy_date" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "year" varchar(20) COLLATE "pg_catalog"."default",
  "season" varchar(20) COLLATE "pg_catalog"."default",
  "month" varchar(20) COLLATE "pg_catalog"."default",
  "weekend" varchar(20) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Table structure for Dept_Dim
-- ----------------------------
DROP TABLE IF EXISTS "public"."Dept_Dim";
CREATE TABLE "public"."Dept_Dim" (
  "id" int8 NOT NULL DEFAULT nextval('dept_dim_id_seq'::regclass),
  "hosp_code" varchar(20) COLLATE "pg_catalog"."default",
  "hosp_name" varchar(20) COLLATE "pg_catalog"."default",
  "dept_code" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "dept_name" varchar(20) COLLATE "pg_catalog"."default",
  "dept_sys_code" varchar(20) COLLATE "pg_catalog"."default",
  "dept_sys_name" varchar(20) COLLATE "pg_catalog"."default",
  "dept_group_flag" varchar(20) COLLATE "pg_catalog"."default",
  "upper_dept_code" varchar(20) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Table structure for Doc_Dim
-- ----------------------------
DROP TABLE IF EXISTS "public"."Doc_Dim";
CREATE TABLE "public"."Doc_Dim" (
  "id" int8 NOT NULL DEFAULT nextval('doc_dim_id_seq'::regclass),
  "doc_code" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "doc_name" varchar(20) COLLATE "pg_catalog"."default",
  "doc_level" varchar(20) COLLATE "pg_catalog"."default",
  "doc_level_name" varchar(20) COLLATE "pg_catalog"."default",
  "doc_dept_code" varchar(20) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Table structure for Drg_Dim
-- ----------------------------
DROP TABLE IF EXISTS "public"."Drg_Dim";
CREATE TABLE "public"."Drg_Dim" (
  "id" int8 NOT NULL DEFAULT nextval('drg_dim_id_seq'::regclass),
  "mdc_code" varchar(20) COLLATE "pg_catalog"."default",
  "mdc_name" varchar(200) COLLATE "pg_catalog"."default",
  "adrg_code" varchar(20) COLLATE "pg_catalog"."default",
  "drg_code" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "drg_name" varchar(200) COLLATE "pg_catalog"."default",
  "cc_type" varchar(20) COLLATE "pg_catalog"."default",
  "std_drg_amt" float4,
  "stg_avg_days" float4,
  "weight" float4,
  "std_medicine_percent" float4,
  "std_material_percent" float4
)
;

-- ----------------------------
-- Table structure for Icd10_Dim
-- ----------------------------
DROP TABLE IF EXISTS "public"."Icd10_Dim";
CREATE TABLE "public"."Icd10_Dim" (
  "id" int8 NOT NULL DEFAULT nextval('icd10_dim_id_seq'::regclass),
  "icd10_code" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "icd10_desc" varchar(200) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Table structure for Icd9_Dim
-- ----------------------------
DROP TABLE IF EXISTS "public"."Icd9_Dim";
CREATE TABLE "public"."Icd9_Dim" (
  "id" int8 NOT NULL DEFAULT nextval('icd9_dim_id_seq'::regclass),
  "icd9_code" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "icd9_desc" varchar(200) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Table structure for Month_Dim
-- ----------------------------
DROP TABLE IF EXISTS "public"."Month_Dim";
CREATE TABLE "public"."Month_Dim" (
  "id" int8 NOT NULL DEFAULT nextval('month_dim_id_seq'::regclass),
  "yyyy_mm" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "year" varchar(20) COLLATE "pg_catalog"."default",
  "season" varchar(20) COLLATE "pg_catalog"."default",
  "month" varchar(20) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Table structure for Patient_Dim
-- ----------------------------
DROP TABLE IF EXISTS "public"."Patient_Dim";
CREATE TABLE "public"."Patient_Dim" (
  "id" int8 NOT NULL DEFAULT nextval('patient_dim_id_seq'::regclass),
  "data_month" varchar(20) COLLATE "pg_catalog"."default",
  "patient_id" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "patient_name" varchar(20) COLLATE "pg_catalog"."default",
  "patient_age" float4,
  "admit_date" varchar(20) COLLATE "pg_catalog"."default",
  "admit_dept" varchar(20) COLLATE "pg_catalog"."default",
  "leave_code" varchar(20) COLLATE "pg_catalog"."default",
  "dept_manager_doc_code" varchar(20) COLLATE "pg_catalog"."default",
  "manager_doc_code" varchar(20) COLLATE "pg_catalog"."default",
  "doc_code" varchar(20) COLLATE "pg_catalog"."default",
  "dischg_date" varchar(20) COLLATE "pg_catalog"."default",
  "dischg_dept" varchar(20) COLLATE "pg_catalog"."default",
  "dischg_ward" varchar(20) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."date_dim_id_seq"
OWNED BY "public"."Date_Dim"."id";
SELECT setval('"public"."date_dim_id_seq"', 2, false);
ALTER SEQUENCE "public"."dept_dim_id_seq"
OWNED BY "public"."Dept_Dim"."id";
SELECT setval('"public"."dept_dim_id_seq"', 2, false);
ALTER SEQUENCE "public"."doc_dim_id_seq"
OWNED BY "public"."Doc_Dim"."id";
SELECT setval('"public"."doc_dim_id_seq"', 2, false);
ALTER SEQUENCE "public"."drg_dim_id_seq"
OWNED BY "public"."Drg_Dim"."id";
SELECT setval('"public"."drg_dim_id_seq"', 2, false);
ALTER SEQUENCE "public"."drgsdeptkpi_fact_id_seq"
OWNED BY "public"."DRGsDeptKPI_FACT"."id";
SELECT setval('"public"."drgsdeptkpi_fact_id_seq"', 2, false);
ALTER SEQUENCE "public"."drgsdepts_fact_id_seq"
OWNED BY "public"."DRGsDepts_FACT"."id";
SELECT setval('"public"."drgsdepts_fact_id_seq"', 2, false);
ALTER SEQUENCE "public"."drgsdeptscmi_fact_id_seq"
OWNED BY "public"."DRGsDeptsCMI_FACT"."id";
SELECT setval('"public"."drgsdeptscmi_fact_id_seq"', 2, false);
ALTER SEQUENCE "public"."drgsdeptscore_fact_id_seq"
OWNED BY "public"."DRGsDeptScore_FACT"."id";
SELECT setval('"public"."drgsdeptscore_fact_id_seq"', 2, false);
ALTER SEQUENCE "public"."drgshosp_fact_id_seq"
OWNED BY "public"."DRGsHosp_FACT"."id";
SELECT setval('"public"."drgshosp_fact_id_seq"', 2, false);
ALTER SEQUENCE "public"."drgshospkpi_fact_id_seq"
OWNED BY "public"."DRGsHospKPI_FACT"."id";
SELECT setval('"public"."drgshospkpi_fact_id_seq"', 2, false);
ALTER SEQUENCE "public"."drgsopdepts_fact_id_seq"
OWNED BY "public"."DRGsOpDepts_FACT"."id";
SELECT setval('"public"."drgsopdepts_fact_id_seq"', 2, false);
ALTER SEQUENCE "public"."drgspatient_fact_id_seq"
OWNED BY "public"."DRGsPatient_FACT"."id";
SELECT setval('"public"."drgspatient_fact_id_seq"', 2, false);
ALTER SEQUENCE "public"."icd10_dim_id_seq"
OWNED BY "public"."Icd10_Dim"."id";
SELECT setval('"public"."icd10_dim_id_seq"', 2, false);
ALTER SEQUENCE "public"."icd9_dim_id_seq"
OWNED BY "public"."Icd9_Dim"."id";
SELECT setval('"public"."icd9_dim_id_seq"', 2, false);
ALTER SEQUENCE "public"."month_dim_id_seq"
OWNED BY "public"."Month_Dim"."id";
SELECT setval('"public"."month_dim_id_seq"', 2, false);
ALTER SEQUENCE "public"."patient_dim_id_seq"
OWNED BY "public"."Patient_Dim"."id";
SELECT setval('"public"."patient_dim_id_seq"', 2, false);

-- ----------------------------
-- Primary Key structure for table DRGsDeptKPI_FACT
-- ----------------------------
ALTER TABLE "public"."DRGsDeptKPI_FACT" ADD CONSTRAINT "DRGsDeptKPI_FACT_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table Date_Dim
-- ----------------------------
ALTER TABLE "public"."Date_Dim" ADD CONSTRAINT "Date_Dim_pkey" PRIMARY KEY ("yyyy_date");

-- ----------------------------
-- Primary Key structure for table Dept_Dim
-- ----------------------------
ALTER TABLE "public"."Dept_Dim" ADD CONSTRAINT "Dept_Dim_pkey" PRIMARY KEY ("dept_code");

-- ----------------------------
-- Primary Key structure for table Doc_Dim
-- ----------------------------
ALTER TABLE "public"."Doc_Dim" ADD CONSTRAINT "Doc_Dim_pkey" PRIMARY KEY ("doc_code");

-- ----------------------------
-- Primary Key structure for table Drg_Dim
-- ----------------------------
ALTER TABLE "public"."Drg_Dim" ADD CONSTRAINT "Drg_Dim_pkey" PRIMARY KEY ("drg_code");

-- ----------------------------
-- Primary Key structure for table Icd10_Dim
-- ----------------------------
ALTER TABLE "public"."Icd10_Dim" ADD CONSTRAINT "Icd10_Dim_pkey" PRIMARY KEY ("icd10_code");

-- ----------------------------
-- Primary Key structure for table Icd9_Dim
-- ----------------------------
ALTER TABLE "public"."Icd9_Dim" ADD CONSTRAINT "Icd9_Dim_pkey" PRIMARY KEY ("icd9_code");

-- ----------------------------
-- Primary Key structure for table Month_Dim
-- ----------------------------
ALTER TABLE "public"."Month_Dim" ADD CONSTRAINT "Month_Dim_pkey" PRIMARY KEY ("yyyy_mm");

-- ----------------------------
-- Uniques structure for table Patient_Dim
-- ----------------------------
ALTER TABLE "public"."Patient_Dim" ADD CONSTRAINT "UK01" UNIQUE ("patient_id");

-- ----------------------------
-- Primary Key structure for table Patient_Dim
-- ----------------------------
ALTER TABLE "public"."Patient_Dim" ADD CONSTRAINT "Patient_Dim_pkey" PRIMARY KEY ("patient_id");

-- ----------------------------
-- Foreign Keys structure for table DRGsDeptKPI_FACT
-- ----------------------------
ALTER TABLE "public"."DRGsDeptKPI_FACT" ADD CONSTRAINT "FK01" FOREIGN KEY ("data_month") REFERENCES "public"."Month_Dim" ("yyyy_mm") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table DRGsDeptScore_FACT
-- ----------------------------
ALTER TABLE "public"."DRGsDeptScore_FACT" ADD CONSTRAINT "FK01" FOREIGN KEY ("data_month") REFERENCES "public"."Month_Dim" ("yyyy_mm") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."DRGsDeptScore_FACT" ADD CONSTRAINT "FK02" FOREIGN KEY ("dept_code") REFERENCES "public"."Dept_Dim" ("dept_code") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table DRGsDeptsCMI_FACT
-- ----------------------------
ALTER TABLE "public"."DRGsDeptsCMI_FACT" ADD CONSTRAINT "FK01" FOREIGN KEY ("data_month") REFERENCES "public"."Month_Dim" ("yyyy_mm") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."DRGsDeptsCMI_FACT" ADD CONSTRAINT "FK02" FOREIGN KEY ("dept_code") REFERENCES "public"."Dept_Dim" ("dept_code") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table DRGsDepts_FACT
-- ----------------------------
ALTER TABLE "public"."DRGsDepts_FACT" ADD CONSTRAINT "FK01" FOREIGN KEY ("data_month") REFERENCES "public"."Month_Dim" ("yyyy_mm") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."DRGsDepts_FACT" ADD CONSTRAINT "FK02" FOREIGN KEY ("dept_code") REFERENCES "public"."Dept_Dim" ("dept_code") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."DRGsDepts_FACT" ADD CONSTRAINT "FK03" FOREIGN KEY ("drg_code") REFERENCES "public"."Drg_Dim" ("drg_code") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table DRGsHospKPI_FACT
-- ----------------------------
ALTER TABLE "public"."DRGsHospKPI_FACT" ADD CONSTRAINT "FK01" FOREIGN KEY ("data_month") REFERENCES "public"."Month_Dim" ("yyyy_mm") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table DRGsHosp_FACT
-- ----------------------------
ALTER TABLE "public"."DRGsHosp_FACT" ADD CONSTRAINT "FK01" FOREIGN KEY ("data_month") REFERENCES "public"."Month_Dim" ("yyyy_mm") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table DRGsOpDepts_FACT
-- ----------------------------
ALTER TABLE "public"."DRGsOpDepts_FACT" ADD CONSTRAINT "FK01" FOREIGN KEY ("data_month") REFERENCES "public"."Month_Dim" ("yyyy_mm") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."DRGsOpDepts_FACT" ADD CONSTRAINT "FK02" FOREIGN KEY ("dept_code") REFERENCES "public"."Dept_Dim" ("dept_code") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."DRGsOpDepts_FACT" ADD CONSTRAINT "FK03" FOREIGN KEY ("doc_code") REFERENCES "public"."Doc_Dim" ("doc_code") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table DRGsPatient_FACT
-- ----------------------------
ALTER TABLE "public"."DRGsPatient_FACT" ADD CONSTRAINT "FK01" FOREIGN KEY ("data_month") REFERENCES "public"."Month_Dim" ("yyyy_mm") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."DRGsPatient_FACT" ADD CONSTRAINT "FK02" FOREIGN KEY ("parent_id") REFERENCES "public"."Patient_Dim" ("patient_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."DRGsPatient_FACT" ADD CONSTRAINT "FK03" FOREIGN KEY ("diag_icd10") REFERENCES "public"."Icd10_Dim" ("icd10_code") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."DRGsPatient_FACT" ADD CONSTRAINT "FK04" FOREIGN KEY ("op_icd9") REFERENCES "public"."Icd9_Dim" ("icd9_code") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."DRGsPatient_FACT" ADD CONSTRAINT "FK05" FOREIGN KEY ("doc_code") REFERENCES "public"."Doc_Dim" ("doc_code") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."DRGsPatient_FACT" ADD CONSTRAINT "FK06" FOREIGN KEY ("dischg_date") REFERENCES "public"."Date_Dim" ("yyyy_date") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."DRGsPatient_FACT" ADD CONSTRAINT "FK07" FOREIGN KEY ("dischg_dept") REFERENCES "public"."Dept_Dim" ("dept_code") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."DRGsPatient_FACT" ADD CONSTRAINT "FK08" FOREIGN KEY ("ward_dept") REFERENCES "public"."Dept_Dim" ("dept_code") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."DRGsPatient_FACT" ADD CONSTRAINT "FK09" FOREIGN KEY ("drg_code") REFERENCES "public"."Drg_Dim" ("drg_code") ON DELETE NO ACTION ON UPDATE NO ACTION;
