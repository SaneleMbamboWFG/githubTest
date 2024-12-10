-- View: accpac.vw_pohstl_recipts_returns

-- DROP VIEW accpac.vw_pohstl_recipts_returns;

CREATE OR REPLACE VIEW accpac.vw_pohstl_recipts_returns
 AS
 WITH po_returns AS (
         SELECT btrim(pohstl.docnumber::text) AS docnumber,
            btrim(pohstl.vendor::text) AS vendor,
            btrim(pohstl.location::text) AS location,
            btrim(pohstl.itemno::text) AS itemno,
            pohstl.audtdate,
            pohstl.postseqnum::text AS postseqnum,
            pohstl.entrynum::text AS entrynum,
            pohstl.lineseq,
            pohstl.fiscyear,
            btrim(((btrim(pohstl.vendor::text) || btrim(pohstl.location::text)) || btrim(pohstl.itemno::text)) || pohstl.lineseq::text) AS return_key,
            min(pohstl.transdate) AS min_transdate,
            max(pohstl.transdate) AS max_transdate,
            sum(
                CASE
                    WHEN pohstl.transtype = 3 THEN pohstl.sctotal
                    ELSE 0::numeric
                END) AS receipts,
            sum(
                CASE
                    WHEN pohstl.transtype = 4 THEN pohstl.sctotal
                    ELSE 0::numeric
                END) AS returns,
            count(pohstl.transdate) AS count
           FROM accpac.pohstl
          WHERE (pohstl.transtype = ANY (ARRAY[3, 4])) AND pohstl.transdate >= 20201231::numeric
          GROUP BY (btrim(pohstl.docnumber::text)), (btrim(pohstl.vendor::text)), (btrim(pohstl.location::text)), (btrim(pohstl.itemno::text)), (pohstl.postseqnum::text), (pohstl.entrynum::text), pohstl.lineseq, pohstl.audtdate, pohstl.fiscyear
        ), po_account AS (
         SELECT DISTINCT btrim(h.rcpnumber::text) AS rcpnumber,
            btrim(l.ponumber::text) AS ponumber,
            h.vendor,
            l.location,
            l.itemno,
            l.dayendseq::text AS dayendseq,
            l.rcpahseq::text AS rcpahseq,
            l.rcpalseq::text AS rcpalseq,
            l.audtdate,
            a_1.acsegval01,
            a_1.acctdesc,
            btrim(((btrim(h.vendor::text) || btrim(l.location::text)) || btrim(l.itemno::text)) || l.rcpalseq::text) AS return_key,
            (btrim(l.ponumber::text) || l.dayendseq::text) || l.rcpahseq::text AS po_key,
            min(h.transdate) AS min_transdate,
            max(h.transdate) AS max_transdate
           FROM accpac.porcpah h
             LEFT JOIN accpac.porcpal l ON btrim(h.ponumber::text) = btrim(l.ponumber::text)
             LEFT JOIN accpac.gl_amf a_1 ON btrim(l.glitem::text) = btrim(a_1.acctfmttd::text)
          WHERE h.transdate >= 20201231::numeric
          GROUP BY (btrim(h.rcpnumber::text)), (btrim(l.ponumber::text)), h.vendor, l.location, l.itemno, (l.dayendseq::text), (l.rcpahseq::text), (l.rcpalseq::text), l.audtdate, a_1.acsegval01, a_1.acctdesc
        )
 SELECT r.return_key,
    max(r.docnumber) AS docnumber,
    max(a.rcpnumber) AS rcpnumber,
    max(a.ponumber) AS ponumber,
    max(r.vendor) AS vendor,
    max(r.location) AS location,
    max(r.itemno) AS itemno,
    max(r.audtdate) AS audtdate,
    max(r.fiscyear::text) AS fiscyear,
    max(a.acsegval01) AS acsegval01,
    max(a.acctdesc::text) AS acctdesc,
    min(r.min_transdate) AS min_transdate,
    max(r.max_transdate) AS max_transdate,
    sum(r.receipts) AS receipts,
    sum(r.returns) AS returns,
    sum(r.receipts) + sum(r.returns) AS total,
    sum(r.count) AS count,
    max(a.po_key) AS po_key,
    max(r.lineseq) AS lineseq
   FROM po_returns r
     JOIN po_account a ON r.return_key = a.return_key
  GROUP BY r.return_key;

