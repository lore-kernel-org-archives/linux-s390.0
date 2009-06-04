Return-Path: <linux-kernel-owner+w=401wt.eu-S1757920AbZFDQYE@vger.kernel.org>
Message-Id: <20090604161900.426173095@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:18:51 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 04/38] device irq power management
Content-Disposition: inline; filename=pm_genirq_buildfix.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

On architectures without GENERIC_HARDIRQS there are no device irqs
to suspend or resume. Add an #ifdef to replace suspend_device_irqs()
and resume_device_irqs() with an empty inline function in that case.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 include/linux/interrupt.h |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: linux-2.6/include/linux/interrupt.h
===================================================================
--- linux-2.6.orig/include/linux/interrupt.h
+++ linux-2.6/include/linux/interrupt.h
@@ -183,9 +183,15 @@ extern void disable_irq(unsigned int irq
 extern void enable_irq(unsigned int irq);
 
 /* The following three functions are for the core kernel use only. */
+#ifdef CONFIG_GENERIC_HARDIRQS
 extern void suspend_device_irqs(void);
 extern void resume_device_irqs(void);
-#ifdef CONFIG_PM_SLEEP
+#else
+static inline void suspend_device_irqs(void) { }
+static inline void resume_device_irqs(void) { }
+#endif
+
+#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_GENERIC_HARDIRQS)
 extern int check_wakeup_irqs(void);
 #else
 static inline int check_wakeup_irqs(void) { return 0; }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
