Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B80E42E8E7;
	Mon,  5 Oct 2026 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211818; cv=none; b=dRqaV6eefW1TI4Ts8Es/jU0YC9Yc7ZrE0I+6gqeXE+UhEVgzasHuE7GYtFTOymODtHh3G7t/z1xBswQN2fPrrs0nO7sHH14+WD8o0fIrlNkG9S2x2/68f0eetwfVGYBxKhREkPdg02PIR2aCLITPp8efSu0Ss1ULYtB3DGnuLr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211818; c=relaxed/simple;
	bh=izhUoT5nd0mhvIDdlCk4nRZ6cDlDLJkZ83wq+nhvCd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmsxIHtKeCT2gs/rR2EfFaJGYJABCkXQvZPOuLhgnhHwJw3w8fyQwG5PaaepMwyeZo4smWhGOWYhFsHuIMm3Q9Wubi/zd4ILpGFWy7Mogh51blcReJrPvZxlXgQSZwIoM+yPQI+7L2u/AmO6UNsGwJofuRk54pZA5iONRYEYcB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cyKSYVL8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cyKSYVL8"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695EZtgA965083;
	Mon, 5 Oct 2026 14:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UM8/lcaUNwV3a3Gjq
	0QjWIWTMYLKGbOzWyiHTNHcsvE=; b=cyKSYVL8mIjZ0N+sm+USbYyNTczrkRbLy
	c5XJ/uP3DjMRXT9w2IBYw+aVO0B9nVSlsxKfpTKENFCAKhvBCRQbHjASh8E7X1Qr
	jktoUV6tMEIzeP9HCv0cFkclqXCxc6hZM1MmqIWqK0m8HhVSfThLoSW44PqhBEIr
	VvMTscVnB7vWaTaO8+EjsYZIDybVBa5G5oG3LGLeRqyzCDv5ovI4QBiOdL70Vgix
	27K7ECnOST7xUtDGhT5A/ciinv98M3MZY2jCKskaBNIr7LoZCi81/qa6lJb1gQ/D
	AbHpVVhe6NPgFvRyrJlBQgZNeV0BFMP+94W3EBR7jMApWHb+DRBRA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74jwkk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 14:50:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695EWZgf3025094;
	Mon, 5 Oct 2026 14:50:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jnvqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 14:50:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695Eo5ws48497074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 14:50:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1359320040;
	Mon,  5 Oct 2026 14:50:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D984A2004B;
	Mon,  5 Oct 2026 14:50:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 14:50:04 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [RFC PATCH 1/2] s390/appldata: Emulate virtual timer with delayed work
Date: Mon,  5 Oct 2026 16:50:03 +0200
Message-ID: <20261005145004.156348-2-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: GJTk-dtBJgFBrwziyEgYAp8Ja7QTXsZV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1NyBTYWx0ZWRfX/ARG5wVKscx4
 n4QmmjfwVDvUuL9puM14Ekh1TXhnospjKxO6x95MqhOUXqCzmzxAAyI1eukYTxW+m7KSFuZaZBo
 CZXt6WODzzNs6QxjvbzvY7mZwPIw2Ho=
X-Proofpoint-GUID: GJTk-dtBJgFBrwziyEgYAp8Ja7QTXsZV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1NyBTYWx0ZWRfX1VO15RUTZiln
 Y9SbDuiSzXu/iIl4fNFD6cUeSQfEYRdx08Px6gaLBG8Eda3rrTtI63hMa1dY4l+5wfAvuLN43Qi
 Hja0toYayWscGlUDV6ZpPPx60iPr/Uy8d698nxWWZw4LSPRMtqfcsaZGPDoeM8TePhJxxkDEKwA
 E2LqxuZ/6fqndGurlwjWTdE/D3qbVSqs12LDl1y8D9lam2heR/iCq8twB3sLO8tLoLygyz0X68h
 tjalujTqYNeA38eOt3jEGeiH/zNAwogrRFQeCYU1I+8csSTCZvMbEck+oOHQc4+yH8lY+Ys2G0E
 XsVCicM8h+YB/bilseW3bsNVJYuwsq1EEJs036bIETkDJkqP5FwZDR8v3AMNpu39YgmR8YoZLjS
 66qgx4OHcYLBomjloizamj2vN7U/rYfy/9TNiOMu/Ottf4UnejA9FmDY5d/9yoHF+IAFmBHyRw9
 TLr7a4rUKOqohGKKbqg==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac3b922 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ii8wfsY1mSSEofDs_2AA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050057

Emulate the virtual timer in appldata using delayed work: the work is
scheduled for the minimum possible wall-clock time until the
configured CPU-time interval elapses (remaining CPU time / number of
online CPUs), with a minimum delay of 100ms. The work then reads
per-CPU statistics of all online CPUs to check whether enough CPU time
has elapsed, and if so runs the registered callbacks.

