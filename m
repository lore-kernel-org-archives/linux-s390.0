Return-Path: <linux-kernel-owner+w=401wt.eu-S1755880AbXD0OKQ@vger.kernel.org>
Message-Id: <20070427140518.900497763@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:33 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 30/38] sclp: fix coding style.
Content-Disposition: inline; filename=133-sclp-coding.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Haberland <stefan.haberland@de.ibm.com>

Use only capital letters for defines.

Cc: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Stefan Haberland <stefan.haberland@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/sclp.c         |    2 -
 drivers/s390/char/sclp.h         |   72 +++++++++++++++++++--------------------
 drivers/s390/char/sclp_cpi.c     |    4 +-
 drivers/s390/char/sclp_quiesce.c |    2 -
 drivers/s390/char/sclp_rw.c      |   16 ++++----
 drivers/s390/char/sclp_sdias.c   |    6 +--
 drivers/s390/char/sclp_tty.c     |    6 +--
 drivers/s390/char/sclp_vt220.c   |    8 ++--
 8 files changed, 58 insertions(+), 58 deletions(-)

Index: quilt-2.6/drivers/s390/char/sclp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp.c	2007-04-27 16:04:59.000000000 +0200
+++ quilt-2.6/drivers/s390/char/sclp.c	2007-04-27 16:05:00.000000000 +0200
@@ -511,7 +511,7 @@
 }
 
 static struct sclp_register sclp_state_change_event = {
-	.receive_mask = EvTyp_StateChange_Mask,
+	.receive_mask = EVTYP_STATECHANGE_MASK,
 	.receiver_fn = sclp_state_change_cb
 };
 
Index: quilt-2.6/drivers/s390/char/sclp_cpi.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_cpi.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/drivers/s390/char/sclp_cpi.c	2007-04-27 16:05:00.000000000 +0200
@@ -46,7 +46,7 @@
 /* Event type structure for write message and write priority message */
 static struct sclp_register sclp_cpi_event =
 {
-	.send_mask = EvTyp_CtlProgIdent_Mask
+	.send_mask = EVTYP_CTLPROGIDENT_MASK
 };
 
 MODULE_LICENSE("GPL");
@@ -201,7 +201,7 @@
 		       "console.\n");
 		return -EINVAL;
 	}
