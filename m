Return-Path: <linux-kernel-owner+w=401wt.eu-S1759335AbYBEPpM@vger.kernel.org>
Message-Id: <20080205153913.137033549@de.ibm.com>
References: <20080205153835.337897404@de.ibm.com>
Date: Tue, 05 Feb 2008 16:38:44 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 09/18] console: allow vt220 console to be the only console
Content-Disposition: inline; filename=009-conmode.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Fix console detection logic to support configurations in which the
vt220 console is the only available Linux console.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/setup.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c
+++ quilt-2.6/arch/s390/kernel/setup.c
@@ -145,7 +145,7 @@ __setup("condev=", condev_setup);
 
 static int __init conmode_setup(char *str)
 {
-#if defined(CONFIG_SCLP_CONSOLE)
+#if defined(CONFIG_SCLP_CONSOLE) || defined(CONFIG_SCLP_VT220_CONSOLE)
 	if (strncmp(str, "hwc", 4) == 0 || strncmp(str, "sclp", 5) == 0)
                 SET_CONSOLE_SCLP;
 #endif
@@ -183,7 +183,7 @@ static void __init conmode_default(void)
 		 */
 		cpcmd("TERM CONMODE 3215", NULL, 0, NULL);
 		if (ptr == NULL) {
-#if defined(CONFIG_SCLP_CONSOLE)
+#if defined(CONFIG_SCLP_CONSOLE) || defined(CONFIG_SCLP_VT220_CONSOLE)
 			SET_CONSOLE_SCLP;
 #endif
 			return;
@@ -193,7 +193,7 @@ static void __init conmode_default(void)
 			SET_CONSOLE_3270;
 #elif defined(CONFIG_TN3215_CONSOLE)
 			SET_CONSOLE_3215;
-#elif defined(CONFIG_SCLP_CONSOLE)
+#elif defined(CONFIG_SCLP_CONSOLE) || defined(CONFIG_SCLP_VT220_CONSOLE)
 			SET_CONSOLE_SCLP;
 #endif
 		} else if (strncmp(ptr + 8, "3215", 4) == 0) {
@@ -201,7 +201,7 @@ static void __init conmode_default(void)
 			SET_CONSOLE_3215;
 #elif defined(CONFIG_TN3270_CONSOLE)
 			SET_CONSOLE_3270;
-#elif defined(CONFIG_SCLP_CONSOLE)
+#elif defined(CONFIG_SCLP_CONSOLE) || defined(CONFIG_SCLP_VT220_CONSOLE)
 			SET_CONSOLE_SCLP;
 #endif
 		}
@@ -212,7 +212,7 @@ static void __init conmode_default(void)
 		SET_CONSOLE_3270;
 #endif
 	} else {
-#if defined(CONFIG_SCLP_CONSOLE)
+#if defined(CONFIG_SCLP_CONSOLE) || defined(CONFIG_SCLP_VT220_CONSOLE)
 		SET_CONSOLE_SCLP;
 #endif
 	}

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
