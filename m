Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9A73E1201;
	Tue,  6 Oct 2026 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791295282; cv=none; b=fvQGIZT3ekC4+JdeO+ELZsGg0C8b3ZoYptow+6D21XMgJCuOuGtat00j2y/NXuxOJDdvi5g9VV0P0nBdkeEJoiQFH9gCrT/o7W8sCwEfH1DM9vHn3m5J5oMbCUO05GbXd3qmzuCJcE2+iFKNGgSuBudrq0lVQIJ62610+0pp2Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791295282; c=relaxed/simple;
	bh=qOCh9C+Evgp9lkCcnBVAgFlXEgQBvPUg5axfsVcsnVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgbi8ICYGPmuN1DxErof2R+ES75tuWOWrtQ6j9CNnTg4nyXhqo/dLaXMn13qp+Y4HeM7p+NZ/CwWuwin57EsqEnvu9jVCnkY7xCKSWw4UW+ob3GH45ka935xXSdQ4ISAZLI+0eQH/5muB5MezGbeYz2REuCz17O+E5DsWBe1YFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oXcR4Q5s; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oXcR4Q5s"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696DZnk33868399;
	Tue, 6 Oct 2026 14:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/hcJ8UAceMbZDstty
	NBdFJmrBIAcNJVwyA3a25u6Drw=; b=oXcR4Q5sOI7lWQEORrlJ8a9EZ99hK79zh
	Hz5k0hH6rmogGxECZAyxCKH1JVXeOmhmxQjAEMzc0AuaFS9DSChX9bSONaASxsJQ
	bKGOcmPTk5l5wYEjd+5kdzssaKid5wahSMrwvANijpU74LMBEs02+qQsvbswLuxq
	1ywFAy54qD5Dk5ucNH7tIQ/P6e1YMOzcyo3w7z/dGr9EErObwHDHE9Mu+/JzIIIA
	C4hqLzodnf8klTH5qEVib8GiVSG5i4ktu4iDbC72ifyiMgFPG4c8I6nWJKBM6cUG
	O/vDiDLde4Fpgss99tbP0/0iOsX08PioCoj6D3tjlbpKDXmEPdl3A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbv7bs1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 14:01:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696DWp44403731;
	Tue, 6 Oct 2026 14:01:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgt3uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 14:01:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696E1EkM39059726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 14:01:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 308782004B;
	Tue,  6 Oct 2026 14:01:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5D7D2004F;
	Tue,  6 Oct 2026 14:01:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 14:01:13 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 1/2] s390/appldata: Emulate virtual timer with delayed work
Date: Tue,  6 Oct 2026 16:01:12 +0200
Message-ID: <20261006140113.3128582-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006140113.3128582-1-hca@linux.ibm.com>
References: <20261006140113.3128582-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RGdXdDdTR-DcsXOgd6KXHpFHrNUH1rak
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1NCBTYWx0ZWRfX8KC5qH8exRAU
 dU7uxvlZYhSmLQSXlGnHJZGWamsZAQKh6Osx6DP2BIxaffZhRt01JS6M8FCAVJLoSrKpcyo9VCV
 FmcDaKl8BaVdAF8FHJApPvofMjTQT3c=
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac4ff2f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=ii8wfsY1mSSEofDs_2AA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: RGdXdDdTR-DcsXOgd6KXHpFHrNUH1rak
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1NCBTYWx0ZWRfXziA9vzzMhTxb
 88/dEOF3eZXsGQmCPlgjM9Q4/bFYyeTH5lUtCduFsGKuiCZ6j9RYSBxe2IKS4qJjmBXyaWoyBuj
 XhNIZiVNYwOGSZVhG7pRs/0fT3nOmIS3N7aFo9+DMCAgZdSvAqIgMdDDYiO1TH0lCFmD3RW7TRY
 5xMvCTODeBWzt90mn1hHsnxHdwp+J1V+vMpdKGQMCd/Z6KoMfh9Wg0V7yDm9Jz9EnE0qcVKFzm1
 W2HrLltjeB9k9lJcbE7/GV4O1gVv0/Jr1TBoVCImNPUHDOdh24Zi06MT6Nz8VjrB0dCNSJdzfNb
 vPzt383dASP0IHlHKDRG3MyZ0yk+xLRrb+/vd27BuBQ95r6GmJeWskz+qLt9cDMPpWXj5kznEFO
 54/bauUgG3jrKbmltfSVIGrXyqn2Ww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060054

