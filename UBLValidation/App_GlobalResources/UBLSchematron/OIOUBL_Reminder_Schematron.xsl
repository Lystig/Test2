<?xml version="1.0" encoding="UTF-16" standalone="yes"?>
<xsl:stylesheet doc:dummy-for-xmlns="" cac:dummy-for-xmlns="" cbc:dummy-for-xmlns="" ccts:dummy-for-xmlns="" sdt:dummy-for-xmlns="" udt:dummy-for-xmlns="" xs:dummy-for-xmlns="" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sch="http://www.ascc.net/xml/schematron" xmlns:iso="http://purl.oclc.org/dsdl/schematron" xmlns:doc="urn:oasis:names:specification:ubl:schema:xsd:Reminder-2" xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" xmlns:ccts="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2" xmlns:sdt="urn:oasis:names:specification:ubl:schema:xsd:SpecializedDatatypes-2" xmlns:udt="urn:un:unece:uncefact:data:specification:UnqualifiedDataTypesSchemaModule:2" xmlns:xs="http://www.w3.org/2001/XMLSchema">
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
<Information>Checking OIOUBL-2.02 Reminder, FC 2010-09-15, Version 1.2</Information>
<xsl:apply-templates select="/" mode="M9" /><xsl:apply-templates select="/" mode="M11" /><xsl:apply-templates select="/" mode="M12" /><xsl:apply-templates select="/" mode="M13" /><xsl:apply-templates select="/" mode="M14" /><xsl:apply-templates select="/" mode="M15" /><xsl:apply-templates select="/" mode="M16" /><xsl:apply-templates select="/" mode="M17" /><xsl:apply-templates select="/" mode="M18" /><xsl:apply-templates select="/" mode="M19" /><xsl:apply-templates select="/" mode="M20" /><xsl:apply-templates select="/" mode="M21" /><xsl:apply-templates select="/" mode="M22" /><xsl:apply-templates select="/" mode="M24" /><xsl:apply-templates select="/" mode="M25" /><xsl:apply-templates select="/" mode="M26" /><xsl:apply-templates select="/" mode="M27" /><xsl:apply-templates select="/" mode="M28" /><xsl:apply-templates select="/" mode="M29" /><xsl:apply-templates select="/" mode="M30" /><xsl:apply-templates select="/" mode="M31" />
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
<xsl:when test="local-name(*) = 'Reminder'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>local-name(*) = 'Reminder'</Pattern>
<Description>[F-REM001] Root element must be Reminder</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M12" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder" priority="3998" mode="M12">

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

<!--PATTERN reminder-->


	<!--RULE -->
<xsl:template match="doc:Reminder" priority="3999" mode="M13">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TaxPointDate) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TaxPointDate) = 0</Pattern>
<Description>[F-REM002] TaxPointDate element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:LineCountNumeric) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:LineCountNumeric) = 0</Pattern>
<Description>[F-REM003] LineCountNumeric element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:TaxRepresentativeParty) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:TaxRepresentativeParty) = 0</Pattern>
<Description>[F-REM004] TaxRepresentativeParty class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ReminderTypeCode != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ReminderTypeCode != ''</Pattern>
<Description>[F-REM006] Invalid ReminderTypeCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ReminderSequenceNumeric != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ReminderSequenceNumeric != ''</Pattern>
<Description>[F-REM007] Invalid ReminderSequenceNumeric. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:DocumentCurrencyCode != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:DocumentCurrencyCode != ''</Pattern>
<Description>[F-REM008] Invalid DocumentCurrencyCode. Must contain a value</Description>
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
<Description>[F-REM010] Invalid ID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ReminderTypeCode/@listID = 'urn:oioubl.codelist:remindertypecode-1.1'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ReminderTypeCode/@listID = 'urn:oioubl.codelist:remindertypecode-1.1'</Pattern>
<Description>[F-REM059] Invalid listID. Must be 'urn:oioubl.codelist:remindertypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ReminderTypeCode/@listAgencyID = '320'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ReminderTypeCode/@listAgencyID = '320'</Pattern>
<Description>[F-REM060] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ReminderTypeCode = 'Reminder' or cbc:ReminderTypeCode = 'Advis'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ReminderTypeCode = 'Reminder' or cbc:ReminderTypeCode = 'Advis'</Pattern>
<Description>[F-REM061] Invalid ReminderTypeCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AccountingCost and cbc:AccountingCostCode">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AccountingCost and cbc:AccountingCostCode</Pattern>
<Description>[F-LIB021] Use either AccountingCost or AccountingCostCode</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(cac:ReminderPeriod) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:ReminderPeriod) &gt; 1</Pattern>
<Description>[F-REM070] No more than one ReminderPeriod class may be present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M13" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cbc:UUID" priority="3998" mode="M13">

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
<xsl:template match="doc:Reminder/cbc:Note" priority="3997" mode="M13">

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

	<!--RULE -->
<xsl:template match="doc:Reminder/cbc:DocumentCurrencyCode" priority="3996" mode="M13">

		<!--REPORT -->
<xsl:if test="/*/cac:ReminderLine/cbc:DebitLineAmount[@currencyID][@currencyID!=string(current())]">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>/*/cac:ReminderLine/cbc:DebitLineAmount[@currencyID][@currencyID!=string(current())]</Pattern>
<Description>[F-REM067] There is a DebitLineAmount for one or more Reminder lines where the currencyID does not equal the DocumentCurrencyCode</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="/*/cac:ReminderLine/cbc:CreditLineAmount[@currencyID][@currencyID!=string(current())]">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>/*/cac:ReminderLine/cbc:CreditLineAmount[@currencyID][@currencyID!=string(current())]</Pattern>
<Description>[F-REM068] There is a CreditLineAmount for one or more Reminder lines where the currencyID does not equal the DocumentCurrencyCode</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="/*/cac:LegalMonetaryTotal/cbc:LineExtensionAmount[@currencyID][@currencyID!=string(current())]">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>/*/cac:LegalMonetaryTotal/cbc:LineExtensionAmount[@currencyID][@currencyID!=string(current())]</Pattern>
<Description>[F-REM065] There is a LineExtensionAmount where the currencyID does not equal the DocumentCurrencyCode</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="/*/cac:LegalMonetaryTotal/cbc:PayableAmount[@currencyID][@currencyID!=string(current())]">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>/*/cac:LegalMonetaryTotal/cbc:PayableAmount[@currencyID][@currencyID!=string(current())]</Pattern>
<Description>[F-REM066] There is a PayableAmount where the currencyID does not equal the DocumentCurrencyCode</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="./@listID and ./@listID != $CurrencyCode_listID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>./@listID and ./@listID != $CurrencyCode_listID</Pattern>
<Description>[F-LIB296] Invalid listID. Must be '<xsl:text />
<xsl:value-of select="$CurrencyCode_listID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="./@listAgencyID and ./@listAgencyID != $CurrencyCode_agencyID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>./@listAgencyID and ./@listAgencyID != $CurrencyCode_agencyID</Pattern>
<Description>[F-LIB297] Invalid listAgencyID. Must be '<xsl:text />
<xsl:value-of select="$CurrencyCode_agencyID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="contains($CurrencyCode, concat(',',.,','))" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>contains($CurrencyCode, concat(',',.,','))</Pattern>
<Description>[F-LIB298] Invalid CurrencyCode: '<xsl:text />
<xsl:value-of select="." />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M13" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cbc:TaxCurrencyCode" priority="3995" mode="M13">

		<!--REPORT -->
<xsl:if test="//cbc:TaxAmount[@currencyID][@currencyID!=string(current())]">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>//cbc:TaxAmount[@currencyID][@currencyID!=string(current())]</Pattern>
<Description>[F-REM011] There is a TaxAmount where the currencyID does not equal the TaxCurrencyCode</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test=".='DKK' or . ='EUR'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>.='DKK' or . ='EUR'</Pattern>
<Description>[F-REM012] TaxCurrencyCode must be either DKK or EUR</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(/*/cac:TaxExchangeRate) != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(/*/cac:TaxExchangeRate) != 0</Pattern>
<Description>[F-REM013] One TaxExchangeRate class must be present when TaxCurrencyCode element is used</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(/*/cac:TaxTotal/cac:TaxSubtotal/cbc:TransactionCurrencyTaxAmount) != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(/*/cac:TaxTotal/cac:TaxSubtotal/cbc:TransactionCurrencyTaxAmount) != 0</Pattern>
<Description>[F-REM014] One TransactionCurrencyTaxAmount element must be present when TaxCurrencyCode element is used</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M13" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cbc:PricingCurrencyCode" priority="3994" mode="M13">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(/*/cac:PricingExchangeRate) != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(/*/cac:PricingExchangeRate) != 0</Pattern>
<Description>[F-REM062] One PricingExchangeRate class must be present when PricingCurrencyCode element is used</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="./@listID and ./@listID != $CurrencyCode_listID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>./@listID and ./@listID != $CurrencyCode_listID</Pattern>
<Description>[F-LIB296] Invalid listID. Must be '<xsl:text />
<xsl:value-of select="$CurrencyCode_listID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="./@listAgencyID and ./@listAgencyID != $CurrencyCode_agencyID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>./@listAgencyID and ./@listAgencyID != $CurrencyCode_agencyID</Pattern>
<Description>[F-LIB297] Invalid listAgencyID. Must be '<xsl:text />
<xsl:value-of select="$CurrencyCode_agencyID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="contains($CurrencyCode, concat(',',.,','))" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>contains($CurrencyCode, concat(',',.,','))</Pattern>
<Description>[F-LIB298] Invalid CurrencyCode: '<xsl:text />
<xsl:value-of select="." />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M13" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cbc:PaymentCurrencyCode" priority="3993" mode="M13">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(/*/cac:PaymentExchangeRate) != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(/*/cac:PaymentExchangeRate) != 0</Pattern>
<Description>[F-REM063] One PaymentExchangeRate class must be present when PaymentCurrencyCode element is used</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="./@listID and ./@listID != $CurrencyCode_listID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>./@listID and ./@listID != $CurrencyCode_listID</Pattern>
<Description>[F-LIB296] Invalid listID. Must be '<xsl:text />
<xsl:value-of select="$CurrencyCode_listID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="./@listAgencyID and ./@listAgencyID != $CurrencyCode_agencyID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>./@listAgencyID and ./@listAgencyID != $CurrencyCode_agencyID</Pattern>
<Description>[F-LIB297] Invalid listAgencyID. Must be '<xsl:text />
<xsl:value-of select="$CurrencyCode_agencyID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="contains($CurrencyCode, concat(',',.,','))" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>contains($CurrencyCode, concat(',',.,','))</Pattern>
<Description>[F-LIB298] Invalid CurrencyCode: '<xsl:text />
<xsl:value-of select="." />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M13" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cbc:PaymentAlternativeCurrencyCode" priority="3992" mode="M13">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(/*/cac:PaymentAlternativeExchangeRate) != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(/*/cac:PaymentAlternativeExchangeRate) != 0</Pattern>
<Description>[F-REM064] One PaymentAlternativeExchangeRate class must be present when PaymentAlternativeCurrencyCode element is used</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="./@listID and ./@listID != $CurrencyCode_listID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>./@listID and ./@listID != $CurrencyCode_listID</Pattern>
<Description>[F-LIB296] Invalid listID. Must be '<xsl:text />
<xsl:value-of select="$CurrencyCode_listID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="./@listAgencyID and ./@listAgencyID != $CurrencyCode_agencyID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>./@listAgencyID and ./@listAgencyID != $CurrencyCode_agencyID</Pattern>
<Description>[F-LIB297] Invalid listAgencyID. Must be '<xsl:text />
<xsl:value-of select="$CurrencyCode_agencyID" />
<xsl:text />'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="contains($CurrencyCode, concat(',',.,','))" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>contains($CurrencyCode, concat(',',.,','))</Pattern>
<Description>[F-LIB298] Invalid CurrencyCode: '<xsl:text />
<xsl:value-of select="." />
<xsl:text />'. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
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

