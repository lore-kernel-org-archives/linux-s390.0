Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811B24B04AD;
	Mon,  5 Oct 2026 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211816; cv=none; b=XpvOCXlOdXDzkcBfN+iCLsrmnpcCGdVfCj4tr1eJzdJqNc9w1dONGVzK5DqeIqC2qh6iovMVQrlWgiM/Uzwk7/9RXZL1Z/B9ZXpfljBy39mNOj51MunHpkNI3XNgig61DFBflFMSXOfEKpUFPFOOPOiUzvId1smjJKOJU/uImtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211816; c=relaxed/simple;
	bh=5cTWjD0mnj1yXOk6RfXezQeY0F59HG7VGw8r3u9d0sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnR7nmcnHDcqoA2ulYtHo83XvnSVZXjesGiqvWTvpIAsTffFnfGCYhxk44VkQkaoFUizyI2jujZMjpY8HNrDTxJqtAQbthO0rpIAWGDHmbs+HE7rd3ejXOLzF+UXBDBz3AFs891liXcI3IEGmgcy4N3T/4+lJDzlAZkXNBsT9WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V2y0U3Z+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V2y0U3Z+"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695EZdTu3285526;
	Mon, 5 Oct 2026 14:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=i6h1GEC5HIyV6EYuF
	OZnavVKR0eSGCP+tDoZBzqFbTE=; b=V2y0U3Z+yTMsSYcGmatN8gvHQFoWdnmUn
	rTRiyqGNL/fCaU7JbYPJ9AWSwYygzVv4Bl5ncAfG86mtYzwrrm9JUVa/y6iAlKs2
	iKKgSqYG5GtcS4ZdA+pkgFypTfRobe6J4KST3OlizTaZc/rpy4cWLxDHK0jOcYbU
	czQI5xLQAN8unCgFzmHNCInOx2sNWM/r+pX0T0NBJ8gV0fCG6YRa6zZC8emiPslL
	qgv5jCJetvvrbMI8bWDTVGl66bybekwfHwBHt3BG2PPaQeav7pnzSPXW+wrzZg1Y
	/EKBiXJmpx6FhgGJKqxpsxB03sXjKmry9NmuUp2JlH/AXpoU9PRig==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scraukv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 14:50:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695EWgJ03050751;
	Mon, 5 Oct 2026 14:50:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1pp2ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 14:50:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695Eo5gq53215694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 14:50:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4712620040;
	Mon,  5 Oct 2026 14:50:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 198D720043;
	Mon,  5 Oct 2026 14:50:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 14:50:05 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [RFC PATCH 2/2] s390/vtime: Remove vtimer infrastructure
Date: Mon,  5 Oct 2026 16:50:04 +0200
Message-ID: <20261005145004.156348-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005145004.156348-1-hca@linux.ibm.com>
References: <20261005145004.156348-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1NyBTYWx0ZWRfX11if0NSvmdwW
 jI7cCWRG8GEv/TVdMokVkw+ShwWnrG7kwMkZEqPslkAAJIcAhaM7EZ1d/DnvxnJg5Mh9lTyhR2q
 lu6AwedAAm5IzIKUW5Ao8TxkBBaUvYI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1NyBTYWx0ZWRfX3lUH6VCwzweT
 BbXYiZqF1r0YiXo2Uoh54FKB7u++1J4M+s4ZQbtERF3pVYe40okptMDL1mSxeJJ29qEpTvXvxve
 lKA6+XmA1Un3x2GzsjmgbQTkzSqCFT+4dAUZnpEz7Ej+4c6YUDrV4MZBmZLwGw5XosIAFjSQrD9
 4BHhLcTQJAgwbCwyrEpuWPh/JlRw2/lVFJWRhBpBoTGpjWBljyGMxyl3CmKQ/V98y4xz/+Pz2Gx
 i+d20UrrzsGv4plM0c56uFTyoMQbkLwyie8ST9Aso5iuQigM4tLmmWEYYIcnlaNFnGxlK//3vjj
 rj2o+GyQ5jlMi7prHGvegARZ8rncMgOTH59nSP/tFsCfn5F9jv9DQzcCaSUIOD5sxZlmHM7Brc7
 fwk6C48g7dEmngKtAkO39PAXkhqXRS4kA/ijWyTdVhsKm8KH16nWIi+WzCVON4U6YzLX3qgCcS5
 +126d7uujvx3X9hc2+g==
X-Proofpoint-GUID: -9LuSAcTSRV-VB9A5DzwfTfPSycBaxGQ
X-Proofpoint-ORIG-GUID: -9LuSAcTSRV-VB9A5DzwfTfPSycBaxGQ
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac3b921 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=4MNNjMLRCm2piMos7SkA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050057

