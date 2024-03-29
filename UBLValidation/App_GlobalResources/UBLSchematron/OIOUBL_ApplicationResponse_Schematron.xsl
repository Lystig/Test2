<?xml version="1.0" encoding="UTF-16" standalone="yes"?>
<xsl:stylesheet doc:dummy-for-xmlns="" cac:dummy-for-xmlns="" cbc:dummy-for-xmlns="" ccts:dummy-for-xmlns="" sdt:dummy-for-xmlns="" udt:dummy-for-xmlns="" xs:dummy-for-xmlns="" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sch="http://www.ascc.net/xml/schematron" xmlns:iso="http://purl.oclc.org/dsdl/schematron" xmlns:doc="urn:oasis:names:specification:ubl:schema:xsd:ApplicationResponse-2" xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" xmlns:ccts="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2" xmlns:sdt="urn:oasis:names:specification:ubl:schema:xsd:SpecializedDatatypes-2" xmlns:udt="urn:un:unece:uncefact:data:specification:UnqualifiedDataTypesSchemaModule:2" xmlns:xs="http://www.w3.org/2001/XMLSchema">
<!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. The name or details of 
    this mode may change during 1Q 2007.-->


<!--PHASES-->


<!--PROLOG-->
<xsl:output method="xml" encoding="utf-8" />

<!--KEYS-->


<!--DEFAULT RULES-->


