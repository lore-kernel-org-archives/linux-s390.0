Return-Path: <linux-kernel-owner+w=401wt.eu-S1762053AbXJDLmA@vger.kernel.org>
Message-Id: <20071004112826.416549634@de.ibm.com>
References: <20071004112706.574737175@de.ibm.com>
Date: Thu, 04 Oct 2007 13:27:13 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 07/34] cio: Minor style fixes.
Content-Disposition: inline; filename=007-cio-style.diff
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

 drivers/s390/cio/chp.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: quilt-2.6/drivers/s390/cio/chp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chp.c
+++ quilt-2.6/drivers/s390/cio/chp.c
@@ -14,7 +14,7 @@
 #include <linux/jiffies.h>
 #include <linux/wait.h>
 #include <linux/mutex.h>
-#include <asm/errno.h>
+#include <linux/errno.h>
 #include <asm/chpid.h>
 #include <asm/sclp.h>
 
@@ -86,7 +86,7 @@ u8 chp_get_sch_opm(struct subchannel *sc
 
 	opm = 0;
 	chp_id_init(&chpid);
-	for (i=0; i < 8; i++) {
+	for (i = 0; i < 8; i++) {
 		opm <<= 1;
 		chpid.id = sch->schib.pmcw.chpid[i];
 		if (chp_get_status(chpid) != 0)
@@ -118,7 +118,7 @@ static int s390_vary_chpid(struct chp_id
 
 	sprintf(dbf_text, on?"varyon%x.%02x":"varyoff%x.%02x", chpid.cssid,
 		chpid.id);
-	CIO_TRACE_EVENT( 2, dbf_text);
+	CIO_TRACE_EVENT(2, dbf_text);
 
 	status = chp_get_status(chpid);
 	if (!on && !status) {
@@ -353,7 +353,7 @@ static ssize_t chp_shared_show(struct de
 
 static DEVICE_ATTR(shared, 0444, chp_shared_show, NULL);
 
-static struct attribute * chp_attrs[] = {
+static struct attribute *chp_attrs[] = {
 	&dev_attr_status.attr,
 	&dev_attr_configure.attr,
 	&dev_attr_type.attr,

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