<!--PATTERN reminderperiod-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderPeriod" priority="3999" mode="M14">

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
<xsl:template match="doc:Reminder/cac:ReminderPeriod/cbc:Description" priority="3998" mode="M14">

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

<!--PATTERN additionaldocumentreference-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AdditionalDocumentReference" priority="3999" mode="M15">

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

<!--PATTERN signature-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:Signature" priority="3999" mode="M16">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID != ''</Pattern>
<Description>[F-REM015] Invalid ID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M16" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:Signature/cac:SignatoryParty" priority="3998" mode="M16">

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
<Description>[F-REM069] No more than one PartyLegalEntity class may be present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M16" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:Signature/cac:SignatoryParty/cac:PartyIdentification" priority="3997" mode="M16">

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
<xsl:template match="doc:Reminder/cac:Signature/cac:SignatoryParty/cac:PartyName" priority="3996" mode="M16">

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
<xsl:template match="doc:Reminder/cac:Signature/cac:SignatoryParty/cac:PostalAddress" priority="3995" mode="M16">

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
<xsl:template match="doc:Reminder/cac:Signature/cac:SignatoryParty/cac:PhysicalLocation" priority="3994" mode="M16">

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
<xsl:template match="doc:Reminder/cac:Signature/cac:SignatoryParty/cac:PhysicalLocation/cac:ValidityPeriod" priority="3993" mode="M16">

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
<xsl:template match="doc:Reminder/cac:Signature/cac:SignatoryParty/cac:PhysicalLocation/cac:ValidityPeriod/cbc:Description" priority="3992" mode="M16">

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
<xsl:template match="doc:Reminder/cac:Signature/cac:SignatoryParty/cac:PhysicalLocation/cac:Address" priority="3991" mode="M16">

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
<xsl:template match="doc:Reminder/cac:Signature/cac:SignatoryParty/cac:PartyTaxScheme" priority="3990" mode="M16">

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
<xsl:template match="doc:Reminder/cac:Signature/cac:SignatoryParty/cac:PartyTaxScheme/cac:TaxScheme" priority="3989" mode="M16">

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
<xsl:template match="doc:Reminder/cac:Signature/cac:SignatoryParty/cac:PartyLegalEntity" priority="3988" mode="M16">

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
<xsl:template match="doc:Reminder/cac:Signature/cac:SignatoryParty/cac:Contact" priority="3987" mode="M16">

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
<xsl:template match="doc:Reminder/cac:Signature/cac:SignatoryParty/cac:Person" priority="3986" mode="M16">

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

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:Signature/cac:DigitalSignatureAttachment" priority="3985" mode="M16">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M16" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:Signature/cac:OriginalDocumentReference" priority="3984" mode="M16">

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

<!--PATTERN accountingsupplierparty-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty" priority="3999" mode="M17">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DataSendingCapability) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DataSendingCapability) = 0</Pattern>
<Description>[F-REM016] DataSendingCapability element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:Party) = 1" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:Party) = 1</Pattern>
<Description>[F-REM017] Party class must be present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty/cac:Party" priority="3998" mode="M17">

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
<Description>[F-REM018] Invalid EndpointID. Must contain a value</Description>
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
<Description>[F-REM021] One PartyLegalEntity class must be present</Description>
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
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification" priority="3997" mode="M17">

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
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty/cac:Party/cac:PartyName" priority="3996" mode="M17">

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
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress" priority="3995" mode="M17">

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
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation" priority="3994" mode="M17">

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
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:ValidityPeriod" priority="3993" mode="M17">

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
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:ValidityPeriod/cbc:Description" priority="3992" mode="M17">

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
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address" priority="3991" mode="M17">

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
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme" priority="3990" mode="M17">

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
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme" priority="3989" mode="M17">

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
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity" priority="3988" mode="M17">

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
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty/cac:Party/cac:Contact" priority="3987" mode="M17">

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
<xsl:template match="doc:Reminder/cac:AccountingSupplierParty/cac:Party/cac:Person" priority="3986" mode="M17">

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
<xsl:template match="doc:Reminder/cac:SellerSupplierParty/cac:DespatchContact" priority="3985" mode="M17">

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
<xsl:template match="doc:Reminder/cac:SellerSupplierParty/cac:AccountingContact" priority="3984" mode="M17">

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
<xsl:template match="doc:Reminder/cac:SellerSupplierParty/cac:SellerContact" priority="3983" mode="M17">

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