<!--MODE: SCHEMATRON-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<xsl:template match="*" mode="schematron-get-full-path">
<xsl:apply-templates select="parent::*" mode="schematron-get-full-path" />
<xsl:text>/</xsl:text>
<xsl:choose>
<xsl:when test="namespace-uri()=''"><xsl:value-of select="name()" /></xsl:when>
<xsl:otherwise>
<xsl:text>*:</xsl:text>
<xsl:value-of select="local-name()" />
<xsl:text>[namespace-uri()='</xsl:text>
<xsl:value-of select="namespace-uri()" />
<xsl:text>']</xsl:text>
</xsl:otherwise>
</xsl:choose>
<xsl:variable name="preceding" select="count(preceding-sibling::*[local-name()=local-name(current())&#xA;	  		                             and namespace-uri() = namespace-uri(current())])" />
<xsl:text>[</xsl:text>
<xsl:value-of select="1+ $preceding" />
<xsl:text>]</xsl:text>
</xsl:template>
<xsl:template match="@*" mode="schematron-get-full-path">
<xsl:apply-templates select="parent::*" mode="schematron-get-full-path" />
<xsl:text>/</xsl:text>
<xsl:choose>
<xsl:when test="namespace-uri()=''">@sch:schema</xsl:when>
<xsl:otherwise>
<xsl:text>@*[local-name()='</xsl:text>
<xsl:value-of select="local-name()" />
<xsl:text>' and namespace-uri()='</xsl:text>
<xsl:value-of select="namespace-uri()" />
<xsl:text>']</xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--MODE: SCHEMATRON-FULL-PATH-2-->
<!--This mode can be used to generate prefixed XPath for humans-->
<xsl:template match="node() | @*" mode="schematron-get-full-path-2">
<xsl:for-each select="ancestor-or-self::*">
<xsl:text>/</xsl:text>
<xsl:value-of select="name(.)" />
<xsl:if test="preceding-sibling::*[name(.)=name(current())]">
<xsl:text>[</xsl:text>
<xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1" />
<xsl:text>]</xsl:text>
</xsl:if>
</xsl:for-each>
<xsl:if test="not(self::*)">
<xsl:text />/@<xsl:value-of select="name(.)" />
</xsl:if>
</xsl:template>

<!--MODE: GENERATE-ID-FROM-PATH -->
<xsl:template match="/" mode="generate-id-from-path" />
<xsl:template match="text()" mode="generate-id-from-path">
<xsl:apply-templates select="parent::*" mode="generate-id-from-path" />
<xsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')" />
</xsl:template>
<xsl:template match="comment()" mode="generate-id-from-path">
<xsl:apply-templates select="parent::*" mode="generate-id-from-path" />
<xsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')" />
</xsl:template>
<xsl:template match="processing-instruction()" mode="generate-id-from-path">
<xsl:apply-templates select="parent::*" mode="generate-id-from-path" />
<xsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')" />
</xsl:template>
<xsl:template match="@*" mode="generate-id-from-path">
<xsl:apply-templates select="parent::*" mode="generate-id-from-path" />
<xsl:value-of select="concat('.@', name())" />
</xsl:template>
<xsl:template match="*" mode="generate-id-from-path" priority="-0.5">
<xsl:apply-templates select="parent::*" mode="generate-id-from-path" />
<xsl:text>.</xsl:text>
<xsl:choose>
<xsl:when test="count(. | ../namespace::*) = count(../namespace::*)">
<xsl:value-of select="concat('.namespace::-',1+count(namespace::*),'-')" />
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--MODE: GENERATE-ID-2 -->
<xsl:template match="/" mode="generate-id-2">U</xsl:template>
<xsl:template match="*" mode="generate-id-2" priority="2">
<xsl:text>U</xsl:text>
<xsl:number level="multiple" count="*" />
</xsl:template>
<xsl:template match="node()" mode="generate-id-2">
<xsl:text>U.</xsl:text>
<xsl:number level="multiple" count="*" />
<xsl:text>n</xsl:text>
<xsl:number count="node()" />
</xsl:template>
<xsl:template match="@*" mode="generate-id-2">
<xsl:text>U.</xsl:text>
<xsl:number level="multiple" count="*" />
<xsl:text>_</xsl:text>
<xsl:value-of select="string-length(local-name(.))" />
<xsl:text>_</xsl:text>
<xsl:value-of select="translate(name(),':','.')" />
</xsl:template>
<!--Strip characters-->
<xsl:template match="text()" priority="-1" />

<!--SCHEMA METADATA-->
<xsl:template match="/">
<Schematron>
<Information>Checking OIOUBL-2.02 ApplicationResponse, FC 2010-09-15, Version 1.2</Information>
<xsl:apply-templates select="/" mode="M9" /><xsl:apply-templates select="/" mode="M11" /><xsl:apply-templates select="/" mode="M12" /><xsl:apply-templates select="/" mode="M13" /><xsl:apply-templates select="/" mode="M14" /><xsl:apply-templates select="/" mode="M15" /><xsl:apply-templates select="/" mode="M16" /><xsl:apply-templates select="/" mode="M17" />
</Schematron>
</xsl:template>

<!--SCHEMATRON PATTERNS-->


<!--PATTERN abstracts2-->
<xsl:variable name="AccountType" select="',1,2,3,'" />
<xsl:variable name="AccountType_listID" select="'urn:oioubl:codelist:accounttypecode-1.1'" />
<xsl:variable name="AccountType_agencyID" select="'320'" />
<xsl:variable name="UN_AddressFormat" select="',1,2,3,4,5,6,7,8,9,'" />
<xsl:variable name="UN_AddressFormat_listID" select="'UN/ECE 3477'" />
<xsl:variable name="UN_AddressFormat_agencyID" select="'6'" />
<xsl:variable name="AddressFormat" select="',StructuredDK,StructuredID,StructuredLax,StructuredRegion,Unstructured,'" />
<xsl:variable name="AddressFormat_listID" select="'urn:oioubl:codelist:addressformatcode-1.1'" />
<xsl:variable name="AddressFormat_agencyID" select="'320'" />
<xsl:variable name="AddressType" select="',Home,Business,'" />
<xsl:variable name="AddressType_listID" select="'urn:oioubl:codelist:addresstypecode-1.1'" />
<xsl:variable name="AddressType_agencyID" select="'320'" />
<xsl:variable name="Allowance" select="',1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,ZZZ,'" />
<xsl:variable name="Allowance_listID" select="'UN/ECE 4465'" />
<xsl:variable name="Allowance_agencyID" select="'6'" />
<xsl:variable name="CatDocType" select="',Brochure,Drawing,Picture,ProductSheet,'" />
<xsl:variable name="CatDocType_listID" select="'urn:oioubl:codelist:cataloguedocumenttypecode-1.1'" />
<xsl:variable name="CatDocType_agencyID" select="'320'" />
<xsl:variable name="CatAction" select="',Update,Delete,Add,'" />
<xsl:variable name="CatAction_listID" select="'urn:oioubl:codelist:catalogueactioncode-1.1'" />
<xsl:variable name="CatAction_agencyID" select="'320'" />
<xsl:variable name="CountryCode" select="',AF,AD,AE,AG,AI,AL,AM,AN,AO,AQ,AR,AS,AT,AU,AW,AX,AZ,BA,BB,BD,BE,BF,BG,BH,BI,BJ,BL,BM,BN,BO,BR,BS,BT,BV,BW,BY,BZ,CA,CC,CD,CF,CG,CH,CI,CK,CL,CM,CN,CO,CR,CU,CV,CX,CY,CZ,DE,DJ,DK,DM,DO,DZ,EC,EE,EG,EH,ER,ES,ET,FI,FJ,FK,FM,FO,FR,GA,GB,GD,GE,GF,GG,GH,GI,GL,GM,GN,GP,GQ,GR,GS,GT,GU,GW,GY,HK,HM,HN,HR,HT,HU,ID,IE,IL,IM,IN,IO,IQ,IR,IS,IT,JE,JM,JO,JP,KE,KG,KH,KI,KM,KN,KP,KR,KW,KY,KZ,LA,LB,LC,LI,LK,LR,LS,LT,LU,LV,LY,MA,MC,MD,ME,MF,MG,MH,MK,ML,MM,MN,MO,MP,MQ,MR,MS,MT,MU,MV,MW,MX,MY,MZ,NA,NC,NE,NF,NG,NI,NL,NO,NP,NR,NU,NZ,OM,PA,PE,PF,PG,PH,PK,PL,PM,PN,PR,PS,PT,PW,PY,QA,RE,RO,RS,RU,RW,SA,SB,SC,SD,SE,SG,SH,SI,SJ,SK,SL,SM,SN,SO,SR,ST,SV,SY,SZ,TC,TD,TF,TG,TH,TJ,TK,TL,TM,TN,TO,TR,TT,TV,TW,TZ,UA,UG,UM,US,UY,UZ,VA,VC,VE,VG,VI,VN,VU,WF,WS,YE,YT,ZA,ZM,ZW,'" />
<xsl:variable name="CountryCode_listID" select="'ISO3166-1'" />
<xsl:variable name="CountryCode_agencyID" select="'6'" />
<xsl:variable name="CountrySub" select="',DK-81,'" />
<xsl:variable name="CountrySub_listID" select="'ISO 3166-2'" />
<xsl:variable name="CountrySub_agencyID" select="'6'" />
<xsl:variable name="CurrencyCode" select="',EUR,AFA,DZD,ADP,ARS,AMD,AWG,AUD,AZM,BSD,BHD,THB,PAB,BBD,BYB,BYR,BEF,BZD,BMD,VEB,BOB,BRL,BND,BGN,BIF,CAD,CVE,KYD,GHC,XOF,XAF,XPF,CLP,COP,KMF,BAM,NIO,CRC,HRK,CUP,CYP,CZK,GMD,DKK,MKD,DEM,DJF,STD,DOP,VND,GRD,XCD,EGP,SVC,ETB,FKP,FJD,HUF,CDF,FRF,GIP,HTG,PYG,GNF,GWP,GYD,HKD,UAH,ISK,INR,IRR,IQD,IEP,ITL,JMD,JOD,KES,PGK,LAK,EEK,KWD,MWK,ZMK,AOA,MMK,GEL,LVL,LBP,ALL,HNL,SLL,ROL,BGL,LRD,LYD,SZL,LTL,LSL,LUF,MGF,MYR,MTL,TMM,FIM,MUR,MZM,MXN,MXV,MDL,MAD,BOV,NGN,ERN,NAD,NPR,ANG,NLG,ILS,TWD,NZD,BTN,KPW,NOK,PEN,MRO,TOP,PKR,MOP,UYU,PHP,PTE,GBP,BWP,QAR,GTQ,ZAR,OMR,KHR,MVR,IDR,RUB,RUR,RWF,SHP,SAR,ATS,XDR,SCR,SGD,SKK,SBD,KGS,SOS,ESP,LKR,SDD,SRG,SEK,CHF,SYP,TJR,BDT,WST,TZS,KZT,TPE,SIT,TTD,MNT,TND,TRL,AED,UGX,CLF,USD,UZS,VUV,KRW,YER,JPY,CNY,YUM,ZWD,PLN,AFA,DZD,ADP,ARS,AMD,AWG,AUD,AZM,BSD,BHD,THB,PAB,BBD,BYB,BYR,BEF,BZD,BMD,VEB,BOB,BRL,BND,BGN,'" />
<xsl:variable name="CurrencyCode_listID" select="'ISO 4217 Alpha'" />
<xsl:variable name="CurrencyCode_agencyID" select="'6'" />
<xsl:variable name="Discrepancy" select="',Billing1,Billing2,Billing3,Condition1,Condition2,Condition3,Condition4,Condition5,Condition6,Delivery1,Delivery2,Delivery3,Quality1,Quality2,ZZZ,'" />
<xsl:variable name="Discrepancy_listID" select="'urn:oioubl:codelist:discrepancyresponsecode-1.1'" />
<xsl:variable name="Discrepancy_agencyID" select="'320'" />
<xsl:variable name="DocTypeCode" select="'rule'" />
<xsl:variable name="DocTypeCode_listID" select="'UN/ECE 1001'" />
<xsl:variable name="DocTypeCode_agencyID" select="'6'" />
<xsl:variable name="InvTypeCode" select="',325,380,393,'" />
<xsl:variable name="InvTypeCode_listID" select="'urn:oioubl:codelist:invoicetypecode-1.1'" />
<xsl:variable name="InvTypeCode_agencyID" select="'320'" />
<xsl:variable name="UNSPSC" select="'rule'" />
<xsl:variable name="UNSPSC_listID" select="'UNSPSC'" />
<xsl:variable name="UNSPSC_agencyID" select="'113'" />
<xsl:variable name="LifeCycle" select="',Available,DeletedAnnouncement,ItemDeleted,NewAnnouncement,NewAvailable,ItemTemporarilyUnavailable,'" />
<xsl:variable name="LifeCycle_listID" select="'urn:oioubl:codelist:lifecyclestatuscode-1.1'" />
<xsl:variable name="LifeCycle_agencyID" select="'320'" />
<xsl:variable name="LineResponse" select="',BusinessAccept,BusinessReject,'" />
<xsl:variable name="LineResponse_listID" select="'urn:oioubl:codelist:lineresponsecode-1.1'" />
<xsl:variable name="LineResponse_agencyID" select="'320'" />
<xsl:variable name="LineStatus" select="',Added,Cancelled,Disputed,NoStatus,Revised,'" />
<xsl:variable name="LineStatus_listID" select="'urn:oioubl:codelist:linestatuscode-1.1'" />
<xsl:variable name="LineStatus_agencyID" select="'320'" />
<xsl:variable name="LossRisk" select="',FOB,'" />
<xsl:variable name="LossRisk_listID" select="'urn:oioubl:codelist:lossriskresponsibilitycode-1.1'" />
<xsl:variable name="LossRisk_agencyID" select="'320'" />
<xsl:variable name="PaymentChannel" select="',BBAN,DK:BANK,DK:FIK,DK:GIRO,DK:NEMKONTO,FI:BANK,FI:GIRO,GB:BACS,GB:BANK,GB:GIRO,IBAN,IS:BANK,IS:GIRO,IS:IK66,IS:RB,NO:BANK,SE:BANKGIRO,SE:PLUSGIRO,SWIFTUS,ZZZ,'" />
<xsl:variable name="PaymentChannel_listID" select="'urn:oioubl:codelist:paymentchannelcode-1.1'" />
<xsl:variable name="PaymentChannel_agencyID" select="'320'" />
<xsl:variable name="PriceType" select="',AAA,AAB,AAC,AAD,AAE,AAF,AAG,AAH,AAI,AAJ,AAK,AAL,AAM,AAN,AAO,AAP,AAQ,AAR,AAS,AAT,AAU,AAV,AAW,AAX,AAY,AAZ,ABA,ABB,ABC,ABD,ABE,ABF,ABG,ABH,ABI,ABJ,ABK,ABL,ABM,ABN,ABO,ABP,ABQ,ABR,ABS,ABT,ABU,ABV,AI,ALT,AP,BR,CAT,CDV,CON,CP,CU,CUP,CUS,DAP,DIS,DPR,DR,DSC,EC,ES,EUP,FCR,GRP,INV,LBL,MAX,MIN,MNR,MSR,MXR,NE,NQT,NTP,NW,OCR,OFR,PAQ,PBQ,PPD,PPR,PRO,PRP,PW,QTE,RES,RTP,SHD,SRP,SW,TB,TRF,TU,TW,WH,'" />
<xsl:variable name="PriceType_listID" select="'UN/ECE 5387'" />
<xsl:variable name="PriceType_agencyID" select="'6'" />
<xsl:variable name="PriceListStat" select="',Original,Copy,Revision,Cancellation,'" />
<xsl:variable name="PriceListStat_listID" select="'urn:oioubl.codelist:priceliststatuscode-1.1'" />
<xsl:variable name="PriceListStat_agencyID" select="'320'" />
<xsl:variable name="RemType" select="',Reminder,Advis,'" />
<xsl:variable name="RemType_listID" select="'urn:oioubl.codelist:remindertypecode-1.1'" />
<xsl:variable name="RemType_agencyID" select="'320'" />
<xsl:variable name="RemAlc" select="',PenaltyFee,PenaltyRate,'" />
<xsl:variable name="RemAlc_listID" select="'urn:oioubl:codelist:reminderallowancechargereasoncode-1.0'" />
<xsl:variable name="RemAlc_agencyID" select="'320'" />
<xsl:variable name="Response" select="',BusinessAccept,BusinessReject,ProfileAccept,ProfileReject,TechnicalAccept,TechnicalReject,'" />
<xsl:variable name="Response_listID" select="'urn:oioubl:codelist:responsecode-1.1'" />
<xsl:variable name="Response_agencyID" select="'320'" />
<xsl:variable name="ResponseDocType" select="',ApplicationResponse,Catalogue,CatalogueDeletion,CatalogueItemSpecificationUpdate,CatalogueItemUpdate,CataloguePricingUpdate,CataloguePriceUpdate,CatalogueRequest,CreditNote,Invoice,Order,OrderCancellation,OrderChange,OrderResponse,OrderResponseSimple,Reminder,Statement,Payment,PersonalSecure,ZZZ,'" />
<xsl:variable name="ResponseDocType_listID" select="'urn:oioubl:codelist:responsedocumenttypecode-1.1'" />
<xsl:variable name="ResponseDocType_agencyID" select="'320'" />
<xsl:variable name="ResponseDocType2" select="',ApplicationResponse,Catalogue,CatalogueDeletion,CatalogueItemSpecificationUpdate,CatalogueItemUpdate,CataloguePricingUpdate,CataloguePriceUpdate,CatalogueRequest,CreditNote,Invoice,Order,OrderCancellation,OrderChange,OrderResponse,OrderResponseSimple,Reminder,Statement,Payment,UtilityStatement,PersonalSecure,ZZZ,'" />
<xsl:variable name="ResponseDocType2_listID" select="'urn:oioubl:codelist:responsedocumenttypecode-1.2'" />
<xsl:variable name="ResponseDocType2_agencyID" select="'320'" />
<xsl:variable name="SubStatus" select="',DeliveryDateChanged,DeliveryDateNotPossible,DeliveryPartyUnknown,ItemDeleted,ItemNotFound,ItemNotInAssortment,ItemReplaced,ItemTemporarilyUnavailable,NewAnnouncement,OrderedQuantityChanged,OrderLineRejected,Original,SeasonalItemUnavailable,Substitution,'" />
<xsl:variable name="SubStatus_listID" select="'urn:oioubl:codelist:substitutionstatuscode-1.1'" />
<xsl:variable name="SubStatus_agencyID" select="'320'" />
<xsl:variable name="TaxExemption" select="',AAA,AAB,AAC,AAE,AAF,AAG,AAH,AAI,AAJ,AAK,AAL,AAM,AAN,AAO,'" />
<xsl:variable name="TaxExemption_listID" select="'CWA 15577'" />
<xsl:variable name="TaxExemption_agencyID" select="'CEN'" />
<xsl:variable name="TaxType" select="',StandardRated,ZeroRated,'" />
<xsl:variable name="TaxType_listID" select="'urn:oioubl:codelist:taxtypecode-1.1'" />
<xsl:variable name="TaxType_agencyID" select="'320'" />
<xsl:variable name="UnitMeasure" select="'xsd'" />
<xsl:variable name="UnitMeasure_listID" select="'UN/ECE rec 20'" />
<xsl:variable name="UnitMeasure_agencyID" select="'6'" />
<xsl:variable name="Delivery_1" select="',EXW,FCA,FAS,FOB,CFR,CIF,CPT,CIP,DAF,DES,DEQ,DDU,DDP,'" />
<xsl:variable name="Delivery_1_schemeID" select="'INCOTERMS 2000'" />
<xsl:variable name="Delivery_1_agencyID" select="'NES'" />
<xsl:variable name="Delivery_2" select="',001 EXW,002 FCA,003 FAS,004 FOB,005 FCA,006 CPT,007 CIP,008 CFR,009 CIF,010 CPT,011 CIP,012 CPT,013 CIP,014 CPT,015 CIP,016 DES,017 DRQ,018 DAF,019 DDU,021 DDP,022 DDU,023 DDP,'" />
<xsl:variable name="Delivery_2_schemeID" select="'COMBITERMS 2000'" />
<xsl:variable name="Delivery_2_agencyID" select="'NES'" />
<xsl:variable name="Dimension" select="',A,AAA,AAB,AAC,AAD,AAE,AAF,AAJ,AAK,AAL,AAM,AAN,AAO,AAP,AAQ,AAR,AAS,AAT,AAU,AAV,AAW,AAX,AAY,AAZ,ABA,ABB,ABC,ABD,ABE,ABJ,ABS,ABX,ABY,ABZ,ACA,ACE,ACG,ACN,ACP,ACS,ACV,ACW,ACX,ADR,ADS,ADT,ADU,ADV,ADW,ADX,ADY,ADZ,AEA,AEB,AEC,AED,AEE,AEF,AEG,AEH,AEI,AEJ,AEK,AEM,AEN,AEO,AEP,AEQ,AER,AET,AEU,AEV,AEW,AEX,AEY,AEZ,AF,AFA,AFB,AFC,AFD,AFE,AFF,AFG,AFH,AFI,AFJ,AFK,B,BL,BMY,BMZ,BNA,BNB,BNC,BND,BNE,BNF,BNG,BNH,BNI,BNJ,BNK,BNL,BNM,BNN,BNO,BNP,BNQ,BNR,BNS,BNT,BR,BRA,BRE,BS,BSW,BW,CHN,CM,CT,CV,CZ,D,DI,DL,DN,DP,DR,DS,DW,E,EA,F,FI,FL,FN,FV,G,GG,GW,HF,HM,HT,IB,ID,L,LM,LN,LND,M,MO,MW,N,OD,PRS,PTN,RA,RF,RJ,RMW,RP,RUN,RY,SQ,T,TC,TH,TN,TT,U,VH,VW,WA,WD,WM,WT,WU,XH,XQ,XZ,YS,ZAL,ZAS,ZB,ZBI,ZC,ZCA,ZCB,ZCE,ZCL,ZCO,ZCR,ZCU,ZFE,ZFS,ZGE,ZH,ZK,ZMG,ZMN,ZMO,ZN,ZNA,ZNB,ZNI,ZO,ZP,ZPB,ZS,ZSB,ZSE,ZSI,ZSL,ZSN,ZTA,ZTE,ZTI,ZV,ZW,ZWA,ZZN,ZZR,ZZZ,'" />
<xsl:variable name="Dimension_schemeID" select="'UN/ECE 6313'" />
<xsl:variable name="Dimension_agencyID" select="'6'" />
<xsl:variable name="BIC" select="'rule'" />
<xsl:variable name="BIC_schemeID" select="'BIC'" />
<xsl:variable name="BIC_agencyID" select="'17'" />
<xsl:variable name="IBAN" select="'rule'" />
<xsl:variable name="IBAN_schemeID" select="'IBAN'" />
<xsl:variable name="IBAN_agencyID" select="'17'" />
<xsl:variable name="LocID" select="'rule'" />
<xsl:variable name="LocID_schemeID" select="'UN/ECE rec 16'" />
<xsl:variable name="LocID_agencyID" select="'6'" />
<xsl:variable name="PaymentID" select="',01,04,15,71,73,75,'" />
<xsl:variable name="PaymentID_schemeID" select="'urn:oioubl:id:paymentid-1.1'" />
<xsl:variable name="PaymentID_agencyID" select="'320'" />
<xsl:variable name="Profile1" select="',NONE,Procurement-BilSim-1.0,Procurement-BilSimR-1.0,Procurement-PayBas-1.0,Procurement-PayBasR-1.0,Procurement-OrdSim-BilSim-1.0,Procurement-OrdSimR-BilSim-1.0,Procurement-OrdSim-BilSimR-1.0,Procurement-OrdSimR-BilSimR-1.0,Procurement-OrdAdv-BilSim-1.0,Procurement-OrdAdv-BilSimR-1.0,Procurement-OrdAdvR-BilSim-1.0,Procurement-OrdAdvR-BilSimR-1.0,Procurement-OrdSel-BilSim-1.0,Procurement-OrdSel-BilSimR-1.0,Catalogue-CatBas-1.0,Catalogue-CatBasR-1.0,Catalogue-CatSim-1.0,Catalogue-CatSimR-1.0,Catalogue-CatExt-1.0,Catalogue-CatExtR-1.0,Catalogue-CatAdv-1.0,Catalogue-CatAdvR-1.0,urn:www.nesubl.eu:profiles:profile1:ver1.0,urn:www.nesubl.eu:profiles:profile2:ver1.0,urn:www.nesubl.eu:profiles:profile5:ver1.0,urn:www.nesubl.eu:profiles:profile7:ver1.0,urn:www.nesubl.eu:profiles:profile8:ver1.0,'" />
<xsl:variable name="Profile1_schemeID" select="'urn:oioubl:id:profileid-1.1'" />
<xsl:variable name="Profile1_agencyID" select="'320'" />
<xsl:variable name="Profile2" select="',NONE,Procurement-BilSim-1.0,Procurement-BilSimR-1.0,Procurement-PayBas-1.0,Procurement-PayBasR-1.0,Procurement-OrdSim-BilSim-1.0,Procurement-OrdSimR-BilSim-1.0,Procurement-OrdSim-BilSimR-1.0,Procurement-OrdSimR-BilSimR-1.0,Procurement-OrdAdv-BilSim-1.0,Procurement-OrdAdv-BilSimR-1.0,Procurement-OrdAdvR-BilSim-1.0,Procurement-OrdAdvR-BilSimR-1.0,Procurement-OrdSel-BilSim-1.0,Procurement-OrdSel-BilSimR-1.0,Catalogue-CatBas-1.0,Catalogue-CatBasR-1.0,Catalogue-CatSim-1.0,Catalogue-CatSimR-1.0,Catalogue-CatExt-1.0,Catalogue-CatExtR-1.0,Catalogue-CatAdv-1.0,Catalogue-CatAdvR-1.0,urn:www.nesubl.eu:profiles:profile1:ver1.0,urn:www.nesubl.eu:profiles:profile2:ver1.0,urn:www.nesubl.eu:profiles:profile5:ver1.0,urn:www.nesubl.eu:profiles:profile7:ver1.0,urn:www.nesubl.eu:profiles:profile8:ver1.0,urn:www.nesubl.eu:profiles:profile1:ver2.0,urn:www.nesubl.eu:profiles:profile2:ver2.0,urn:www.nesubl.eu:profiles:profile5:ver2.0,urn:www.nesubl.eu:profiles:profile7:ver2.0,urn:www.nesubl.eu:profiles:profile8:ver2.0,'" />
<xsl:variable name="Profile2_schemeID" select="'urn:oioubl:id:profileid-1.2'" />
<xsl:variable name="Profile2_agencyID" select="'320'" />
<xsl:variable name="Profile3" select="',NONE,Procurement-BilSim-1.0,Procurement-BilSimR-1.0,Procurement-PayBas-1.0,Procurement-PayBasR-1.0,Procurement-OrdSim-BilSim-1.0,Procurement-OrdSimR-BilSim-1.0,Procurement-OrdSim-BilSimR-1.0,Procurement-OrdSimR-BilSimR-1.0,Procurement-OrdAdv-BilSim-1.0,Procurement-OrdAdv-BilSimR-1.0,Procurement-OrdAdvR-BilSim-1.0,Procurement-OrdAdvR-BilSimR-1.0,Procurement-OrdSel-BilSim-1.0,Procurement-OrdSel-BilSimR-1.0,Catalogue-CatBas-1.0,Catalogue-CatBasR-1.0,Catalogue-CatSim-1.0,Catalogue-CatSimR-1.0,Catalogue-CatExt-1.0,Catalogue-CatExtR-1.0,Catalogue-CatAdv-1.0,Catalogue-CatAdvR-1.0,urn:www.nesubl.eu:profiles:profile1:ver1.0,urn:www.nesubl.eu:profiles:profile2:ver1.0,urn:www.nesubl.eu:profiles:profile5:ver1.0,urn:www.nesubl.eu:profiles:profile7:ver1.0,urn:www.nesubl.eu:profiles:profile8:ver1.0,urn:www.nesubl.eu:profiles:profile1:ver2.0,urn:www.nesubl.eu:profiles:profile2:ver2.0,urn:www.nesubl.eu:profiles:profile5:ver2.0,urn:www.nesubl.eu:profiles:profile7:ver2.0,urn:www.nesubl.eu:profiles:profile8:ver2.0,Reference-Utility-1.0,Reference-UtilityR-1.0,'" />
<xsl:variable name="Profile3_schemeID" select="'urn:oioubl:id:profileid-1.3'" />
<xsl:variable name="Profile3_agencyID" select="'320'" />
<xsl:variable name="TaxCategory" select="',ZeroRated,StandardRated,ReverseCharge,Excise,3010,3020,3021,3022,3023,3024,3025,3030,3040,3041,3048,3049,3050,3051,3052,3053,3054,3055,3056,3057,3058,3059,3060,3061,3062,3063,3064,3065,3066,3067,3068,3070,3071,3072,3073,3075,3080,3081,3082,3083,3084,3085,3086,3090,3091,3092,3093,3094,3095,3096,3100,3101,3102,3120,3121,3122,3123,3130,3140,3141,3160,3161,3162,3163,3170,3171,3240,3241,3242,3245,3246,3247,3250,3251,3260,3271,3272,3273,3276,3277,3280,3281,3282,3283,3290,3291,3292,3293,3294,3295,3296,3297,3300,3301,3302,3303,3304,3305,3310,3311,3320,3321,3330,3331,3340,3341,3350,3351,3360,3370,3380,3400,3403,3404,3405,3406,3410,3420,3430,3440,3441,3451,3452,3453,3500,3501,3502,3503,3600,3620,3621,3622,3623,3624,3630,3631,3632,3633,3634,3635,3636,3637,3638,3640,3641,3645,3650,3660,3661,3670,3671,'" />
<xsl:variable name="TaxCategory_schemeID" select="'urn:oioubl:id:taxcategoryid-1.1'" />
<xsl:variable name="TaxCategory_agencyID" select="'320'" />
<xsl:variable name="TaxScheme" select="',9,10,11,16,17,18,19,21,24,25,27,28,30,31,32,33,39,40,41,53,54,56,57,61,62,63,69,70,71,72,75,76,77,79,85,86,87,91,94,95,97,98,99,100,108,109,110,111,127,128,130,133,134,135,136,137,138,139,140,142,146,151,152,VAT,0,'" />
<xsl:variable name="TaxScheme_schemeID" select="'urn:oioubl:id:taxschemeid-1.1'" />
<xsl:variable name="TaxScheme_agencyID" select="'320'" />
<xsl:variable name="TaxScheme2" select="',9,10,11,16,17,18,19,21,21a,21b,21c,21d,21e,21f,24,25,27,28,30,31,32,33,39,40,41,53,54,56,57,61,61a,62,63,69,70,71,72,75,76,77,79,85,86,87,91,94,94a,95,97,98,99,99a,100,108,109,110,110a,110b,110c,111,112,112a,112b,112c,112d,112e,112f,127,127a,127b,127c,128,130,133,134,135,136,137,138,139,140,142,146,151,152,VAT,0,'" />
<xsl:variable name="TaxScheme2_schemeID" select="'urn:oioubl:id:taxschemeid-1.2'" />
<xsl:variable name="TaxScheme2_agencyID" select="'320'" />
<xsl:variable name="EndpointID" select="',DUNS,GLN,IBAN,ISO 6523,DK:CPR,DK:CVR,DK:P,DK:SE,DK:VANS,'" />
<xsl:variable name="PartyID" select="',DUNS,GLN,IBAN,ISO 6523,ZZZ,DK:CPR,DK:CVR,DK:P,DK:SE,DK:TELEFON,FI:ORGNR,IS:KT,IS:VSKNR,NO:EFO,NO:NOBB,NO:NODI,NO:ORGNR,NO:VAT,SE:ORGNR,SE:VAT,'" />
<xsl:variable name="PartyLegalID" select="',DK:CVR,DK:CPR,ZZZ,'" />
<xsl:variable name="PartyTaxID" select="',DK:SE,ZZZ,'" />
<xsl:template match="text()" priority="-1" mode="M9" />
<xsl:template match="@*|node()" priority="-2" mode="M9">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M9" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M9" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN abstracts-->
<xsl:template match="text()" priority="-1" mode="M11" />
<xsl:template match="@*|node()" priority="-2" mode="M11">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M11" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M11" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN profile-->


	<!--RULE -->
<xsl:template match="/" priority="3999" mode="M12">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="local-name(*) = 'ApplicationResponse'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(*) = 'ApplicationResponse'</Pattern>
<Description>[F-APR001] Root element must be ApplicationResponse</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M12" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse" priority="3998" mode="M12">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:UBLVersionID = '2.0'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:UBLVersionID = '2.0'</Pattern>
<Description>[F-LIB001] Invalid UBLVersionID. Must be '2.0'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CustomizationID = 'OIOUBL-2.01' or cbc:CustomizationID = 'OIOUBL-2.02'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CustomizationID = 'OIOUBL-2.01' or cbc:CustomizationID = 'OIOUBL-2.02'</Pattern>
<Description>[F-LIB002] Invalid CustomizationID. Must be either 'OIOUBL-2.01' or 'OIOUBL-2.02'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ProfileID/@schemeID = $Profile1_schemeID or cbc:ProfileID/@schemeID = $Profile2_schemeID or cbc:ProfileID/@schemeID = $Profile3_schemeID" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ProfileID/@schemeID = $Profile1_schemeID or cbc:ProfileID/@schemeID = $Profile2_schemeID or cbc:ProfileID/@schemeID = $Profile3_schemeID</Pattern>
<Description>[W-LIB003] Invalid schemeID. Must be '<xsl:text />
<xsl:value-of select="$Profile1_schemeID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$Profile2_schemeID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$Profile3_schemeID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ProfileID/@schemeAgencyID = $Profile1_agencyID" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ProfileID/@schemeAgencyID = $Profile1_agencyID</Pattern>
<Description>[W-LIB203] Invalid schemeAgencyID. Must be '<xsl:text />
<xsl:value-of select="$Profile1_agencyID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:ProfileID/@schemeID = $Profile1_schemeID and not (contains($Profile1, concat(',',cbc:ProfileID,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ProfileID/@schemeID = $Profile1_schemeID and not (contains($Profile1, concat(',',cbc:ProfileID,',')))</Pattern>
<Description>[F-LIB004] Invalid ProfileID: '<xsl:text />
<xsl:value-of select="cbc:ProfileID" />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ProfileID/@schemeID = $Profile2_schemeID and not (contains($Profile2, concat(',',cbc:ProfileID,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ProfileID/@schemeID = $Profile2_schemeID and not (contains($Profile2, concat(',',cbc:ProfileID,',')))</Pattern>
<Description>[F-LIB302] Invalid ProfileID: '<xsl:text />
<xsl:value-of select="cbc:ProfileID" />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ProfileID/@schemeID = $Profile3_schemeID and not (contains($Profile3, concat(',',cbc:ProfileID,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ProfileID/@schemeID = $Profile3_schemeID and not (contains($Profile3, concat(',',cbc:ProfileID,',')))</Pattern>
<Description>[F-LIB308] Invalid ProfileID: '<xsl:text />
<xsl:value-of select="cbc:ProfileID" />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ProfileID = 'NONE') and not(cac:DocumentResponse/cac:Response/cbc:ResponseCode = 'TechnicalReject' or cac:DocumentResponse/cac:Response/cbc:ResponseCode = 'ProfileReject')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ProfileID = 'NONE') and not(cac:DocumentResponse/cac:Response/cbc:ResponseCode = 'TechnicalReject' or cac:DocumentResponse/cac:Response/cbc:ResponseCode = 'ProfileReject')</Pattern>
<Description>[F-APR004] ProfileID with value 'NONE' is only allowed when ResponseCode equals 'TechnicalReject' or 'ProfileReject'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M12" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M12" />
<xsl:template match="@*|node()" priority="-2" mode="M12">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M12" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M12" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN applicationresponse-->


	<!--RULE -->
<xsl:template match="doc:ApplicationResponse" priority="3999" mode="M13">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID != ''</Pattern>
<Description>[F-APR005] Invalid ID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="count(cac:DocumentResponse) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:DocumentResponse) &gt; 1</Pattern>
<Description>[F-APR054] No more than one DocumentResponse class may be present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M13" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cbc:UUID" priority="3998" mode="M13">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="string-length(string(.)) = 36" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(string(.)) = 36</Pattern>
<Description>[F-LIB006] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M13" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cbc:Note" priority="3997" mode="M13">

		<!--REPORT -->
<xsl:if test="count(../cbc:Note) &gt; 1 and not(./@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cbc:Note) &gt; 1 and not(./@languageID)</Pattern>
<Description>[W-LIB011] The attribute languageID should be used when more than one <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text /> element is present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID</Pattern>
<Description>[W-LIB012] Multilanguage error. Replicated <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text /> elements with same languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M13" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M13" />
<xsl:template match="@*|node()" priority="-2" mode="M13">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M13" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M13" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN signature-->


	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:Signature" priority="3999" mode="M14">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID != ''</Pattern>
<Description>[F-APR006] Invalid ID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M14" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:Signature/cac:SignatoryParty" priority="3998" mode="M14">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:MarkCareIndicator) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:MarkCareIndicator) = 0</Pattern>
<Description>[F-LIB166] MarkCareIndicator element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:MarkAttentionIndicator) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:MarkAttentionIndicator) = 0</Pattern>
<Description>[F-LIB167] MarkAttentionIndicator element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:AgentParty) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:AgentParty) = 0</Pattern>
<Description>[F-LIB168] AgentParty class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(not(cac:PartyIdentification) or cac:PartyIdentification/cbc:ID = '') and (not(cac:PartyName) or cac:PartyName/cbc:Name = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cac:PartyIdentification) or cac:PartyIdentification/cbc:ID = '') and (not(cac:PartyName) or cac:PartyName/cbc:Name = '')</Pattern>
<Description>[F-LIB022] PartyName/Name is mandatory if PartyIdentification/ID is not found</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:EndpointID and not(cbc:EndpointID/@schemeID = 'GLN' or cbc:EndpointID/@schemeID = 'DUNS' or cbc:EndpointID/@schemeID = 'DK:P' or cbc:EndpointID/@schemeID = 'DK:CVR' or cbc:EndpointID/@schemeID = 'DK:CPR' or cbc:EndpointID/@schemeID = 'DK:SE' or cbc:EndpointID/@schemeID = 'DK:VANS' or cbc:EndpointID/@schemeID = 'IBAN' or cbc:EndpointID/@schemeID = 'ISO 6523')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:EndpointID and not(cbc:EndpointID/@schemeID = 'GLN' or cbc:EndpointID/@schemeID = 'DUNS' or cbc:EndpointID/@schemeID = 'DK:P' or cbc:EndpointID/@schemeID = 'DK:CVR' or cbc:EndpointID/@schemeID = 'DK:CPR' or cbc:EndpointID/@schemeID = 'DK:SE' or cbc:EndpointID/@schemeID = 'DK:VANS' or cbc:EndpointID/@schemeID = 'IBAN' or cbc:EndpointID/@schemeID = 'ISO 6523')</Pattern>
<Description>[F-LIB179] Invalid schemeID. Must be a valid scheme for EndpointID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'DK:CVR') and (string-length(cbc:EndpointID) != 10 or substring(cbc:EndpointID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'DK:CVR') and (string-length(cbc:EndpointID) != 10 or substring(cbc:EndpointID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB180] schemeID = DK:CVR, EndpointID must be a valid CVR number (DK12345678)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'DK:CPR') and not(string-length(cbc:EndpointID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'DK:CPR') and not(string-length(cbc:EndpointID) = 10)</Pattern>
<Description>[F-LIB215] schemeID = DK:CPR, EndpointID must be a valid CPR number (1234560000)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'GLN') and not(string-length(cbc:EndpointID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'GLN') and not(string-length(cbc:EndpointID) = 13)</Pattern>
<Description>[F-LIB181] schemeID = GLN, EndpointID must be a valid GLN number (1234567890123)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'EAN') and not(string-length(cbc:EndpointID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'EAN') and not(string-length(cbc:EndpointID) = 13)</Pattern>
<Description>[F-LIB216] schemeID = EAN, EndpointID must be a valid EAN number (1234567890123)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(cac:PartyLegalEntity) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:PartyLegalEntity) &gt; 1</Pattern>
<Description>[F-APR039] No more than one PartyLegalEntity class may be present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M14" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:Signature/cac:SignatoryParty/cac:PartyIdentification" priority="3997" mode="M14">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeID = 'DUNS' or cbc:ID/@schemeID = 'GLN' or cbc:ID/@schemeID = 'IBAN' or cbc:ID/@schemeID = 'ISO 6523' or cbc:ID/@schemeID = 'ZZZ' or cbc:ID/@schemeID = 'DK:CPR' or cbc:ID/@schemeID = 'DK:CVR' or cbc:ID/@schemeID = 'DK:P' or cbc:ID/@schemeID = 'DK:SE' or cbc:ID/@schemeID = 'DK:TELEFON' or cbc:ID/@schemeID = 'FI:ORGNR' or cbc:ID/@schemeID = 'IS:KT' or cbc:ID/@schemeID = 'IS:VSKNR' or cbc:ID/@schemeID = 'NO:EFO' or cbc:ID/@schemeID = 'NO:NOBB' or cbc:ID/@schemeID = 'NO:NODI' or cbc:ID/@schemeID = 'NO:ORGNR' or cbc:ID/@schemeID = 'NO:VAT' or cbc:ID/@schemeID = 'SE:ORGNR' or cbc:ID/@schemeID = 'SE:VAT'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeID = 'DUNS' or cbc:ID/@schemeID = 'GLN' or cbc:ID/@schemeID = 'IBAN' or cbc:ID/@schemeID = 'ISO 6523' or cbc:ID/@schemeID = 'ZZZ' or cbc:ID/@schemeID = 'DK:CPR' or cbc:ID/@schemeID = 'DK:CVR' or cbc:ID/@schemeID = 'DK:P' or cbc:ID/@schemeID = 'DK:SE' or cbc:ID/@schemeID = 'DK:TELEFON' or cbc:ID/@schemeID = 'FI:ORGNR' or cbc:ID/@schemeID = 'IS:KT' or cbc:ID/@schemeID = 'IS:VSKNR' or cbc:ID/@schemeID = 'NO:EFO' or cbc:ID/@schemeID = 'NO:NOBB' or cbc:ID/@schemeID = 'NO:NODI' or cbc:ID/@schemeID = 'NO:ORGNR' or cbc:ID/@schemeID = 'NO:VAT' or cbc:ID/@schemeID = 'SE:ORGNR' or cbc:ID/@schemeID = 'SE:VAT'</Pattern>
<Description>[F-LIB183] Invalid schemeID. Must be a valid scheme for PartyIdentification/ID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'DK:CVR') and (string-length(cbc:ID) != 10 or substring(cbc:ID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'DK:CVR') and (string-length(cbc:ID) != 10 or substring(cbc:ID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB184] schemeID = DK:CVR, ID must be a valid CVR number (DK12345678)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'DK:CPR') and not(string-length(cbc:ID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'DK:CPR') and not(string-length(cbc:ID) = 10)</Pattern>
<Description>[F-LIB217] schemeID = DK:CPR, ID must be a valid CPR number (1234560000)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'GLN') and not(string-length(cbc:ID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'GLN') and not(string-length(cbc:ID) = 13)</Pattern>
<Description>[F-LIB185] schemeID = GLN, ID must be a valid GLN number (1234567890123)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'EAN') and not(string-length(cbc:ID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'EAN') and not(string-length(cbc:ID) = 13)</Pattern>
<Description>[F-LIB218] schemeID = EAN, ID must be a valid EAN number (1234567890123)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'DK:P') and not(string-length(cbc:ID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'DK:P') and not(string-length(cbc:ID) = 10)</Pattern>
<Description>[F-LIB287] schemeID = DK:P, ID must be a valid P number (1234567890)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M14" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:Signature/cac:SignatoryParty/cac:PartyName" priority="3996" mode="M14">

		<!--REPORT -->
<xsl:if test="count(../cac:PartyName) &gt; 1 and not(./cbc:Name/@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cac:PartyName) &gt; 1 and not(./cbc:Name/@languageID)</Pattern>
<Description>[W-LIB219] The attribute Name@languageID should be used when more than one PartyName class is present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/cbc:Name/@languageID = self::*/cbc:Name/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/cbc:Name/@languageID = self::*/cbc:Name/@languageID</Pattern>
<Description>[W-LIB220] Multilanguage error. Replicated PartyName classes with same Name@languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M14" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:Signature/cac:SignatoryParty/cac:PostalAddress" priority="3995" mode="M14">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:BlockName) = 0</Pattern>
<Description>[F-LIB210] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB211] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB212] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode != ''</Pattern>
<Description>[F-LIB025] Invalid AddressFormatCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')</Pattern>
<Description>[F-LIB204] Invalid listID. Must be 'urn:oioubl:codelist:addresstypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB205] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )</Pattern>
<Description>[F-LIB206] Invalid AddressTypeCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'</Pattern>
<Description>[F-LIB026] Invalid listID. Must be either 'urn:oioubl:codelist:addressformatcode-1.1' or 'UN/ECE 3477'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB207] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode = 'StructuredDK' or cbc:AddressFormatCode = 'StructuredLax' or cbc:AddressFormatCode = 'StructuredID' or cbc:AddressFormatCode = 'StructuredRegion' or cbc:AddressFormatCode = 'Unstructured')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode = 'StructuredDK' or cbc:AddressFormatCode = 'StructuredLax' or cbc:AddressFormatCode = 'StructuredID' or cbc:AddressFormatCode = 'StructuredRegion' or cbc:AddressFormatCode = 'Unstructured')</Pattern>
<Description>[F-LIB027] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')</Pattern>
<Description>[F-LIB208] Invalid listAgencyID. Must be '6'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')</Pattern>
<Description>[F-LIB209] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Country and not(cac:Country/cbc:IdentificationCode != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Country and not(cac:Country/cbc:IdentificationCode != '')</Pattern>
<Description>[F-LIB213] When Country is used the element Country/IdentificationCode must be filled out</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB031] An Unstructured address is only allowed to have AddressLine elements</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine</Pattern>
<Description>[F-LIB032] AddressLine elements not allowed for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or cbc:PostalZone = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or cbc:PostalZone = '')</Pattern>
<Description>[F-LIB033] PostalZone is mandatory for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or cbc:StreetName = '') and (not(cbc:Postbox) or cbc:Postbox = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or cbc:StreetName = '') and (not(cbc:Postbox) or cbc:Postbox = ''))</Pattern>
<Description>[F-LIB034] There should be either a StreetName or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or cbc:BuildingNumber = '') and (not(cbc:Postbox) or cbc:Postbox = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or cbc:BuildingNumber = '') and (not(cbc:Postbox) or cbc:Postbox = ''))</Pattern>
<Description>[F-LIB035] There should be either a BuildingNumber or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine</Pattern>
<Description>[F-LIB036] AddressLine elements not allowed for a StructuredLax address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')</Pattern>
<Description>[F-LIB037] ID is required for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB038] Only the ID is used for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))</Pattern>
<Description>[F-LIB039] Region or District or Country/IdentificationCode is required for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')</Pattern>
<Description>[F-LIB040] Only Region, District, and/or Country/IdentificationCode can be used for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)</Pattern>
<Description>[F-LIB028] When ID is used under Address the attribute schemeID is used to give an addressregister</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(cbc:ID/@schemeID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(cbc:ID/@schemeID)</Pattern>
<Description>[F-LIB029] schemeID attribute must be present on an address ID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:Postbox and not(number(cbc:Postbox)=((cbc:Postbox + 1)-1))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:Postbox and not(number(cbc:Postbox)=((cbc:Postbox + 1)-1))</Pattern>
<Description>[F-LIB030] The value of Postbox must always be a number</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M14" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:Signature/cac:SignatoryParty/cac:PhysicalLocation" priority="3994" mode="M14">

		<!--REPORT -->
<xsl:if test="(not(cbc:ID) or cbc:ID = '') and (count(cac:Address) = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:ID) or cbc:ID = '') and (count(cac:Address) = 0)</Pattern>
<Description>[F-LIB221] If ID not specified, Address is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M14" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:Signature/cac:SignatoryParty/cac:PhysicalLocation/cac:ValidityPeriod" priority="3993" mode="M14">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DurationMeasure) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DurationMeasure) = 0</Pattern>
<Description>[F-LIB076] DurationMeasure element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DescriptionCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DescriptionCode) = 0</Pattern>
<Description>[F-LIB077] DescriptionCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')</Pattern>
<Description>[F-LIB078] There must be a StartDate if you have a StartTime</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')</Pattern>
<Description>[F-LIB079] There must be a EndDate if you have a EndTime</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))</Pattern>
<Description>[F-LIB080] The EndDate must be greater or equal to the startdate</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))</Pattern>
<Description>[F-LIB081] EndTime must be greater or equal to StartTime</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M14" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:Signature/cac:SignatoryParty/cac:PhysicalLocation/cac:ValidityPeriod/cbc:Description" priority="3992" mode="M14">

		<!--REPORT -->
