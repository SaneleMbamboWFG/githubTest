-- View: accpac.vw_account_mapping_expanded

-- DROP VIEW accpac.vw_account_mapping_expanded;

CREATE OR REPLACE VIEW accpac.vw_account_mapping_expanded
 AS
 WITH vw_account_mapping AS (
         SELECT am."Account ID",
            am."Account No",
            am."Cost Centre",
            am."Cost Centre Subst3",
            am."Cost Centre Subst6",
            am."Cost Centre Subst9",
            am."CCentre Subst BDS Entity key",
            am."CCentre Subst BDS Region key",
            am."Audit Date",
            am."Year",
            am."Audit User",
            am."Description",
            am."Group Account Description",
            am."EBITDA View",
            am."FS Classification heading",
            am."FS Classification detail",
            am."Account Type",
            am."BS Classification",
            am."CF Activities heading",
            am."CF Activities detail",
            am."CF Operational headings",
            am."Designation",
            am."Loan account grouping",
            am."Responsible person",
            bdsm."Cluster",
            bdsm."Entity"
           FROM accpac.vw_account_mapping am
             LEFT JOIN accpac.bds_mapping bdsm ON bdsm.bds_key::text = am."CCentre Subst BDS Entity key"
        )
 SELECT DISTINCT vw_account_mapping."Cost Centre",
    max(vw_account_mapping."Cost Centre Subst3") AS "Cost Centre Subst3",
    max(vw_account_mapping."Cost Centre Subst6") AS "Cost Centre Subst6",
    max(vw_account_mapping."Cost Centre Subst9") AS "Cost Centre Subst9",
    max(vw_account_mapping."CCentre Subst BDS Entity key") AS "CCentre Subst BDS Entity key",
    max(vw_account_mapping."CCentre Subst BDS Region key") AS "CCentre Subst BDS Region key",
    max(vw_account_mapping."Audit Date") AS "Audit Date",
    max(vw_account_mapping."Year") AS "Year",
    max(vw_account_mapping."Audit User"::text) AS "Audit User",
    max(vw_account_mapping."Description"::text) AS "Description",
    max(vw_account_mapping."Group Account Description"::text) AS "Group Account Description",
    max(vw_account_mapping."EBITDA View"::text) AS "EBITDA View",
    max(vw_account_mapping."FS Classification heading"::text) AS "FS Classification heading",
    max(vw_account_mapping."FS Classification detail"::text) AS "FS Classification detail",
    max(vw_account_mapping."Account Type"::text) AS "Account Type",
    max(vw_account_mapping."BS Classification"::text) AS "BS Classification",
    max(vw_account_mapping."CF Activities heading"::text) AS "CF Activities heading",
    max(vw_account_mapping."CF Activities detail"::text) AS "CF Activities detail",
    max(vw_account_mapping."CF Operational headings"::text) AS "CF Operational headings",
    max(vw_account_mapping."Designation"::text) AS "Designation",
    max(vw_account_mapping."Loan account grouping") AS "Loan account grouping",
    max(vw_account_mapping."Responsible person"::text) AS "Responsible person",
    max(vw_account_mapping."Cluster"::text) AS "Cluster",
    max(vw_account_mapping."Entity"::text) AS "Entity"
   FROM vw_account_mapping
  WHERE vw_account_mapping."Cost Centre" <> ''::text
  GROUP BY vw_account_mapping."Cost Centre"