This slightly more expensive, but allows to subsequently remove the
entire vtimer infrastructure.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/appldata/appldata_base.c | 150 ++++++++++++++++-------------
 1 file changed, 82 insertions(+), 68 deletions(-)

diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index 9cba4633c3f3..aca747c98f1b 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -28,19 +28,14 @@
 #include <linux/workqueue.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
+#include <linux/kernel_stat.h>
 #include <asm/appldata.h>
-#include <asm/vtimer.h>
 #include <asm/smp.h>
 
 #include "appldata.h"
 
-
-#define APPLDATA_CPU_INTERVAL	10000		/* default (CPU) time for
-						   sampling interval in
-						   milliseconds */
-
-#define TOD_MICRO	0x01000			/* nr. of TOD clock units
-						   for 1 microsecond */
+/* Default CPU time for sampling interval */
+#define APPLDATA_CPU_INTERVAL	(10 * NSEC_PER_SEC)
 
 /*
  * /proc entries (sysctl)
@@ -64,22 +59,14 @@ static const struct ctl_table appldata_table[] = {
 	},
 };
 
-/*
- * Timer
- */
-static struct vtimer_list appldata_timer;
+static void appldata_work_fn(struct work_struct *work);
+static DECLARE_DELAYED_WORK(appldata_work, appldata_work_fn);
 
-static DEFINE_SPINLOCK(appldata_timer_lock);
-static int appldata_interval = APPLDATA_CPU_INTERVAL;
+static DEFINE_MUTEX(appldata_timer_lock);
+static u64 appldata_interval = APPLDATA_CPU_INTERVAL;
 static int appldata_timer_active;
 
-/*
- * Work queue
- */
-static struct workqueue_struct *appldata_wq;
-static void appldata_work_fn(struct work_struct *work);
-static DECLARE_WORK(appldata_work, appldata_work_fn);
-
+static u64 appldata_cputime_start;
 
 /*
  * Ops list
@@ -89,34 +76,68 @@ static LIST_HEAD(appldata_ops_list);
 
 
 /*************************** timer, work, DIAG *******************************/