-	if (!(sclp_cpi_event.sclp_send_mask & EvTyp_CtlProgIdent_Mask)) {
+	if (!(sclp_cpi_event.sclp_send_mask & EVTYP_CTLPROGIDENT_MASK)) {
 		printk(KERN_WARNING "cpi: no control program identification "
 		       "support\n");
 		sclp_unregister(&sclp_cpi_event);
Index: quilt-2.6/drivers/s390/char/sclp.h
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp.h	2007-04-27 16:04:59.000000000 +0200
+++ quilt-2.6/drivers/s390/char/sclp.h	2007-04-27 16:05:00.000000000 +0200
@@ -19,35 +19,35 @@
 #define MAX_KMEM_PAGES (sizeof(unsigned long) << 3)
 #define MAX_CONSOLE_PAGES	4
 
-#define EvTyp_OpCmd		0x01
-#define EvTyp_Msg		0x02
-#define EvTyp_StateChange	0x08
-#define EvTyp_PMsgCmd		0x09
-#define EvTyp_CntlProgOpCmd	0x20
-#define EvTyp_CntlProgIdent	0x0B
-#define EvTyp_SigQuiesce	0x1D
-#define EvTyp_VT220Msg		0x1A
-#define EvTyp_SDIAS		0x1C
-
-#define EvTyp_OpCmd_Mask	0x80000000
-#define EvTyp_Msg_Mask		0x40000000
-#define EvTyp_StateChange_Mask	0x01000000
-#define EvTyp_PMsgCmd_Mask	0x00800000
-#define EvTyp_CtlProgOpCmd_Mask	0x00000001
-#define EvTyp_CtlProgIdent_Mask	0x00200000
-#define EvTyp_SigQuiesce_Mask	0x00000008
-#define EvTyp_VT220Msg_Mask	0x00000040
-#define EvTyp_SDIAS_Mask	0x00000010
-
-#define GnrlMsgFlgs_DOM		0x8000
-#define GnrlMsgFlgs_SndAlrm	0x4000
-#define GnrlMsgFlgs_HoldMsg	0x2000
-
-#define LnTpFlgs_CntlText	0x8000
-#define LnTpFlgs_LabelText	0x4000
-#define LnTpFlgs_DataText	0x2000
-#define LnTpFlgs_EndText	0x1000
-#define LnTpFlgs_PromptText	0x0800
+#define EVTYP_OPCMD		0x01
+#define EVTYP_MSG		0x02
+#define EVTYP_STATECHANGE	0x08
+#define EVTYP_PMSGCMD		0x09
+#define EVTYP_CNTLPROGOPCMD	0x20
+#define EVTYP_CNTLPROGIDENT	0x0B
+#define EVTYP_SIGQUIESCE	0x1D
+#define EVTYP_VT220MSG		0x1A
+#define EVTYP_SDIAS		0x1C
+
+#define EVTYP_OPCMD_MASK	0x80000000
+#define EVTYP_MSG_MASK		0x40000000
+#define EVTYP_STATECHANGE_MASK	0x01000000
+#define EVTYP_PMSGCMD_MASK	0x00800000
+#define EVTYP_CTLPROGOPCMD_MASK	0x00000001
+#define EVTYP_CTLPROGIDENT_MASK	0x00200000
+#define EVTYP_SIGQUIESCE_MASK	0x00000008
+#define EVTYP_VT220MSG_MASK	0x00000040
+#define EVTYP_SDIAS_MASK	0x00000010
+
+#define GNRLMSGFLGS_DOM		0x8000
+#define GNRLMSGFLGS_SNDALRM	0x4000
+#define GNRLMSGFLGS_HOLDMSG	0x2000
+
+#define LNTPFLGS_CNTLTEXT	0x8000
+#define LNTPFLGS_LABELTEXT	0x4000
+#define LNTPFLGS_DATATEXT	0x2000
+#define LNTPFLGS_ENDTEXT	0x1000
+#define LNTPFLGS_PROMPTTEXT	0x0800
 
 typedef unsigned int sclp_cmdw_t;
 
@@ -58,15 +58,15 @@
 #define SCLP_CMDW_READ_SCP_INFO_FORCED	0x00120001
 
 #define GDS_ID_MDSMU		0x1310
-#define GDS_ID_MDSRouteInfo	0x1311
-#define GDS_ID_AgUnWrkCorr	0x1549
-#define GDS_ID_SNACondReport	0x1532
+#define GDS_ID_MDSROUTEINFO	0x1311
+#define GDS_ID_AGUNWRKCORR	0x1549
+#define GDS_ID_SNACONDREPORT	0x1532
 #define GDS_ID_CPMSU		0x1212
-#define GDS_ID_RoutTargInstr	0x154D
-#define GDS_ID_OpReq		0x8070
-#define GDS_ID_TextCmd		0x1320
+#define GDS_ID_ROUTTARGINSTR	0x154D
+#define GDS_ID_OPREQ		0x8070
+#define GDS_ID_TEXTCMD		0x1320
 
-#define GDS_KEY_SelfDefTextMsg	0x31
+#define GDS_KEY_SELFDEFTEXTMSG	0x31
 
 typedef u32 sccb_mask_t;	/* ATTENTION: assumes 32bit mask !!! */
 
Index: quilt-2.6/drivers/s390/char/sclp_quiesce.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_quiesce.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/drivers/s390/char/sclp_quiesce.c	2007-04-27 16:05:00.000000000 +0200
@@ -43,7 +43,7 @@
 }
 
 static struct sclp_register sclp_quiesce_event = {
-	.receive_mask = EvTyp_SigQuiesce_Mask,
+	.receive_mask = EVTYP_SIGQUIESCE_MASK,
 	.receiver_fn = sclp_quiesce_handler
 };
 
Index: quilt-2.6/drivers/s390/char/sclp_rw.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_rw.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/drivers/s390/char/sclp_rw.c	2007-04-27 16:05:00.000000000 +0200
@@ -30,7 +30,7 @@
 
 /* Event type structure for write message and write priority message */
 static struct sclp_register sclp_rw_event = {
-	.send_mask = EvTyp_Msg_Mask | EvTyp_PMsgCmd_Mask
+	.send_mask = EVTYP_MSG_MASK | EVTYP_PMSGCMD_MASK
 };
 
 /*
@@ -64,7 +64,7 @@
 	memset(sccb, 0, sizeof(struct write_sccb));
 	sccb->header.length = sizeof(struct write_sccb);
 	sccb->msg_buf.header.length = sizeof(struct msg_buf);
-	sccb->msg_buf.header.type = EvTyp_Msg;
+	sccb->msg_buf.header.type = EVTYP_MSG;
 	sccb->msg_buf.mdb.header.length = sizeof(struct mdb);
 	sccb->msg_buf.mdb.header.type = 1;
 	sccb->msg_buf.mdb.header.tag = 0xD4C4C240;	/* ebcdic "MDB " */
@@ -114,7 +114,7 @@
 	memset(mto, 0, sizeof(struct mto));
 	mto->length = sizeof(struct mto);
 	mto->type = 4;	/* message text object */
-	mto->line_type_flags = LnTpFlgs_EndText; /* end text */
+	mto->line_type_flags = LNTPFLGS_ENDTEXT; /* end text */
 
 	/* set pointer to first byte after struct mto. */
 	buffer->current_line = (char *) (mto + 1);
@@ -215,7 +215,7 @@
 		case '\a':	/* bell, one for several times	*/
 			/* set SCLP sound alarm bit in General Object */
 			buffer->sccb->msg_buf.mdb.go.general_msg_flags |=
-				GnrlMsgFlgs_SndAlrm;
+				GNRLMSGFLGS_SNDALRM;
 			break;
 		case '\t':	/* horizontal tabulator	 */
 			/* check if new mto needs to be created */
@@ -452,12 +452,12 @@
 		return -EIO;
 
 	sccb = buffer->sccb;
-	if (sclp_rw_event.sclp_send_mask & EvTyp_Msg_Mask)
+	if (sclp_rw_event.sclp_send_mask & EVTYP_MSG_MASK)
 		/* Use normal write message */
-		sccb->msg_buf.header.type = EvTyp_Msg;
-	else if (sclp_rw_event.sclp_send_mask & EvTyp_PMsgCmd_Mask)
+		sccb->msg_buf.header.type = EVTYP_MSG;
+	else if (sclp_rw_event.sclp_send_mask & EVTYP_PMSGCMD_MASK)
 		/* Use write priority message */
-		sccb->msg_buf.header.type = EvTyp_PMsgCmd;
+		sccb->msg_buf.header.type = EVTYP_PMSGCMD;
 	else
 		return -ENOSYS;
 	buffer->request.command = SCLP_CMDW_WRITE_EVENT_DATA;
Index: quilt-2.6/drivers/s390/char/sclp_sdias.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_sdias.c	2007-04-27 16:04:59.000000000 +0200
+++ quilt-2.6/drivers/s390/char/sclp_sdias.c	2007-04-27 16:05:00.000000000 +0200
@@ -30,7 +30,7 @@
 static struct debug_info *sdias_dbf;
 
 static struct sclp_register sclp_sdias_register = {
-	.send_mask = EvTyp_SDIAS_Mask,
+	.send_mask = EVTYP_SDIAS_MASK,
 };
 
 struct sdias_evbuf {
@@ -118,7 +118,7 @@
 
 	sccb.hdr.length = sizeof(sccb);
 	sccb.evbuf.hdr.length = sizeof(struct sdias_evbuf);
-	sccb.evbuf.hdr.type = EvTyp_SDIAS;
+	sccb.evbuf.hdr.type = EVTYP_SDIAS;
 	sccb.evbuf.event_qual = EQ_SIZE;
 	sccb.evbuf.data_id = DI_FCP_DUMP;
 	sccb.evbuf.event_id = 4712;
@@ -177,7 +177,7 @@
 
 	sccb.hdr.length = sizeof(sccb);
 	sccb.evbuf.hdr.length = sizeof(struct sdias_evbuf);
-	sccb.evbuf.hdr.type = EvTyp_SDIAS;
+	sccb.evbuf.hdr.type = EVTYP_SDIAS;
 	sccb.evbuf.hdr.flags = 0;
 	sccb.evbuf.event_qual = EQ_STORE_DATA;
 	sccb.evbuf.data_id = DI_FCP_DUMP;
Index: quilt-2.6/drivers/s390/char/sclp_tty.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_tty.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/drivers/s390/char/sclp_tty.c	2007-04-27 16:05:00.000000000 +0200
@@ -648,7 +648,7 @@
 	subvec = start;
 	while (subvec < end) {
 		subvec = find_gds_subvector(subvec, end,
-					    GDS_KEY_SelfDefTextMsg);
+					    GDS_KEY_SELFDEFTEXTMSG);
 		if (!subvec)
 			break;
 		sclp_eval_selfdeftextmsg((struct gds_subvector *)(subvec + 1),
@@ -664,7 +664,7 @@
 
 	vec = start;
 	while (vec < end) {
-		vec = find_gds_vector(vec, end, GDS_ID_TextCmd);
+		vec = find_gds_vector(vec, end, GDS_ID_TEXTCMD);
 		if (!vec)
 			break;
 		sclp_eval_textcmd((struct gds_subvector *)(vec + 1),
@@ -703,7 +703,7 @@
 
 static struct sclp_register sclp_input_event =
 {
-	.receive_mask = EvTyp_OpCmd_Mask | EvTyp_PMsgCmd_Mask,
+	.receive_mask = EVTYP_OPCMD_MASK | EVTYP_PMSGCMD_MASK,
 	.state_change_fn = sclp_tty_state_change,
 	.receiver_fn = sclp_tty_receiver
 };
Index: quilt-2.6/drivers/s390/char/sclp_vt220.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_vt220.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/drivers/s390/char/sclp_vt220.c	2007-04-27 16:05:00.000000000 +0200
@@ -99,8 +99,8 @@
 
 /* Registration structure for our interest in SCLP event buffers */
 static struct sclp_register sclp_vt220_register = {
-	.send_mask		= EvTyp_VT220Msg_Mask,
-	.receive_mask		= EvTyp_VT220Msg_Mask,
+	.send_mask		= EVTYP_VT220MSG_MASK,
+	.receive_mask		= EVTYP_VT220MSG_MASK,
 	.state_change_fn	= NULL,
 	.receiver_fn		= sclp_vt220_receiver_fn
 };
@@ -202,7 +202,7 @@
 static int
 __sclp_vt220_emit(struct sclp_vt220_request *request)
 {
-	if (!(sclp_vt220_register.sclp_send_mask & EvTyp_VT220Msg_Mask)) {
+	if (!(sclp_vt220_register.sclp_send_mask & EVTYP_VT220MSG_MASK)) {
 		request->sclp_req.status = SCLP_REQ_FAILED;
 		return -EIO;
 	}
@@ -284,7 +284,7 @@
 	sccb->header.length = sizeof(struct sclp_vt220_sccb);
 	sccb->header.function_code = SCLP_NORMAL_WRITE;
 	sccb->header.response_code = 0x0000;
-	sccb->evbuf.type = EvTyp_VT220Msg;
+	sccb->evbuf.type = EVTYP_VT220MSG;
 	sccb->evbuf.length = sizeof(struct evbuf_header);
 
 	return request;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