<xsl:if test="count(../cbc:Description) &gt; 1 and not(./@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cbc:Description) &gt; 1 and not(./@languageID)</Pattern>
<Description>[W-LIB222] The attribute languageID should be used when more than one Description element is present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID</Pattern>
<Description>[W-LIB223] Multilanguage error. Replicated Description elements with same languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M14" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:Signature/cac:SignatoryParty/cac:PhysicalLocation/cac:Address" priority="3991" mode="M14">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:BlockName) = 0</Pattern>
<Description>[F-LIB210] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB211] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB212] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode != ''</Pattern>
<Description>[F-LIB025] Invalid AddressFormatCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')</Pattern>
<Description>[F-LIB204] Invalid listID. Must be 'urn:oioubl:codelist:addresstypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB205] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )</Pattern>
<Description>[F-LIB206] Invalid AddressTypeCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'</Pattern>
<Description>[F-LIB026] Invalid listID. Must be either 'urn:oioubl:codelist:addressformatcode-1.1' or 'UN/ECE 3477'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB207] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode = 'StructuredDK' or cbc:AddressFormatCode = 'StructuredLax' or cbc:AddressFormatCode = 'StructuredID' or cbc:AddressFormatCode = 'StructuredRegion' or cbc:AddressFormatCode = 'Unstructured')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode = 'StructuredDK' or cbc:AddressFormatCode = 'StructuredLax' or cbc:AddressFormatCode = 'StructuredID' or cbc:AddressFormatCode = 'StructuredRegion' or cbc:AddressFormatCode = 'Unstructured')</Pattern>
<Description>[F-LIB027] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')</Pattern>
<Description>[F-LIB208] Invalid listAgencyID. Must be '6'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')</Pattern>
<Description>[F-LIB209] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Country and not(cac:Country/cbc:IdentificationCode != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Country and not(cac:Country/cbc:IdentificationCode != '')</Pattern>
<Description>[F-LIB213] When Country is used the element Country/IdentificationCode must be filled out</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB031] An Unstructured address is only allowed to have AddressLine elements</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine</Pattern>
<Description>[F-LIB032] AddressLine elements not allowed for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or cbc:PostalZone = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or cbc:PostalZone = '')</Pattern>
<Description>[F-LIB033] PostalZone is mandatory for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or cbc:StreetName = '') and (not(cbc:Postbox) or cbc:Postbox = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or cbc:StreetName = '') and (not(cbc:Postbox) or cbc:Postbox = ''))</Pattern>
<Description>[F-LIB034] There should be either a StreetName or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or cbc:BuildingNumber = '') and (not(cbc:Postbox) or cbc:Postbox = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or cbc:BuildingNumber = '') and (not(cbc:Postbox) or cbc:Postbox = ''))</Pattern>
<Description>[F-LIB035] There should be either a BuildingNumber or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine</Pattern>
<Description>[F-LIB036] AddressLine elements not allowed for a StructuredLax address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')</Pattern>
<Description>[F-LIB037] ID is required for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB038] Only the ID is used for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))</Pattern>
<Description>[F-LIB039] Region or District or Country/IdentificationCode is required for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')</Pattern>
<Description>[F-LIB040] Only Region, District, and/or Country/IdentificationCode can be used for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)</Pattern>
<Description>[F-LIB028] When ID is used under Address the attribute schemeID is used to give an addressregister</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(cbc:ID/@schemeID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(cbc:ID/@schemeID)</Pattern>
<Description>[F-LIB029] schemeID attribute must be present on an address ID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:Postbox and not(number(cbc:Postbox)=((cbc:Postbox + 1)-1))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:Postbox and not(number(cbc:Postbox)=((cbc:Postbox + 1)-1))</Pattern>
<Description>[F-LIB030] The value of Postbox must always be a number</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M14" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:Signature/cac:SignatoryParty/cac:PartyTaxScheme" priority="3990" mode="M14">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TaxLevelCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TaxLevelCode) = 0</Pattern>
<Description>[F-LIB192] TaxLevelCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID != ''</Pattern>
<Description>[F-LIB193] Invalid CompanyID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID/@schemeID = 'DK:SE' or cbc:CompanyID/@schemeID = 'ZZZ' " />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID/@schemeID = 'DK:SE' or cbc:CompanyID/@schemeID = 'ZZZ'</Pattern>
<Description>[F-LIB195] Invalid schemeID. Must be a valid scheme for PartyTaxScheme/CompanyID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:SE') and (string-length(cbc:CompanyID) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:SE') and (string-length(cbc:CompanyID) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB196] schemeID = DK:SE, CompanyID must be a valid SE number (DK12345678)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M14" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:Signature/cac:SignatoryParty/cac:PartyTaxScheme/cac:TaxScheme" priority="3989" mode="M14">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:ID) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:ID) = 0</Pattern>
<Description>[F-LIB041] ID element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:AddressTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:AddressTypeCode) = 0</Pattern>
<Description>[F-LIB042] AddressTypeCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Postbox) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Postbox) = 0</Pattern>
<Description>[F-LIB043] Postbox element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Floor) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Floor) = 0</Pattern>
<Description>[F-LIB044] Floor element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Room) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Room) = 0</Pattern>
<Description>[F-LIB045] Room element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:StreetName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:StreetName) = 0</Pattern>
<Description>[F-LIB046] StreetName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:AdditionalStreetName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:AdditionalStreetName) = 0</Pattern>
<Description>[F-LIB047] AdditionalStreetName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BlockName) = 0</Pattern>
<Description>[F-LIB048] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BuildingName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BuildingName) = 0</Pattern>
<Description>[F-LIB049] BuildingName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BuildingNumber) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BuildingNumber) = 0</Pattern>
<Description>[F-LIB050] BuildingNumber element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:InhouseMail) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:InhouseMail) = 0</Pattern>
<Description>[F-LIB051] InhouseMail element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Department) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Department) = 0</Pattern>
<Description>[F-LIB052] Department element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:MarkAttention) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:MarkAttention) = 0</Pattern>
<Description>[F-LIB053] MarkAttention element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:MarkCare) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:MarkCare) = 0</Pattern>
<Description>[F-LIB054] MarkCare element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:PlotIdentification) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:PlotIdentification) = 0</Pattern>
<Description>[F-LIB055] PlotIdentification element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CitySubdivisionName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CitySubdivisionName) = 0</Pattern>
<Description>[F-LIB056] CitySubdivisionName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CityName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CityName) = 0</Pattern>
<Description>[F-LIB057] CityName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:PostalZone) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:PostalZone) = 0</Pattern>
<Description>[F-LIB058] PostalZone element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CountrySubentity) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CountrySubentity) = 0</Pattern>
<Description>[F-LIB059] CountrySubentity element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CountrySubentityCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CountrySubentityCode) = 0</Pattern>
<Description>[F-LIB060] CountrySubentityCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB063] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cac:AddressLine) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cac:AddressLine) = 0</Pattern>
<Description>[F-LIB234] AddressLine class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB064] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:ID = '63') and cbc:TaxTypeCode">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID = '63') and cbc:TaxTypeCode</Pattern>
<Description>[F-LIB067] TaxTypeCode is not allowed when TaxScheme/ID equals '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID != ''</Pattern>
<Description>[F-LIB065] Invalid ID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:Name != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:Name != ''</Pattern>
<Description>[F-LIB066] Invalid Name. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:ID != '63') and not(cbc:TaxTypeCode)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID != '63') and not(cbc:TaxTypeCode)</Pattern>
<Description>[F-LIB197] TaxTypeCode is mandatory when TaxScheme/ID is different from '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeID = $TaxScheme_schemeID or cbc:ID/@schemeID = $TaxScheme2_schemeID" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeID = $TaxScheme_schemeID or cbc:ID/@schemeID = $TaxScheme2_schemeID</Pattern>
<Description>[F-LIB070] Invalid schemeID. Must be '<xsl:text />
<xsl:value-of select="$TaxScheme_schemeID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$TaxScheme2_schemeID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:TaxTypeCode) and not(cbc:TaxTypeCode/@listID = 'urn:oioubl:codelist:taxtypecode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:TaxTypeCode) and not(cbc:TaxTypeCode/@listID = 'urn:oioubl:codelist:taxtypecode-1.1')</Pattern>
<Description>[F-LIB071] Invalid listID. Must be 'urn:oioubl:codelist:taxtypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID = '63') and cbc:Name != 'Moms'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID = '63') and cbc:Name != 'Moms'</Pattern>
<Description>[F-LIB198] Name must equal 'Moms' when  TaxScheme/ID equals '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID != '63') and cbc:Name = 'Moms'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID != '63') and cbc:Name = 'Moms'</Pattern>
<Description>[F-LIB199] Name must correspond to the value of TaxScheme/ID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cac:JurisdictionRegionAddress) and cac:JurisdictionRegionAddress/cbc:AddressFormatCode != 'StructuredRegion'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cac:JurisdictionRegionAddress) and cac:JurisdictionRegionAddress/cbc:AddressFormatCode != 'StructuredRegion'</Pattern>
<Description>[F-LIB233] The AddressFormatCode under JurisdictionRegionAddress must always equal 'StructuredRegion'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M14" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:Signature/cac:SignatoryParty/cac:PartyLegalEntity" priority="3988" mode="M14">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:CorporateRegistrationScheme) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:CorporateRegistrationScheme) = 0</Pattern>
<Description>[F-LIB186] CorporateRegistrationScheme class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID != ''</Pattern>
<Description>[F-LIB187] Invalid CompanyID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID/@schemeID = 'DK:CVR' or cbc:CompanyID/@schemeID = 'DK:CPR' or cbc:CompanyID/@schemeID = 'ZZZ'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID/@schemeID = 'DK:CVR' or cbc:CompanyID/@schemeID = 'DK:CPR' or cbc:CompanyID/@schemeID = 'ZZZ'</Pattern>
<Description>[F-LIB189] Invalid schemeID. Must be a valid scheme for PartyLegalEntity/CompanyID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:CVR') and (string-length(cbc:CompanyID) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:CVR') and (string-length(cbc:CompanyID) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB190] schemeID = DK:CVR, CompanyID must be a valid CVR number (DK12345678)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:CPR') and not(string-length(cbc:CompanyID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:CPR') and not(string-length(cbc:CompanyID) = 10)</Pattern>
<Description>[F-LIB191] schemeID = DK:CPR, CompanyID must be a valid CPR number (1234560000)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M14" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:Signature/cac:SignatoryParty/cac:Contact" priority="3987" mode="M14">

		<!--REPORT -->
