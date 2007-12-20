Return-Path: <linux-kernel-owner+w=401wt.eu-S933628AbXLTPV2@vger.kernel.org>
Message-Id: <20071220152103.123287240@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:26 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 01/47] Cleanup in Documentation/kernel-parameters.txt.
Content-Disposition: inline; filename=100-cio-docu.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Sebastian Ott <sebott@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@de.ibm.com>

Signed-off-by: Sebastian Ott <sebott@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/kernel-parameters.txt |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: quilt-2.6/Documentation/kernel-parameters.txt
===================================================================
--- quilt-2.6.orig/Documentation/kernel-parameters.txt
+++ quilt-2.6/Documentation/kernel-parameters.txt
@@ -369,8 +369,6 @@ and is between 256 and 4096 characters. 
 			configured.  Potentially dangerous and should only be
 			used if you are entirely sure of the consequences.
 
-	chandev=	[HW,NET] Generic channel device initialisation
-
 	checkreqprot	[SELINUX] Set initial checkreqprot flag value.
 			Format: { "0" | "1" }
 			See security/selinux/Kconfig help text.
@@ -381,6 +379,12 @@ and is between 256 and 4096 characters. 
 			Value can be changed at runtime via
 				/selinux/checkreqprot.
 
+	cio_ignore=	[S390]
+			See Documentation/s390/CommonIO for details.
+
+	cio_msg=	[S390]
+			See Documentation/s390/CommonIO for details.
+
 	clock=		[BUGS=X86-32, HW] gettimeofday clocksource override.
 			[Deprecated]
 			Forces specified clocksource (if available) to be used

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