<!--PATTERN accountingcustomerparty-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty" priority="3999" mode="M18">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:Party) = 1" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:Party) = 1</Pattern>
<Description>[F-REM024] One Party class must be present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:Party" priority="3998" mode="M18">

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
<Description>[F-REM025] Invalid EndpointID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:Contact) = 1" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:Contact) = 1</Pattern>
<Description>[F-REM071] One Contact class must be present</Description>
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
<Description>[F-REM093] No more than one PartyLegalEntity class may be present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification" priority="3997" mode="M18">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:Party/cac:PartyName" priority="3996" mode="M18">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress" priority="3995" mode="M18">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation" priority="3994" mode="M18">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:ValidityPeriod" priority="3993" mode="M18">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:ValidityPeriod/cbc:Description" priority="3992" mode="M18">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address" priority="3991" mode="M18">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme" priority="3990" mode="M18">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme" priority="3989" mode="M18">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity" priority="3988" mode="M18">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:Party/cac:Contact" priority="3987" mode="M18">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:Party/cac:Person" priority="3986" mode="M18">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:DeliveryContact" priority="3985" mode="M18">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:AccountingContact" priority="3984" mode="M18">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AccountingCustomerParty/cac:BuyerContact" priority="3983" mode="M18">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M18" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M18" />
<xsl:template match="@*|node()" priority="-2" mode="M18">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M18" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M18" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN payeeparty-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PayeeParty" priority="3999" mode="M19">

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
<Description>[F-REM034] Invalid EndpointID. Must contain a value</Description>
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
<Description>[F-REM072] No more than one PartyLegalEntity class may be present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PayeeParty/cac:PartyIdentification" priority="3998" mode="M19">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PayeeParty/cac:PartyName" priority="3997" mode="M19">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PayeeParty/cac:PostalAddress" priority="3996" mode="M19">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PayeeParty/cac:PhysicalLocation" priority="3995" mode="M19">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PayeeParty/cac:PhysicalLocation/cac:ValidityPeriod" priority="3994" mode="M19">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PayeeParty/cac:PhysicalLocation/cac:ValidityPeriod/cbc:Description" priority="3993" mode="M19">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PayeeParty/cac:PhysicalLocation/cac:Address" priority="3992" mode="M19">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PayeeParty/cac:PartyTaxScheme" priority="3991" mode="M19">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PayeeParty/cac:PartyTaxScheme/cac:TaxScheme" priority="3990" mode="M19">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PayeeParty/cac:PartyLegalEntity" priority="3989" mode="M19">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PayeeParty/cac:Contact" priority="3988" mode="M19">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PayeeParty/cac:Person" priority="3987" mode="M19">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M19" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M19" />
<xsl:template match="@*|node()" priority="-2" mode="M19">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M19" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M19" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN paymentmeans-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentMeans" priority="3999" mode="M20">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:CardAccount) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:CardAccount) = 0</Pattern>
<Description>[F-LIB242] CardAccount class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:PayerFinancialAccount/cac:FinancialInstitutionBranch/cac:Address) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:PayerFinancialAccount/cac:FinancialInstitutionBranch/cac:Address) = 0</Pattern>
<Description>[F-LIB151] Address class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:PayerFinancialAccount/cac:Country) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:PayerFinancialAccount/cac:Country) = 0</Pattern>
<Description>[F-LIB162] Country class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cac:Address) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cac:Address) = 0</Pattern>
<Description>[F-LIB243] Address class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:PayeeFinancialAccount/cac:Country) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:PayeeFinancialAccount/cac:Country) = 0</Pattern>
<Description>[F-LIB244] Country class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:PaymentMeansCode = '1' or cbc:PaymentMeansCode = '10' or cbc:PaymentMeansCode = '20' or cbc:PaymentMeansCode = '31' or cbc:PaymentMeansCode = '42' or cbc:PaymentMeansCode = '48' or cbc:PaymentMeansCode = '49' or cbc:PaymentMeansCode = '50' or cbc:PaymentMeansCode = '93' or cbc:PaymentMeansCode = '97'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PaymentMeansCode = '1' or cbc:PaymentMeansCode = '10' or cbc:PaymentMeansCode = '20' or cbc:PaymentMeansCode = '31' or cbc:PaymentMeansCode = '42' or cbc:PaymentMeansCode = '48' or cbc:PaymentMeansCode = '49' or cbc:PaymentMeansCode = '50' or cbc:PaymentMeansCode = '93' or cbc:PaymentMeansCode = '97'</Pattern>
<Description>[F-LIB100] Invalid PaymentMeansCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="count(../cac:PaymentMeans) &gt; 1 and not(cbc:ID != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cac:PaymentMeans) &gt; 1 and not(cbc:ID != '')</Pattern>
<Description>[W-LIB241]: ID should be used when more than one instance of the PaymentMeans class is present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:PayerFinancialAccount/cbc:AccountTypeCode and not(cac:PayerFinancialAccount/cbc:AccountTypeCode/@listID = 'urn:oioubl:codelist:accounttypecode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:PayerFinancialAccount/cbc:AccountTypeCode and not(cac:PayerFinancialAccount/cbc:AccountTypeCode/@listID = 'urn:oioubl:codelist:accounttypecode-1.1')</Pattern>
<Description>[F-LIB105] Invalid listID. Must be 'urn:oioubl:codelist:accounttypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:PayerFinancialAccount/cbc:AccountTypeCode and not(cac:PayerFinancialAccount/cbc:AccountTypeCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:PayerFinancialAccount/cbc:AccountTypeCode and not(cac:PayerFinancialAccount/cbc:AccountTypeCode/@listAgencyID = '320')</Pattern>
<Description>[W-LIB121] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:PayeeFinancialAccount/cbc:AccountTypeCode and not(cac:PayeeFinancialAccount/cbc:AccountTypeCode/@listID = 'urn:oioubl:codelist:accounttypecode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:PayeeFinancialAccount/cbc:AccountTypeCode and not(cac:PayeeFinancialAccount/cbc:AccountTypeCode/@listID = 'urn:oioubl:codelist:accounttypecode-1.1')</Pattern>
<Description>[F-LIB136] Invalid listID. Must be 'urn:oioubl:codelist:accounttypecode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:PayeeFinancialAccount/cbc:AccountTypeCode and not(cac:PayeeFinancialAccount/cbc:AccountTypeCode/@listAgencyID = '320')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:PayeeFinancialAccount/cbc:AccountTypeCode and not(cac:PayeeFinancialAccount/cbc:AccountTypeCode/@listAgencyID = '320')</Pattern>
<Description>[W-LIB141] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31') and cbc:InstructionID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31') and cbc:InstructionID</Pattern>
<Description>[F-LIB102] PaymentMeansCode = 31, InstructionID element not allowed</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31') and cbc:InstructionNote">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31') and cbc:InstructionNote</Pattern>
<Description>[F-LIB103] PaymentMeansCode = 31, InstructionNote element not allowed</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31') and cbc:PaymentID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31') and cbc:PaymentID</Pattern>
<Description>[F-LIB104] PaymentMeansCode = 31, PaymentID element not allowed</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31') and not(cbc:PaymentChannelCode/@listID = 'urn:oioubl:codelist:paymentchannelcode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31') and not(cbc:PaymentChannelCode/@listID = 'urn:oioubl:codelist:paymentchannelcode-1.1')</Pattern>
<Description>[F-LIB106] PaymentMeansCode = 31, Invalid listID. Must be 'urn:oioubl:codelist:paymentchannelcode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31') and not(cac:PayeeFinancialAccount/cbc:ID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31') and not(cac:PayeeFinancialAccount/cbc:ID)</Pattern>
<Description>[F-LIB107] PaymentMeansCode = 31, ID element is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31') and not(cbc:PaymentChannelCode = 'IBAN' or cbc:PaymentChannelCode = 'ZZZ')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31') and not(cbc:PaymentChannelCode = 'IBAN' or cbc:PaymentChannelCode = 'ZZZ')</Pattern>
<Description>[F-LIB109] PaymentMeansCode = 31, PaymentChannelCode must equal IBAN or ZZZ</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31') and string-length(cac:PayerFinancialAccount/cbc:PaymentNote)&gt; 20">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31') and string-length(cac:PayerFinancialAccount/cbc:PaymentNote)&gt; 20</Pattern>
<Description>[F-LIB110] PaymentMeansCode = 31, PaymentNote must be no more than 20 characters</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31') and string-length(cac:PayeeFinancialAccount/cbc:PaymentNote)&gt; 20">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31') and string-length(cac:PayeeFinancialAccount/cbc:PaymentNote)&gt; 20</Pattern>
<Description>[F-LIB111] PaymentMeansCode = 31, PaymentNote must be no more than 20 characters</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31') and string-length(cac:CreditAccount/cbc:AccountID) &gt; 8">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31') and string-length(cac:CreditAccount/cbc:AccountID) &gt; 8</Pattern>
<Description>[F-LIB112] PaymentMeansCode = 31, AccountID must be no more than 8 characters</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'IBAN') and (cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'IBAN') and (cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID)</Pattern>
<Description>[F-LIB108] PaymentMeansCode = 31, ID element is not used, when PaymentChannelCode equals IBAN</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'IBAN') and not(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'IBAN') and not(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID)</Pattern>
<Description>[F-LIB113] PaymentMeansCode = 31, ID element is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'IBAN') and string-length(cac:PayeeFinancialAccount/cbc:ID) &gt; 34">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'IBAN') and string-length(cac:PayeeFinancialAccount/cbc:ID) &gt; 34</Pattern>
<Description>[F-LIB114] PaymentMeansCode = 31, ID must be no more than 34 characters</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'IBAN') and string-length(cac:PayeeFinancialAccount/cbc:ID) &lt; 18">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'IBAN') and string-length(cac:PayeeFinancialAccount/cbc:ID) &lt; 18</Pattern>
<Description>[F-LIB115] PaymentMeansCode = 31, ID must be at least 18 characters</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'ZZZ') and not(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'ZZZ') and not(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID)</Pattern>
<Description>[F-LIB276] PaymentMeansCode = 31, ID element is mandatory, when PaymentChannelCode equals ZZZ</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'ZZZ') and not(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:Name)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'ZZZ') and not(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:Name)</Pattern>
<Description>[F-LIB116] PaymentMeansCode = 31, Name element is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'ZZZ') and not(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '31' and cbc:PaymentChannelCode = 'ZZZ') and not(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address)</Pattern>
<Description>[F-LIB117] PaymentMeansCode = 31, Address class is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and cbc:InstructionID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and cbc:InstructionID</Pattern>
<Description>[F-LIB118] PaymentMeansCode = 42, InstructionID element not allowed</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and cbc:InstructionNote">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and cbc:InstructionNote</Pattern>
<Description>[F-LIB119] PaymentMeansCode = 42, InstructionNote element not allowed</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and cbc:PaymentID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and cbc:PaymentID</Pattern>
<Description>[F-LIB120] PaymentMeansCode = 42, PaymentID element not allowed</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and cac:CreditAccount">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and cac:CreditAccount</Pattern>
<Description>[F-LIB122] PaymentMeansCode = 42, CreditAccount class not allowed</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and not(cbc:PaymentChannelCode/@listID = 'urn:oioubl:codelist:paymentchannelcode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and not(cbc:PaymentChannelCode/@listID = 'urn:oioubl:codelist:paymentchannelcode-1.1')</Pattern>
<Description>[F-LIB123] PaymentMeansCode = 42, Invalid listID. Must be 'urn:oioubl:codelist:paymentchannelcode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and cac:PayerFinancialAccount/cac:FinancialInstitutionBranch and not(cac:PayerFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and cac:PayerFinancialAccount/cac:FinancialInstitutionBranch and not(cac:PayerFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID)</Pattern>
<Description>[F-LIB124] PaymentMeansCode = 42, ID element is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and not(cac:PayeeFinancialAccount)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and not(cac:PayeeFinancialAccount)</Pattern>
<Description>[F-LIB125] PaymentMeansCode = 42, PayeeFinancialAccount class is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and not(cac:PayeeFinancialAccount/cbc:ID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and not(cac:PayeeFinancialAccount/cbc:ID)</Pattern>
<Description>[F-LIB126] PaymentMeansCode = 42, ID element is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and not(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and not(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID)</Pattern>
<Description>[F-LIB127] PaymentMeansCode = 42, ID element is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and cbc:PaymentChannelCode != 'DK:BANK'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and cbc:PaymentChannelCode != 'DK:BANK'</Pattern>
<Description>[F-LIB128] PaymentMeansCode = 42, PaymentChannelCode must equal DK:BANK</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and string-length(cac:PayerFinancialAccount/cbc:PaymentNote)&gt; 20">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and string-length(cac:PayerFinancialAccount/cbc:PaymentNote)&gt; 20</Pattern>
<Description>[F-LIB129] PaymentMeansCode = 42, PaymentNote must be no more than 20 characters</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and string-length(cac:PayerFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID) &gt; 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and string-length(cac:PayerFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID) &gt; 4</Pattern>
<Description>[F-LIB130] PaymentMeansCode = 42, ID must be no more than 4 numerical characters</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and string-length(cac:PayeeFinancialAccount/cbc:ID)&gt; 10">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and string-length(cac:PayeeFinancialAccount/cbc:ID)&gt; 10</Pattern>
<Description>[F-LIB131] PaymentMeansCode = 42, ID must be no more than 10 characters</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and string-length(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID)&gt; 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and string-length(cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID)&gt; 4</Pattern>
<Description>[F-LIB132] PaymentMeansCode = 42, ID must be no more than 4 numerical characters</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '42') and string-length(cac:PayeeFinancialAccount/cbc:PaymentNote)&gt; 20">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '42') and string-length(cac:PayeeFinancialAccount/cbc:PaymentNote)&gt; 20</Pattern>
<Description>[F-LIB133] PaymentMeansCode = 42, PaymentNote must be no more than 20 characters</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '49') and cbc:InstructionNote">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '49') and cbc:InstructionNote</Pattern>
<Description>[F-LIB135] PaymentMeansCode = 49, InstructionNote element not allowed</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '49') and cac:CreditAccount">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '49') and cac:CreditAccount</Pattern>
<Description>[F-LIB137] PaymentMeansCode = 49, CreditAccount class not allowed</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '49') and cbc:PaymentChannelCode and cbc:InstructionID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '49') and cbc:PaymentChannelCode and cbc:InstructionID</Pattern>
<Description>[F-LIB134] PaymentMeansCode = 49, Use either PaymentChannelCode or InstructionID element</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '49') and string-length(cac:PayerFinancialAccount/cbc:PaymentNote)&gt; 20">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '49') and string-length(cac:PayerFinancialAccount/cbc:PaymentNote)&gt; 20</Pattern>
<Description>[F-LIB288] PaymentMeansCode = 49, PaymentNote must be no more than 20 characters</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode) and not(cbc:PaymentChannelCode = 'IBAN' or cbc:PaymentChannelCode = 'DK:BANK')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode) and not(cbc:PaymentChannelCode = 'IBAN' or cbc:PaymentChannelCode = 'DK:BANK')</Pattern>
<Description>[F-LIB289] PaymentMeansCode = 49, If present, PaymentChannelCode must equal IBAN or DK:BANK</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '49') and string-length(cbc:InstructionID) &gt; 60">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '49') and string-length(cbc:InstructionID) &gt; 60</Pattern>
<Description>[F-LIB140] PaymentMeansCode = 49, InstructionID must be no more than 60 characters</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode = 'DK:BANK') and (string-length(cac:PayerFinancialAccount/cbc:ID) != 10)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode = 'DK:BANK') and (string-length(cac:PayerFinancialAccount/cbc:ID) != 10)</Pattern>
<Description>[F-LIB290] PaymentMeansCode = 49, For DK:BANK, ID must be 10 characters</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode = 'DK:BANK') and (string-length(cac:PayerFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID) != 4)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode = 'DK:BANK') and (string-length(cac:PayerFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID) != 4)</Pattern>
<Description>[F-LIB291] PaymentMeansCode = 49, For DK:BANK, ID must be 4 numerical characters</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode = 'IBAN') and string-length(cac:PayerFinancialAccount/cbc:ID) &gt; 34">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode = 'IBAN') and string-length(cac:PayerFinancialAccount/cbc:ID) &gt; 34</Pattern>
<Description>[F-LIB292] PaymentMeansCode = 49, For IBAN, ID must be no more than 34 characters</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode = 'IBAN') and string-length(cac:PayerFinancialAccount/cbc:ID) &lt; 18">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode = 'IBAN') and string-length(cac:PayerFinancialAccount/cbc:ID) &lt; 18</Pattern>
<Description>[F-LIB293] PaymentMeansCode = 49, For IBAN, ID must be at least 18 characters</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode = 'IBAN') and (cac:PayerFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode = 'IBAN') and (cac:PayerFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID)</Pattern>
<Description>[F-LIB294] PaymentMeansCode = 49, ID element is not used, when PaymentChannelCode equals IBAN</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode = 'IBAN') and not(cac:PayerFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '49' and cbc:PaymentChannelCode = 'IBAN') and not(cac:PayerFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID)</Pattern>
<Description>[F-LIB295] PaymentMeansCode = 49, For IBAN, ID element is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '50') and cac:CreditAccount">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '50') and cac:CreditAccount</Pattern>
<Description>[F-LIB142] PaymentMeansCode = 50, CreditAccount class not allowed</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '50') and not(cbc:PaymentID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '50') and not(cbc:PaymentID)</Pattern>
<Description>[F-LIB144] PaymentMeansCode = 50, PaymentID element is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '50') and (cbc:PaymentID = '04' or cbc:PaymentID = '15') and not(cbc:InstructionID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '50') and (cbc:PaymentID = '04' or cbc:PaymentID = '15') and not(cbc:InstructionID)</Pattern>
<Description>[F-LIB145] PaymentMeansCode = 50, InstructionID is mandatory when PaymentID equals 04 or 15</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '50' and cbc:PaymentChannelCode) and cbc:PaymentChannelCode != 'DK:GIRO'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '50' and cbc:PaymentChannelCode) and cbc:PaymentChannelCode != 'DK:GIRO'</Pattern>
<Description>[F-LIB146] PaymentMeansCode = 50, PaymentChannelCode must equal DK:GIRO</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '50' and cbc:PaymentChannelCode) and not(cbc:PaymentChannelCode/@listID = 'urn:oioubl:codelist:paymentchannelcode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '50' and cbc:PaymentChannelCode) and not(cbc:PaymentChannelCode/@listID = 'urn:oioubl:codelist:paymentchannelcode-1.1')</Pattern>
<Description>[F-LIB143] PaymentMeansCode = 50, Invalid listID. Must be 'urn:oioubl:codelist:paymentchannelcode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '50') and not(cbc:PaymentID = '01' or cbc:PaymentID = '04' or cbc:PaymentID = '15')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '50') and not(cbc:PaymentID = '01' or cbc:PaymentID = '04' or cbc:PaymentID = '15')</Pattern>
<Description>[F-LIB147] PaymentMeansCode = 50, PaymentID must equal 01, 04 or 15</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '50') and cbc:InstructionNote and not(cbc:PaymentID = '01')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '50') and cbc:InstructionNote and not(cbc:PaymentID = '01')</Pattern>
<Description>[F-LIB148] PaymentMeansCode = 50, InstructionNote only allowed if PaymentID equals 01</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '50') and string-length(cbc:InstructionID) &gt; 16">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '50') and string-length(cbc:InstructionID) &gt; 16</Pattern>
<Description>[F-LIB149] PaymentMeansCode = 50, InstructionID must be no more than 16 characters</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '93') and not(cbc:PaymentID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '93') and not(cbc:PaymentID)</Pattern>
<Description>[F-LIB152] PaymentMeansCode = 93, PaymentID element is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '93') and (cbc:PaymentID = '71' or cbc:PaymentID = '75') and not(cbc:InstructionID)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '93') and (cbc:PaymentID = '71' or cbc:PaymentID = '75') and not(cbc:InstructionID)</Pattern>
<Description>[F-LIB153] PaymentMeansCode = 93, InstructionID is mandatory when PaymentID equals 71 or 75</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '93' and cbc:PaymentChannelCode) and cbc:PaymentChannelCode != 'DK:FIK'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '93' and cbc:PaymentChannelCode) and cbc:PaymentChannelCode != 'DK:FIK'</Pattern>
<Description>[F-LIB277] PaymentMeansCode = 93, PaymentChannelCode must equal DK:FIK</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '93' and cbc:PaymentChannelCode) and not(cbc:PaymentChannelCode/@listID = 'urn:oioubl:codelist:paymentchannelcode-1.1')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '93' and cbc:PaymentChannelCode) and not(cbc:PaymentChannelCode/@listID = 'urn:oioubl:codelist:paymentchannelcode-1.1')</Pattern>
<Description>[F-LIB278] PaymentMeansCode = 93, Invalid listID. Must be 'urn:oioubl:codelist:paymentchannelcode-1.1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '93') and cbc:InstructionNote and not(cbc:PaymentID = '73' or cbc:PaymentID = '75')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '93') and cbc:InstructionNote and not(cbc:PaymentID = '73' or cbc:PaymentID = '75')</Pattern>
<Description>[F-LIB154] PaymentMeansCode = 93, InstructionNote only allowed if PaymentID equals 71 or 75</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '93') and not(cbc:PaymentID = '71' or cbc:PaymentID = '73' or cbc:PaymentID = '75')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '93') and not(cbc:PaymentID = '71' or cbc:PaymentID = '73' or cbc:PaymentID = '75')</Pattern>
<Description>[F-LIB155] PaymentMeansCode = 93, PaymentID must equal 71, 73 or 75</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '93') and cbc:PaymentID = '71' and string-length(cbc:InstructionID) &gt; 15">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '93') and cbc:PaymentID = '71' and string-length(cbc:InstructionID) &gt; 15</Pattern>
<Description>[F-LIB156] PaymentMeansCode = 93, InstructionID must be no more than 15 characters (when PaymentID equals 71)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '93') and cbc:PaymentID = '75' and string-length(cbc:InstructionID) &gt; 16">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '93') and cbc:PaymentID = '75' and string-length(cbc:InstructionID) &gt; 16</Pattern>
<Description>[F-LIB157] PaymentMeansCode = 93, InstructionID must be no more than 16 characters (when PaymentID equals 75)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '93') and cbc:PaymentID = '73' and cbc:InstructionID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '93') and cbc:PaymentID = '73' and cbc:InstructionID</Pattern>
<Description>[F-LIB275] PaymentMeansCode = 93, InstructionID only allowed if PaymentID equals 71 or 75</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '93') and string-length(cac:CreditAccount/cbc:AccountID) != 8">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '93') and string-length(cac:CreditAccount/cbc:AccountID) != 8</Pattern>
<Description>[F-LIB305] PaymentMeansCode = 93, AccountID must be 8 characters</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '97') and cbc:PaymentChannelCode and not(cbc:PaymentChannelCode = 'DK:NEMKONTO')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '97') and cbc:PaymentChannelCode and not(cbc:PaymentChannelCode = 'DK:NEMKONTO')</Pattern>
<Description>[F-LIB158] PaymentMeansCode = 97, PaymentChannelCode element only allowed with value = "DK:NEMKONTO"</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '97') and cbc:InstructionID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '97') and cbc:InstructionID</Pattern>
<Description>[F-LIB159] PaymentMeansCode = 97, InstructionID element not allowed</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '97') and cbc:InstructionNote">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '97') and cbc:InstructionNote</Pattern>
<Description>[F-LIB160] PaymentMeansCode = 97, InstructionNote element not allowed</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '97') and cbc:PaymentID">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '97') and cbc:PaymentID</Pattern>
<Description>[F-LIB161] PaymentMeansCode = 97, PaymentID element not allowed</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '97') and cac:PayerFinancialAccount">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '97') and cac:PayerFinancialAccount</Pattern>
<Description>[F-LIB163] PaymentMeansCode = 97, PayerFinancialAccount class not allowed</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '97') and cac:PayeeFinancialAccount">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '97') and cac:PayeeFinancialAccount</Pattern>
<Description>[F-LIB164] PaymentMeansCode = 97, PayeeFinancialAccount class not allowed</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="(cbc:PaymentMeansCode = '97') and cac:CreditAccount">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:PaymentMeansCode = '97') and cac:CreditAccount</Pattern>
<Description>[F-LIB165] PaymentMeansCode = 97, CreditAccount class not allowed</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M20" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M20" />
<xsl:template match="@*|node()" priority="-2" mode="M20">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M20" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M20" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN paymentterms-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentTerms" priority="3999" mode="M21">

		<!--REPORT -->