<xsl:if test="(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)</Pattern>
<Description>[F-LIB235] At least one field should be specified</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel</Pattern>
<Description>[F-LIB236] Use either ChannelCode or Channel</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication and not(cac:OtherCommunication/cbc:Value != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication and not(cac:OtherCommunication/cbc:Value != '')</Pattern>
<Description>[F-LIB237] Invalid Value. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M14" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:Signature/cac:SignatoryParty/cac:Person" priority="3986" mode="M14">

		<!--REPORT -->
<xsl:if test="(not(cbc:FamilyName) or cbc:FamilyName = '') and (not(cbc:FirstName) or cbc:FirstName = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:FamilyName) or cbc:FamilyName = '') and (not(cbc:FirstName) or cbc:FirstName = '')</Pattern>
<Description>[F-LIB024] There must be a FirstName if the FamilyName is not present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M14" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:Signature/cac:DigitalSignatureAttachment" priority="3985" mode="M14">

		<!--REPORT -->
<xsl:if test="cbc:EmbeddedDocumentBinaryObject and cac:ExternalReference">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:EmbeddedDocumentBinaryObject and cac:ExternalReference</Pattern>
<Description>[F-LIB284] Use either EmbeddedDocumentBinaryObject or ExternalReference</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:EmbeddedDocumentBinaryObject and not(cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:EmbeddedDocumentBinaryObject and not(cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')</Pattern>
<Description>[F-LIB285] Attribute mimeCode must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:ExternalReference and not(cac:ExternalReference/cbc:URI != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:ExternalReference and not(cac:ExternalReference/cbc:URI != '')</Pattern>
<Description>[F-LIB286] When using ExternalReference, URI is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M14" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:Signature/cac:OriginalDocumentReference" priority="3984" mode="M14">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:DocumentType or cbc:DocumentTypeCode" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:DocumentType or cbc:DocumentTypeCode</Pattern>
<Description>[F-LIB092] Use either DocumentType or DocumentTypeCode</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cac:Attachment and cbc:XPath">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment and cbc:XPath</Pattern>
<Description>[F-LIB093] Use either Attachment or XPath</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:DocumentType and cbc:DocumentTypeCode != 'ZZZ'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:DocumentType and cbc:DocumentTypeCode != 'ZZZ'</Pattern>
<Description>[F-LIB094] Use either DocumentType or DocumentTypeCode</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference</Pattern>
<Description>[F-LIB095] Use either EmbeddedDocumentBinaryObject or ExternalReference</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:UUID and not(string-length(string(cbc:UUID)) = 36)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:UUID and not(string-length(string(cbc:UUID)) = 36)</Pattern>
<Description>[F-LIB097] Invalid UUID. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')</Pattern>
<Description>[F-LIB098] Attribute mimeCode must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')</Pattern>
<Description>[F-LIB279] When using ExternalReference, URI is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M14" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M14" />
<xsl:template match="@*|node()" priority="-2" mode="M14">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M14" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M14" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN senderparty-->


	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:SenderParty" priority="3999" mode="M15">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:MarkCareIndicator) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:MarkCareIndicator) = 0</Pattern>
<Description>[F-LIB166] MarkCareIndicator element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:MarkAttentionIndicator) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:MarkAttentionIndicator) = 0</Pattern>
<Description>[F-LIB167] MarkAttentionIndicator element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:AgentParty) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:AgentParty) = 0</Pattern>
<Description>[F-LIB168] AgentParty class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:EndpointID != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:EndpointID != ''</Pattern>
<Description>[F-APR008] Invalid EndpointID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(not(cac:PartyIdentification) or cac:PartyIdentification/cbc:ID = '') and (not(cac:PartyName) or cac:PartyName/cbc:Name = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cac:PartyIdentification) or cac:PartyIdentification/cbc:ID = '') and (not(cac:PartyName) or cac:PartyName/cbc:Name = '')</Pattern>
<Description>[F-LIB022] PartyName/Name is mandatory if PartyIdentification/ID is not found</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:EndpointID and not(cbc:EndpointID/@schemeID = 'GLN' or cbc:EndpointID/@schemeID = 'DUNS' or cbc:EndpointID/@schemeID = 'DK:P' or cbc:EndpointID/@schemeID = 'DK:CVR' or cbc:EndpointID/@schemeID = 'DK:CPR' or cbc:EndpointID/@schemeID = 'DK:SE' or cbc:EndpointID/@schemeID = 'DK:VANS' or cbc:EndpointID/@schemeID = 'IBAN' or cbc:EndpointID/@schemeID = 'ISO 6523')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:EndpointID and not(cbc:EndpointID/@schemeID = 'GLN' or cbc:EndpointID/@schemeID = 'DUNS' or cbc:EndpointID/@schemeID = 'DK:P' or cbc:EndpointID/@schemeID = 'DK:CVR' or cbc:EndpointID/@schemeID = 'DK:CPR' or cbc:EndpointID/@schemeID = 'DK:SE' or cbc:EndpointID/@schemeID = 'DK:VANS' or cbc:EndpointID/@schemeID = 'IBAN' or cbc:EndpointID/@schemeID = 'ISO 6523')</Pattern>
<Description>[F-LIB179] Invalid schemeID. Must be a valid scheme for EndpointID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'DK:CVR') and (string-length(cbc:EndpointID) != 10 or substring(cbc:EndpointID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'DK:CVR') and (string-length(cbc:EndpointID) != 10 or substring(cbc:EndpointID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB180] schemeID = DK:CVR, EndpointID must be a valid CVR number (DK12345678)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'DK:CPR') and not(string-length(cbc:EndpointID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'DK:CPR') and not(string-length(cbc:EndpointID) = 10)</Pattern>
<Description>[F-LIB215] schemeID = DK:CPR, EndpointID must be a valid CPR number (1234560000)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'GLN') and not(string-length(cbc:EndpointID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'GLN') and not(string-length(cbc:EndpointID) = 13)</Pattern>
<Description>[F-LIB181] schemeID = GLN, EndpointID must be a valid GLN number (1234567890123)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'EAN') and not(string-length(cbc:EndpointID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'EAN') and not(string-length(cbc:EndpointID) = 13)</Pattern>
<Description>[F-LIB216] schemeID = EAN, EndpointID must be a valid EAN number (1234567890123)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:PartyLegalEntity) = 1" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:PartyLegalEntity) = 1</Pattern>
<Description>[F-APR040] One PartyLegalEntity class must be present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M15" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:SenderParty/cac:PartyIdentification" priority="3998" mode="M15">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeID = 'DUNS' or cbc:ID/@schemeID = 'GLN' or cbc:ID/@schemeID = 'IBAN' or cbc:ID/@schemeID = 'ISO 6523' or cbc:ID/@schemeID = 'ZZZ' or cbc:ID/@schemeID = 'DK:CPR' or cbc:ID/@schemeID = 'DK:CVR' or cbc:ID/@schemeID = 'DK:P' or cbc:ID/@schemeID = 'DK:SE' or cbc:ID/@schemeID = 'DK:TELEFON' or cbc:ID/@schemeID = 'FI:ORGNR' or cbc:ID/@schemeID = 'IS:KT' or cbc:ID/@schemeID = 'IS:VSKNR' or cbc:ID/@schemeID = 'NO:EFO' or cbc:ID/@schemeID = 'NO:NOBB' or cbc:ID/@schemeID = 'NO:NODI' or cbc:ID/@schemeID = 'NO:ORGNR' or cbc:ID/@schemeID = 'NO:VAT' or cbc:ID/@schemeID = 'SE:ORGNR' or cbc:ID/@schemeID = 'SE:VAT'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeID = 'DUNS' or cbc:ID/@schemeID = 'GLN' or cbc:ID/@schemeID = 'IBAN' or cbc:ID/@schemeID = 'ISO 6523' or cbc:ID/@schemeID = 'ZZZ' or cbc:ID/@schemeID = 'DK:CPR' or cbc:ID/@schemeID = 'DK:CVR' or cbc:ID/@schemeID = 'DK:P' or cbc:ID/@schemeID = 'DK:SE' or cbc:ID/@schemeID = 'DK:TELEFON' or cbc:ID/@schemeID = 'FI:ORGNR' or cbc:ID/@schemeID = 'IS:KT' or cbc:ID/@schemeID = 'IS:VSKNR' or cbc:ID/@schemeID = 'NO:EFO' or cbc:ID/@schemeID = 'NO:NOBB' or cbc:ID/@schemeID = 'NO:NODI' or cbc:ID/@schemeID = 'NO:ORGNR' or cbc:ID/@schemeID = 'NO:VAT' or cbc:ID/@schemeID = 'SE:ORGNR' or cbc:ID/@schemeID = 'SE:VAT'</Pattern>
<Description>[F-LIB183] Invalid schemeID. Must be a valid scheme for PartyIdentification/ID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'DK:CVR') and (string-length(cbc:ID) != 10 or substring(cbc:ID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'DK:CVR') and (string-length(cbc:ID) != 10 or substring(cbc:ID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB184] schemeID = DK:CVR, ID must be a valid CVR number (DK12345678)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'DK:CPR') and not(string-length(cbc:ID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'DK:CPR') and not(string-length(cbc:ID) = 10)</Pattern>
<Description>[F-LIB217] schemeID = DK:CPR, ID must be a valid CPR number (1234560000)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'GLN') and not(string-length(cbc:ID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'GLN') and not(string-length(cbc:ID) = 13)</Pattern>
<Description>[F-LIB185] schemeID = GLN, ID must be a valid GLN number (1234567890123)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'EAN') and not(string-length(cbc:ID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'EAN') and not(string-length(cbc:ID) = 13)</Pattern>
<Description>[F-LIB218] schemeID = EAN, ID must be a valid EAN number (1234567890123)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'DK:P') and not(string-length(cbc:ID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'DK:P') and not(string-length(cbc:ID) = 10)</Pattern>
<Description>[F-LIB287] schemeID = DK:P, ID must be a valid P number (1234567890)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M15" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:SenderParty/cac:PartyName" priority="3997" mode="M15">

		<!--REPORT -->
<xsl:if test="count(../cac:PartyName) &gt; 1 and not(./cbc:Name/@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cac:PartyName) &gt; 1 and not(./cbc:Name/@languageID)</Pattern>
<Description>[W-LIB219] The attribute Name@languageID should be used when more than one PartyName class is present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/cbc:Name/@languageID = self::*/cbc:Name/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/cbc:Name/@languageID = self::*/cbc:Name/@languageID</Pattern>
<Description>[W-LIB220] Multilanguage error. Replicated PartyName classes with same Name@languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M15" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:SenderParty/cac:PostalAddress" priority="3996" mode="M15">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:BlockName) = 0</Pattern>
<Description>[F-LIB210] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB211] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB212] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode != ''</Pattern>
<Description>[F-LIB025] Invalid AddressFormatCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')</Pattern>
<Description>[F-LIB204] Invalid listID. Must be 'urn:oioubl:codelist:addresstypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB205] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )</Pattern>
<Description>[F-LIB206] Invalid AddressTypeCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'</Pattern>
<Description>[F-LIB026] Invalid listID. Must be either 'urn:oioubl:codelist:addressformatcode-1.1' or 'UN/ECE 3477'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB207] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode = 'StructuredDK' or cbc:AddressFormatCode = 'StructuredLax' or cbc:AddressFormatCode = 'StructuredID' or cbc:AddressFormatCode = 'StructuredRegion' or cbc:AddressFormatCode = 'Unstructured')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode = 'StructuredDK' or cbc:AddressFormatCode = 'StructuredLax' or cbc:AddressFormatCode = 'StructuredID' or cbc:AddressFormatCode = 'StructuredRegion' or cbc:AddressFormatCode = 'Unstructured')</Pattern>
<Description>[F-LIB027] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')</Pattern>
<Description>[F-LIB208] Invalid listAgencyID. Must be '6'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')</Pattern>
<Description>[F-LIB209] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Country and not(cac:Country/cbc:IdentificationCode != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Country and not(cac:Country/cbc:IdentificationCode != '')</Pattern>
<Description>[F-LIB213] When Country is used the element Country/IdentificationCode must be filled out</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB031] An Unstructured address is only allowed to have AddressLine elements</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine</Pattern>
<Description>[F-LIB032] AddressLine elements not allowed for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or cbc:PostalZone = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or cbc:PostalZone = '')</Pattern>
<Description>[F-LIB033] PostalZone is mandatory for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or cbc:StreetName = '') and (not(cbc:Postbox) or cbc:Postbox = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or cbc:StreetName = '') and (not(cbc:Postbox) or cbc:Postbox = ''))</Pattern>
<Description>[F-LIB034] There should be either a StreetName or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or cbc:BuildingNumber = '') and (not(cbc:Postbox) or cbc:Postbox = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or cbc:BuildingNumber = '') and (not(cbc:Postbox) or cbc:Postbox = ''))</Pattern>
<Description>[F-LIB035] There should be either a BuildingNumber or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine</Pattern>
<Description>[F-LIB036] AddressLine elements not allowed for a StructuredLax address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')</Pattern>
<Description>[F-LIB037] ID is required for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB038] Only the ID is used for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))</Pattern>
<Description>[F-LIB039] Region or District or Country/IdentificationCode is required for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')</Pattern>
<Description>[F-LIB040] Only Region, District, and/or Country/IdentificationCode can be used for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)</Pattern>
<Description>[F-LIB028] When ID is used under Address the attribute schemeID is used to give an addressregister</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(cbc:ID/@schemeID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(cbc:ID/@schemeID)</Pattern>
<Description>[F-LIB029] schemeID attribute must be present on an address ID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:Postbox and not(number(cbc:Postbox)=((cbc:Postbox + 1)-1))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:Postbox and not(number(cbc:Postbox)=((cbc:Postbox + 1)-1))</Pattern>
<Description>[F-LIB030] The value of Postbox must always be a number</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M15" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:SenderParty/cac:PhysicalLocation" priority="3995" mode="M15">

		<!--REPORT -->
<xsl:if test="(not(cbc:ID) or cbc:ID = '') and (count(cac:Address) = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:ID) or cbc:ID = '') and (count(cac:Address) = 0)</Pattern>
<Description>[F-LIB221] If ID not specified, Address is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M15" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:SenderParty/cac:PhysicalLocation/cac:ValidityPeriod" priority="3994" mode="M15">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DurationMeasure) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DurationMeasure) = 0</Pattern>
<Description>[F-LIB076] DurationMeasure element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DescriptionCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DescriptionCode) = 0</Pattern>
<Description>[F-LIB077] DescriptionCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')</Pattern>
<Description>[F-LIB078] There must be a StartDate if you have a StartTime</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')</Pattern>
<Description>[F-LIB079] There must be a EndDate if you have a EndTime</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))</Pattern>
<Description>[F-LIB080] The EndDate must be greater or equal to the startdate</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))</Pattern>
<Description>[F-LIB081] EndTime must be greater or equal to StartTime</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M15" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:SenderParty/cac:PhysicalLocation/cac:ValidityPeriod/cbc:Description" priority="3993" mode="M15">

		<!--REPORT -->
<xsl:if test="count(../cbc:Description) &gt; 1 and not(./@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cbc:Description) &gt; 1 and not(./@languageID)</Pattern>
<Description>[W-LIB222] The attribute languageID should be used when more than one Description element is present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID</Pattern>
<Description>[W-LIB223] Multilanguage error. Replicated Description elements with same languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M15" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:SenderParty/cac:PhysicalLocation/cac:Address" priority="3992" mode="M15">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:BlockName) = 0</Pattern>
<Description>[F-LIB210] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB211] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB212] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode != ''</Pattern>
<Description>[F-LIB025] Invalid AddressFormatCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')</Pattern>
<Description>[F-LIB204] Invalid listID. Must be 'urn:oioubl:codelist:addresstypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB205] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )</Pattern>
<Description>[F-LIB206] Invalid AddressTypeCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'</Pattern>
<Description>[F-LIB026] Invalid listID. Must be either 'urn:oioubl:codelist:addressformatcode-1.1' or 'UN/ECE 3477'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB207] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode = 'StructuredDK' or cbc:AddressFormatCode = 'StructuredLax' or cbc:AddressFormatCode = 'StructuredID' or cbc:AddressFormatCode = 'StructuredRegion' or cbc:AddressFormatCode = 'Unstructured')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode = 'StructuredDK' or cbc:AddressFormatCode = 'StructuredLax' or cbc:AddressFormatCode = 'StructuredID' or cbc:AddressFormatCode = 'StructuredRegion' or cbc:AddressFormatCode = 'Unstructured')</Pattern>
<Description>[F-LIB027] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')</Pattern>
<Description>[F-LIB208] Invalid listAgencyID. Must be '6'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')</Pattern>
<Description>[F-LIB209] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Country and not(cac:Country/cbc:IdentificationCode != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Country and not(cac:Country/cbc:IdentificationCode != '')</Pattern>
<Description>[F-LIB213] When Country is used the element Country/IdentificationCode must be filled out</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB031] An Unstructured address is only allowed to have AddressLine elements</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine</Pattern>
<Description>[F-LIB032] AddressLine elements not allowed for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or cbc:PostalZone = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or cbc:PostalZone = '')</Pattern>
<Description>[F-LIB033] PostalZone is mandatory for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or cbc:StreetName = '') and (not(cbc:Postbox) or cbc:Postbox = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or cbc:StreetName = '') and (not(cbc:Postbox) or cbc:Postbox = ''))</Pattern>
<Description>[F-LIB034] There should be either a StreetName or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or cbc:BuildingNumber = '') and (not(cbc:Postbox) or cbc:Postbox = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or cbc:BuildingNumber = '') and (not(cbc:Postbox) or cbc:Postbox = ''))</Pattern>
<Description>[F-LIB035] There should be either a BuildingNumber or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine</Pattern>
<Description>[F-LIB036] AddressLine elements not allowed for a StructuredLax address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')</Pattern>
<Description>[F-LIB037] ID is required for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB038] Only the ID is used for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))</Pattern>
<Description>[F-LIB039] Region or District or Country/IdentificationCode is required for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')</Pattern>
<Description>[F-LIB040] Only Region, District, and/or Country/IdentificationCode can be used for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)</Pattern>
<Description>[F-LIB028] When ID is used under Address the attribute schemeID is used to give an addressregister</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(cbc:ID/@schemeID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(cbc:ID/@schemeID)</Pattern>
<Description>[F-LIB029] schemeID attribute must be present on an address ID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:Postbox and not(number(cbc:Postbox)=((cbc:Postbox + 1)-1))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:Postbox and not(number(cbc:Postbox)=((cbc:Postbox + 1)-1))</Pattern>
<Description>[F-LIB030] The value of Postbox must always be a number</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M15" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:SenderParty/cac:PartyTaxScheme" priority="3991" mode="M15">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TaxLevelCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TaxLevelCode) = 0</Pattern>
<Description>[F-LIB192] TaxLevelCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID != ''</Pattern>
<Description>[F-LIB193] Invalid CompanyID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID/@schemeID = 'DK:SE' or cbc:CompanyID/@schemeID = 'ZZZ' " />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID/@schemeID = 'DK:SE' or cbc:CompanyID/@schemeID = 'ZZZ'</Pattern>
<Description>[F-LIB195] Invalid schemeID. Must be a valid scheme for PartyTaxScheme/CompanyID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:SE') and (string-length(cbc:CompanyID) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:SE') and (string-length(cbc:CompanyID) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB196] schemeID = DK:SE, CompanyID must be a valid SE number (DK12345678)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M15" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:SenderParty/cac:PartyTaxScheme/cac:TaxScheme" priority="3990" mode="M15">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:ID) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:ID) = 0</Pattern>
<Description>[F-LIB041] ID element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:AddressTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:AddressTypeCode) = 0</Pattern>
<Description>[F-LIB042] AddressTypeCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Postbox) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Postbox) = 0</Pattern>
<Description>[F-LIB043] Postbox element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Floor) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Floor) = 0</Pattern>
<Description>[F-LIB044] Floor element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Room) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Room) = 0</Pattern>
<Description>[F-LIB045] Room element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:StreetName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:StreetName) = 0</Pattern>
<Description>[F-LIB046] StreetName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:AdditionalStreetName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:AdditionalStreetName) = 0</Pattern>
<Description>[F-LIB047] AdditionalStreetName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BlockName) = 0</Pattern>
<Description>[F-LIB048] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BuildingName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BuildingName) = 0</Pattern>
<Description>[F-LIB049] BuildingName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BuildingNumber) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BuildingNumber) = 0</Pattern>
<Description>[F-LIB050] BuildingNumber element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:InhouseMail) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:InhouseMail) = 0</Pattern>
<Description>[F-LIB051] InhouseMail element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Department) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Department) = 0</Pattern>
<Description>[F-LIB052] Department element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:MarkAttention) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:MarkAttention) = 0</Pattern>
<Description>[F-LIB053] MarkAttention element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:MarkCare) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:MarkCare) = 0</Pattern>
<Description>[F-LIB054] MarkCare element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:PlotIdentification) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:PlotIdentification) = 0</Pattern>
<Description>[F-LIB055] PlotIdentification element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CitySubdivisionName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CitySubdivisionName) = 0</Pattern>
<Description>[F-LIB056] CitySubdivisionName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CityName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CityName) = 0</Pattern>
<Description>[F-LIB057] CityName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:PostalZone) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:PostalZone) = 0</Pattern>
<Description>[F-LIB058] PostalZone element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CountrySubentity) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CountrySubentity) = 0</Pattern>
<Description>[F-LIB059] CountrySubentity element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CountrySubentityCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CountrySubentityCode) = 0</Pattern>
<Description>[F-LIB060] CountrySubentityCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB063] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cac:AddressLine) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cac:AddressLine) = 0</Pattern>
<Description>[F-LIB234] AddressLine class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB064] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:ID = '63') and cbc:TaxTypeCode">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID = '63') and cbc:TaxTypeCode</Pattern>
<Description>[F-LIB067] TaxTypeCode is not allowed when TaxScheme/ID equals '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID != ''</Pattern>
<Description>[F-LIB065] Invalid ID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:Name != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:Name != ''</Pattern>
<Description>[F-LIB066] Invalid Name. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:ID != '63') and not(cbc:TaxTypeCode)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID != '63') and not(cbc:TaxTypeCode)</Pattern>
<Description>[F-LIB197] TaxTypeCode is mandatory when TaxScheme/ID is different from '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeID = $TaxScheme_schemeID or cbc:ID/@schemeID = $TaxScheme2_schemeID" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeID = $TaxScheme_schemeID or cbc:ID/@schemeID = $TaxScheme2_schemeID</Pattern>
<Description>[F-LIB070] Invalid schemeID. Must be '<xsl:text />
<xsl:value-of select="$TaxScheme_schemeID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$TaxScheme2_schemeID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:TaxTypeCode) and not(cbc:TaxTypeCode/@listID = 'urn:oioubl:codelist:taxtypecode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:TaxTypeCode) and not(cbc:TaxTypeCode/@listID = 'urn:oioubl:codelist:taxtypecode-1.1')</Pattern>
<Description>[F-LIB071] Invalid listID. Must be 'urn:oioubl:codelist:taxtypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID = '63') and cbc:Name != 'Moms'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID = '63') and cbc:Name != 'Moms'</Pattern>
<Description>[F-LIB198] Name must equal 'Moms' when  TaxScheme/ID equals '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID != '63') and cbc:Name = 'Moms'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID != '63') and cbc:Name = 'Moms'</Pattern>
<Description>[F-LIB199] Name must correspond to the value of TaxScheme/ID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cac:JurisdictionRegionAddress) and cac:JurisdictionRegionAddress/cbc:AddressFormatCode != 'StructuredRegion'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cac:JurisdictionRegionAddress) and cac:JurisdictionRegionAddress/cbc:AddressFormatCode != 'StructuredRegion'</Pattern>
<Description>[F-LIB233] The AddressFormatCode under JurisdictionRegionAddress must always equal 'StructuredRegion'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M15" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:SenderParty/cac:PartyLegalEntity" priority="3989" mode="M15">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:CorporateRegistrationScheme) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:CorporateRegistrationScheme) = 0</Pattern>
<Description>[F-LIB186] CorporateRegistrationScheme class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID != ''</Pattern>
<Description>[F-LIB187] Invalid CompanyID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID/@schemeID = 'DK:CVR' or cbc:CompanyID/@schemeID = 'DK:CPR' or cbc:CompanyID/@schemeID = 'ZZZ'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID/@schemeID = 'DK:CVR' or cbc:CompanyID/@schemeID = 'DK:CPR' or cbc:CompanyID/@schemeID = 'ZZZ'</Pattern>
<Description>[F-LIB189] Invalid schemeID. Must be a valid scheme for PartyLegalEntity/CompanyID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:CVR') and (string-length(cbc:CompanyID) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:CVR') and (string-length(cbc:CompanyID) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB190] schemeID = DK:CVR, CompanyID must be a valid CVR number (DK12345678)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:CPR') and not(string-length(cbc:CompanyID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:CPR') and not(string-length(cbc:CompanyID) = 10)</Pattern>
<Description>[F-LIB191] schemeID = DK:CPR, CompanyID must be a valid CPR number (1234560000)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M15" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:SenderParty/cac:Contact" priority="3988" mode="M15">

		<!--REPORT -->