-/*
- * appldata_timer_function()
- *
- * schedule work and reschedule timer
- */
-static void appldata_timer_function(unsigned long data)
+static u64 appldata_total_cpu_time_ns(void)
 {
-	queue_work(appldata_wq, (struct work_struct *) data);
+	u64 total = 0;
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		total += kcpustat_cpu(cpu).cpustat[CPUTIME_USER];
+		total += kcpustat_cpu(cpu).cpustat[CPUTIME_NICE];
+		total += kcpustat_cpu(cpu).cpustat[CPUTIME_SYSTEM];
+		total += kcpustat_cpu(cpu).cpustat[CPUTIME_IRQ];
+		total += kcpustat_cpu(cpu).cpustat[CPUTIME_SOFTIRQ];
+	}
+	return total;
+}
+
+static void appldata_schedule_work(u64 remaining)
+{
+	unsigned int ncpus = num_online_cpus();
+	unsigned long delay = HZ / 10;
+
+	/*
+	 * At most ncpus CPUs consume CPU time simultaneously, so the
+	 * minimum wall-clock time until the remaining CPU time elapses
+	 * is remaining / ncpus.
+	 * Make sure the work is not scheduled more than once per 100ms.
+	 */
+	delay = max(delay, nsecs_to_jiffies(remaining / ncpus));
+	schedule_delayed_work(&appldata_work, delay);
 }
 
 /*
  * appldata_work_fn()
  *
- * call data gathering function for each (active) module
+ * Check whether the CPU-time interval has elapsed. If yes, run the
+ * data-gathering callbacks and reschedule for the next full interval.
+ * If no, only reschedule for the remaining time.
  */
 static void appldata_work_fn(struct work_struct *work)
 {
-	struct list_head *lh;
+	u64 now, elapsed, interval;
 	struct appldata_ops *ops;
+	struct list_head *lh;
 
-	mutex_lock(&appldata_ops_mutex);
+	now = appldata_total_cpu_time_ns();
+	scoped_guard(mutex, &appldata_timer_lock) {
+		if (!appldata_timer_active)
+			return;
+		interval = appldata_interval;
+		elapsed = now - appldata_cputime_start;
+		if (elapsed < interval) {
+			appldata_schedule_work(interval - elapsed);
+			return;
+		}
+		appldata_cputime_start = now;
+		appldata_schedule_work(interval);
+	}
+	guard(mutex)(&appldata_ops_mutex);
 	list_for_each(lh, &appldata_ops_list) {
 		ops = list_entry(lh, struct appldata_ops, list);
-		if (ops->active == 1) {
+		if (ops->active)
 			ops->callback(ops->data);
-		}
 	}
-	mutex_unlock(&appldata_ops_mutex);
 }
 
 static struct appldata_product_id appldata_id = {
@@ -162,33 +183,37 @@ int appldata_diag(char record_nr, u16 function, unsigned long buffer,
 #define APPLDATA_MOD_TIMER	2
 
 /*
- * __appldata_vtimer_setup()
+ * appldata_work_setup()
  *
- * Add, delete or modify virtual timers on all online cpus.
- * The caller needs to get the appldata_timer_lock spinlock.
+ * Add, delete or modify the appldata delayed work.
  */
-static void __appldata_vtimer_setup(int cmd)
+static void appldata_work_setup(int cmd)
 {
-	u64 timer_interval = (u64) appldata_interval * 1000 * TOD_MICRO;
+	u64 now, elapsed, remaining;
 
 	switch (cmd) {
 	case APPLDATA_ADD_TIMER:
+		lockdep_assert_held(&appldata_timer_lock);
 		if (appldata_timer_active)
 			break;
-		appldata_timer.expires = timer_interval;
-		add_virt_timer_periodic(&appldata_timer);
+		appldata_cputime_start = appldata_total_cpu_time_ns();
+		appldata_schedule_work(appldata_interval);
 		appldata_timer_active = 1;
 		break;
 	case APPLDATA_DEL_TIMER:
-		del_virt_timer(&appldata_timer);
-		if (!appldata_timer_active)
-			break;
+		lockdep_assert_not_held(&appldata_timer_lock);
 		appldata_timer_active = 0;
+		cancel_delayed_work_sync(&appldata_work);
 		break;
 	case APPLDATA_MOD_TIMER:
+		lockdep_assert_held(&appldata_timer_lock);
 		if (!appldata_timer_active)
 			break;
-		mod_virt_timer_periodic(&appldata_timer, timer_interval);
+		now = appldata_total_cpu_time_ns();
+		elapsed = now - appldata_cputime_start;
+		remaining = (elapsed < appldata_interval) ? (appldata_interval - elapsed) : 1;
+		appldata_schedule_work(remaining);
+		break;
 	}
 }
 
@@ -215,12 +240,12 @@ appldata_timer_handler(const struct ctl_table *ctl, int write,
 	if (rc < 0 || !write)
 		return rc;
 
-	spin_lock(&appldata_timer_lock);
-	if (timer_active)
-		__appldata_vtimer_setup(APPLDATA_ADD_TIMER);
-	else
-		__appldata_vtimer_setup(APPLDATA_DEL_TIMER);
-	spin_unlock(&appldata_timer_lock);
+	if (timer_active) {
+		scoped_guard(mutex, &appldata_timer_lock)
+			appldata_work_setup(APPLDATA_ADD_TIMER);
+	} else {
+		appldata_work_setup(APPLDATA_DEL_TIMER);
+	}
 	return 0;
 }
 
@@ -234,11 +259,11 @@ static int
 appldata_interval_handler(const struct ctl_table *ctl, int write,
 			   void *buffer, size_t *lenp, loff_t *ppos)
 {
-	int interval = appldata_interval;
+	int interval_ms = appldata_interval / NSEC_PER_MSEC;
 	int rc;
 	struct ctl_table ctl_entry = {
 		.procname	= ctl->procname,
-		.data		= &interval,
+		.data		= &interval_ms,
 		.maxlen		= sizeof(int),
 		.extra1		= SYSCTL_ONE,
 	};
@@ -247,10 +272,10 @@ appldata_interval_handler(const struct ctl_table *ctl, int write,
 	if (rc < 0 || !write)
 		return rc;
 
-	spin_lock(&appldata_timer_lock);
-	appldata_interval = interval;
-	__appldata_vtimer_setup(APPLDATA_MOD_TIMER);
-	spin_unlock(&appldata_timer_lock);
+	scoped_guard(mutex, &appldata_timer_lock) {
+		appldata_interval = interval_ms * NSEC_PER_MSEC;
+		appldata_work_setup(APPLDATA_MOD_TIMER);
+	}
 	return 0;
 }
 
@@ -392,19 +417,8 @@ void appldata_unregister_ops(struct appldata_ops *ops)
 
 /******************************* init / exit *********************************/
 
-/*
- * appldata_init()
- *
- * init timer, register /proc entries
- */
 static int __init appldata_init(void)
 {
-	init_virt_timer(&appldata_timer);
-	appldata_timer.function = appldata_timer_function;
-	appldata_timer.data = (unsigned long) &appldata_work;
-	appldata_wq = alloc_ordered_workqueue("appldata", 0);
-	if (!appldata_wq)
-		return -ENOMEM;
 	register_sysctl(appldata_proc_name, appldata_table);
 	return 0;
 }
-- 
2.53.0