<xsl:if test="count(../cac:PaymentTerms) &gt; 1 and not(cbc:ID != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cac:PaymentTerms) &gt; 1 and not(cbc:ID != '')</Pattern>
<Description>[W-LIB245]: ID should be used when more than one instance of the PaymentTerms class is present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ID = 'Factoring' and not(cbc:Note != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID = 'Factoring' and not(cbc:Note != '')</Pattern>
<Description>[F-LIB246] when ID equals 'Factoring', Note element is mandatory (factoring note)</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(cbc:Note) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:Note) &gt; 1</Pattern>
<Description>[F-LIB247] No more than one Note element may be present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M21" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentTerms/cbc:PaymentMeansID" priority="3998" mode="M21">
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M21" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentTerms/cbc:Amount" priority="3997" mode="M21">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-')) and . != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-')) and . != 0</Pattern>
<Description>[F-LIB019] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M21" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentTerms/cac:SettlementPeriod" priority="3996" mode="M21">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M21" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentTerms/cac:SettlementPeriod/cbc:Description" priority="3995" mode="M21">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M21" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentTerms/cac:PenaltyPeriod" priority="3994" mode="M21">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M21" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentTerms/cac:PenaltyPeriod/cbc:Description" priority="3993" mode="M21">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M21" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M21" />
<xsl:template match="@*|node()" priority="-2" mode="M21">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M21" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M21" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN prepaidpayment-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PrepaidPayment" priority="3999" mode="M22">
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M22" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M22" />
<xsl:template match="@*|node()" priority="-2" mode="M22">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M22" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M22" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PrepaidPayment/cbc:PaidAmount" priority="3977" mode="M0">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-')) and . != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-')) and . != 0</Pattern>
<Description>[F-LIB013] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(., '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(., '.')) != 2</Pattern>
<Description>[F-LIB014] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M0" />
</xsl:template>

<!--PATTERN allowancecharge-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AllowanceCharge" priority="3999" mode="M24">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:TaxTotal) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:TaxTotal) = 0</Pattern>
<Description>[F-LIB224] TaxTotal class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:PaymentMeans) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:PaymentMeans) = 0</Pattern>
<Description>[F-LIB225] PaymentMeans class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:TaxCategory) = 1" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:TaxCategory) = 1</Pattern>
<Description>[F-LIB226] One TaxCategory class must be present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:MultiplierFactorNumeric and not(cbc:BaseAmount != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:MultiplierFactorNumeric and not(cbc:BaseAmount != '')</Pattern>
<Description>[F-LIB248] When MultiplierFactorNumeric is used, BaseAmount is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="starts-with(cbc:MultiplierFactorNumeric,'-')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>starts-with(cbc:MultiplierFactorNumeric,'-')</Pattern>
<Description>[F-LIB227] MultiplierFactorNumeric must be a positive number</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:MultiplierFactorNumeric and not(format-number(cbc:Amount,'##.00') = format-number((cbc:BaseAmount * cbc:MultiplierFactorNumeric),'##.00'))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:MultiplierFactorNumeric and not(format-number(cbc:Amount,'##.00') = format-number((cbc:BaseAmount * cbc:MultiplierFactorNumeric),'##.00'))</Pattern>
<Description>[F-LIB228] Amount must equal BaseAmount * MultiplierFactorNumeric</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AccountingCost and cbc:AccountingCostCode">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AccountingCost and cbc:AccountingCostCode</Pattern>
<Description>[F-LIB021] Use either AccountingCost or AccountingCostCode</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AllowanceChargeReason and cbc:AllowanceChargeReasonCode">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AllowanceChargeReason and cbc:AllowanceChargeReasonCode</Pattern>
<Description>[F-REM094] Use either AllowanceChargeReason or AllowanceChargeReasonCode</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M24" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AllowanceCharge/cbc:AllowanceChargeReasonCode" priority="3998" mode="M24">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="./@listID = 'urn:oioubl:codelist:reminderallowancechargereasoncode-1.0'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>./@listID = 'urn:oioubl:codelist:reminderallowancechargereasoncode-1.0'</Pattern>
<Description>[W-REM095] Invalid listID. Must be 'urn:oioubl:codelist:reminderallowancechargereasoncode-1.0'</Description>
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
<Description>[W-REM096] Invalid listAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test=". = 'PenaltyFee' or . = 'PenaltyRate'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>. = 'PenaltyFee' or . = 'PenaltyRate'</Pattern>
<Description>[F-REM097] Invalid AllowanceChargeReasonCode. Must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M24" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AllowanceCharge/cbc:SequenceNumeric" priority="3997" mode="M24">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-'))" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-'))</Pattern>
<Description>[F-LIB020] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M24" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AllowanceCharge/cbc:Amount" priority="3996" mode="M24">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-')) and . != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-')) and . != 0</Pattern>
<Description>[F-LIB019] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M24" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AllowanceCharge/cbc:BaseAmount" priority="3995" mode="M24">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-')) and . != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-')) and . != 0</Pattern>
<Description>[F-LIB019] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M24" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AllowanceCharge/cac:TaxCategory" priority="3994" mode="M24">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TierRange) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TierRange) = 0</Pattern>
<Description>[F-LIB072] TierRange element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TierRatePercent) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TierRatePercent) = 0</Pattern>
<Description>[F-LIB073] TierRatePercent element must be excluded</Description>
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
<Description>[F-LIB074] Invalid ID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeID = 'urn:oioubl:id:taxcategoryid-1.1'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeID = 'urn:oioubl:id:taxcategoryid-1.1'</Pattern>
<Description>[F-LIB075] Invalid schemeID. Must be 'urn:oioubl:id:taxcategoryid-1.1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeAgencyID = '320'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeAgencyID = '320'</Pattern>
<Description>[W-LIB229] Invalid schemeAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:Name != '') and not(contains(/doc:Invoice/cbc:ProfileID, 'nesubl.eu'))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:Name != '') and not(contains(/doc:Invoice/cbc:ProfileID, 'nesubl.eu'))</Pattern>
<Description>[W-LIB230] Name should only be used within NES profiles</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PerUnitAmount and cbc:Percent">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PerUnitAmount and cbc:Percent</Pattern>
<Description>[F-LIB231] Use either PerUnitAmount or Percent</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PerUnitAmount and not(cbc:BaseUnitMeasure != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PerUnitAmount and not(cbc:BaseUnitMeasure != '')</Pattern>
<Description>[F-LIB232] When PerUnitAmount is used, BaseUnitMeasure is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M24" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:AllowanceCharge/cac:TaxCategory/cac:TaxScheme" priority="3993" mode="M24">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M24" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M24" />
<xsl:template match="@*|node()" priority="-2" mode="M24">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M24" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M24" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN taxexchangerate-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:TaxExchangeRate" priority="3999" mode="M25">

		<!--REPORT -->
<xsl:if test="cac:ForeignExchangeContract and not(cac:ForeignExchangeContract/cbc:ID != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:ForeignExchangeContract and not(cac:ForeignExchangeContract/cbc:ID != '')</Pattern>
<Description>[F-LIB238] Invalid ID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:SourceCurrencyCode != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:SourceCurrencyCode != ''</Pattern>
<Description>[F-LIB083] Invalid SourceCurrencyCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:TargetCurrencyCode != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TargetCurrencyCode != ''</Pattern>
<Description>[F-LIB084] Invalid TargetCurrencyCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:SourceCurrencyBaseRate and (starts-with(cbc:SourceCurrencyBaseRate,'-') or cbc:SourceCurrencyBaseRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:SourceCurrencyBaseRate and (starts-with(cbc:SourceCurrencyBaseRate,'-') or cbc:SourceCurrencyBaseRate = 0)</Pattern>
<Description>[F-LIB085] Invalid SourceCurrencyBaseRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:SourceCurrencyBaseRate and string-length(substring-after(cbc:SourceCurrencyBaseRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:SourceCurrencyBaseRate and string-length(substring-after(cbc:SourceCurrencyBaseRate, '.')) != 4</Pattern>
<Description>[F-LIB086] Invalid SourceCurrencyBaseRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TargetCurrencyBaseRate and (starts-with(cbc:TargetCurrencyBaseRate,'-') or cbc:TargetCurrencyBaseRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TargetCurrencyBaseRate and (starts-with(cbc:TargetCurrencyBaseRate,'-') or cbc:TargetCurrencyBaseRate = 0)</Pattern>
<Description>[F-LIB087] Invalid TargetCurrencyBaseRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TargetCurrencyBaseRate and string-length(substring-after(cbc:TargetCurrencyBaseRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TargetCurrencyBaseRate and string-length(substring-after(cbc:TargetCurrencyBaseRate, '.')) != 4</Pattern>
<Description>[F-LIB088] Invalid TargetCurrencyBaseRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:CalculationRate and (starts-with(cbc:CalculationRate,'-') or cbc:CalculationRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CalculationRate and (starts-with(cbc:CalculationRate,'-') or cbc:CalculationRate = 0)</Pattern>
<Description>[F-LIB089] Invalid CalculationRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:CalculationRate and string-length(substring-after(cbc:CalculationRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CalculationRate and string-length(substring-after(cbc:CalculationRate, '.')) != 4</Pattern>
<Description>[F-LIB090] Invalid CalculationRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:ForeignExchangeContract/cbc:ContractTypeCode and cac:ForeignExchangeContract/cbc:ContractType">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:ForeignExchangeContract/cbc:ContractTypeCode and cac:ForeignExchangeContract/cbc:ContractType</Pattern>
<Description>[F-LIB239] Use either ContractTypeCode or ContractType</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(cac:ForeignExchangeContract/cac:ContractDocumentReference) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:ForeignExchangeContract/cac:ContractDocumentReference) &gt; 1</Pattern>
<Description>[F-LIB240] No more than one ContractDocumentReference class may be present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M25" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:TaxExchangeRate/cac:ForeignExchangeContract/cac:ValidityPeriod" priority="3998" mode="M25">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M25" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:TaxExchangeRate/cac:ForeignExchangeContract/cac:ValidityPeriod/cbc:Description" priority="3997" mode="M25">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M25" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:TaxExchangeRate/cac:ForeignExchangeContract/cac:ContractDocumentReference" priority="3996" mode="M25">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentType) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentType) = 0</Pattern>
<Description>[F-LIB170] DocumentType element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentTypeCode) = 0</Pattern>
<Description>[F-LIB172] DocumentTypeCode element must be excluded</Description>
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
<Description>[F-LIB169] Use either Attachment or XPath</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference</Pattern>
<Description>[F-LIB171] Use either EmbeddedDocumentBinaryObject or ExternalReference</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:UUID and not(string-length(string(cbc:UUID)) = 36)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:UUID and not(string-length(string(cbc:UUID)) = 36)</Pattern>
<Description>[F-LIB173] Invalid UUID. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')</Pattern>
<Description>[F-LIB174] Attribute mimeCode must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')</Pattern>
<Description>[F-LIB096] When using ExternalReference, URI is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M25" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M25" />
<xsl:template match="@*|node()" priority="-2" mode="M25">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M25" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M25" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN pricingexchangerate-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PricingExchangeRate" priority="3999" mode="M26">

		<!--REPORT -->
<xsl:if test="cac:ForeignExchangeContract and not(cac:ForeignExchangeContract/cbc:ID != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:ForeignExchangeContract and not(cac:ForeignExchangeContract/cbc:ID != '')</Pattern>
<Description>[F-LIB238] Invalid ID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:SourceCurrencyCode != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:SourceCurrencyCode != ''</Pattern>
<Description>[F-LIB083] Invalid SourceCurrencyCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:TargetCurrencyCode != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TargetCurrencyCode != ''</Pattern>
<Description>[F-LIB084] Invalid TargetCurrencyCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:SourceCurrencyBaseRate and (starts-with(cbc:SourceCurrencyBaseRate,'-') or cbc:SourceCurrencyBaseRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:SourceCurrencyBaseRate and (starts-with(cbc:SourceCurrencyBaseRate,'-') or cbc:SourceCurrencyBaseRate = 0)</Pattern>
<Description>[F-LIB085] Invalid SourceCurrencyBaseRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:SourceCurrencyBaseRate and string-length(substring-after(cbc:SourceCurrencyBaseRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:SourceCurrencyBaseRate and string-length(substring-after(cbc:SourceCurrencyBaseRate, '.')) != 4</Pattern>
<Description>[F-LIB086] Invalid SourceCurrencyBaseRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TargetCurrencyBaseRate and (starts-with(cbc:TargetCurrencyBaseRate,'-') or cbc:TargetCurrencyBaseRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TargetCurrencyBaseRate and (starts-with(cbc:TargetCurrencyBaseRate,'-') or cbc:TargetCurrencyBaseRate = 0)</Pattern>
<Description>[F-LIB087] Invalid TargetCurrencyBaseRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TargetCurrencyBaseRate and string-length(substring-after(cbc:TargetCurrencyBaseRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TargetCurrencyBaseRate and string-length(substring-after(cbc:TargetCurrencyBaseRate, '.')) != 4</Pattern>
<Description>[F-LIB088] Invalid TargetCurrencyBaseRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:CalculationRate and (starts-with(cbc:CalculationRate,'-') or cbc:CalculationRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CalculationRate and (starts-with(cbc:CalculationRate,'-') or cbc:CalculationRate = 0)</Pattern>
<Description>[F-LIB089] Invalid CalculationRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:CalculationRate and string-length(substring-after(cbc:CalculationRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CalculationRate and string-length(substring-after(cbc:CalculationRate, '.')) != 4</Pattern>
<Description>[F-LIB090] Invalid CalculationRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:ForeignExchangeContract/cbc:ContractTypeCode and cac:ForeignExchangeContract/cbc:ContractType">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:ForeignExchangeContract/cbc:ContractTypeCode and cac:ForeignExchangeContract/cbc:ContractType</Pattern>
<Description>[F-LIB239] Use either ContractTypeCode or ContractType</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(cac:ForeignExchangeContract/cac:ContractDocumentReference) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:ForeignExchangeContract/cac:ContractDocumentReference) &gt; 1</Pattern>
<Description>[F-LIB240] No more than one ContractDocumentReference class may be present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M26" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PricingExchangeRate/cac:ForeignExchangeContract/cac:ValidityPeriod" priority="3998" mode="M26">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M26" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PricingExchangeRate/cac:ForeignExchangeContract/cac:ValidityPeriod/cbc:Description" priority="3997" mode="M26">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M26" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PricingExchangeRate/cac:ForeignExchangeContract/cac:ContractDocumentReference" priority="3996" mode="M26">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentType) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentType) = 0</Pattern>
<Description>[F-LIB170] DocumentType element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentTypeCode) = 0</Pattern>
<Description>[F-LIB172] DocumentTypeCode element must be excluded</Description>
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
<Description>[F-LIB169] Use either Attachment or XPath</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference</Pattern>
<Description>[F-LIB171] Use either EmbeddedDocumentBinaryObject or ExternalReference</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:UUID and not(string-length(string(cbc:UUID)) = 36)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:UUID and not(string-length(string(cbc:UUID)) = 36)</Pattern>
<Description>[F-LIB173] Invalid UUID. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')</Pattern>
<Description>[F-LIB174] Attribute mimeCode must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')</Pattern>
<Description>[F-LIB096] When using ExternalReference, URI is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M26" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M26" />
<xsl:template match="@*|node()" priority="-2" mode="M26">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M26" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M26" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN paymentexchangerate-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentExchangeRate" priority="3999" mode="M27">

		<!--REPORT -->
<xsl:if test="cac:ForeignExchangeContract and not(cac:ForeignExchangeContract/cbc:ID != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:ForeignExchangeContract and not(cac:ForeignExchangeContract/cbc:ID != '')</Pattern>
<Description>[F-LIB238] Invalid ID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:SourceCurrencyCode != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:SourceCurrencyCode != ''</Pattern>
<Description>[F-LIB083] Invalid SourceCurrencyCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:TargetCurrencyCode != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TargetCurrencyCode != ''</Pattern>
<Description>[F-LIB084] Invalid TargetCurrencyCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:SourceCurrencyBaseRate and (starts-with(cbc:SourceCurrencyBaseRate,'-') or cbc:SourceCurrencyBaseRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:SourceCurrencyBaseRate and (starts-with(cbc:SourceCurrencyBaseRate,'-') or cbc:SourceCurrencyBaseRate = 0)</Pattern>
<Description>[F-LIB085] Invalid SourceCurrencyBaseRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:SourceCurrencyBaseRate and string-length(substring-after(cbc:SourceCurrencyBaseRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:SourceCurrencyBaseRate and string-length(substring-after(cbc:SourceCurrencyBaseRate, '.')) != 4</Pattern>
<Description>[F-LIB086] Invalid SourceCurrencyBaseRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TargetCurrencyBaseRate and (starts-with(cbc:TargetCurrencyBaseRate,'-') or cbc:TargetCurrencyBaseRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TargetCurrencyBaseRate and (starts-with(cbc:TargetCurrencyBaseRate,'-') or cbc:TargetCurrencyBaseRate = 0)</Pattern>
<Description>[F-LIB087] Invalid TargetCurrencyBaseRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TargetCurrencyBaseRate and string-length(substring-after(cbc:TargetCurrencyBaseRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TargetCurrencyBaseRate and string-length(substring-after(cbc:TargetCurrencyBaseRate, '.')) != 4</Pattern>
<Description>[F-LIB088] Invalid TargetCurrencyBaseRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:CalculationRate and (starts-with(cbc:CalculationRate,'-') or cbc:CalculationRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CalculationRate and (starts-with(cbc:CalculationRate,'-') or cbc:CalculationRate = 0)</Pattern>
<Description>[F-LIB089] Invalid CalculationRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:CalculationRate and string-length(substring-after(cbc:CalculationRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CalculationRate and string-length(substring-after(cbc:CalculationRate, '.')) != 4</Pattern>
<Description>[F-LIB090] Invalid CalculationRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:ForeignExchangeContract/cbc:ContractTypeCode and cac:ForeignExchangeContract/cbc:ContractType">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:ForeignExchangeContract/cbc:ContractTypeCode and cac:ForeignExchangeContract/cbc:ContractType</Pattern>
<Description>[F-LIB239] Use either ContractTypeCode or ContractType</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(cac:ForeignExchangeContract/cac:ContractDocumentReference) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:ForeignExchangeContract/cac:ContractDocumentReference) &gt; 1</Pattern>
<Description>[F-LIB240] No more than one ContractDocumentReference class may be present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M27" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentExchangeRate/cac:ForeignExchangeContract/cac:ValidityPeriod" priority="3998" mode="M27">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M27" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentExchangeRate/cac:ForeignExchangeContract/cac:ValidityPeriod/cbc:Description" priority="3997" mode="M27">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M27" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentExchangeRate/cac:ForeignExchangeContract/cac:ContractDocumentReference" priority="3996" mode="M27">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentType) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentType) = 0</Pattern>
<Description>[F-LIB170] DocumentType element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentTypeCode) = 0</Pattern>
<Description>[F-LIB172] DocumentTypeCode element must be excluded</Description>
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
<Description>[F-LIB169] Use either Attachment or XPath</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference</Pattern>
<Description>[F-LIB171] Use either EmbeddedDocumentBinaryObject or ExternalReference</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:UUID and not(string-length(string(cbc:UUID)) = 36)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:UUID and not(string-length(string(cbc:UUID)) = 36)</Pattern>
<Description>[F-LIB173] Invalid UUID. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')</Pattern>
<Description>[F-LIB174] Attribute mimeCode must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')</Pattern>
<Description>[F-LIB096] When using ExternalReference, URI is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M27" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M27" />
<xsl:template match="@*|node()" priority="-2" mode="M27">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M27" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M27" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN paymentalternativeexchangerate-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentAlternativeExchangeRate" priority="3999" mode="M28">

		<!--REPORT -->
<xsl:if test="cac:ForeignExchangeContract and not(cac:ForeignExchangeContract/cbc:ID != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:ForeignExchangeContract and not(cac:ForeignExchangeContract/cbc:ID != '')</Pattern>
<Description>[F-LIB238] Invalid ID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:SourceCurrencyCode != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:SourceCurrencyCode != ''</Pattern>
<Description>[F-LIB083] Invalid SourceCurrencyCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:TargetCurrencyCode != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TargetCurrencyCode != ''</Pattern>
<Description>[F-LIB084] Invalid TargetCurrencyCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:SourceCurrencyBaseRate and (starts-with(cbc:SourceCurrencyBaseRate,'-') or cbc:SourceCurrencyBaseRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:SourceCurrencyBaseRate and (starts-with(cbc:SourceCurrencyBaseRate,'-') or cbc:SourceCurrencyBaseRate = 0)</Pattern>
<Description>[F-LIB085] Invalid SourceCurrencyBaseRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:SourceCurrencyBaseRate and string-length(substring-after(cbc:SourceCurrencyBaseRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:SourceCurrencyBaseRate and string-length(substring-after(cbc:SourceCurrencyBaseRate, '.')) != 4</Pattern>
<Description>[F-LIB086] Invalid SourceCurrencyBaseRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TargetCurrencyBaseRate and (starts-with(cbc:TargetCurrencyBaseRate,'-') or cbc:TargetCurrencyBaseRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TargetCurrencyBaseRate and (starts-with(cbc:TargetCurrencyBaseRate,'-') or cbc:TargetCurrencyBaseRate = 0)</Pattern>
<Description>[F-LIB087] Invalid TargetCurrencyBaseRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TargetCurrencyBaseRate and string-length(substring-after(cbc:TargetCurrencyBaseRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TargetCurrencyBaseRate and string-length(substring-after(cbc:TargetCurrencyBaseRate, '.')) != 4</Pattern>
<Description>[F-LIB088] Invalid TargetCurrencyBaseRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:CalculationRate and (starts-with(cbc:CalculationRate,'-') or cbc:CalculationRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CalculationRate and (starts-with(cbc:CalculationRate,'-') or cbc:CalculationRate = 0)</Pattern>
<Description>[F-LIB089] Invalid CalculationRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:CalculationRate and string-length(substring-after(cbc:CalculationRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CalculationRate and string-length(substring-after(cbc:CalculationRate, '.')) != 4</Pattern>
<Description>[F-LIB090] Invalid CalculationRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:ForeignExchangeContract/cbc:ContractTypeCode and cac:ForeignExchangeContract/cbc:ContractType">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:ForeignExchangeContract/cbc:ContractTypeCode and cac:ForeignExchangeContract/cbc:ContractType</Pattern>
<Description>[F-LIB239] Use either ContractTypeCode or ContractType</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(cac:ForeignExchangeContract/cac:ContractDocumentReference) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:ForeignExchangeContract/cac:ContractDocumentReference) &gt; 1</Pattern>
<Description>[F-LIB240] No more than one ContractDocumentReference class may be present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M28" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentAlternativeExchangeRate/cac:ForeignExchangeContract/cac:ValidityPeriod" priority="3998" mode="M28">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M28" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentAlternativeExchangeRate/cac:ForeignExchangeContract/cac:ValidityPeriod/cbc:Description" priority="3997" mode="M28">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M28" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:PaymentAlternativeExchangeRate/cac:ForeignExchangeContract/cac:ContractDocumentReference" priority="3996" mode="M28">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentType) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentType) = 0</Pattern>
<Description>[F-LIB170] DocumentType element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentTypeCode) = 0</Pattern>
<Description>[F-LIB172] DocumentTypeCode element must be excluded</Description>
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
<Description>[F-LIB169] Use either Attachment or XPath</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference</Pattern>
<Description>[F-LIB171] Use either EmbeddedDocumentBinaryObject or ExternalReference</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:UUID and not(string-length(string(cbc:UUID)) = 36)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:UUID and not(string-length(string(cbc:UUID)) = 36)</Pattern>
<Description>[F-LIB173] Invalid UUID. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')</Pattern>
<Description>[F-LIB174] Attribute mimeCode must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')</Pattern>
<Description>[F-LIB096] When using ExternalReference, URI is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M28" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M28" />
<xsl:template match="@*|node()" priority="-2" mode="M28">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M28" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M28" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN taxtotal-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:TaxTotal" priority="3999" mode="M29">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:TaxSubtotal) != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:TaxSubtotal) != 0</Pattern>
<Description>[F-LIB306] One or more TaxSubtotal classes must be present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(cbc:TaxAmount, '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(cbc:TaxAmount, '.')) != 2</Pattern>
<Description>[F-LIB250] Invalid TaxAmount. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:RoundingAmount and (cbc:RoundingAmount = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:RoundingAmount and (cbc:RoundingAmount = 0)</Pattern>
<Description>[F-LIB251] Invalid RoundingAmount. Must not be zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:RoundingAmount and string-length(substring-after(cbc:RoundingAmount, '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:RoundingAmount and string-length(substring-after(cbc:RoundingAmount, '.')) != 2</Pattern>
<Description>[F-LIB252] Invalid RoundingAmount. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TaxEvidenceIndicator = 'false' and /doc:Invoice/cbc:InvoiceTypeCode != '325'">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TaxEvidenceIndicator = 'false' and /doc:Invoice/cbc:InvoiceTypeCode != '325'</Pattern>
<Description>[F-LIB253] Can only be false if proforma invoice (InvoiceTypeCode = '325')</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M29" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:TaxTotal/cac:TaxSubtotal" priority="3998" mode="M29">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:Percent) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:Percent) = 0</Pattern>
<Description>[F-LIB254] Percent element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:BaseUnitMeasure) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:BaseUnitMeasure) = 0</Pattern>
<Description>[F-LIB255] BaseUnitMeasure element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:PerUnitAmount) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:PerUnitAmount) = 0</Pattern>
<Description>[F-LIB256] PerUnitAmount element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TierRange) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TierRange) = 0</Pattern>
<Description>[F-LIB257] TierRange element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TierRatePercent) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TierRatePercent) = 0</Pattern>
<Description>[F-LIB258] TierRatePercent element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:TaxableAmount != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TaxableAmount != ''</Pattern>
<Description>[F-LIB259] Invalid TaxableAmount. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(cbc:TaxableAmount, '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(cbc:TaxableAmount, '.')) != 2</Pattern>
<Description>[F-LIB261] Invalid TaxableAmount. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(cbc:TaxAmount, '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(cbc:TaxAmount, '.')) != 2</Pattern>
<Description>[F-LIB263] Invalid TaxAmount. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:CalculationSequenceNumeric and (starts-with(cbc:CalculationSequenceNumeric,'-') or cbc:CalculationSequenceNumeric = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CalculationSequenceNumeric and (starts-with(cbc:CalculationSequenceNumeric,'-') or cbc:CalculationSequenceNumeric = 0)</Pattern>
<Description>[F-LIB264] Invalid CalculationSequenceNumeric. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="/doc:Invoice/cac:TaxExchangeRate and count(cbc:TransactionCurrencyTaxAmount) = 0">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>/doc:Invoice/cac:TaxExchangeRate and count(cbc:TransactionCurrencyTaxAmount) = 0</Pattern>
<Description>[F-LIB265] if Tax Currency is different from Document Currency, TransactionCurrencyTaxAmount is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TransactionCurrencyTaxAmount and (starts-with(cbc:TransactionCurrencyTaxAmount,'-'))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TransactionCurrencyTaxAmount and (starts-with(cbc:TransactionCurrencyTaxAmount,'-'))</Pattern>
<Description>[F-LIB266] Invalid TransactionCurrencyTaxAmount. Must not be negative</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TransactionCurrencyTaxAmount and string-length(substring-after(cbc:TransactionCurrencyTaxAmount, '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TransactionCurrencyTaxAmount and string-length(substring-after(cbc:TransactionCurrencyTaxAmount, '.')) != 2</Pattern>
<Description>[F-LIB267] Invalid TransactionCurrencyTaxAmount. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M29" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory" priority="3997" mode="M29">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TierRange) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TierRange) = 0</Pattern>
<Description>[F-LIB072] TierRange element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TierRatePercent) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TierRatePercent) = 0</Pattern>
<Description>[F-LIB073] TierRatePercent element must be excluded</Description>
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
<Description>[F-LIB074] Invalid ID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeID = 'urn:oioubl:id:taxcategoryid-1.1'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeID = 'urn:oioubl:id:taxcategoryid-1.1'</Pattern>
<Description>[F-LIB075] Invalid schemeID. Must be 'urn:oioubl:id:taxcategoryid-1.1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeAgencyID = '320'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeAgencyID = '320'</Pattern>
<Description>[W-LIB229] Invalid schemeAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:Name != '') and not(contains(/doc:Invoice/cbc:ProfileID, 'nesubl.eu'))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:Name != '') and not(contains(/doc:Invoice/cbc:ProfileID, 'nesubl.eu'))</Pattern>
<Description>[W-LIB230] Name should only be used within NES profiles</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PerUnitAmount and cbc:Percent">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PerUnitAmount and cbc:Percent</Pattern>
<Description>[F-LIB231] Use either PerUnitAmount or Percent</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PerUnitAmount and not(cbc:BaseUnitMeasure != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PerUnitAmount and not(cbc:BaseUnitMeasure != '')</Pattern>
<Description>[F-LIB232] When PerUnitAmount is used, BaseUnitMeasure is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M29" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme" priority="3996" mode="M29">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M29" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M29" />
<xsl:template match="@*|node()" priority="-2" mode="M29">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M29" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M29" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN legalmonetarytotal-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:LegalMonetaryTotal" priority="3999" mode="M30">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:LineExtensionAmount != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:LineExtensionAmount != ''</Pattern>
<Description>[F-REM054] Invalid LineExtensionAmount. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="count(../cac:AllowanceCharge[cbc:ChargeIndicator='false']) and not(cbc:AllowanceTotalAmount)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cac:AllowanceCharge[cbc:ChargeIndicator='false']) and not(cbc:AllowanceTotalAmount)</Pattern>
<Description>[F-REM074] AllowanceTotalAmount is mandatory when AllowanceCharge classes (with ChargeIndicator='false') are present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(../cac:AllowanceCharge[cbc:ChargeIndicator='true']) and not(cbc:ChargeTotalAmount)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cac:AllowanceCharge[cbc:ChargeIndicator='true']) and not(cbc:ChargeTotalAmount)</Pattern>
<Description>[F-REM075] ChargeTotalAmount is mandatory when AllowanceCharge classes (with ChargeIndicator='true') are present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(../cac:PrepaidPayment/cbc:PaidAmount) and not(cbc:PrepaidAmount)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cac:PrepaidPayment/cbc:PaidAmount) and not(cbc:PrepaidAmount)</Pattern>
<Description>[F-REM076] PrepaidAmount is mandatory when PrepaidPayment/PaidAmount elements are present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(../cac:TaxTotal/cbc:RoundingAmount) and not(cbc:PayableRoundingAmount)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cac:TaxTotal/cbc:RoundingAmount) and not(cbc:PayableRoundingAmount)</Pattern>
<Description>[F-REM077] PayableRoundingAmount is mandatory when TaxTotal/RoundingAmount elements are present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TaxExclusiveAmount and not(format-number(cbc:TaxExclusiveAmount,'##.00') = format-number(sum(../cac:TaxTotal/cac:TaxSubtotal/cbc:TaxAmount),'##.00'))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TaxExclusiveAmount and not(format-number(cbc:TaxExclusiveAmount,'##.00') = format-number(sum(../cac:TaxTotal/cac:TaxSubtotal/cbc:TaxAmount),'##.00'))</Pattern>
<Description>[F-REM079] The sum of TaxTotal/TaxSubtotal/TaxAmount elements must equal TaxExclusiveAmount</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TaxInclusiveAmount and not(format-number(cbc:TaxInclusiveAmount,'##.00') = format-number(sum(cbc:LineExtensionAmount) + sum(../cac:TaxTotal/cac:TaxSubtotal/cbc:TaxAmount) + sum(cbc:ChargeTotalAmount) - sum(cbc:AllowanceTotalAmount) + sum(cbc:PayableRoundingAmount),'##.00'))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TaxInclusiveAmount and not(format-number(cbc:TaxInclusiveAmount,'##.00') = format-number(sum(cbc:LineExtensionAmount) + sum(../cac:TaxTotal/cac:TaxSubtotal/cbc:TaxAmount) + sum(cbc:ChargeTotalAmount) - sum(cbc:AllowanceTotalAmount) + sum(cbc:PayableRoundingAmount),'##.00'))</Pattern>
<Description>[F-REM080] TaxInclusiveAmount is calculated incorrectly</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AllowanceTotalAmount and not(format-number(cbc:AllowanceTotalAmount,'##.00') = format-number(sum(../cac:AllowanceCharge[cbc:ChargeIndicator='false']/cbc:Amount),'##.00'))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AllowanceTotalAmount and not(format-number(cbc:AllowanceTotalAmount,'##.00') = format-number(sum(../cac:AllowanceCharge[cbc:ChargeIndicator='false']/cbc:Amount),'##.00'))</Pattern>
<Description>[F-REM081] The sum of AllowanceCharge/Amount elements (with ChargeIndicator='false') must equal AllowanceTotalAmount</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:ChargeTotalAmount and not(format-number(cbc:ChargeTotalAmount,'##.00') = format-number(sum(../cac:AllowanceCharge[cbc:ChargeIndicator='true']/cbc:Amount),'##.00'))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ChargeTotalAmount and not(format-number(cbc:ChargeTotalAmount,'##.00') = format-number(sum(../cac:AllowanceCharge[cbc:ChargeIndicator='true']/cbc:Amount),'##.00'))</Pattern>
<Description>[F-REM082] The sum of AllowanceCharge/Amount elements (with ChargeIndicator='true') must equal cbc:ChargeTotalAmount</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PrepaidAmount and not(format-number(cbc:PrepaidAmount,'##.00') = format-number(sum(../cac:PrepaidPayment/cbc:PaidAmount),'##.00'))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PrepaidAmount and not(format-number(cbc:PrepaidAmount,'##.00') = format-number(sum(../cac:PrepaidPayment/cbc:PaidAmount),'##.00'))</Pattern>
<Description>[F-REM083] The sum of PrepaidPayment/PaidAmount elements must equal PrepaidAmount</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PayableRoundingAmount and not(format-number(cbc:PayableRoundingAmount,'##.00') = format-number(sum(../cac:TaxTotal/cbc:RoundingAmount),'##.00'))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PayableRoundingAmount and not(format-number(cbc:PayableRoundingAmount,'##.00') = format-number(sum(../cac:TaxTotal/cbc:RoundingAmount),'##.00'))</Pattern>
<Description>[F-REM084] The sum of TaxTotal/RoundingAmount elements must equal PayableRoundingAmount</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="format-number(cbc:PayableAmount,'##.00') = format-number(sum(cbc:LineExtensionAmount) + sum(../cac:TaxTotal/cac:TaxSubtotal/cbc:TaxAmount) + sum(cbc:ChargeTotalAmount) - sum(cbc:AllowanceTotalAmount) - sum(cbc:PrepaidAmount) + sum(cbc:PayableRoundingAmount),'##.00')" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>format-number(cbc:PayableAmount,'##.00') = format-number(sum(cbc:LineExtensionAmount) + sum(../cac:TaxTotal/cac:TaxSubtotal/cbc:TaxAmount) + sum(cbc:ChargeTotalAmount) - sum(cbc:AllowanceTotalAmount) - sum(cbc:PrepaidAmount) + sum(cbc:PayableRoundingAmount),'##.00')</Pattern>
<Description>[F-REM085] PayableAmount is calculated incorrectly</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="count(../cac:PaymentTerms) &gt; 0 and not(format-number(cbc:PayableAmount,'##.00') = format-number(sum(../cac:PaymentTerms/cbc:Amount),'##.00'))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(../cac:PaymentTerms) &gt; 0 and not(format-number(cbc:PayableAmount,'##.00') = format-number(sum(../cac:PaymentTerms/cbc:Amount),'##.00'))</Pattern>
<Description>[F-REM086] The sum of PaymentTerms/Amount elements must equal PayableAmount</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M30" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:LegalMonetaryTotal/cbc:LineExtensionAmount" priority="3998" mode="M30">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-')) and . != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-')) and . != 0</Pattern>
<Description>[F-LIB013] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(., '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(., '.')) != 2</Pattern>
<Description>[F-LIB014] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M30" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount" priority="3997" mode="M30">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-'))" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-'))</Pattern>
<Description>[F-LIB016] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(., '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(., '.')) != 2</Pattern>
<Description>[F-LIB017] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M30" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount" priority="3996" mode="M30">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-')) and . != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-')) and . != 0</Pattern>
<Description>[F-LIB013] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(., '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(., '.')) != 2</Pattern>
<Description>[F-LIB014] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M30" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount" priority="3995" mode="M30">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-')) and . != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-')) and . != 0</Pattern>
<Description>[F-LIB013] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(., '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(., '.')) != 2</Pattern>
<Description>[F-LIB014] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M30" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:LegalMonetaryTotal/cbc:ChargeTotalAmount" priority="3994" mode="M30">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-')) and . != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-')) and . != 0</Pattern>
<Description>[F-LIB013] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(., '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(., '.')) != 2</Pattern>
<Description>[F-LIB014] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M30" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:LegalMonetaryTotal/cbc:PrepaidAmount" priority="3993" mode="M30">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-')) and . != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-')) and . != 0</Pattern>
<Description>[F-LIB013] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(., '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(., '.')) != 2</Pattern>
<Description>[F-LIB014] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M30" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:LegalMonetaryTotal/cbc:PayableRoundingAmount" priority="3992" mode="M30">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test=". != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>. != 0</Pattern>
<Description>[F-LIB303] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(., '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(., '.')) != 2</Pattern>
<Description>[F-LIB304] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M30" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:LegalMonetaryTotal/cbc:PayableAmount" priority="3991" mode="M30">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-')) and . != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-')) and . != 0</Pattern>
<Description>[F-LIB013] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(., '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(., '.')) != 2</Pattern>
<Description>[F-LIB014] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M30" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M30" />
<xsl:template match="@*|node()" priority="-2" mode="M30">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M30" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M30" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!--PATTERN reminderline-->


	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine" priority="3999" mode="M31">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID != ''</Pattern>
<Description>[F-REM058] Invalid ID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:AccountingCost and cbc:AccountingCostCode">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AccountingCost and cbc:AccountingCostCode</Pattern>
<Description>[F-LIB021] Use either AccountingCost or AccountingCostCode</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(cac:ReminderPeriod) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:ReminderPeriod) &gt; 1</Pattern>
<Description>[F-REM087] No more than one ReminderPeriod class may be present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(cac:BillingReference) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:BillingReference) &gt; 1</Pattern>
<Description>[F-REM088] No more than one BillingReference class may be present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M31" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cbc:UUID" priority="3998" mode="M31">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M31" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cbc:DebitLineAmount" priority="3997" mode="M31">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-')) and . != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-')) and . != 0</Pattern>
<Description>[F-LIB013] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(., '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(., '.')) != 2</Pattern>
<Description>[F-LIB014] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M31" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cbc:CreditLineAmount" priority="3996" mode="M31">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-')) and . != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-')) and . != 0</Pattern>
<Description>[F-LIB013] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="string-length(substring-after(., '.')) != 2">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>string-length(substring-after(., '.')) != 2</Pattern>
<Description>[F-LIB014] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must have 2 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M31" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:ReminderPeriod" priority="3995" mode="M31">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M31" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:ReminderPeriod/cbc:Description" priority="3994" mode="M31">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M31" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:BillingReference" priority="3993" mode="M31">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:DebitNoteDocumentReference) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:DebitNoteDocumentReference) = 0</Pattern>
<Description>[F-REM089] DebitNoteDocumentReference class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:AdditionalDocumentReference) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:AdditionalDocumentReference) = 0</Pattern>
<Description>[F-REM090] AdditionalDocumentReference class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="count(cac:BillingReferenceLine) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:BillingReferenceLine) &gt; 1</Pattern>
<Description>[F-REM091] No more than one BillingReferenceLine class may be present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M31" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:BillingReference/cac:InvoiceDocumentReference" priority="3992" mode="M31">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentType) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentType) = 0</Pattern>
<Description>[F-LIB170] DocumentType element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentTypeCode) = 0</Pattern>
<Description>[F-LIB172] DocumentTypeCode element must be excluded</Description>
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
<Description>[F-LIB169] Use either Attachment or XPath</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference</Pattern>
<Description>[F-LIB171] Use either EmbeddedDocumentBinaryObject or ExternalReference</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:UUID and not(string-length(string(cbc:UUID)) = 36)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:UUID and not(string-length(string(cbc:UUID)) = 36)</Pattern>
<Description>[F-LIB173] Invalid UUID. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')</Pattern>
<Description>[F-LIB174] Attribute mimeCode must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')</Pattern>
<Description>[F-LIB096] When using ExternalReference, URI is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M31" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:BillingReference/cac:SelfBilledInvoiceDocumentReference" priority="3991" mode="M31">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentType) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentType) = 0</Pattern>
<Description>[F-LIB170] DocumentType element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentTypeCode) = 0</Pattern>
<Description>[F-LIB172] DocumentTypeCode element must be excluded</Description>
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
<Description>[F-LIB169] Use either Attachment or XPath</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference</Pattern>
<Description>[F-LIB171] Use either EmbeddedDocumentBinaryObject or ExternalReference</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:UUID and not(string-length(string(cbc:UUID)) = 36)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:UUID and not(string-length(string(cbc:UUID)) = 36)</Pattern>
<Description>[F-LIB173] Invalid UUID. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')</Pattern>
<Description>[F-LIB174] Attribute mimeCode must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')</Pattern>
<Description>[F-LIB096] When using ExternalReference, URI is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M31" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:BillingReference/cac:CreditNoteDocumentReference" priority="3990" mode="M31">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentType) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentType) = 0</Pattern>
<Description>[F-LIB170] DocumentType element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentTypeCode) = 0</Pattern>
<Description>[F-LIB172] DocumentTypeCode element must be excluded</Description>
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
<Description>[F-LIB169] Use either Attachment or XPath</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference</Pattern>
<Description>[F-LIB171] Use either EmbeddedDocumentBinaryObject or ExternalReference</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:UUID and not(string-length(string(cbc:UUID)) = 36)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:UUID and not(string-length(string(cbc:UUID)) = 36)</Pattern>
<Description>[F-LIB173] Invalid UUID. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')</Pattern>
<Description>[F-LIB174] Attribute mimeCode must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')</Pattern>
<Description>[F-LIB096] When using ExternalReference, URI is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M31" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:BillingReference/cac:SelfBilledCreditNoteDocumentReference" priority="3989" mode="M31">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentType) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentType) = 0</Pattern>
<Description>[F-LIB170] DocumentType element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentTypeCode) = 0</Pattern>
<Description>[F-LIB172] DocumentTypeCode element must be excluded</Description>
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
<Description>[F-LIB169] Use either Attachment or XPath</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference</Pattern>
<Description>[F-LIB171] Use either EmbeddedDocumentBinaryObject or ExternalReference</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:UUID and not(string-length(string(cbc:UUID)) = 36)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:UUID and not(string-length(string(cbc:UUID)) = 36)</Pattern>
<Description>[F-LIB173] Invalid UUID. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')</Pattern>
<Description>[F-LIB174] Attribute mimeCode must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')</Pattern>
<Description>[F-LIB096] When using ExternalReference, URI is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M31" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:BillingReference/cac:ReminderDocumentReference" priority="3988" mode="M31">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentType) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentType) = 0</Pattern>
<Description>[F-LIB170] DocumentType element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentTypeCode) = 0</Pattern>
<Description>[F-LIB172] DocumentTypeCode element must be excluded</Description>
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
<Description>[F-LIB169] Use either Attachment or XPath</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference</Pattern>
<Description>[F-LIB171] Use either EmbeddedDocumentBinaryObject or ExternalReference</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:UUID and not(string-length(string(cbc:UUID)) = 36)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:UUID and not(string-length(string(cbc:UUID)) = 36)</Pattern>
<Description>[F-LIB173] Invalid UUID. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')</Pattern>
<Description>[F-LIB174] Attribute mimeCode must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')</Pattern>
<Description>[F-LIB096] When using ExternalReference, URI is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M31" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:BillingReference/cac:BillingReferenceLine" priority="3987" mode="M31">

		<!--REPORT -->