<xsl:if test="(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)</Pattern>
<Description>[F-LIB235] At least one field should be specified</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel</Pattern>
<Description>[F-LIB236] Use either ChannelCode or Channel</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication and not(cac:OtherCommunication/cbc:Value != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication and not(cac:OtherCommunication/cbc:Value != '')</Pattern>
<Description>[F-LIB237] Invalid Value. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M15" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:SenderParty/cac:Person" priority="3987" mode="M15">

		<!--REPORT -->
<xsl:if test="(not(cbc:FamilyName) or cbc:FamilyName = '') and (not(cbc:FirstName) or cbc:FirstName = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:FamilyName) or cbc:FamilyName = '') and (not(cbc:FirstName) or cbc:FirstName = '')</Pattern>
<Description>[F-LIB024] There must be a FirstName if the FamilyName is not present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M15" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M15" />
<xsl:template match="@*|node()" priority="-2" mode="M15">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M15" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M15" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN receiverparty-->


	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:ReceiverParty" priority="3999" mode="M16">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:MarkCareIndicator) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:MarkCareIndicator) = 0</Pattern>
<Description>[F-LIB166] MarkCareIndicator element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:MarkAttentionIndicator) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:MarkAttentionIndicator) = 0</Pattern>
<Description>[F-LIB167] MarkAttentionIndicator element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:AgentParty) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:AgentParty) = 0</Pattern>
<Description>[F-LIB168] AgentParty class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:EndpointID != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:EndpointID != ''</Pattern>
<Description>[F-APR012] Invalid EndpointID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(not(cac:PartyIdentification) or cac:PartyIdentification/cbc:ID = '') and (not(cac:PartyName) or cac:PartyName/cbc:Name = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cac:PartyIdentification) or cac:PartyIdentification/cbc:ID = '') and (not(cac:PartyName) or cac:PartyName/cbc:Name = '')</Pattern>
<Description>[F-LIB022] PartyName/Name is mandatory if PartyIdentification/ID is not found</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:EndpointID and not(cbc:EndpointID/@schemeID = 'GLN' or cbc:EndpointID/@schemeID = 'DUNS' or cbc:EndpointID/@schemeID = 'DK:P' or cbc:EndpointID/@schemeID = 'DK:CVR' or cbc:EndpointID/@schemeID = 'DK:CPR' or cbc:EndpointID/@schemeID = 'DK:SE' or cbc:EndpointID/@schemeID = 'DK:VANS' or cbc:EndpointID/@schemeID = 'IBAN' or cbc:EndpointID/@schemeID = 'ISO 6523')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:EndpointID and not(cbc:EndpointID/@schemeID = 'GLN' or cbc:EndpointID/@schemeID = 'DUNS' or cbc:EndpointID/@schemeID = 'DK:P' or cbc:EndpointID/@schemeID = 'DK:CVR' or cbc:EndpointID/@schemeID = 'DK:CPR' or cbc:EndpointID/@schemeID = 'DK:SE' or cbc:EndpointID/@schemeID = 'DK:VANS' or cbc:EndpointID/@schemeID = 'IBAN' or cbc:EndpointID/@schemeID = 'ISO 6523')</Pattern>
<Description>[F-LIB179] Invalid schemeID. Must be a valid scheme for EndpointID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'DK:CVR') and (string-length(cbc:EndpointID) != 10 or substring(cbc:EndpointID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'DK:CVR') and (string-length(cbc:EndpointID) != 10 or substring(cbc:EndpointID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB180] schemeID = DK:CVR, EndpointID must be a valid CVR number (DK12345678)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'DK:CPR') and not(string-length(cbc:EndpointID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'DK:CPR') and not(string-length(cbc:EndpointID) = 10)</Pattern>
<Description>[F-LIB215] schemeID = DK:CPR, EndpointID must be a valid CPR number (1234560000)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'GLN') and not(string-length(cbc:EndpointID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'GLN') and not(string-length(cbc:EndpointID) = 13)</Pattern>
<Description>[F-LIB181] schemeID = GLN, EndpointID must be a valid GLN number (1234567890123)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'EAN') and not(string-length(cbc:EndpointID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'EAN') and not(string-length(cbc:EndpointID) = 13)</Pattern>
<Description>[F-LIB216] schemeID = EAN, EndpointID must be a valid EAN number (1234567890123)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(cac:PartyLegalEntity) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:PartyLegalEntity) &gt; 1</Pattern>
<Description>[F-APR041] No more than one PartyLegalEntity class may be present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M16" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:ReceiverParty/cac:PartyIdentification" priority="3998" mode="M16">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeID = 'DUNS' or cbc:ID/@schemeID = 'GLN' or cbc:ID/@schemeID = 'IBAN' or cbc:ID/@schemeID = 'ISO 6523' or cbc:ID/@schemeID = 'ZZZ' or cbc:ID/@schemeID = 'DK:CPR' or cbc:ID/@schemeID = 'DK:CVR' or cbc:ID/@schemeID = 'DK:P' or cbc:ID/@schemeID = 'DK:SE' or cbc:ID/@schemeID = 'DK:TELEFON' or cbc:ID/@schemeID = 'FI:ORGNR' or cbc:ID/@schemeID = 'IS:KT' or cbc:ID/@schemeID = 'IS:VSKNR' or cbc:ID/@schemeID = 'NO:EFO' or cbc:ID/@schemeID = 'NO:NOBB' or cbc:ID/@schemeID = 'NO:NODI' or cbc:ID/@schemeID = 'NO:ORGNR' or cbc:ID/@schemeID = 'NO:VAT' or cbc:ID/@schemeID = 'SE:ORGNR' or cbc:ID/@schemeID = 'SE:VAT'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeID = 'DUNS' or cbc:ID/@schemeID = 'GLN' or cbc:ID/@schemeID = 'IBAN' or cbc:ID/@schemeID = 'ISO 6523' or cbc:ID/@schemeID = 'ZZZ' or cbc:ID/@schemeID = 'DK:CPR' or cbc:ID/@schemeID = 'DK:CVR' or cbc:ID/@schemeID = 'DK:P' or cbc:ID/@schemeID = 'DK:SE' or cbc:ID/@schemeID = 'DK:TELEFON' or cbc:ID/@schemeID = 'FI:ORGNR' or cbc:ID/@schemeID = 'IS:KT' or cbc:ID/@schemeID = 'IS:VSKNR' or cbc:ID/@schemeID = 'NO:EFO' or cbc:ID/@schemeID = 'NO:NOBB' or cbc:ID/@schemeID = 'NO:NODI' or cbc:ID/@schemeID = 'NO:ORGNR' or cbc:ID/@schemeID = 'NO:VAT' or cbc:ID/@schemeID = 'SE:ORGNR' or cbc:ID/@schemeID = 'SE:VAT'</Pattern>
<Description>[F-LIB183] Invalid schemeID. Must be a valid scheme for PartyIdentification/ID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'DK:CVR') and (string-length(cbc:ID) != 10 or substring(cbc:ID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'DK:CVR') and (string-length(cbc:ID) != 10 or substring(cbc:ID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB184] schemeID = DK:CVR, ID must be a valid CVR number (DK12345678)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'DK:CPR') and not(string-length(cbc:ID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'DK:CPR') and not(string-length(cbc:ID) = 10)</Pattern>
<Description>[F-LIB217] schemeID = DK:CPR, ID must be a valid CPR number (1234560000)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'GLN') and not(string-length(cbc:ID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'GLN') and not(string-length(cbc:ID) = 13)</Pattern>
<Description>[F-LIB185] schemeID = GLN, ID must be a valid GLN number (1234567890123)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'EAN') and not(string-length(cbc:ID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'EAN') and not(string-length(cbc:ID) = 13)</Pattern>
<Description>[F-LIB218] schemeID = EAN, ID must be a valid EAN number (1234567890123)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'DK:P') and not(string-length(cbc:ID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'DK:P') and not(string-length(cbc:ID) = 10)</Pattern>
<Description>[F-LIB287] schemeID = DK:P, ID must be a valid P number (1234567890)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M16" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:ReceiverParty/cac:PartyName" priority="3997" mode="M16">

		<!--REPORT -->
<xsl:if test="count(../cac:PartyName) &gt; 1 and not(./cbc:Name/@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cac:PartyName) &gt; 1 and not(./cbc:Name/@languageID)</Pattern>
<Description>[W-LIB219] The attribute Name@languageID should be used when more than one PartyName class is present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/cbc:Name/@languageID = self::*/cbc:Name/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/cbc:Name/@languageID = self::*/cbc:Name/@languageID</Pattern>
<Description>[W-LIB220] Multilanguage error. Replicated PartyName classes with same Name@languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M16" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:ReceiverParty/cac:PostalAddress" priority="3996" mode="M16">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:BlockName) = 0</Pattern>
<Description>[F-LIB210] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB211] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB212] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode != ''</Pattern>
<Description>[F-LIB025] Invalid AddressFormatCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')</Pattern>
<Description>[F-LIB204] Invalid listID. Must be 'urn:oioubl:codelist:addresstypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB205] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )</Pattern>
<Description>[F-LIB206] Invalid AddressTypeCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'</Pattern>
<Description>[F-LIB026] Invalid listID. Must be either 'urn:oioubl:codelist:addressformatcode-1.1' or 'UN/ECE 3477'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB207] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode = 'StructuredDK' or cbc:AddressFormatCode = 'StructuredLax' or cbc:AddressFormatCode = 'StructuredID' or cbc:AddressFormatCode = 'StructuredRegion' or cbc:AddressFormatCode = 'Unstructured')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode = 'StructuredDK' or cbc:AddressFormatCode = 'StructuredLax' or cbc:AddressFormatCode = 'StructuredID' or cbc:AddressFormatCode = 'StructuredRegion' or cbc:AddressFormatCode = 'Unstructured')</Pattern>
<Description>[F-LIB027] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')</Pattern>
<Description>[F-LIB208] Invalid listAgencyID. Must be '6'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')</Pattern>
<Description>[F-LIB209] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Country and not(cac:Country/cbc:IdentificationCode != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Country and not(cac:Country/cbc:IdentificationCode != '')</Pattern>
<Description>[F-LIB213] When Country is used the element Country/IdentificationCode must be filled out</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB031] An Unstructured address is only allowed to have AddressLine elements</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine</Pattern>
<Description>[F-LIB032] AddressLine elements not allowed for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or cbc:PostalZone = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or cbc:PostalZone = '')</Pattern>
<Description>[F-LIB033] PostalZone is mandatory for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or cbc:StreetName = '') and (not(cbc:Postbox) or cbc:Postbox = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or cbc:StreetName = '') and (not(cbc:Postbox) or cbc:Postbox = ''))</Pattern>
<Description>[F-LIB034] There should be either a StreetName or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or cbc:BuildingNumber = '') and (not(cbc:Postbox) or cbc:Postbox = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or cbc:BuildingNumber = '') and (not(cbc:Postbox) or cbc:Postbox = ''))</Pattern>
<Description>[F-LIB035] There should be either a BuildingNumber or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine</Pattern>
<Description>[F-LIB036] AddressLine elements not allowed for a StructuredLax address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')</Pattern>
<Description>[F-LIB037] ID is required for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB038] Only the ID is used for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))</Pattern>
<Description>[F-LIB039] Region or District or Country/IdentificationCode is required for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')</Pattern>
<Description>[F-LIB040] Only Region, District, and/or Country/IdentificationCode can be used for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)</Pattern>
<Description>[F-LIB028] When ID is used under Address the attribute schemeID is used to give an addressregister</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(cbc:ID/@schemeID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(cbc:ID/@schemeID)</Pattern>
<Description>[F-LIB029] schemeID attribute must be present on an address ID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:Postbox and not(number(cbc:Postbox)=((cbc:Postbox + 1)-1))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:Postbox and not(number(cbc:Postbox)=((cbc:Postbox + 1)-1))</Pattern>
<Description>[F-LIB030] The value of Postbox must always be a number</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M16" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:ReceiverParty/cac:PhysicalLocation" priority="3995" mode="M16">

		<!--REPORT -->
<xsl:if test="(not(cbc:ID) or cbc:ID = '') and (count(cac:Address) = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:ID) or cbc:ID = '') and (count(cac:Address) = 0)</Pattern>
<Description>[F-LIB221] If ID not specified, Address is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M16" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:ReceiverParty/cac:PhysicalLocation/cac:ValidityPeriod" priority="3994" mode="M16">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DurationMeasure) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DurationMeasure) = 0</Pattern>
<Description>[F-LIB076] DurationMeasure element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DescriptionCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DescriptionCode) = 0</Pattern>
<Description>[F-LIB077] DescriptionCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')</Pattern>
<Description>[F-LIB078] There must be a StartDate if you have a StartTime</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')</Pattern>
<Description>[F-LIB079] There must be a EndDate if you have a EndTime</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))</Pattern>
<Description>[F-LIB080] The EndDate must be greater or equal to the startdate</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))</Pattern>
<Description>[F-LIB081] EndTime must be greater or equal to StartTime</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M16" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:ReceiverParty/cac:PhysicalLocation/cac:ValidityPeriod/cbc:Description" priority="3993" mode="M16">

		<!--REPORT -->
<xsl:if test="count(../cbc:Description) &gt; 1 and not(./@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cbc:Description) &gt; 1 and not(./@languageID)</Pattern>
<Description>[W-LIB222] The attribute languageID should be used when more than one Description element is present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID</Pattern>
<Description>[W-LIB223] Multilanguage error. Replicated Description elements with same languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M16" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:ReceiverParty/cac:PhysicalLocation/cac:Address" priority="3992" mode="M16">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:BlockName) = 0</Pattern>
<Description>[F-LIB210] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB211] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB212] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode != ''</Pattern>
<Description>[F-LIB025] Invalid AddressFormatCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')</Pattern>
<Description>[F-LIB204] Invalid listID. Must be 'urn:oioubl:codelist:addresstypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB205] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )</Pattern>
<Description>[F-LIB206] Invalid AddressTypeCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'</Pattern>
<Description>[F-LIB026] Invalid listID. Must be either 'urn:oioubl:codelist:addressformatcode-1.1' or 'UN/ECE 3477'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB207] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode = 'StructuredDK' or cbc:AddressFormatCode = 'StructuredLax' or cbc:AddressFormatCode = 'StructuredID' or cbc:AddressFormatCode = 'StructuredRegion' or cbc:AddressFormatCode = 'Unstructured')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode = 'StructuredDK' or cbc:AddressFormatCode = 'StructuredLax' or cbc:AddressFormatCode = 'StructuredID' or cbc:AddressFormatCode = 'StructuredRegion' or cbc:AddressFormatCode = 'Unstructured')</Pattern>
<Description>[F-LIB027] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')</Pattern>
<Description>[F-LIB208] Invalid listAgencyID. Must be '6'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')</Pattern>
<Description>[F-LIB209] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Country and not(cac:Country/cbc:IdentificationCode != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Country and not(cac:Country/cbc:IdentificationCode != '')</Pattern>
<Description>[F-LIB213] When Country is used the element Country/IdentificationCode must be filled out</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB031] An Unstructured address is only allowed to have AddressLine elements</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine</Pattern>
<Description>[F-LIB032] AddressLine elements not allowed for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or cbc:PostalZone = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or cbc:PostalZone = '')</Pattern>
<Description>[F-LIB033] PostalZone is mandatory for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or cbc:StreetName = '') and (not(cbc:Postbox) or cbc:Postbox = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or cbc:StreetName = '') and (not(cbc:Postbox) or cbc:Postbox = ''))</Pattern>
<Description>[F-LIB034] There should be either a StreetName or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or cbc:BuildingNumber = '') and (not(cbc:Postbox) or cbc:Postbox = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or cbc:BuildingNumber = '') and (not(cbc:Postbox) or cbc:Postbox = ''))</Pattern>
<Description>[F-LIB035] There should be either a BuildingNumber or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine</Pattern>
<Description>[F-LIB036] AddressLine elements not allowed for a StructuredLax address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')</Pattern>
<Description>[F-LIB037] ID is required for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB038] Only the ID is used for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))</Pattern>
<Description>[F-LIB039] Region or District or Country/IdentificationCode is required for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')</Pattern>
<Description>[F-LIB040] Only Region, District, and/or Country/IdentificationCode can be used for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)</Pattern>
<Description>[F-LIB028] When ID is used under Address the attribute schemeID is used to give an addressregister</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(cbc:ID/@schemeID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(cbc:ID/@schemeID)</Pattern>
<Description>[F-LIB029] schemeID attribute must be present on an address ID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:Postbox and not(number(cbc:Postbox)=((cbc:Postbox + 1)-1))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:Postbox and not(number(cbc:Postbox)=((cbc:Postbox + 1)-1))</Pattern>
<Description>[F-LIB030] The value of Postbox must always be a number</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M16" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:ReceiverParty/cac:PartyTaxScheme" priority="3991" mode="M16">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TaxLevelCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TaxLevelCode) = 0</Pattern>
<Description>[F-LIB192] TaxLevelCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID != ''</Pattern>
<Description>[F-LIB193] Invalid CompanyID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID/@schemeID = 'DK:SE' or cbc:CompanyID/@schemeID = 'ZZZ' " />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID/@schemeID = 'DK:SE' or cbc:CompanyID/@schemeID = 'ZZZ'</Pattern>
<Description>[F-LIB195] Invalid schemeID. Must be a valid scheme for PartyTaxScheme/CompanyID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:SE') and (string-length(cbc:CompanyID) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:SE') and (string-length(cbc:CompanyID) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB196] schemeID = DK:SE, CompanyID must be a valid SE number (DK12345678)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M16" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:ReceiverParty/cac:PartyTaxScheme/cac:TaxScheme" priority="3990" mode="M16">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:ID) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:ID) = 0</Pattern>
<Description>[F-LIB041] ID element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:AddressTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:AddressTypeCode) = 0</Pattern>
<Description>[F-LIB042] AddressTypeCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Postbox) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Postbox) = 0</Pattern>
<Description>[F-LIB043] Postbox element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Floor) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Floor) = 0</Pattern>
<Description>[F-LIB044] Floor element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Room) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Room) = 0</Pattern>
<Description>[F-LIB045] Room element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:StreetName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:StreetName) = 0</Pattern>
<Description>[F-LIB046] StreetName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:AdditionalStreetName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:AdditionalStreetName) = 0</Pattern>
<Description>[F-LIB047] AdditionalStreetName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BlockName) = 0</Pattern>
<Description>[F-LIB048] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BuildingName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BuildingName) = 0</Pattern>
<Description>[F-LIB049] BuildingName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BuildingNumber) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BuildingNumber) = 0</Pattern>
<Description>[F-LIB050] BuildingNumber element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:InhouseMail) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:InhouseMail) = 0</Pattern>
<Description>[F-LIB051] InhouseMail element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Department) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Department) = 0</Pattern>
<Description>[F-LIB052] Department element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:MarkAttention) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:MarkAttention) = 0</Pattern>
<Description>[F-LIB053] MarkAttention element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:MarkCare) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:MarkCare) = 0</Pattern>
<Description>[F-LIB054] MarkCare element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:PlotIdentification) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:PlotIdentification) = 0</Pattern>
<Description>[F-LIB055] PlotIdentification element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CitySubdivisionName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CitySubdivisionName) = 0</Pattern>
<Description>[F-LIB056] CitySubdivisionName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CityName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CityName) = 0</Pattern>
<Description>[F-LIB057] CityName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:PostalZone) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:PostalZone) = 0</Pattern>
<Description>[F-LIB058] PostalZone element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CountrySubentity) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CountrySubentity) = 0</Pattern>
<Description>[F-LIB059] CountrySubentity element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CountrySubentityCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CountrySubentityCode) = 0</Pattern>
<Description>[F-LIB060] CountrySubentityCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB063] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cac:AddressLine) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cac:AddressLine) = 0</Pattern>
<Description>[F-LIB234] AddressLine class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB064] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:ID = '63') and cbc:TaxTypeCode">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID = '63') and cbc:TaxTypeCode</Pattern>
<Description>[F-LIB067] TaxTypeCode is not allowed when TaxScheme/ID equals '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID != ''</Pattern>
<Description>[F-LIB065] Invalid ID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:Name != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:Name != ''</Pattern>
<Description>[F-LIB066] Invalid Name. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:ID != '63') and not(cbc:TaxTypeCode)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID != '63') and not(cbc:TaxTypeCode)</Pattern>
<Description>[F-LIB197] TaxTypeCode is mandatory when TaxScheme/ID is different from '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeID = $TaxScheme_schemeID or cbc:ID/@schemeID = $TaxScheme2_schemeID" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeID = $TaxScheme_schemeID or cbc:ID/@schemeID = $TaxScheme2_schemeID</Pattern>
<Description>[F-LIB070] Invalid schemeID. Must be '<xsl:text />
<xsl:value-of select="$TaxScheme_schemeID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$TaxScheme2_schemeID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:TaxTypeCode) and not(cbc:TaxTypeCode/@listID = 'urn:oioubl:codelist:taxtypecode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:TaxTypeCode) and not(cbc:TaxTypeCode/@listID = 'urn:oioubl:codelist:taxtypecode-1.1')</Pattern>
<Description>[F-LIB071] Invalid listID. Must be 'urn:oioubl:codelist:taxtypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID = '63') and cbc:Name != 'Moms'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID = '63') and cbc:Name != 'Moms'</Pattern>
<Description>[F-LIB198] Name must equal 'Moms' when  TaxScheme/ID equals '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID != '63') and cbc:Name = 'Moms'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID != '63') and cbc:Name = 'Moms'</Pattern>
<Description>[F-LIB199] Name must correspond to the value of TaxScheme/ID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cac:JurisdictionRegionAddress) and cac:JurisdictionRegionAddress/cbc:AddressFormatCode != 'StructuredRegion'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cac:JurisdictionRegionAddress) and cac:JurisdictionRegionAddress/cbc:AddressFormatCode != 'StructuredRegion'</Pattern>
<Description>[F-LIB233] The AddressFormatCode under JurisdictionRegionAddress must always equal 'StructuredRegion'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M16" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:ReceiverParty/cac:PartyLegalEntity" priority="3989" mode="M16">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:CorporateRegistrationScheme) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:CorporateRegistrationScheme) = 0</Pattern>
<Description>[F-LIB186] CorporateRegistrationScheme class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID != ''</Pattern>
<Description>[F-LIB187] Invalid CompanyID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID/@schemeID = 'DK:CVR' or cbc:CompanyID/@schemeID = 'DK:CPR' or cbc:CompanyID/@schemeID = 'ZZZ'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID/@schemeID = 'DK:CVR' or cbc:CompanyID/@schemeID = 'DK:CPR' or cbc:CompanyID/@schemeID = 'ZZZ'</Pattern>
<Description>[F-LIB189] Invalid schemeID. Must be a valid scheme for PartyLegalEntity/CompanyID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:CVR') and (string-length(cbc:CompanyID) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:CVR') and (string-length(cbc:CompanyID) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB190] schemeID = DK:CVR, CompanyID must be a valid CVR number (DK12345678)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:CPR') and not(string-length(cbc:CompanyID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:CPR') and not(string-length(cbc:CompanyID) = 10)</Pattern>
<Description>[F-LIB191] schemeID = DK:CPR, CompanyID must be a valid CPR number (1234560000)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M16" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:ReceiverParty/cac:Contact" priority="3988" mode="M16">

		<!--REPORT -->
