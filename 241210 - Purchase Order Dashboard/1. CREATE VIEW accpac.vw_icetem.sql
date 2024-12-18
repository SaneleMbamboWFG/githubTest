-- View: accpac.vw_icetem

-- DROP VIEW accpac.vw_icetem;

CREATE OR REPLACE VIEW accpac.vw_icetem
 AS
 SELECT icetem.itemno,
    icetem.audtdate,
    icetem.audttime,
    icetem.audtuser,
    icetem.audtorg,
    icetem.altset,
    icetem."DESC",
    icetem.datelastmn,
    icetem.inactive,
    icetem.itembrkid,
    icetem.fmtitemno,
    icetem.category,
    icetem.cntlacct,
    icetem.stockitem,
    icetem.stockunit,
    icetem.defpriclst,
    icetem.unitwgt,
    icetem.pickingseq,
    icetem.serialno,
    icetem.commodim,
    icetem.dateinactv,
    icetem.segment1,
    icetem.segment2,
    icetem.segment3,
    icetem.segment4,
    icetem.segment5,
    icetem.segment6,
    icetem.segment7,
    icetem.segment8,
    icetem.segment9,
    icetem.segment10,
    icetem.comment1,
    icetem.comment2,
    icetem.comment3,
    icetem.comment4,
    icetem.allowonweb,
    icetem.kitting,
    icetem."VALUES",
    icetem.defkitno,
    icetem.sellable,
    icetem.weightunit,
    icetem.serialmask,
    icetem.nextserfmt,
    icetem.suseexpday,
    icetem.sexpdays,
    icetem.sdifqtyok,
    icetem.svalues,
    icetem.swarycode,
    icetem.scontcode,
    icetem.scontrece,
    icetem.swarysold,
    icetem.swaryreg,
    icetem.lotitem,
    icetem.lotmask,
    icetem.nextlotfmt,
    icetem.luseexpday,
    icetem.lexpdays,
    icetem.luseqrnday,
    icetem.lqrndays,
    icetem.ldifqtyok,
    icetem.lvalues,
    icetem.lwarycode,
    icetem.lcontcode,
    icetem.lcontrece,
    icetem.lwarysold,
    icetem.prevendty,
    icetem.defbomno,
    icetem.seasonal,
    icetem.tariffcode
   FROM accpac.icetem;