Emulate the virtual timer in appldata using delayed work: the work is
scheduled for the minimum possible wall-clock time until the
configured CPU-time interval elapses (remaining CPU time / number of
online CPUs), with a minimum delay of 100ms. The work then reads
per-CPU statistics of all online CPUs to check whether enough CPU time
has elapsed, and if so runs the registered callbacks.

This is slightly more expensive, but allows to subsequently remove the
entire vtimer infrastructure.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/appldata/appldata_base.c | 171 ++++++++++++++++++-----------
 1 file changed, 107 insertions(+), 64 deletions(-)

diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index 9cba4633c3f3..836c51da18f4 100644
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
@@ -89,14 +76,34 @@ static LIST_HEAD(appldata_ops_list);
 
 
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
+	for_each_possible_cpu(cpu) {
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
+	mod_delayed_work(system_percpu_wq, &appldata_work, delay);
 }
 
 /*
@@ -106,9 +113,27 @@ static void appldata_timer_function(unsigned long data)
  */
 static void appldata_work_fn(struct work_struct *work)
 {
-	struct list_head *lh;
+	u64 now, elapsed, interval;
 	struct appldata_ops *ops;
+	struct list_head *lh;
+	bool expired = false;
 
+	now = appldata_total_cpu_time_ns();
+	mutex_lock(&appldata_timer_lock);
+	if (appldata_timer_active) {
+		interval = appldata_interval;
+		elapsed = now - appldata_cputime_start;
+		if (elapsed < interval) {
+			appldata_schedule_work(interval - elapsed);
+		} else {
+			appldata_cputime_start = now;
+			appldata_schedule_work(interval);
+			expired = true;
+		}
+	}
+	mutex_unlock(&appldata_timer_lock);
+	if (!expired)
+		return;
 	mutex_lock(&appldata_ops_mutex);
 	list_for_each(lh, &appldata_ops_list) {
 		ops = list_entry(lh, struct appldata_ops, list);
@@ -162,33 +187,52 @@ int appldata_diag(char record_nr, u16 function, unsigned long buffer,
 #define APPLDATA_MOD_TIMER	2
 
 /*
- * __appldata_vtimer_setup()
+ * __appldata_timer_setup()
  *
- * Add, delete or modify virtual timers on all online cpus.
- * The caller needs to get the appldata_timer_lock spinlock.
+ * Add, delete or modify the appldata delayed work.
  */
-static void __appldata_vtimer_setup(int cmd)
+static void __appldata_timer_setup(int cmd)
 {
-	u64 timer_interval = (u64) appldata_interval * 1000 * TOD_MICRO;
+	static DEFINE_MUTEX(appldata_cancel_lock);
+	u64 now, elapsed, remaining;
 
 	switch (cmd) {
 	case APPLDATA_ADD_TIMER:
-		if (appldata_timer_active)
-			break;
-		appldata_timer.expires = timer_interval;
-		add_virt_timer_periodic(&appldata_timer);
-		appldata_timer_active = 1;
+		mutex_lock(&appldata_cancel_lock);
+		mutex_lock(&appldata_timer_lock);
+		if (!appldata_timer_active) {
+			appldata_cputime_start = appldata_total_cpu_time_ns();
+			appldata_schedule_work(appldata_interval);
+			appldata_timer_active = 1;
+		}
+		mutex_unlock(&appldata_timer_lock);
+		mutex_unlock(&appldata_cancel_lock);
 		break;
 	case APPLDATA_DEL_TIMER:
-		del_virt_timer(&appldata_timer);
-		if (!appldata_timer_active)
+		mutex_lock(&appldata_cancel_lock);
+		mutex_lock(&appldata_timer_lock);
+		if (!appldata_timer_active) {
+			mutex_unlock(&appldata_timer_lock);
+			mutex_unlock(&appldata_cancel_lock);
 			break;
+		}
 		appldata_timer_active = 0;
+		mutex_unlock(&appldata_timer_lock);
+		cancel_delayed_work_sync(&appldata_work);
+		mutex_unlock(&appldata_cancel_lock);
 		break;
 	case APPLDATA_MOD_TIMER:
-		if (!appldata_timer_active)
-			break;
-		mod_virt_timer_periodic(&appldata_timer, timer_interval);
+		mutex_lock(&appldata_timer_lock);
+		if (appldata_timer_active) {
+			now = appldata_total_cpu_time_ns();
+			elapsed = now - appldata_cputime_start;
+			remaining = appldata_interval - elapsed;
+			if (elapsed >= appldata_interval)
+				remaining = 1;
+			appldata_schedule_work(remaining);
+		}
+		mutex_unlock(&appldata_timer_lock);
+		break;
 	}
 }
 
@@ -215,12 +259,10 @@ appldata_timer_handler(const struct ctl_table *ctl, int write,
 	if (rc < 0 || !write)
 		return rc;
 
-	spin_lock(&appldata_timer_lock);
 	if (timer_active)
-		__appldata_vtimer_setup(APPLDATA_ADD_TIMER);
+		__appldata_timer_setup(APPLDATA_ADD_TIMER);
 	else
-		__appldata_vtimer_setup(APPLDATA_DEL_TIMER);
-	spin_unlock(&appldata_timer_lock);
+		__appldata_timer_setup(APPLDATA_DEL_TIMER);
 	return 0;
 }
 
@@ -234,7 +276,7 @@ static int
 appldata_interval_handler(const struct ctl_table *ctl, int write,
 			   void *buffer, size_t *lenp, loff_t *ppos)
 {
-	int interval = appldata_interval;
+	int interval = appldata_interval / NSEC_PER_MSEC;
 	int rc;
 	struct ctl_table ctl_entry = {
 		.procname	= ctl->procname,
@@ -247,10 +289,10 @@ appldata_interval_handler(const struct ctl_table *ctl, int write,
 	if (rc < 0 || !write)
 		return rc;
 
-	spin_lock(&appldata_timer_lock);
-	appldata_interval = interval;
-	__appldata_vtimer_setup(APPLDATA_MOD_TIMER);
-	spin_unlock(&appldata_timer_lock);
+	mutex_lock(&appldata_timer_lock);
+	appldata_interval = interval * NSEC_PER_MSEC;
+	mutex_unlock(&appldata_timer_lock);
+	__appldata_timer_setup(APPLDATA_MOD_TIMER);
 	return 0;
 }
 
@@ -392,19 +434,20 @@ void appldata_unregister_ops(struct appldata_ops *ops)
 
 /******************************* init / exit *********************************/
 
-/*
- * appldata_init()
- *
- * init timer, register /proc entries
- */
+static int appldata_cpu_online(unsigned int cpu)
+{
+	__appldata_timer_setup(APPLDATA_MOD_TIMER);
+	return 0;
+}
+
 static int __init appldata_init(void)
 {
-	init_virt_timer(&appldata_timer);
-	appldata_timer.function = appldata_timer_function;
-	appldata_timer.data = (unsigned long) &appldata_work;
-	appldata_wq = alloc_ordered_workqueue("appldata", 0);
-	if (!appldata_wq)
-		return -ENOMEM;
+	int rc;
+
+	rc = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "s390/appldata:online",
+				       appldata_cpu_online, NULL);
+	if (rc < 0)
+		return rc;
 	register_sysctl(appldata_proc_name, appldata_table);
 	return 0;
 }
-- 
2.53.0