<xsl:if test="(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)</Pattern>
<Description>[F-LIB235] At least one field should be specified</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel</Pattern>
<Description>[F-LIB236] Use either ChannelCode or Channel</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication and not(cac:OtherCommunication/cbc:Value != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication and not(cac:OtherCommunication/cbc:Value != '')</Pattern>
<Description>[F-LIB237] Invalid Value. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M16" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:ReceiverParty/cac:Person" priority="3987" mode="M16">

		<!--REPORT -->
<xsl:if test="(not(cbc:FamilyName) or cbc:FamilyName = '') and (not(cbc:FirstName) or cbc:FirstName = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:FamilyName) or cbc:FamilyName = '') and (not(cbc:FirstName) or cbc:FirstName = '')</Pattern>
<Description>[F-LIB024] There must be a FirstName if the FamilyName is not present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M16" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M16" />
<xsl:template match="@*|node()" priority="-2" mode="M16">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M16" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M16" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN documentresponse-->


	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse" priority="3999" mode="M17">
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:Response" priority="3998" mode="M17">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ResponseCode != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ResponseCode != ''</Pattern>
<Description>[F-APR015] Invalid ResponseCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ReferenceID != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ReferenceID != ''</Pattern>
<Description>[F-APR016] Invalid ReferenceID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:Response/cbc:ResponseCode" priority="3997" mode="M17">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="./@listID = 'urn:oioubl:codelist:responsecode-1.1'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>./@listID = 'urn:oioubl:codelist:responsecode-1.1'</Pattern>
<Description>[F-APR017] Invalid listID. Must be 'urn:oioubl:codelist:responsecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test=". = 'TechnicalReject' or . = 'ProfileReject' or . = 'BusinessReject' or . = 'BusinessAccept'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>. = 'TechnicalReject' or . = 'ProfileReject' or . = 'BusinessReject' or . = 'BusinessAccept'</Pattern>
<Description>[F-APR018] Invalid ResponseCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:Response/cbc:Description" priority="3996" mode="M17">

		<!--REPORT -->
<xsl:if test="count(../cbc:Description) &gt; 1 and not(./@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cbc:Description) &gt; 1 and not(./@languageID)</Pattern>
<Description>[W-LIB222] The attribute languageID should be used when more than one Description element is present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID</Pattern>
<Description>[W-LIB223] Multilanguage error. Replicated Description elements with same languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:DocumentReference" priority="3995" mode="M17">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentType) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentType) = 0</Pattern>
<Description>[F-APR021] DocumentType element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:DocumentTypeCode != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:DocumentTypeCode != ''</Pattern>
<Description>[F-APR024] Invalid DocumentTypeCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID != ''</Pattern>
<Description>[F-APR025] Invalid ID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:UUID and not(string-length(string(cbc:UUID)) = 36)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:UUID and not(string-length(string(cbc:UUID)) = 36)</Pattern>
<Description>[F-APR026] Invalid UUID. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:DocumentTypeCode/@listID = $ResponseDocType_listID or cbc:DocumentTypeCode/@listID = $ResponseDocType2_listID" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:DocumentTypeCode/@listID = $ResponseDocType_listID or cbc:DocumentTypeCode/@listID = $ResponseDocType2_listID</Pattern>
<Description>[W-APR027] Invalid listID. Must be '<xsl:text />
<xsl:value-of select="$ResponseDocType_listID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$ResponseDocType2_listID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:DocumentTypeCode/@listAgencyID = $ResponseDocType_agencyID" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:DocumentTypeCode/@listAgencyID = $ResponseDocType_agencyID</Pattern>
<Description>[W-APR043] Invalid listAgencyID. Must be '<xsl:text />
<xsl:value-of select="$ResponseDocType_agencyID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:DocumentTypeCode/@listID = $ResponseDocType_listID and not (contains($ResponseDocType, concat(',',cbc:DocumentTypeCode,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:DocumentTypeCode/@listID = $ResponseDocType_listID and not (contains($ResponseDocType, concat(',',cbc:DocumentTypeCode,',')))</Pattern>
<Description>[F-APR028] Invalid DocumentTypeCode: '<xsl:text />
<xsl:value-of select="cbc:DocumentTypeCode" />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:DocumentTypeCode/@listID = $ResponseDocType2_listID and not (contains($ResponseDocType2, concat(',',cbc:DocumentTypeCode,',')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:DocumentTypeCode/@listID = $ResponseDocType2_listID and not (contains($ResponseDocType2, concat(',',cbc:DocumentTypeCode,',')))</Pattern>
<Description>[F-APR055] Invalid DocumentTypeCode: '<xsl:text />
<xsl:value-of select="cbc:DocumentTypeCode" />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:DocumentTypeCode = 'Order' and (../cac:Response/cbc:ResponseCode = 'BusinessAccept' or ../cac:Response/cbc:ResponseCode = 'BusinessReject')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:DocumentTypeCode = 'Order' and (../cac:Response/cbc:ResponseCode = 'BusinessAccept' or ../cac:Response/cbc:ResponseCode = 'BusinessReject')</Pattern>
<Description>[F-APR053] Invalid DocumentTypeCode. ApplicationResponse can't be used as response for an Order, when ResponseCode equals BusinessReject or BusinessAccept</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:DocumentReference/cac:Attachment" priority="3994" mode="M17">

		<!--REPORT -->
<xsl:if test="cbc:EmbeddedDocumentBinaryObject and cac:ExternalReference">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:EmbeddedDocumentBinaryObject and cac:ExternalReference</Pattern>
<Description>[F-APR045] Use either EmbeddedDocumentBinaryObject or ExternalReference</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject" priority="3993" mode="M17">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="./@mimeCode='image/tiff' or ./@mimeCode='image/png' or ./@mimeCode='image/jpeg' or ./@mimeCode='image/gif' or ./@mimeCode='application/pdf' or ./@mimeCode='text/xml'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>./@mimeCode='image/tiff' or ./@mimeCode='image/png' or ./@mimeCode='image/jpeg' or ./@mimeCode='image/gif' or ./@mimeCode='application/pdf' or ./@mimeCode='text/xml'</Pattern>
<Description>[F-APR044] Attribute mimeCode must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:DocumentReference/cac:Attachment/cac:ExternalReference" priority="3992" mode="M17">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:URI != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:URI != ''</Pattern>
<Description>[F-APR046] Invalid URI. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:IssuerParty" priority="3991" mode="M17">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:MarkCareIndicator) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:MarkCareIndicator) = 0</Pattern>
<Description>[F-LIB166] MarkCareIndicator element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:MarkAttentionIndicator) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:MarkAttentionIndicator) = 0</Pattern>
<Description>[F-LIB167] MarkAttentionIndicator element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:AgentParty) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:AgentParty) = 0</Pattern>
<Description>[F-LIB168] AgentParty class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:EndpointID != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:EndpointID != ''</Pattern>
<Description>[F-APR047] Invalid EndpointID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:PartyLegalEntity) = 1" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:PartyLegalEntity) = 1</Pattern>
<Description>[F-APR048] One PartyLegalEntity class must be present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(not(cac:PartyIdentification) or cac:PartyIdentification/cbc:ID = '') and (not(cac:PartyName) or cac:PartyName/cbc:Name = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cac:PartyIdentification) or cac:PartyIdentification/cbc:ID = '') and (not(cac:PartyName) or cac:PartyName/cbc:Name = '')</Pattern>
<Description>[F-LIB022] PartyName/Name is mandatory if PartyIdentification/ID is not found</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:EndpointID and not(cbc:EndpointID/@schemeID = 'GLN' or cbc:EndpointID/@schemeID = 'DUNS' or cbc:EndpointID/@schemeID = 'DK:P' or cbc:EndpointID/@schemeID = 'DK:CVR' or cbc:EndpointID/@schemeID = 'DK:CPR' or cbc:EndpointID/@schemeID = 'DK:SE' or cbc:EndpointID/@schemeID = 'DK:VANS' or cbc:EndpointID/@schemeID = 'IBAN' or cbc:EndpointID/@schemeID = 'ISO 6523')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:EndpointID and not(cbc:EndpointID/@schemeID = 'GLN' or cbc:EndpointID/@schemeID = 'DUNS' or cbc:EndpointID/@schemeID = 'DK:P' or cbc:EndpointID/@schemeID = 'DK:CVR' or cbc:EndpointID/@schemeID = 'DK:CPR' or cbc:EndpointID/@schemeID = 'DK:SE' or cbc:EndpointID/@schemeID = 'DK:VANS' or cbc:EndpointID/@schemeID = 'IBAN' or cbc:EndpointID/@schemeID = 'ISO 6523')</Pattern>
<Description>[F-LIB179] Invalid schemeID. Must be a valid scheme for EndpointID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'DK:CVR') and (string-length(cbc:EndpointID) != 10 or substring(cbc:EndpointID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'DK:CVR') and (string-length(cbc:EndpointID) != 10 or substring(cbc:EndpointID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB180] schemeID = DK:CVR, EndpointID must be a valid CVR number (DK12345678)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'DK:CPR') and not(string-length(cbc:EndpointID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'DK:CPR') and not(string-length(cbc:EndpointID) = 10)</Pattern>
<Description>[F-LIB215] schemeID = DK:CPR, EndpointID must be a valid CPR number (1234560000)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'GLN') and not(string-length(cbc:EndpointID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'GLN') and not(string-length(cbc:EndpointID) = 13)</Pattern>
<Description>[F-LIB181] schemeID = GLN, EndpointID must be a valid GLN number (1234567890123)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'EAN') and not(string-length(cbc:EndpointID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'EAN') and not(string-length(cbc:EndpointID) = 13)</Pattern>
<Description>[F-LIB216] schemeID = EAN, EndpointID must be a valid EAN number (1234567890123)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:IssuerParty/cac:PartyIdentification" priority="3990" mode="M17">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeID = 'DUNS' or cbc:ID/@schemeID = 'GLN' or cbc:ID/@schemeID = 'IBAN' or cbc:ID/@schemeID = 'ISO 6523' or cbc:ID/@schemeID = 'ZZZ' or cbc:ID/@schemeID = 'DK:CPR' or cbc:ID/@schemeID = 'DK:CVR' or cbc:ID/@schemeID = 'DK:P' or cbc:ID/@schemeID = 'DK:SE' or cbc:ID/@schemeID = 'DK:TELEFON' or cbc:ID/@schemeID = 'FI:ORGNR' or cbc:ID/@schemeID = 'IS:KT' or cbc:ID/@schemeID = 'IS:VSKNR' or cbc:ID/@schemeID = 'NO:EFO' or cbc:ID/@schemeID = 'NO:NOBB' or cbc:ID/@schemeID = 'NO:NODI' or cbc:ID/@schemeID = 'NO:ORGNR' or cbc:ID/@schemeID = 'NO:VAT' or cbc:ID/@schemeID = 'SE:ORGNR' or cbc:ID/@schemeID = 'SE:VAT'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeID = 'DUNS' or cbc:ID/@schemeID = 'GLN' or cbc:ID/@schemeID = 'IBAN' or cbc:ID/@schemeID = 'ISO 6523' or cbc:ID/@schemeID = 'ZZZ' or cbc:ID/@schemeID = 'DK:CPR' or cbc:ID/@schemeID = 'DK:CVR' or cbc:ID/@schemeID = 'DK:P' or cbc:ID/@schemeID = 'DK:SE' or cbc:ID/@schemeID = 'DK:TELEFON' or cbc:ID/@schemeID = 'FI:ORGNR' or cbc:ID/@schemeID = 'IS:KT' or cbc:ID/@schemeID = 'IS:VSKNR' or cbc:ID/@schemeID = 'NO:EFO' or cbc:ID/@schemeID = 'NO:NOBB' or cbc:ID/@schemeID = 'NO:NODI' or cbc:ID/@schemeID = 'NO:ORGNR' or cbc:ID/@schemeID = 'NO:VAT' or cbc:ID/@schemeID = 'SE:ORGNR' or cbc:ID/@schemeID = 'SE:VAT'</Pattern>
<Description>[F-LIB183] Invalid schemeID. Must be a valid scheme for PartyIdentification/ID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'DK:CVR') and (string-length(cbc:ID) != 10 or substring(cbc:ID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'DK:CVR') and (string-length(cbc:ID) != 10 or substring(cbc:ID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB184] schemeID = DK:CVR, ID must be a valid CVR number (DK12345678)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'DK:CPR') and not(string-length(cbc:ID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'DK:CPR') and not(string-length(cbc:ID) = 10)</Pattern>
<Description>[F-LIB217] schemeID = DK:CPR, ID must be a valid CPR number (1234560000)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'GLN') and not(string-length(cbc:ID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'GLN') and not(string-length(cbc:ID) = 13)</Pattern>
<Description>[F-LIB185] schemeID = GLN, ID must be a valid GLN number (1234567890123)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'EAN') and not(string-length(cbc:ID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'EAN') and not(string-length(cbc:ID) = 13)</Pattern>
<Description>[F-LIB218] schemeID = EAN, ID must be a valid EAN number (1234567890123)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'DK:P') and not(string-length(cbc:ID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'DK:P') and not(string-length(cbc:ID) = 10)</Pattern>
<Description>[F-LIB287] schemeID = DK:P, ID must be a valid P number (1234567890)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:IssuerParty/cac:PartyName" priority="3989" mode="M17">

		<!--REPORT -->
<xsl:if test="count(../cac:PartyName) &gt; 1 and not(./cbc:Name/@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cac:PartyName) &gt; 1 and not(./cbc:Name/@languageID)</Pattern>
<Description>[W-LIB219] The attribute Name@languageID should be used when more than one PartyName class is present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/cbc:Name/@languageID = self::*/cbc:Name/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/cbc:Name/@languageID = self::*/cbc:Name/@languageID</Pattern>
<Description>[W-LIB220] Multilanguage error. Replicated PartyName classes with same Name@languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:IssuerParty/cac:PostalAddress" priority="3988" mode="M17">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:BlockName) = 0</Pattern>
<Description>[F-LIB210] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB211] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB212] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode != ''</Pattern>
<Description>[F-LIB025] Invalid AddressFormatCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')</Pattern>
<Description>[F-LIB204] Invalid listID. Must be 'urn:oioubl:codelist:addresstypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB205] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )</Pattern>
<Description>[F-LIB206] Invalid AddressTypeCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'</Pattern>
<Description>[F-LIB026] Invalid listID. Must be either 'urn:oioubl:codelist:addressformatcode-1.1' or 'UN/ECE 3477'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB207] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode = 'StructuredDK' or cbc:AddressFormatCode = 'StructuredLax' or cbc:AddressFormatCode = 'StructuredID' or cbc:AddressFormatCode = 'StructuredRegion' or cbc:AddressFormatCode = 'Unstructured')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode = 'StructuredDK' or cbc:AddressFormatCode = 'StructuredLax' or cbc:AddressFormatCode = 'StructuredID' or cbc:AddressFormatCode = 'StructuredRegion' or cbc:AddressFormatCode = 'Unstructured')</Pattern>
<Description>[F-LIB027] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')</Pattern>
<Description>[F-LIB208] Invalid listAgencyID. Must be '6'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')</Pattern>
<Description>[F-LIB209] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Country and not(cac:Country/cbc:IdentificationCode != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Country and not(cac:Country/cbc:IdentificationCode != '')</Pattern>
<Description>[F-LIB213] When Country is used the element Country/IdentificationCode must be filled out</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB031] An Unstructured address is only allowed to have AddressLine elements</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine</Pattern>
<Description>[F-LIB032] AddressLine elements not allowed for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or cbc:PostalZone = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or cbc:PostalZone = '')</Pattern>
<Description>[F-LIB033] PostalZone is mandatory for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or cbc:StreetName = '') and (not(cbc:Postbox) or cbc:Postbox = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or cbc:StreetName = '') and (not(cbc:Postbox) or cbc:Postbox = ''))</Pattern>
<Description>[F-LIB034] There should be either a StreetName or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or cbc:BuildingNumber = '') and (not(cbc:Postbox) or cbc:Postbox = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or cbc:BuildingNumber = '') and (not(cbc:Postbox) or cbc:Postbox = ''))</Pattern>
<Description>[F-LIB035] There should be either a BuildingNumber or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine</Pattern>
<Description>[F-LIB036] AddressLine elements not allowed for a StructuredLax address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')</Pattern>
<Description>[F-LIB037] ID is required for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB038] Only the ID is used for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))</Pattern>
<Description>[F-LIB039] Region or District or Country/IdentificationCode is required for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')</Pattern>
<Description>[F-LIB040] Only Region, District, and/or Country/IdentificationCode can be used for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)</Pattern>
<Description>[F-LIB028] When ID is used under Address the attribute schemeID is used to give an addressregister</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(cbc:ID/@schemeID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(cbc:ID/@schemeID)</Pattern>
<Description>[F-LIB029] schemeID attribute must be present on an address ID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:Postbox and not(number(cbc:Postbox)=((cbc:Postbox + 1)-1))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:Postbox and not(number(cbc:Postbox)=((cbc:Postbox + 1)-1))</Pattern>
<Description>[F-LIB030] The value of Postbox must always be a number</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:IssuerParty/cac:PhysicalLocation" priority="3987" mode="M17">

		<!--REPORT -->
<xsl:if test="(not(cbc:ID) or cbc:ID = '') and (count(cac:Address) = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:ID) or cbc:ID = '') and (count(cac:Address) = 0)</Pattern>
<Description>[F-LIB221] If ID not specified, Address is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:IssuerParty/cac:PhysicalLocation/cac:ValidityPeriod" priority="3986" mode="M17">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DurationMeasure) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DurationMeasure) = 0</Pattern>
<Description>[F-LIB076] DurationMeasure element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DescriptionCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DescriptionCode) = 0</Pattern>
<Description>[F-LIB077] DescriptionCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')</Pattern>
<Description>[F-LIB078] There must be a StartDate if you have a StartTime</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')</Pattern>
<Description>[F-LIB079] There must be a EndDate if you have a EndTime</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))</Pattern>
<Description>[F-LIB080] The EndDate must be greater or equal to the startdate</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))</Pattern>
<Description>[F-LIB081] EndTime must be greater or equal to StartTime</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:IssuerParty/cac:PhysicalLocation/cac:ValidityPeriod/cbc:Description" priority="3985" mode="M17">

		<!--REPORT -->
