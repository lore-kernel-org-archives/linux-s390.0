Return-Path: <linux-kernel-owner+w=401wt.eu-S1760953AbYBSOsi@vger.kernel.org>
Message-Id: <20080219144505.029121882@de.ibm.com>
References: <20080219144047.587547541@de.ibm.com>
Date: Tue, 19 Feb 2008 15:40:56 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 09/13] etr: fix compile error on !SMP
Content-Disposition: inline; filename=009-etr-nonsmp.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Since a5fbb6d1064be885d2a6b82f625186753cf74848
"KVM: fix !SMP build error" smp_call_function isn't a define anymore
that folds into nothing but a define that calls up_smp_call_function
with all parameters. Hence we cannot #ifdef out the unused code
anymore...
This seems to be the preferred method, so do this for s390 as well.

arch/s390/kernel/time.c: In function 'etr_sync_clock':
arch/s390/kernel/time.c:825: error: 'clock_sync_cpu_start' undeclared
arch/s390/kernel/time.c:862: error: 'clock_sync_cpu_end' undeclared

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/time.c |    2 --
 1 file changed, 2 deletions(-)

Index: quilt-2.6/arch/s390/kernel/time.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/time.c
+++ quilt-2.6/arch/s390/kernel/time.c
@@ -744,7 +744,6 @@ static void etr_adjust_time(unsigned lon
 	}
 }
 
-#ifdef CONFIG_SMP
 static void etr_sync_cpu_start(void *dummy)
 {
 	int *in_sync = dummy;
@@ -777,7 +776,6 @@ static void etr_sync_cpu_start(void *dum
 static void etr_sync_cpu_end(void *dummy)
 {
 }
-#endif /* CONFIG_SMP */
 
 /*
  * Sync the TOD clock using the port refered to by aibp. This port

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
