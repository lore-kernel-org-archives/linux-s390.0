Return-Path: <linux-kernel-owner+w=401wt.eu-S1756353AbYFCRGZ@vger.kernel.org>
Message-Id: <20080603170519.787597406@de.ibm.com>
References: <20080603165859.107949986@de.ibm.com>
Date: Tue, 03 Jun 2008 18:59:05 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 06/14] cio: Base message subchannel handling.
Content-Disposition: inline; filename=105-cio-msg-subchannel.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/cio.c |   30 ++++++++++++++++++++++++------
 drivers/s390/cio/cio.h |    2 +-
 drivers/s390/cio/css.c |    2 ++
 3 files changed, 27 insertions(+), 7 deletions(-)

Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -498,13 +498,8 @@ int cio_create_sch_lock(struct subchanne
 	return 0;
 }
 
-static int cio_validate_io_subchannel(struct subchannel *sch)
+static int cio_check_devno_blacklisted(struct subchannel *sch)
 {
-	/* Initialization for io subchannels. */
-	if (!css_sch_is_valid(&sch->schib))
-		return -ENODEV;
-
-	/* Devno is valid. */
 	if (is_blacklisted(sch->schid.ssid, sch->schib.pmcw.dev)) {
 		/*
 		 * This device must not be known to Linux. So we simply
@@ -518,6 +513,26 @@ static int cio_validate_io_subchannel(st
 	return 0;
 }
 
+static int cio_validate_io_subchannel(struct subchannel *sch)
+{
+	/* Initialization for io subchannels. */
+	if (!css_sch_is_valid(&sch->schib))
+		return -ENODEV;
+
+	/* Devno is valid. */
+	return cio_check_devno_blacklisted(sch);
+}
+
+static int cio_validate_msg_subchannel(struct subchannel *sch)
+{
+	/* Initialization for message subchannels. */
+	if (!css_sch_is_valid(&sch->schib))
+		return -ENODEV;
+
+	/* Devno is valid. */
+	return cio_check_devno_blacklisted(sch);
+}
+
 /**
  * cio_validate_subchannel - basic validation of subchannel
  * @sch: subchannel structure to be filled out
@@ -573,6 +588,9 @@ int cio_validate_subchannel(struct subch
 	case SUBCHANNEL_TYPE_IO:
 		err = cio_validate_io_subchannel(sch);
 		break;
+	case SUBCHANNEL_TYPE_MSG:
+		err = cio_validate_msg_subchannel(sch);
+		break;
 	default:
 		err = 0;
 	}
Index: quilt-2.6/drivers/s390/cio/cio.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.h
+++ quilt-2.6/drivers/s390/cio/cio.h
@@ -14,7 +14,7 @@
 struct pmcw {
 	u32 intparm;		/* interruption parameter */
 	u32 qf	 : 1;		/* qdio facility */
-	u32 res0 : 1;		/* reserved zeros */
+	u32 w	 : 1;
 	u32 isc  : 3;		/* interruption sublass */
 	u32 res5 : 3;		/* reserved zeros */
 	u32 ena  : 1;		/* enabled */
Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -332,6 +332,8 @@ int css_sch_is_valid(struct schib *schib
 {
 	if ((schib->pmcw.st == SUBCHANNEL_TYPE_IO) && !schib->pmcw.dnv)
 		return 0;
+	if ((schib->pmcw.st == SUBCHANNEL_TYPE_MSG) && !schib->pmcw.w)
+		return 0;
 	return 1;
 }
 EXPORT_SYMBOL_GPL(css_sch_is_valid);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