<xsl:if test="count(../cbc:Description) &gt; 1 and not(./@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cbc:Description) &gt; 1 and not(./@languageID)</Pattern>
<Description>[W-LIB222] The attribute languageID should be used when more than one Description element is present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID</Pattern>
<Description>[W-LIB223] Multilanguage error. Replicated Description elements with same languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:IssuerParty/cac:PhysicalLocation/cac:Address" priority="3984" mode="M17">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:BlockName) = 0</Pattern>
<Description>[F-LIB210] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB211] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB212] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode != ''</Pattern>
<Description>[F-LIB025] Invalid AddressFormatCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')</Pattern>
<Description>[F-LIB204] Invalid listID. Must be 'urn:oioubl:codelist:addresstypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB205] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )</Pattern>
<Description>[F-LIB206] Invalid AddressTypeCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'</Pattern>
<Description>[F-LIB026] Invalid listID. Must be either 'urn:oioubl:codelist:addressformatcode-1.1' or 'UN/ECE 3477'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB207] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode = 'StructuredDK' or cbc:AddressFormatCode = 'StructuredLax' or cbc:AddressFormatCode = 'StructuredID' or cbc:AddressFormatCode = 'StructuredRegion' or cbc:AddressFormatCode = 'Unstructured')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode = 'StructuredDK' or cbc:AddressFormatCode = 'StructuredLax' or cbc:AddressFormatCode = 'StructuredID' or cbc:AddressFormatCode = 'StructuredRegion' or cbc:AddressFormatCode = 'Unstructured')</Pattern>
<Description>[F-LIB027] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')</Pattern>
<Description>[F-LIB208] Invalid listAgencyID. Must be '6'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')</Pattern>
<Description>[F-LIB209] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Country and not(cac:Country/cbc:IdentificationCode != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Country and not(cac:Country/cbc:IdentificationCode != '')</Pattern>
<Description>[F-LIB213] When Country is used the element Country/IdentificationCode must be filled out</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB031] An Unstructured address is only allowed to have AddressLine elements</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine</Pattern>
<Description>[F-LIB032] AddressLine elements not allowed for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or cbc:PostalZone = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or cbc:PostalZone = '')</Pattern>
<Description>[F-LIB033] PostalZone is mandatory for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or cbc:StreetName = '') and (not(cbc:Postbox) or cbc:Postbox = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or cbc:StreetName = '') and (not(cbc:Postbox) or cbc:Postbox = ''))</Pattern>
<Description>[F-LIB034] There should be either a StreetName or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or cbc:BuildingNumber = '') and (not(cbc:Postbox) or cbc:Postbox = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or cbc:BuildingNumber = '') and (not(cbc:Postbox) or cbc:Postbox = ''))</Pattern>
<Description>[F-LIB035] There should be either a BuildingNumber or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine</Pattern>
<Description>[F-LIB036] AddressLine elements not allowed for a StructuredLax address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')</Pattern>
<Description>[F-LIB037] ID is required for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB038] Only the ID is used for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))</Pattern>
<Description>[F-LIB039] Region or District or Country/IdentificationCode is required for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')</Pattern>
<Description>[F-LIB040] Only Region, District, and/or Country/IdentificationCode can be used for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)</Pattern>
<Description>[F-LIB028] When ID is used under Address the attribute schemeID is used to give an addressregister</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(cbc:ID/@schemeID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(cbc:ID/@schemeID)</Pattern>
<Description>[F-LIB029] schemeID attribute must be present on an address ID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:Postbox and not(number(cbc:Postbox)=((cbc:Postbox + 1)-1))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:Postbox and not(number(cbc:Postbox)=((cbc:Postbox + 1)-1))</Pattern>
<Description>[F-LIB030] The value of Postbox must always be a number</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:IssuerParty/cac:PartyTaxScheme" priority="3983" mode="M17">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TaxLevelCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TaxLevelCode) = 0</Pattern>
<Description>[F-LIB192] TaxLevelCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID != ''</Pattern>
<Description>[F-LIB193] Invalid CompanyID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID/@schemeID = 'DK:SE' or cbc:CompanyID/@schemeID = 'ZZZ' " />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID/@schemeID = 'DK:SE' or cbc:CompanyID/@schemeID = 'ZZZ'</Pattern>
<Description>[F-LIB195] Invalid schemeID. Must be a valid scheme for PartyTaxScheme/CompanyID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:SE') and (string-length(cbc:CompanyID) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:SE') and (string-length(cbc:CompanyID) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB196] schemeID = DK:SE, CompanyID must be a valid SE number (DK12345678)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:IssuerParty/cac:PartyTaxScheme/cac:TaxScheme" priority="3982" mode="M17">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:ID) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:ID) = 0</Pattern>
<Description>[F-LIB041] ID element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:AddressTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:AddressTypeCode) = 0</Pattern>
<Description>[F-LIB042] AddressTypeCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Postbox) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Postbox) = 0</Pattern>
<Description>[F-LIB043] Postbox element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Floor) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Floor) = 0</Pattern>
<Description>[F-LIB044] Floor element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Room) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Room) = 0</Pattern>
<Description>[F-LIB045] Room element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:StreetName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:StreetName) = 0</Pattern>
<Description>[F-LIB046] StreetName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:AdditionalStreetName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:AdditionalStreetName) = 0</Pattern>
<Description>[F-LIB047] AdditionalStreetName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BlockName) = 0</Pattern>
<Description>[F-LIB048] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BuildingName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BuildingName) = 0</Pattern>
<Description>[F-LIB049] BuildingName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BuildingNumber) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BuildingNumber) = 0</Pattern>
<Description>[F-LIB050] BuildingNumber element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:InhouseMail) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:InhouseMail) = 0</Pattern>
<Description>[F-LIB051] InhouseMail element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Department) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Department) = 0</Pattern>
<Description>[F-LIB052] Department element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:MarkAttention) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:MarkAttention) = 0</Pattern>
<Description>[F-LIB053] MarkAttention element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:MarkCare) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:MarkCare) = 0</Pattern>
<Description>[F-LIB054] MarkCare element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:PlotIdentification) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:PlotIdentification) = 0</Pattern>
<Description>[F-LIB055] PlotIdentification element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CitySubdivisionName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CitySubdivisionName) = 0</Pattern>
<Description>[F-LIB056] CitySubdivisionName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CityName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CityName) = 0</Pattern>
<Description>[F-LIB057] CityName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:PostalZone) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:PostalZone) = 0</Pattern>
<Description>[F-LIB058] PostalZone element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CountrySubentity) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CountrySubentity) = 0</Pattern>
<Description>[F-LIB059] CountrySubentity element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CountrySubentityCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CountrySubentityCode) = 0</Pattern>
<Description>[F-LIB060] CountrySubentityCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB063] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cac:AddressLine) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cac:AddressLine) = 0</Pattern>
<Description>[F-LIB234] AddressLine class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB064] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:ID = '63') and cbc:TaxTypeCode">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID = '63') and cbc:TaxTypeCode</Pattern>
<Description>[F-LIB067] TaxTypeCode is not allowed when TaxScheme/ID equals '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID != ''</Pattern>
<Description>[F-LIB065] Invalid ID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:Name != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:Name != ''</Pattern>
<Description>[F-LIB066] Invalid Name. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:ID != '63') and not(cbc:TaxTypeCode)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID != '63') and not(cbc:TaxTypeCode)</Pattern>
<Description>[F-LIB197] TaxTypeCode is mandatory when TaxScheme/ID is different from '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeID = $TaxScheme_schemeID or cbc:ID/@schemeID = $TaxScheme2_schemeID" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeID = $TaxScheme_schemeID or cbc:ID/@schemeID = $TaxScheme2_schemeID</Pattern>
<Description>[F-LIB070] Invalid schemeID. Must be '<xsl:text />
<xsl:value-of select="$TaxScheme_schemeID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$TaxScheme2_schemeID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:TaxTypeCode) and not(cbc:TaxTypeCode/@listID = 'urn:oioubl:codelist:taxtypecode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:TaxTypeCode) and not(cbc:TaxTypeCode/@listID = 'urn:oioubl:codelist:taxtypecode-1.1')</Pattern>
<Description>[F-LIB071] Invalid listID. Must be 'urn:oioubl:codelist:taxtypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID = '63') and cbc:Name != 'Moms'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID = '63') and cbc:Name != 'Moms'</Pattern>
<Description>[F-LIB198] Name must equal 'Moms' when  TaxScheme/ID equals '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID != '63') and cbc:Name = 'Moms'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID != '63') and cbc:Name = 'Moms'</Pattern>
<Description>[F-LIB199] Name must correspond to the value of TaxScheme/ID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cac:JurisdictionRegionAddress) and cac:JurisdictionRegionAddress/cbc:AddressFormatCode != 'StructuredRegion'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cac:JurisdictionRegionAddress) and cac:JurisdictionRegionAddress/cbc:AddressFormatCode != 'StructuredRegion'</Pattern>
<Description>[F-LIB233] The AddressFormatCode under JurisdictionRegionAddress must always equal 'StructuredRegion'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:IssuerParty/cac:PartyLegalEntity" priority="3981" mode="M17">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:CorporateRegistrationScheme) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:CorporateRegistrationScheme) = 0</Pattern>
<Description>[F-LIB186] CorporateRegistrationScheme class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID != ''</Pattern>
<Description>[F-LIB187] Invalid CompanyID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID/@schemeID = 'DK:CVR' or cbc:CompanyID/@schemeID = 'DK:CPR' or cbc:CompanyID/@schemeID = 'ZZZ'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID/@schemeID = 'DK:CVR' or cbc:CompanyID/@schemeID = 'DK:CPR' or cbc:CompanyID/@schemeID = 'ZZZ'</Pattern>
<Description>[F-LIB189] Invalid schemeID. Must be a valid scheme for PartyLegalEntity/CompanyID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:CVR') and (string-length(cbc:CompanyID) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:CVR') and (string-length(cbc:CompanyID) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB190] schemeID = DK:CVR, CompanyID must be a valid CVR number (DK12345678)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:CPR') and not(string-length(cbc:CompanyID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:CPR') and not(string-length(cbc:CompanyID) = 10)</Pattern>
<Description>[F-LIB191] schemeID = DK:CPR, CompanyID must be a valid CPR number (1234560000)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:IssuerParty/cac:Contact" priority="3980" mode="M17">

		<!--REPORT -->
<xsl:if test="(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)</Pattern>
<Description>[F-LIB235] At least one field should be specified</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel</Pattern>
<Description>[F-LIB236] Use either ChannelCode or Channel</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication and not(cac:OtherCommunication/cbc:Value != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication and not(cac:OtherCommunication/cbc:Value != '')</Pattern>
<Description>[F-LIB237] Invalid Value. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:IssuerParty/cac:Person" priority="3979" mode="M17">

		<!--REPORT -->
<xsl:if test="(not(cbc:FamilyName) or cbc:FamilyName = '') and (not(cbc:FirstName) or cbc:FirstName = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:FamilyName) or cbc:FamilyName = '') and (not(cbc:FirstName) or cbc:FirstName = '')</Pattern>
<Description>[F-LIB024] There must be a FirstName if the FamilyName is not present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:RecipientParty" priority="3978" mode="M17">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:MarkCareIndicator) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:MarkCareIndicator) = 0</Pattern>
<Description>[F-LIB166] MarkCareIndicator element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:MarkAttentionIndicator) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:MarkAttentionIndicator) = 0</Pattern>
<Description>[F-LIB167] MarkAttentionIndicator element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:AgentParty) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:AgentParty) = 0</Pattern>
<Description>[F-LIB168] AgentParty class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:EndpointID != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:EndpointID != ''</Pattern>
<Description>[F-APR049] Invalid EndpointID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(not(cac:PartyIdentification) or cac:PartyIdentification/cbc:ID = '') and (not(cac:PartyName) or cac:PartyName/cbc:Name = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cac:PartyIdentification) or cac:PartyIdentification/cbc:ID = '') and (not(cac:PartyName) or cac:PartyName/cbc:Name = '')</Pattern>
<Description>[F-LIB022] PartyName/Name is mandatory if PartyIdentification/ID is not found</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:EndpointID and not(cbc:EndpointID/@schemeID = 'GLN' or cbc:EndpointID/@schemeID = 'DUNS' or cbc:EndpointID/@schemeID = 'DK:P' or cbc:EndpointID/@schemeID = 'DK:CVR' or cbc:EndpointID/@schemeID = 'DK:CPR' or cbc:EndpointID/@schemeID = 'DK:SE' or cbc:EndpointID/@schemeID = 'DK:VANS' or cbc:EndpointID/@schemeID = 'IBAN' or cbc:EndpointID/@schemeID = 'ISO 6523')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:EndpointID and not(cbc:EndpointID/@schemeID = 'GLN' or cbc:EndpointID/@schemeID = 'DUNS' or cbc:EndpointID/@schemeID = 'DK:P' or cbc:EndpointID/@schemeID = 'DK:CVR' or cbc:EndpointID/@schemeID = 'DK:CPR' or cbc:EndpointID/@schemeID = 'DK:SE' or cbc:EndpointID/@schemeID = 'DK:VANS' or cbc:EndpointID/@schemeID = 'IBAN' or cbc:EndpointID/@schemeID = 'ISO 6523')</Pattern>
<Description>[F-LIB179] Invalid schemeID. Must be a valid scheme for EndpointID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'DK:CVR') and (string-length(cbc:EndpointID) != 10 or substring(cbc:EndpointID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'DK:CVR') and (string-length(cbc:EndpointID) != 10 or substring(cbc:EndpointID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB180] schemeID = DK:CVR, EndpointID must be a valid CVR number (DK12345678)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'DK:CPR') and not(string-length(cbc:EndpointID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'DK:CPR') and not(string-length(cbc:EndpointID) = 10)</Pattern>
<Description>[F-LIB215] schemeID = DK:CPR, EndpointID must be a valid CPR number (1234560000)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'GLN') and not(string-length(cbc:EndpointID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'GLN') and not(string-length(cbc:EndpointID) = 13)</Pattern>
<Description>[F-LIB181] schemeID = GLN, EndpointID must be a valid GLN number (1234567890123)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndpointID/@schemeID = 'EAN') and not(string-length(cbc:EndpointID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndpointID/@schemeID = 'EAN') and not(string-length(cbc:EndpointID) = 13)</Pattern>
<Description>[F-LIB216] schemeID = EAN, EndpointID must be a valid EAN number (1234567890123)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(cac:PartyLegalEntity) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:PartyLegalEntity) &gt; 1</Pattern>
<Description>[F-APR050] No more than one PartyLegalEntity class may be present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:RecipientParty/cac:PartyIdentification" priority="3977" mode="M17">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeID = 'DUNS' or cbc:ID/@schemeID = 'GLN' or cbc:ID/@schemeID = 'IBAN' or cbc:ID/@schemeID = 'ISO 6523' or cbc:ID/@schemeID = 'ZZZ' or cbc:ID/@schemeID = 'DK:CPR' or cbc:ID/@schemeID = 'DK:CVR' or cbc:ID/@schemeID = 'DK:P' or cbc:ID/@schemeID = 'DK:SE' or cbc:ID/@schemeID = 'DK:TELEFON' or cbc:ID/@schemeID = 'FI:ORGNR' or cbc:ID/@schemeID = 'IS:KT' or cbc:ID/@schemeID = 'IS:VSKNR' or cbc:ID/@schemeID = 'NO:EFO' or cbc:ID/@schemeID = 'NO:NOBB' or cbc:ID/@schemeID = 'NO:NODI' or cbc:ID/@schemeID = 'NO:ORGNR' or cbc:ID/@schemeID = 'NO:VAT' or cbc:ID/@schemeID = 'SE:ORGNR' or cbc:ID/@schemeID = 'SE:VAT'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeID = 'DUNS' or cbc:ID/@schemeID = 'GLN' or cbc:ID/@schemeID = 'IBAN' or cbc:ID/@schemeID = 'ISO 6523' or cbc:ID/@schemeID = 'ZZZ' or cbc:ID/@schemeID = 'DK:CPR' or cbc:ID/@schemeID = 'DK:CVR' or cbc:ID/@schemeID = 'DK:P' or cbc:ID/@schemeID = 'DK:SE' or cbc:ID/@schemeID = 'DK:TELEFON' or cbc:ID/@schemeID = 'FI:ORGNR' or cbc:ID/@schemeID = 'IS:KT' or cbc:ID/@schemeID = 'IS:VSKNR' or cbc:ID/@schemeID = 'NO:EFO' or cbc:ID/@schemeID = 'NO:NOBB' or cbc:ID/@schemeID = 'NO:NODI' or cbc:ID/@schemeID = 'NO:ORGNR' or cbc:ID/@schemeID = 'NO:VAT' or cbc:ID/@schemeID = 'SE:ORGNR' or cbc:ID/@schemeID = 'SE:VAT'</Pattern>
<Description>[F-LIB183] Invalid schemeID. Must be a valid scheme for PartyIdentification/ID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'DK:CVR') and (string-length(cbc:ID) != 10 or substring(cbc:ID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'DK:CVR') and (string-length(cbc:ID) != 10 or substring(cbc:ID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB184] schemeID = DK:CVR, ID must be a valid CVR number (DK12345678)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'DK:CPR') and not(string-length(cbc:ID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'DK:CPR') and not(string-length(cbc:ID) = 10)</Pattern>
<Description>[F-LIB217] schemeID = DK:CPR, ID must be a valid CPR number (1234560000)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'GLN') and not(string-length(cbc:ID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'GLN') and not(string-length(cbc:ID) = 13)</Pattern>
<Description>[F-LIB185] schemeID = GLN, ID must be a valid GLN number (1234567890123)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'EAN') and not(string-length(cbc:ID) = 13)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'EAN') and not(string-length(cbc:ID) = 13)</Pattern>
<Description>[F-LIB218] schemeID = EAN, ID must be a valid EAN number (1234567890123)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID/@schemeID = 'DK:P') and not(string-length(cbc:ID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID/@schemeID = 'DK:P') and not(string-length(cbc:ID) = 10)</Pattern>
<Description>[F-LIB287] schemeID = DK:P, ID must be a valid P number (1234567890)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:RecipientParty/cac:PartyName" priority="3976" mode="M17">

		<!--REPORT -->
<xsl:if test="count(../cac:PartyName) &gt; 1 and not(./cbc:Name/@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cac:PartyName) &gt; 1 and not(./cbc:Name/@languageID)</Pattern>
<Description>[W-LIB219] The attribute Name@languageID should be used when more than one PartyName class is present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/cbc:Name/@languageID = self::*/cbc:Name/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/cbc:Name/@languageID = self::*/cbc:Name/@languageID</Pattern>
<Description>[W-LIB220] Multilanguage error. Replicated PartyName classes with same Name@languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:RecipientParty/cac:PostalAddress" priority="3975" mode="M17">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:BlockName) = 0</Pattern>
<Description>[F-LIB210] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB211] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB212] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode != ''</Pattern>
<Description>[F-LIB025] Invalid AddressFormatCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')</Pattern>
<Description>[F-LIB204] Invalid listID. Must be 'urn:oioubl:codelist:addresstypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB205] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )</Pattern>
<Description>[F-LIB206] Invalid AddressTypeCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'</Pattern>
<Description>[F-LIB026] Invalid listID. Must be either 'urn:oioubl:codelist:addressformatcode-1.1' or 'UN/ECE 3477'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB207] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode = 'StructuredDK' or cbc:AddressFormatCode = 'StructuredLax' or cbc:AddressFormatCode = 'StructuredID' or cbc:AddressFormatCode = 'StructuredRegion' or cbc:AddressFormatCode = 'Unstructured')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode = 'StructuredDK' or cbc:AddressFormatCode = 'StructuredLax' or cbc:AddressFormatCode = 'StructuredID' or cbc:AddressFormatCode = 'StructuredRegion' or cbc:AddressFormatCode = 'Unstructured')</Pattern>
<Description>[F-LIB027] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')</Pattern>
<Description>[F-LIB208] Invalid listAgencyID. Must be '6'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')</Pattern>
<Description>[F-LIB209] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Country and not(cac:Country/cbc:IdentificationCode != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Country and not(cac:Country/cbc:IdentificationCode != '')</Pattern>
<Description>[F-LIB213] When Country is used the element Country/IdentificationCode must be filled out</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB031] An Unstructured address is only allowed to have AddressLine elements</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine</Pattern>
<Description>[F-LIB032] AddressLine elements not allowed for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or cbc:PostalZone = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or cbc:PostalZone = '')</Pattern>
<Description>[F-LIB033] PostalZone is mandatory for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or cbc:StreetName = '') and (not(cbc:Postbox) or cbc:Postbox = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or cbc:StreetName = '') and (not(cbc:Postbox) or cbc:Postbox = ''))</Pattern>
<Description>[F-LIB034] There should be either a StreetName or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or cbc:BuildingNumber = '') and (not(cbc:Postbox) or cbc:Postbox = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or cbc:BuildingNumber = '') and (not(cbc:Postbox) or cbc:Postbox = ''))</Pattern>
<Description>[F-LIB035] There should be either a BuildingNumber or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine</Pattern>
<Description>[F-LIB036] AddressLine elements not allowed for a StructuredLax address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')</Pattern>
<Description>[F-LIB037] ID is required for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB038] Only the ID is used for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))</Pattern>
<Description>[F-LIB039] Region or District or Country/IdentificationCode is required for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')</Pattern>
<Description>[F-LIB040] Only Region, District, and/or Country/IdentificationCode can be used for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)</Pattern>
<Description>[F-LIB028] When ID is used under Address the attribute schemeID is used to give an addressregister</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(cbc:ID/@schemeID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(cbc:ID/@schemeID)</Pattern>
<Description>[F-LIB029] schemeID attribute must be present on an address ID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:Postbox and not(number(cbc:Postbox)=((cbc:Postbox + 1)-1))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:Postbox and not(number(cbc:Postbox)=((cbc:Postbox + 1)-1))</Pattern>
<Description>[F-LIB030] The value of Postbox must always be a number</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:RecipientParty/cac:PhysicalLocation" priority="3974" mode="M17">

		<!--REPORT -->
<xsl:if test="(not(cbc:ID) or cbc:ID = '') and (count(cac:Address) = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:ID) or cbc:ID = '') and (count(cac:Address) = 0)</Pattern>
<Description>[F-LIB221] If ID not specified, Address is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:RecipientParty/cac:PhysicalLocation/cac:ValidityPeriod" priority="3973" mode="M17">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DurationMeasure) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DurationMeasure) = 0</Pattern>
<Description>[F-LIB076] DurationMeasure element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DescriptionCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DescriptionCode) = 0</Pattern>
<Description>[F-LIB077] DescriptionCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime) and (not(cbc:StartDate) or cbc:StartDate = '')</Pattern>
<Description>[F-LIB078] There must be a StartDate if you have a StartTime</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:EndTime) and (not(cbc:EndDate) or cbc:EndDate = '')</Pattern>
<Description>[F-LIB079] There must be a EndDate if you have a EndTime</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartDate and cbc:EndDate) and not(number(translate(cbc:EndDate,'-','')) &gt; number(translate(cbc:StartDate,'-','')) or number(translate(cbc:EndDate,'-','')) = number(translate(cbc:StartDate,'-','')))</Pattern>
<Description>[F-LIB080] The EndDate must be greater or equal to the startdate</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:StartTime and cbc:EndTime) and not(number(translate(cbc:EndTime,':','')) &gt; number(translate(cbc:StartTime,':','')) or number(translate(cbc:EndTime,':','')) = number(translate(cbc:StartTime,':','')))</Pattern>
<Description>[F-LIB081] EndTime must be greater or equal to StartTime</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:RecipientParty/cac:PhysicalLocation/cac:ValidityPeriod/cbc:Description" priority="3972" mode="M17">

		<!--REPORT -->