The only user is gone - remove the vtimer infrastructure.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/vtime.h  |   2 +
 arch/s390/include/asm/vtimer.h |  30 -----
 arch/s390/kernel/process.c     |   1 -
 arch/s390/kernel/smp.c         |   2 +-
 arch/s390/kernel/time.c        |   2 +-
 arch/s390/kernel/vtime.c       | 212 ++-------------------------------
 6 files changed, 12 insertions(+), 237 deletions(-)
 delete mode 100644 arch/s390/include/asm/vtimer.h

diff --git a/arch/s390/include/asm/vtime.h b/arch/s390/include/asm/vtime.h
index da116a93d3b6..22e494b22192 100644
--- a/arch/s390/include/asm/vtime.h
+++ b/arch/s390/include/asm/vtime.h
@@ -8,6 +8,8 @@
 
 DECLARE_PER_CPU(u64, mt_cycles[8]);
 
+void vtime_init(void);
+
 static inline void update_timer_sys(void)
 {
 	struct lowcore *lc = get_lowcore();
diff --git a/arch/s390/include/asm/vtimer.h b/arch/s390/include/asm/vtimer.h
deleted file mode 100644
index e601adaa6320..000000000000
--- a/arch/s390/include/asm/vtimer.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  Copyright IBM Corp. 2003, 2012
- *  Virtual CPU timer
- *
- *  Author(s): Jan Glauber <jan.glauber@de.ibm.com>
- */
-
-#ifndef _ASM_S390_TIMER_H
-#define _ASM_S390_TIMER_H
-
-#define VTIMER_MAX_SLICE (0x7fffffffffffffffULL)
-
-struct vtimer_list {
-	struct list_head entry;
-	u64 expires;
-	u64 interval;
-	void (*function)(unsigned long);
-	unsigned long data;
-};
-
-extern void init_virt_timer(struct vtimer_list *timer);
-extern void add_virt_timer(struct vtimer_list *timer);
-extern void add_virt_timer_periodic(struct vtimer_list *timer);
-extern int mod_virt_timer(struct vtimer_list *timer, u64 expires);
-extern int mod_virt_timer_periodic(struct vtimer_list *timer, u64 expires);
-extern int del_virt_timer(struct vtimer_list *timer);
-extern void vtime_init(void);
-
-#endif /* _ASM_S390_TIMER_H */
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 416650ae4871..4c73d2528fcb 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -35,7 +35,6 @@
 #include <asm/cpu_mf.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
-#include <asm/vtimer.h>
 #include <asm/exec.h>
 #include <asm/fpu.h>
 #include <asm/irq.h>
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 32499cad86f0..f7c262a17c03 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -48,7 +48,7 @@
 #include <asm/setup.h>
 #include <asm/irq.h>
 #include <asm/tlbflush.h>
-#include <asm/vtimer.h>
+#include <asm/vtime.h>
 #include <asm/abs_lowcore.h>
 #include <asm/sclp.h>
 #include <asm/debug.h>
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 2b989bebd220..dd8a88cc9c4b 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -48,9 +48,9 @@
 #include <asm/vdso.h>
 #include <asm/irq.h>
 #include <asm/irq_regs.h>
-#include <asm/vtimer.h>
 #include <asm/stp.h>
 #include <asm/cio.h>
+#include <asm/vtime.h>
 #include "entry.h"
 
 union tod_clock __bootdata_preserved(tod_clock_base);
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index efcbf406f03e..d9fd39c5732e 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *    Virtual cpu timer based timer functions.
+ *    Virtual CPU time accounting
  *
  *    Copyright IBM Corp. 2004, 2012
  *    Author(s): Jan Glauber <jan.glauber@de.ibm.com>
@@ -14,7 +14,6 @@
 #include <linux/time.h>
 #include <asm/alternative.h>
 #include <asm/cputime.h>
-#include <asm/vtimer.h>
 #include <asm/vtime.h>
 #include <asm/cpu_mf.h>
 #include <asm/idle.h>
@@ -22,19 +21,14 @@
 
 #include "entry.h"
 
-static void virt_timer_expire(void);
-
-static LIST_HEAD(virt_timer_list);
-static DEFINE_SPINLOCK(virt_timer_lock);
-static atomic64_t virt_timer_current;
-static atomic64_t virt_timer_elapsed;
+#define CPU_TIMER_MAX	0x7fffffffffffffffUL
 
 DEFINE_PER_CPU(u64, mt_cycles[8]);
 static DEFINE_PER_CPU(u64, mt_scaling_mult) = { 1 };
 static DEFINE_PER_CPU(u64, mt_scaling_div) = { 1 };
 static DEFINE_PER_CPU(unsigned long, mt_scaling_jiffies);
 
-static inline void set_vtimer(u64 expires)
+static inline void cpu_timer_init(u64 value)
 {
 	struct lowcore *lc = get_lowcore();
 	u64 timer;
@@ -42,18 +36,9 @@ static inline void set_vtimer(u64 expires)
 	asm volatile(
 		"	stpt	%0\n"	/* Store current cpu timer value */
 		"	spt	%1"	/* Set new value imm. afterwards */
-		: "=Q" (timer) : "Q" (expires));
+		: "=Q" (timer) : "Q" (value));
 	lc->system_timer += lc->last_update_timer - timer;
-	lc->last_update_timer = expires;
-}
-
-static inline int virt_timer_forward(u64 elapsed)
-{
-	lockdep_assert_irqs_disabled();
-	if (list_empty(&virt_timer_list))
-		return 0;
-	elapsed = atomic64_add_return(elapsed, &virt_timer_elapsed);
-	return elapsed >= atomic64_read(&virt_timer_current);
+	lc->last_update_timer = value;
 }
 
 static void update_mt_scaling(void)
