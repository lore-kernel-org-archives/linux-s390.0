Return-Path: <linux-kernel-owner+w=401wt.eu-S1756746AbYFCRGn@vger.kernel.org>
Message-Id: <20080603170520.017934731@de.ibm.com>
References: <20080603165859.107949986@de.ibm.com>
Date: Tue, 03 Jun 2008 18:59:06 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 07/14] cio: introduce fcx bit to chsc characteristics
Content-Disposition: inline; filename=106-fcx-chsc.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Introduce fcx bit to chsc characteristics.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chsc.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/cio/chsc.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.h
+++ quilt-2.6/drivers/s390/cio/chsc.h
@@ -49,7 +49,9 @@ struct css_general_char {
 	u32 qebsm : 1;   /* bit 58 */
 	u32 : 8;
 	u32 aif_osa : 1; /* bit 67 */
-	u32 : 28;
+	u32 : 20;
+	u32 fcx : 1;	 /* bit 88 */
+	u32 : 7;
 }__attribute__((packed));
 
 struct css_chsc_char {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