<xsl:if test="count(../cbc:Description) &gt; 1 and not(./@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cbc:Description) &gt; 1 and not(./@languageID)</Pattern>
<Description>[W-LIB222] The attribute languageID should be used when more than one Description element is present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID</Pattern>
<Description>[W-LIB223] Multilanguage error. Replicated Description elements with same languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:RecipientParty/cac:PhysicalLocation/cac:Address" priority="3971" mode="M17">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:BlockName) = 0</Pattern>
<Description>[F-LIB210] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB211] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB212] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode != ''</Pattern>
<Description>[F-LIB025] Invalid AddressFormatCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listID = 'urn:oioubl:codelist:addresstypecode-1.1')</Pattern>
<Description>[F-LIB204] Invalid listID. Must be 'urn:oioubl:codelist:addresstypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB205] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressTypeCode and not(cbc:AddressTypeCode = 'Home' or cbc:AddressTypeCode = 'Business' )</Pattern>
<Description>[F-LIB206] Invalid AddressTypeCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' or cbc:AddressFormatCode/@listID = 'UN/ECE 3477'</Pattern>
<Description>[F-LIB026] Invalid listID. Must be either 'urn:oioubl:codelist:addressformatcode-1.1' or 'UN/ECE 3477'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode/@listAgencyID = '320')</Pattern>
<Description>[F-LIB207] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode = 'StructuredDK' or cbc:AddressFormatCode = 'StructuredLax' or cbc:AddressFormatCode = 'StructuredID' or cbc:AddressFormatCode = 'StructuredRegion' or cbc:AddressFormatCode = 'Unstructured')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'urn:oioubl:codelist:addressformatcode-1.1' and not(cbc:AddressFormatCode = 'StructuredDK' or cbc:AddressFormatCode = 'StructuredLax' or cbc:AddressFormatCode = 'StructuredID' or cbc:AddressFormatCode = 'StructuredRegion' or cbc:AddressFormatCode = 'Unstructured')</Pattern>
<Description>[F-LIB027] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode/@listAgencyID = '6')</Pattern>
<Description>[F-LIB208] Invalid listAgencyID. Must be '6'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AddressFormatCode/@listID = 'UN/ECE 3477' and not(cbc:AddressFormatCode = '1' or cbc:AddressFormatCode = '2' or cbc:AddressFormatCode = '3' or cbc:AddressFormatCode = '4' or cbc:AddressFormatCode = '5' or cbc:AddressFormatCode = '6' or cbc:AddressFormatCode = '7' or cbc:AddressFormatCode = '8' or cbc:AddressFormatCode = '9')</Pattern>
<Description>[F-LIB209] Invalid AddressFormatCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Country and not(cac:Country/cbc:IdentificationCode != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Country and not(cac:Country/cbc:IdentificationCode != '')</Pattern>
<Description>[F-LIB213] When Country is used the element Country/IdentificationCode must be filled out</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'Unstructured') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB031] An Unstructured address is only allowed to have AddressLine elements</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and cac:AddressLine</Pattern>
<Description>[F-LIB032] AddressLine elements not allowed for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or cbc:PostalZone = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and (not(cbc:PostalZone) or cbc:PostalZone = '')</Pattern>
<Description>[F-LIB033] PostalZone is mandatory for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or cbc:StreetName = '') and (not(cbc:Postbox) or cbc:Postbox = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:StreetName) or cbc:StreetName = '') and (not(cbc:Postbox) or cbc:Postbox = ''))</Pattern>
<Description>[F-LIB034] There should be either a StreetName or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or cbc:BuildingNumber = '') and (not(cbc:Postbox) or cbc:Postbox = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredDK') and ((not(cbc:BuildingNumber) or cbc:BuildingNumber = '') and (not(cbc:Postbox) or cbc:Postbox = ''))</Pattern>
<Description>[F-LIB035] There should be either a BuildingNumber or a Postbox for a StructuredDK address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredLax') and cac:AddressLine</Pattern>
<Description>[F-LIB036] AddressLine elements not allowed for a StructuredLax address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (not(cbc:ID) or cbc:ID = '')</Pattern>
<Description>[F-LIB037] ID is required for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredID') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0' or count(cac:Country) != '0')</Pattern>
<Description>[F-LIB038] Only the ID is used for a StructuredID address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and ((not(cac:Country/cbc:IdentificationCode) or cac:Country/cbc:IdentificationCode = '') and (not(cbc:Region) or cbc:Region = '') and (not(cbc:District) or cbc:District = ''))</Pattern>
<Description>[F-LIB039] Region or District or Country/IdentificationCode is required for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:AddressFormatCode = 'StructuredRegion') and (count(cbc:StreetName) != '0' or count(cbc:BuildingNumber) != '0' or count(cbc:CityName) != '0' or count(cbc:PostalZone) != '0')</Pattern>
<Description>[F-LIB040] Only Region, District, and/or Country/IdentificationCode can be used for a StructuredRegion address type</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(string-length(cbc:ID/@schemeID)&gt;0)</Pattern>
<Description>[F-LIB028] When ID is used under Address the attribute schemeID is used to give an addressregister</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID and not(cbc:ID/@schemeID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID and not(cbc:ID/@schemeID)</Pattern>
<Description>[F-LIB029] schemeID attribute must be present on an address ID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:Postbox and not(number(cbc:Postbox)=((cbc:Postbox + 1)-1))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:Postbox and not(number(cbc:Postbox)=((cbc:Postbox + 1)-1))</Pattern>
<Description>[F-LIB030] The value of Postbox must always be a number</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:RecipientParty/cac:PartyTaxScheme" priority="3970" mode="M17">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TaxLevelCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TaxLevelCode) = 0</Pattern>
<Description>[F-LIB192] TaxLevelCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID != ''</Pattern>
<Description>[F-LIB193] Invalid CompanyID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID/@schemeID = 'DK:SE' or cbc:CompanyID/@schemeID = 'ZZZ' " />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID/@schemeID = 'DK:SE' or cbc:CompanyID/@schemeID = 'ZZZ'</Pattern>
<Description>[F-LIB195] Invalid schemeID. Must be a valid scheme for PartyTaxScheme/CompanyID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:SE') and (string-length(cbc:CompanyID) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:SE') and (string-length(cbc:CompanyID) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB196] schemeID = DK:SE, CompanyID must be a valid SE number (DK12345678)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:RecipientParty/cac:PartyTaxScheme/cac:TaxScheme" priority="3969" mode="M17">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:ID) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:ID) = 0</Pattern>
<Description>[F-LIB041] ID element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:AddressTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:AddressTypeCode) = 0</Pattern>
<Description>[F-LIB042] AddressTypeCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Postbox) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Postbox) = 0</Pattern>
<Description>[F-LIB043] Postbox element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Floor) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Floor) = 0</Pattern>
<Description>[F-LIB044] Floor element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Room) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Room) = 0</Pattern>
<Description>[F-LIB045] Room element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:StreetName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:StreetName) = 0</Pattern>
<Description>[F-LIB046] StreetName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:AdditionalStreetName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:AdditionalStreetName) = 0</Pattern>
<Description>[F-LIB047] AdditionalStreetName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BlockName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BlockName) = 0</Pattern>
<Description>[F-LIB048] BlockName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BuildingName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BuildingName) = 0</Pattern>
<Description>[F-LIB049] BuildingName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:BuildingNumber) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:BuildingNumber) = 0</Pattern>
<Description>[F-LIB050] BuildingNumber element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:InhouseMail) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:InhouseMail) = 0</Pattern>
<Description>[F-LIB051] InhouseMail element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:Department) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:Department) = 0</Pattern>
<Description>[F-LIB052] Department element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:MarkAttention) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:MarkAttention) = 0</Pattern>
<Description>[F-LIB053] MarkAttention element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:MarkCare) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:MarkCare) = 0</Pattern>
<Description>[F-LIB054] MarkCare element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:PlotIdentification) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:PlotIdentification) = 0</Pattern>
<Description>[F-LIB055] PlotIdentification element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CitySubdivisionName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CitySubdivisionName) = 0</Pattern>
<Description>[F-LIB056] CitySubdivisionName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CityName) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CityName) = 0</Pattern>
<Description>[F-LIB057] CityName element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:PostalZone) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:PostalZone) = 0</Pattern>
<Description>[F-LIB058] PostalZone element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CountrySubentity) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CountrySubentity) = 0</Pattern>
<Description>[F-LIB059] CountrySubentity element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:CountrySubentityCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:CountrySubentityCode) = 0</Pattern>
<Description>[F-LIB060] CountrySubentityCode element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cbc:TimezoneOffset) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cbc:TimezoneOffset) = 0</Pattern>
<Description>[F-LIB063] TimezoneOffset element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cac:AddressLine) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cac:AddressLine) = 0</Pattern>
<Description>[F-LIB234] AddressLine class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:JurisdictionRegionAddress/cac:LocationCoordinate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:JurisdictionRegionAddress/cac:LocationCoordinate) = 0</Pattern>
<Description>[F-LIB064] LocationCoordinate class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:ID = '63') and cbc:TaxTypeCode">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID = '63') and cbc:TaxTypeCode</Pattern>
<Description>[F-LIB067] TaxTypeCode is not allowed when TaxScheme/ID equals '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID != ''</Pattern>
<Description>[F-LIB065] Invalid ID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:Name != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:Name != ''</Pattern>
<Description>[F-LIB066] Invalid Name. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:ID != '63') and not(cbc:TaxTypeCode)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID != '63') and not(cbc:TaxTypeCode)</Pattern>
<Description>[F-LIB197] TaxTypeCode is mandatory when TaxScheme/ID is different from '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeID = $TaxScheme_schemeID or cbc:ID/@schemeID = $TaxScheme2_schemeID" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeID = $TaxScheme_schemeID or cbc:ID/@schemeID = $TaxScheme2_schemeID</Pattern>
<Description>[F-LIB070] Invalid schemeID. Must be '<xsl:text />
<xsl:value-of select="$TaxScheme_schemeID" />
<xsl:text />' or '<xsl:text />
<xsl:value-of select="$TaxScheme2_schemeID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:TaxTypeCode) and not(cbc:TaxTypeCode/@listID = 'urn:oioubl:codelist:taxtypecode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:TaxTypeCode) and not(cbc:TaxTypeCode/@listID = 'urn:oioubl:codelist:taxtypecode-1.1')</Pattern>
<Description>[F-LIB071] Invalid listID. Must be 'urn:oioubl:codelist:taxtypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID = '63') and cbc:Name != 'Moms'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID = '63') and cbc:Name != 'Moms'</Pattern>
<Description>[F-LIB198] Name must equal 'Moms' when  TaxScheme/ID equals '63' (Moms)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:ID != '63') and cbc:Name = 'Moms'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:ID != '63') and cbc:Name = 'Moms'</Pattern>
<Description>[F-LIB199] Name must correspond to the value of TaxScheme/ID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cac:JurisdictionRegionAddress) and cac:JurisdictionRegionAddress/cbc:AddressFormatCode != 'StructuredRegion'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cac:JurisdictionRegionAddress) and cac:JurisdictionRegionAddress/cbc:AddressFormatCode != 'StructuredRegion'</Pattern>
<Description>[F-LIB233] The AddressFormatCode under JurisdictionRegionAddress must always equal 'StructuredRegion'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:RecipientParty/cac:PartyLegalEntity" priority="3968" mode="M17">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:CorporateRegistrationScheme) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:CorporateRegistrationScheme) = 0</Pattern>
<Description>[F-LIB186] CorporateRegistrationScheme class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID != ''</Pattern>
<Description>[F-LIB187] Invalid CompanyID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:CompanyID/@schemeID = 'DK:CVR' or cbc:CompanyID/@schemeID = 'DK:CPR' or cbc:CompanyID/@schemeID = 'ZZZ'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CompanyID/@schemeID = 'DK:CVR' or cbc:CompanyID/@schemeID = 'DK:CPR' or cbc:CompanyID/@schemeID = 'ZZZ'</Pattern>
<Description>[F-LIB189] Invalid schemeID. Must be a valid scheme for PartyLegalEntity/CompanyID</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:CVR') and (string-length(cbc:CompanyID) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:CVR') and (string-length(cbc:CompanyID) != 10 or substring(cbc:CompanyID, 1, 2) != 'DK')</Pattern>
<Description>[F-LIB190] schemeID = DK:CVR, CompanyID must be a valid CVR number (DK12345678)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:CompanyID/@schemeID = 'DK:CPR') and not(string-length(cbc:CompanyID) = 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:CompanyID/@schemeID = 'DK:CPR') and not(string-length(cbc:CompanyID) = 10)</Pattern>
<Description>[F-LIB191] schemeID = DK:CPR, CompanyID must be a valid CPR number (1234560000)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:RecipientParty/cac:Contact" priority="3967" mode="M17">

		<!--REPORT -->
<xsl:if test="(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:ID) or cbc:ID = '') and (not(cbc:Name) or cbc:Name = '') and (not(cbc:Telephone) or cbc:Telephone = '') and (not(cbc:Telefax) or cbc:Telefax = '') and (not(cbc:ElectronicMail) or cbc:ElectronicMail = '') and (not(cbc:Note) or cbc:Note = '') and not(cac:OtherCommunication)</Pattern>
<Description>[F-LIB235] At least one field should be specified</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication/cbc:ChannelCode and cac:OtherCommunication/cbc:Channel</Pattern>
<Description>[F-LIB236] Use either ChannelCode or Channel</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:OtherCommunication and not(cac:OtherCommunication/cbc:Value != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:OtherCommunication and not(cac:OtherCommunication/cbc:Value != '')</Pattern>
<Description>[F-LIB237] Invalid Value. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:RecipientParty/cac:Person" priority="3966" mode="M17">

		<!--REPORT -->
<xsl:if test="(not(cbc:FamilyName) or cbc:FamilyName = '') and (not(cbc:FirstName) or cbc:FirstName = '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(not(cbc:FamilyName) or cbc:FamilyName = '') and (not(cbc:FirstName) or cbc:FirstName = '')</Pattern>
<Description>[F-LIB024] There must be a FirstName if the FamilyName is not present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:LineResponse" priority="3965" mode="M17">

		<!--REPORT -->
<xsl:if test="count(cac:Response) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:Response) &gt; 1</Pattern>
<Description>[F-APR051] No more than one Response class may be present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:LineResponse/cac:LineReference" priority="3964" mode="M17">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:DocumentReference) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:DocumentReference) = 0</Pattern>
<Description>[F-APR029] DocumentReference class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:LineID != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:LineID != ''</Pattern>
<Description>[F-APR030] Invalid LineID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:UUID and not(string-length(string(cbc:UUID)) = 36)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:UUID and not(string-length(string(cbc:UUID)) = 36)</Pattern>
<Description>[F-APR031] Invalid UUID. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:LineResponse/cac:Response" priority="3963" mode="M17">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ResponseCode != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ResponseCode != ''</Pattern>
<Description>[F-APR032] Invalid ResponseCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ReferenceID != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ReferenceID != ''</Pattern>
<Description>[F-APR033] Invalid ReferenceID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:LineResponse/cac:Response/cbc:ResponseCode" priority="3962" mode="M17">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="./@listID = 'urn:oioubl:codelist:lineresponsecode-1.1'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>./@listID = 'urn:oioubl:codelist:lineresponsecode-1.1'</Pattern>
<Description>[W-APR034] Invalid listID. Must be 'urn:oioubl:codelist:lineresponsecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="./@listAgencyID = '320'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>./@listAgencyID = '320'</Pattern>
<Description>[W-APR052] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test=". = 'BusinessReject' or . = 'BusinessAccept'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>. = 'BusinessReject' or . = 'BusinessAccept'</Pattern>
<Description>[F-APR035] Invalid ResponseCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:ApplicationResponse/cac:DocumentResponse/cac:LineResponse/cac:Response/cbc:Description" priority="3961" mode="M17">

		<!--REPORT -->
<xsl:if test="count(../cbc:Description) &gt; 1 and not(./@languageID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cbc:Description) &gt; 1 and not(./@languageID)</Pattern>
<Description>[W-LIB222] The attribute languageID should be used when more than one Description element is present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(following-sibling::*) = local-name(current()) and following-sibling::*/@languageID = self::*/@languageID</Pattern>
<Description>[W-LIB223] Multilanguage error. Replicated Description elements with same languageID attribute value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M17" />
<xsl:template match="@*|node()" priority="-2" mode="M17">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M17" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M17" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>
</xsl:stylesheet>
