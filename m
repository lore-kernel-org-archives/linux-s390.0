Return-Path: <linux-kernel-owner+w=401wt.eu-S1755487AbYK0Kwr@vger.kernel.org>
Message-Id: <20081127103136.442737065@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:30:51 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 31/60] cio: update sac values
Content-Disposition: inline; filename=130-cio-fcx.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Values for the sac field have changed - update code accordingly.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/fcx.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/fcx.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/fcx.h
+++ quilt-2.6/arch/s390/include/asm/fcx.h
@@ -248,8 +248,8 @@ struct dcw {
 #define TCCB_MAX_SIZE		(sizeof(struct tccb_tcah) + \
 				 TCCB_MAX_DCW * sizeof(struct dcw) + \
 				 sizeof(struct tccb_tcat))
-#define TCCB_SAC_DEFAULT	0xf901
-#define TCCB_SAC_INTRG		0xf902
+#define TCCB_SAC_DEFAULT	0x1ffe
+#define TCCB_SAC_INTRG		0x1fff
 
 /**
  * struct tccb_tcah - Transport-Command-Area Header (TCAH)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
