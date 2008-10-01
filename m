Return-Path: <linux-kernel-owner+w=401wt.eu-S1755261AbYJAJBv@vger.kernel.org>
Message-Id: <20081001084129.857963493@de.ibm.com>
References: <20081001083317.782967473@de.ibm.com>
Date: Wed, 01 Oct 2008 10:33:35 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 18/21] Move private simple udelay function to arch/s390/lib/delay.c.
Content-Disposition: inline; filename=117-udelay-simple.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Move cio's private simple udelay function to lib/delay.c and turn it
into something much more readable. So we have all implementations
at one place.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/delay.h |    1 +
 arch/s390/lib/delay.c         |   13 +++++++++++++
 drivers/s390/cio/cio.c        |   17 ++---------------
 3 files changed, 16 insertions(+), 15 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/delay.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/delay.h
+++ quilt-2.6/arch/s390/include/asm/delay.h
@@ -15,6 +15,7 @@
 #define _S390_DELAY_H
 
 extern void __udelay(unsigned long usecs);
+extern void udelay_simple(unsigned long usecs);
 extern void __delay(unsigned long loops);
 
 #define udelay(n) __udelay(n)
Index: quilt-2.6/arch/s390/lib/delay.c
===================================================================
--- quilt-2.6.orig/arch/s390/lib/delay.c
+++ quilt-2.6/arch/s390/lib/delay.c
@@ -92,3 +92,16 @@ out:
 	local_irq_restore(flags);
 	preempt_enable();
 }
+
+/*
+ * Simple udelay variant. To be used on startup and reboot
+ * when the interrupt handler isn't working.
+ */
+void udelay_simple(unsigned long usecs)
+{
+	u64 end;
+
+	end = get_clock() + ((u64) usecs << 12);
+	while (get_clock() < end)
+		cpu_relax();
+}
Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -855,19 +855,6 @@ __disable_subchannel_easy(struct subchan
 	return -EBUSY; /* uhm... */
 }
 
-/* we can't use the normal udelay here, since it enables external interrupts */
-
-static void udelay_reset(unsigned long usecs)
-{
-	uint64_t start_cc, end_cc;
-
-	asm volatile ("STCK %0" : "=m" (start_cc));
-	do {
-		cpu_relax();
-		asm volatile ("STCK %0" : "=m" (end_cc));
-	} while (((end_cc - start_cc)/4096) < usecs);
-}
-
 static int
 __clear_io_subchannel_easy(struct subchannel_id schid)
 {
@@ -883,7 +870,7 @@ __clear_io_subchannel_easy(struct subcha
 			if (schid_equal(&ti.schid, &schid))
 				return 0;
 		}
-		udelay_reset(100);
+		udelay_simple(100);
 	}
 	return -EBUSY;
 }
@@ -891,7 +878,7 @@ __clear_io_subchannel_easy(struct subcha
 static void __clear_chsc_subchannel_easy(void)
 {
 	/* It seems we can only wait for a bit here :/ */
-	udelay_reset(100);
+	udelay_simple(100);
 }
 
 static int pgm_check_occured;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
