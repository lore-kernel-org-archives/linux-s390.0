Return-Path: <linux-kernel-owner+w=401wt.eu-S935080AbXLTP2A@vger.kernel.org>
Message-Id: <20071220152110.514200108@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:59 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 34/47] Load disabled wait psw instead of stopping cpu on halt.
Content-Disposition: inline; filename=133-disabled-wait.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Michael Holzheu <holzheu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@de.ibm.com>

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/ipl.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: quilt-2.6/arch/s390/kernel/ipl.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/ipl.c
+++ quilt-2.6/arch/s390/kernel/ipl.c
@@ -1087,8 +1087,12 @@ static struct shutdown_action vmcmd_acti
 
 static void stop_run(struct shutdown_trigger *trigger)
 {
-	signal_processor(smp_processor_id(), sigp_stop_and_store_status);
-	for (;;);
+	if (strcmp(trigger->name, ON_PANIC_STR) == 0)
+		disabled_wait((unsigned long) __builtin_return_address(0));
+	else {
+		signal_processor(smp_processor_id(), sigp_stop);
+		for (;;);
+	}
 }
 
 static struct shutdown_action stop_action = {SHUTDOWN_ACTION_STOP_STR,

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