<xsl:if test="count(cac:AllowanceCharge) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:AllowanceCharge) &gt; 1</Pattern>
<Description>[F-REM092] No more than one AllowanceCharge class may be present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M31" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:BillingReference/cac:BillingReferenceLine/cac:AllowanceCharge" priority="3986" mode="M31">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:TaxTotal) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:TaxTotal) = 0</Pattern>
<Description>[F-LIB224] TaxTotal class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:PaymentMeans) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:PaymentMeans) = 0</Pattern>
<Description>[F-LIB225] PaymentMeans class must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cac:TaxCategory) = 1" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:TaxCategory) = 1</Pattern>
<Description>[F-LIB226] One TaxCategory class must be present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:MultiplierFactorNumeric and not(cbc:BaseAmount != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:MultiplierFactorNumeric and not(cbc:BaseAmount != '')</Pattern>
<Description>[F-LIB248] When MultiplierFactorNumeric is used, BaseAmount is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="starts-with(cbc:MultiplierFactorNumeric,'-')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>starts-with(cbc:MultiplierFactorNumeric,'-')</Pattern>
<Description>[F-LIB227] MultiplierFactorNumeric must be a positive number</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:MultiplierFactorNumeric and not(format-number(cbc:Amount,'##.00') = format-number((cbc:BaseAmount * cbc:MultiplierFactorNumeric),'##.00'))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:MultiplierFactorNumeric and not(format-number(cbc:Amount,'##.00') = format-number((cbc:BaseAmount * cbc:MultiplierFactorNumeric),'##.00'))</Pattern>
<Description>[F-LIB228] Amount must equal BaseAmount * MultiplierFactorNumeric</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:AccountingCost and cbc:AccountingCostCode">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:AccountingCost and cbc:AccountingCostCode</Pattern>
<Description>[F-LIB021] Use either AccountingCost or AccountingCostCode</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M31" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:BillingReference/cac:BillingReferenceLine/cac:AllowanceCharge/cbc:SequenceNumeric" priority="3985" mode="M31">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-'))" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-'))</Pattern>
<Description>[F-LIB020] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M31" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:BillingReference/cac:BillingReferenceLine/cac:AllowanceCharge/cbc:Amount" priority="3984" mode="M31">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-')) and . != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-')) and . != 0</Pattern>
<Description>[F-LIB019] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M31" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:BillingReference/cac:BillingReferenceLine/cac:AllowanceCharge/cbc:BaseAmount" priority="3983" mode="M31">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="not(starts-with(.,'-')) and . != 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>not(starts-with(.,'-')) and . != 0</Pattern>
<Description>[F-LIB019] Invalid <xsl:text />
<xsl:value-of select="name(.)" />
<xsl:text />. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M31" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:BillingReference/cac:BillingReferenceLine/cac:AllowanceCharge/cac:TaxCategory" priority="3982" mode="M31">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TierRange) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TierRange) = 0</Pattern>
<Description>[F-LIB072] TierRange element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:TierRatePercent) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:TierRatePercent) = 0</Pattern>
<Description>[F-LIB073] TierRatePercent element must be excluded</Description>
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
<Description>[F-LIB074] Invalid ID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeID = 'urn:oioubl:id:taxcategoryid-1.1'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeID = 'urn:oioubl:id:taxcategoryid-1.1'</Pattern>
<Description>[F-LIB075] Invalid schemeID. Must be 'urn:oioubl:id:taxcategoryid-1.1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:ID/@schemeAgencyID = '320'" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:ID/@schemeAgencyID = '320'</Pattern>
<Description>[W-LIB229] Invalid schemeAgencyID. Must be '320'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="(cbc:Name != '') and not(contains(/doc:Invoice/cbc:ProfileID, 'nesubl.eu'))">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>(cbc:Name != '') and not(contains(/doc:Invoice/cbc:ProfileID, 'nesubl.eu'))</Pattern>
<Description>[W-LIB230] Name should only be used within NES profiles</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PerUnitAmount and cbc:Percent">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PerUnitAmount and cbc:Percent</Pattern>
<Description>[F-LIB231] Use either PerUnitAmount or Percent</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:PerUnitAmount and not(cbc:BaseUnitMeasure != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:PerUnitAmount and not(cbc:BaseUnitMeasure != '')</Pattern>
<Description>[F-LIB232] When PerUnitAmount is used, BaseUnitMeasure is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M31" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:BillingReference/cac:BillingReferenceLine/cac:AllowanceCharge/cac:TaxCategory/cac:TaxScheme" priority="3981" mode="M31">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M31" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:ExchangeRate" priority="3980" mode="M31">

		<!--REPORT -->
<xsl:if test="cac:ForeignExchangeContract and not(cac:ForeignExchangeContract/cbc:ID != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:ForeignExchangeContract and not(cac:ForeignExchangeContract/cbc:ID != '')</Pattern>
<Description>[F-LIB238] Invalid ID. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:SourceCurrencyCode != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:SourceCurrencyCode != ''</Pattern>
<Description>[F-LIB083] Invalid SourceCurrencyCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="cbc:TargetCurrencyCode != ''" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TargetCurrencyCode != ''</Pattern>
<Description>[F-LIB084] Invalid TargetCurrencyCode. Must contain a value</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--REPORT -->
<xsl:if test="cbc:SourceCurrencyBaseRate and (starts-with(cbc:SourceCurrencyBaseRate,'-') or cbc:SourceCurrencyBaseRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:SourceCurrencyBaseRate and (starts-with(cbc:SourceCurrencyBaseRate,'-') or cbc:SourceCurrencyBaseRate = 0)</Pattern>
<Description>[F-LIB085] Invalid SourceCurrencyBaseRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:SourceCurrencyBaseRate and string-length(substring-after(cbc:SourceCurrencyBaseRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:SourceCurrencyBaseRate and string-length(substring-after(cbc:SourceCurrencyBaseRate, '.')) != 4</Pattern>
<Description>[F-LIB086] Invalid SourceCurrencyBaseRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TargetCurrencyBaseRate and (starts-with(cbc:TargetCurrencyBaseRate,'-') or cbc:TargetCurrencyBaseRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TargetCurrencyBaseRate and (starts-with(cbc:TargetCurrencyBaseRate,'-') or cbc:TargetCurrencyBaseRate = 0)</Pattern>
<Description>[F-LIB087] Invalid TargetCurrencyBaseRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:TargetCurrencyBaseRate and string-length(substring-after(cbc:TargetCurrencyBaseRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:TargetCurrencyBaseRate and string-length(substring-after(cbc:TargetCurrencyBaseRate, '.')) != 4</Pattern>
<Description>[F-LIB088] Invalid TargetCurrencyBaseRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:CalculationRate and (starts-with(cbc:CalculationRate,'-') or cbc:CalculationRate = 0)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CalculationRate and (starts-with(cbc:CalculationRate,'-') or cbc:CalculationRate = 0)</Pattern>
<Description>[F-LIB089] Invalid CalculationRate. Must not be negative or zero</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:CalculationRate and string-length(substring-after(cbc:CalculationRate, '.')) != 4">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:CalculationRate and string-length(substring-after(cbc:CalculationRate, '.')) != 4</Pattern>
<Description>[F-LIB090] Invalid CalculationRate. Must have 4 decimals</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:ForeignExchangeContract/cbc:ContractTypeCode and cac:ForeignExchangeContract/cbc:ContractType">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:ForeignExchangeContract/cbc:ContractTypeCode and cac:ForeignExchangeContract/cbc:ContractType</Pattern>
<Description>[F-LIB239] Use either ContractTypeCode or ContractType</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="count(cac:ForeignExchangeContract/cac:ContractDocumentReference) &gt; 1">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cac:ForeignExchangeContract/cac:ContractDocumentReference) &gt; 1</Pattern>
<Description>[F-LIB240] No more than one ContractDocumentReference class may be present</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M31" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:ExchangeRate/cac:ForeignExchangeContract/cac:ValidityPeriod" priority="3979" mode="M31">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M31" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:ExchangeRate/cac:ForeignExchangeContract/cac:ValidityPeriod/cbc:Description" priority="3978" mode="M31">

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
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M31" />
</xsl:template>

	<!--RULE -->
<xsl:template match="doc:Reminder/cac:ReminderLine/cac:ExchangeRate/cac:ForeignExchangeContract/cac:ContractDocumentReference" priority="3977" mode="M31">

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentType) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentType) = 0</Pattern>
<Description>[F-LIB170] DocumentType element must be excluded</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:otherwise>
</xsl:choose>

		<!--ASSERT -->
<xsl:choose>
<xsl:when test="count(cbc:DocumentTypeCode) = 0" />
<xsl:otherwise>
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>count(cbc:DocumentTypeCode) = 0</Pattern>
<Description>[F-LIB172] DocumentTypeCode element must be excluded</Description>
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
<Description>[F-LIB169] Use either Attachment or XPath</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and cac:Attachment/cac:ExternalReference</Pattern>
<Description>[F-LIB171] Use either EmbeddedDocumentBinaryObject or ExternalReference</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cbc:UUID and not(string-length(string(cbc:UUID)) = 36)">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cbc:UUID and not(string-length(string(cbc:UUID)) = 36)</Pattern>
<Description>[F-LIB173] Invalid UUID. Must be of this form '6E09886B-DC6E-439F-82D1-7CCAC7F4E3B1'</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cbc:EmbeddedDocumentBinaryObject and not(cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/tiff' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/png' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/jpeg' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='image/gif' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='application/pdf' or cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode='text/xml')</Pattern>
<Description>[F-LIB174] Attribute mimeCode must be a value from the codelist</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>

		<!--REPORT -->
<xsl:if test="cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')">
<Error>
<xsl:attribute name="context"><xsl:value-of select="concat(name(parent::*),'/',name())" /></xsl:attribute>
<Pattern>cac:Attachment/cac:ExternalReference and not(cac:Attachment/cac:ExternalReference/cbc:URI != '')</Pattern>
<Description>[F-LIB096] When using ExternalReference, URI is mandatory</Description>
<Xpath><xsl:for-each select="ancestor::*">/<xsl:value-of select="name()" />[<xsl:value-of select="position()" />]</xsl:for-each>
</Xpath>
</Error>
</xsl:if>
<xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M31" />
</xsl:template>
<xsl:template match="text()" priority="-1" mode="M31" />
<xsl:template match="@*|node()" priority="-2" mode="M31">
<xsl:choose>
<!--Housekeeping: SAXON warns if attempting to find the attribute
                           of an attribute-->
<xsl:when test="not(@*)">
<xsl:apply-templates select="node()" mode="M31" />
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="@*|node()" mode="M31" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>
</xsl:stylesheet>