@@ -125,7 +110,7 @@ static inline void vtime_reset_last_update(struct lowcore *lc)
  * Update process times based on virtual cpu times stored by entry.S
  * to the lowcore fields user_timer, system_timer & steal_clock.
  */
-static int do_account_vtime(struct task_struct *tsk)
+static void do_account_vtime(struct task_struct *tsk)
 {
 	u64 timer, clock, user, guest, system, hardirq, softirq;
 	struct lowcore *lc = get_lowcore();
@@ -172,8 +157,6 @@ static int do_account_vtime(struct task_struct *tsk)
 		account_system_index_scaled(tsk, hardirq, CPUTIME_IRQ);
 	if (softirq)
 		account_system_index_scaled(tsk, softirq, CPUTIME_SOFTIRQ);
-
-	return virt_timer_forward(user + guest + system + hardirq + softirq);
 }
 
 void vtime_task_switch(struct task_struct *prev)
@@ -203,8 +186,7 @@ void vtime_flush(struct task_struct *tsk)
 	struct lowcore *lc = get_lowcore();
 	u64 steal, avg_steal;
 
-	if (do_account_vtime(tsk))
-		virt_timer_expire();
+	do_account_vtime(tsk);
 
 	steal = lc->steal_timer;
 	avg_steal = lc->avg_steal_timer;
@@ -247,187 +229,9 @@ void vtime_account_hardirq(struct task_struct *tsk)
 	get_lowcore()->hardirq_timer += vtime_delta();
 }
 
