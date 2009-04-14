Return-Path: <linux-kernel-owner+w=401wt.eu-S1756970AbZDNN5h@vger.kernel.org>
Message-Id: <20090414135349.139318931@de.ibm.com>
References: <20090414135327.576111185@de.ibm.com>
Date: Tue, 14 Apr 2009 15:53:38 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 11/14] fix idle time accounting
Content-Disposition: inline; filename=011-idle-accounting.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The steal time is calculated by subtracting the time the virtual cpu
has been running on a physical cpu from the wall clock time. To make
that work all wall time needs to be added to the steal time field first
before the virtual cpu time is subtracted.

The time between the last clock update and the load of the enabled wait
psw needs to be added to the steal_time field as well to make the sum
over all cpu accounting numbers match the wall clock.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/vtime.c |    2 ++
 1 file changed, 2 insertions(+)

Index: quilt-2.6/arch/s390/kernel/vtime.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/vtime.c
+++ quilt-2.6/arch/s390/kernel/vtime.c
@@ -134,6 +134,8 @@ void vtime_start_cpu(void)
 	/* Account time spent with enabled wait psw loaded as idle time. */
 	idle_time = S390_lowcore.int_clock - idle->idle_enter;
 	account_idle_time(idle_time);
+	S390_lowcore.steal_timer +=
+		idle->idle_enter - S390_lowcore.last_update_clock;
 	S390_lowcore.last_update_clock = S390_lowcore.int_clock;
 
 	/* Account system time spent going idle. */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