-/*
- * Sorted add to a list. List is linear searched until first bigger
- * element is found.
- */
-static void list_add_sorted(struct vtimer_list *timer, struct list_head *head)
-{
-	struct vtimer_list *tmp;
-
-	list_for_each_entry(tmp, head, entry) {
-		if (tmp->expires > timer->expires) {
-			list_add_tail(&timer->entry, &tmp->entry);
-			return;
-		}
-	}
-	list_add_tail(&timer->entry, head);
-}
-
-/*
- * Handler for expired virtual CPU timer.
- */
-static void virt_timer_expire(void)
-{
-	struct vtimer_list *timer, *tmp;
-	unsigned long elapsed;
-	LIST_HEAD(cb_list);
-
-	/* walk timer list, fire all expired timers */
-	spin_lock(&virt_timer_lock);
-	elapsed = atomic64_read(&virt_timer_elapsed);
-	list_for_each_entry_safe(timer, tmp, &virt_timer_list, entry) {
-		if (timer->expires < elapsed)
-			/* move expired timer to the callback queue */
-			list_move_tail(&timer->entry, &cb_list);
-		else
-			timer->expires -= elapsed;
-	}
-	if (!list_empty(&virt_timer_list)) {
-		timer = list_first_entry(&virt_timer_list,
-					 struct vtimer_list, entry);
-		atomic64_set(&virt_timer_current, timer->expires);
-	}
-	atomic64_sub(elapsed, &virt_timer_elapsed);
-	spin_unlock(&virt_timer_lock);
-
-	/* Do callbacks and recharge periodic timers */
-	list_for_each_entry_safe(timer, tmp, &cb_list, entry) {
-		list_del_init(&timer->entry);
-		timer->function(timer->data);
-		if (timer->interval) {
-			/* Recharge interval timer */
-			timer->expires = timer->interval +
-				atomic64_read(&virt_timer_elapsed);
-			spin_lock(&virt_timer_lock);
-			list_add_sorted(timer, &virt_timer_list);
-			spin_unlock(&virt_timer_lock);
-		}
-	}
-}
-
-void init_virt_timer(struct vtimer_list *timer)
-{
-	timer->function = NULL;
-	INIT_LIST_HEAD(&timer->entry);
-}
-EXPORT_SYMBOL(init_virt_timer);
-
-static inline int vtimer_pending(struct vtimer_list *timer)
-{
-	return !list_empty(&timer->entry);
-}
-
-static void internal_add_vtimer(struct vtimer_list *timer)
-{
-	if (list_empty(&virt_timer_list)) {
-		/* First timer, just program it. */
-		atomic64_set(&virt_timer_current, timer->expires);
-		atomic64_set(&virt_timer_elapsed, 0);
-		list_add(&timer->entry, &virt_timer_list);
-	} else {
-		/* Update timer against current base. */
-		timer->expires += atomic64_read(&virt_timer_elapsed);
-		if (likely((s64) timer->expires <
-			   (s64) atomic64_read(&virt_timer_current)))
-			/* The new timer expires before the current timer. */
-			atomic64_set(&virt_timer_current, timer->expires);
-		/* Insert new timer into the list. */
-		list_add_sorted(timer, &virt_timer_list);
-	}
-}
-
-static void __add_vtimer(struct vtimer_list *timer, int periodic)
-{
-	unsigned long flags;
-
-	timer->interval = periodic ? timer->expires : 0;
-	spin_lock_irqsave(&virt_timer_lock, flags);
-	internal_add_vtimer(timer);
-	spin_unlock_irqrestore(&virt_timer_lock, flags);
-}
-
-/*
- * add_virt_timer - add a oneshot virtual CPU timer
- */
-void add_virt_timer(struct vtimer_list *timer)
-{
-	__add_vtimer(timer, 0);
-}
-EXPORT_SYMBOL(add_virt_timer);
-
-/*
- * add_virt_timer_int - add an interval virtual CPU timer
- */
-void add_virt_timer_periodic(struct vtimer_list *timer)
-{
-	__add_vtimer(timer, 1);
-}
-EXPORT_SYMBOL(add_virt_timer_periodic);
-
-static int __mod_vtimer(struct vtimer_list *timer, u64 expires, int periodic)
-{
-	unsigned long flags;
-	int rc;
-
-	BUG_ON(!timer->function);
-
-	if (timer->expires == expires && vtimer_pending(timer))
-		return 1;
-	spin_lock_irqsave(&virt_timer_lock, flags);
-	rc = vtimer_pending(timer);
-	if (rc)
-		list_del_init(&timer->entry);
-	timer->interval = periodic ? expires : 0;
-	timer->expires = expires;
-	internal_add_vtimer(timer);
-	spin_unlock_irqrestore(&virt_timer_lock, flags);
-	return rc;
-}
-
-/*
- * returns whether it has modified a pending timer (1) or not (0)
- */
-int mod_virt_timer(struct vtimer_list *timer, u64 expires)
-{
-	return __mod_vtimer(timer, expires, 0);
-}
-EXPORT_SYMBOL(mod_virt_timer);
-
-/*
- * returns whether it has modified a pending timer (1) or not (0)
- */
-int mod_virt_timer_periodic(struct vtimer_list *timer, u64 expires)
-{
-	return __mod_vtimer(timer, expires, 1);
-}
-EXPORT_SYMBOL(mod_virt_timer_periodic);
-
-/*
- * Delete a virtual timer.
- *
- * returns whether the deleted timer was pending (1) or not (0)
- */
-int del_virt_timer(struct vtimer_list *timer)
-{
-	unsigned long flags;
-
-	if (!vtimer_pending(timer))
-		return 0;
-	spin_lock_irqsave(&virt_timer_lock, flags);
-	list_del_init(&timer->entry);
-	spin_unlock_irqrestore(&virt_timer_lock, flags);
-	return 1;
-}
-EXPORT_SYMBOL(del_virt_timer);
-
-/*
- * Start the virtual CPU timer on the current CPU.
- */
 void vtime_init(void)
 {
-	/* set initial cpu timer */
-	set_vtimer(VTIMER_MAX_SLICE);
+	cpu_timer_init(CPU_TIMER_MAX);
 	/* Setup initial MT scaling values */
 	if (smp_cpu_mtid) {
 		__this_cpu_write(mt_scaling_jiffies, jiffies);
-- 
2.53.0

