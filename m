Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9499730676C;
	Wed, 13 May 2026 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680910; cv=none; b=Qb5EEBT3ul3DVC3OKn8i1AYkEpd4wA4Kf1rkJYwAOd9S3B5O6hv9H0H1y4p+9ekMlc7KwRAC0dJIQJjzwLoZY8jgkfZM0xCj84lCZ4SAcTFfojSLcXliCLbScC5VaGLnMMf8JQhnUkI2on4upor2+TdolycRWqb2sVM9zNG7NrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680910; c=relaxed/simple;
	bh=7kDHGOaYwjFIVIuupOXpLe46qHdviieAOA+flt2O/iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpJlxi0JqkqhurmpcQ4JbMzQtBYxKW9ldvzHgVqaJAOutBeX03gLPGeMzX0EKGtg6f6QJT62WkwuvEeIaLKnPmSDt9yGkyFUBRGAVSyDy/p9lyy9CVhoI7kz+Du/hKboSHEpZeAFBCUxcs3JvaMYNtPy61K3e/MTwinUQ+R/WxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g+GAY0Qe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g+GAY0Qe"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D3qbmM2613479;
	Wed, 13 May 2026 14:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Z5Bf/WH1Hmluh4kaQ
	CJ2UoYAtX4WNNCJN9+w4UnCG7w=; b=g+GAY0QeBKNTeTSIFiKMG8xwZqiOiZpJY
	FcuQ7HER88HgPC64dudbgOyWUfd2l9lPqUUTHSiTd0/fGDHkjQtM+otofC3eQjUk
	1KXTmEkj4gwHn5zaDdcze7oscfskIdIuOEojZW9af8ID0rOtpgtOfDz5oJVxkAnP
	i8CdArCXkuj3WOZK8tlVFbJ198POOZbeOhDk862YAHkGz2187kD/F3Akjh52SEKZ
	bEKVLNTxMg3X0CkbgzbqhYfpe+v/8J66w6I9eMQJmjWlUtKy2YMS3lbKHo0sMpu7
	lq9vtoynxxLhJeMrgYgYCiaEr1J8cjISGw3omXm7FP+sGVwnpZtpQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nve01n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 14:01:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64DDsTSm016953;
	Wed, 13 May 2026 14:01:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfh033v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 14:01:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64DE1UdG47710600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 14:01:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82AB420040;
	Wed, 13 May 2026 14:01:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C8042004D;
	Wed, 13 May 2026 14:01:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2026 14:01:30 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 2/4] s390/irq/idle: Use stcke instead of stckf for time stamps
Date: Wed, 13 May 2026 16:01:27 +0200
Message-ID: <20260513140129.4100822-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260513140129.4100822-1-hca@linux.ibm.com>
References: <20260513140129.4100822-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Y/XIdBeN c=1 sm=1 tr=0 ts=6a04843f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=vsOAJfgJ7yOkkXygIcsA:9
X-Proofpoint-GUID: c-2ayTzU5mr6I9pwyrk5Bq1XD3NsqrE6
X-Proofpoint-ORIG-GUID: c-2ayTzU5mr6I9pwyrk5Bq1XD3NsqrE6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE0MCBTYWx0ZWRfXzETvLgAUnEYH
 EhTfvuAepT2ueEDvWLF5Mf9gl1VrFxW7PhVV4qm6gS/DnT3JCCFYt5NRnvvs00N0iy2uEOpjDoq
 g/HBWX1yvnvUKgap+iFgpSoIDG6XoWFMJYjvZR892ns9BeD/1t6n1ntRS+9lC8lRtsNt0/MuiNm
 3SMHuxyjeGx+U4I/WHiE5NCtYW/craWS7AvDFw9vyL18jNy96+qLMQEpEPuQZx566on65Naew3t
 SyAwIAjaDw5tWB/fNSambRhNxpyM1nM5i9CqMR6sjudr35sTZ91G1wFEA8WZTIWbd5Q0qrnpwk5
 YPyreREiAeLuZZ3NiJBLibZqTE0OKOWqOcS0kZtMmdXyvRiYKds/IfqONB3Tdsi56im4kORbjV4
 ZYMSmcAgg4McXBVAw8Mc30STZVBFSqdvDgu6b+1nLR/pf+K9j92kdFL6KVtd0i0HqnAMmptTPJS
 xdxX/yKBWf82NkAqdXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130140

The upcoming cpu idle time accounting rework involves comparing and
subtracting cross cpu time stamps. Time stamps created with the stckf
instruction monotonic with respect to the local cpu. For cross cpu
monotonic time stamps the slightly slower stcke instruction has to
be used [1].

Convert the idle time accounting relevant usages of stckf to stcke.

[1] Principles of Operation - Setting and Inspecting the Clock

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/idle.h    | 3 ++-
 arch/s390/include/asm/lowcore.h | 4 ++--
 arch/s390/include/asm/vtime.h   | 4 ++--
 arch/s390/kernel/entry.S        | 2 +-
 arch/s390/kernel/idle.c         | 4 ++--
 arch/s390/kernel/irq.c          | 7 ++++---
 drivers/s390/cio/qdio_main.c    | 2 +-
 drivers/s390/cio/qdio_thinint.c | 2 +-
 8 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/idle.h b/arch/s390/include/asm/idle.h
index e4ad09a22400..6963e92b60a1 100644
--- a/arch/s390/include/asm/idle.h
+++ b/arch/s390/include/asm/idle.h
@@ -11,14 +11,15 @@
 #include <linux/percpu-defs.h>
 #include <linux/types.h>
 #include <linux/device.h>
+#include <asm/tod_types.h>
 
 struct s390_idle_data {
 	bool	      idle_dyntick;
 	unsigned long idle_count;
 	unsigned long idle_time;
-	unsigned long clock_idle_enter;
 	unsigned long timer_idle_enter;
 	unsigned long mt_cycles_enter[8];
+	union tod_clock clock_idle_enter;
 };
 
 DECLARE_PER_CPU(struct s390_idle_data, s390_idle);
diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index 50ffe75adeb4..b7720484b2f7 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -10,6 +10,7 @@
 #define _ASM_S390_LOWCORE_H
 
 #include <linux/types.h>
+#include <asm/tod_types.h>
 #include <asm/machine.h>
 #include <asm/ptrace.h>
 #include <asm/ctlreg.h>
@@ -125,8 +126,7 @@ struct lowcore {
 	__u64	avg_steal_timer;		/* 0x0300 */
 	__u64	last_update_timer;		/* 0x0308 */
 	__u64	last_update_clock;		/* 0x0310 */
-	__u64	int_clock;			/* 0x0318 */
-	__u8	pad_0x0320[0x0328-0x0320];	/* 0x0320 */
+	union tod_clock int_clock;		/* 0x0318 */
 	__u64	clock_comparator;		/* 0x0328 */
 	__u8	pad_0x0330[0x0340-0x0330];	/* 0x0330 */
 
diff --git a/arch/s390/include/asm/vtime.h b/arch/s390/include/asm/vtime.h
index b1db75d14e9d..da116a93d3b6 100644
--- a/arch/s390/include/asm/vtime.h
+++ b/arch/s390/include/asm/vtime.h
@@ -48,8 +48,8 @@ static inline void update_timer_idle(void)
 	 * The accounted CPU times will be subtracted again from steal_timer
 	 * when accumulated steal time is calculated in do_account_vtime().
 	 */
-	lc->steal_timer += idle->clock_idle_enter - lc->last_update_clock;
-	lc->last_update_clock = lc->int_clock;
+	lc->steal_timer += idle->clock_idle_enter.tod - lc->last_update_clock;
+	lc->last_update_clock = lc->int_clock.tod;
 	lc->system_timer += lc->last_update_timer - idle->timer_idle_enter;
 	lc->last_update_timer = lc->sys_enter_timer;
 }
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index bb806d1ddae0..7147f3e51ace 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -379,7 +379,7 @@ SYM_CODE_END(pgm_check_handler)
 SYM_CODE_START(\name)
 	STMG_LC	%r8,%r15,__LC_SAVE_AREA
 	GET_LC	%r13
-	stckf	__LC_INT_CLOCK(%r13)
+	stcke	__LC_INT_CLOCK(%r13)
 	stpt	__LC_SYS_ENTER_TIMER(%r13)
 	STBEAR	__LC_LAST_BREAK(%r13)
 	BPOFF
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index 4685d7c5bc51..36020dffb86b 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -26,7 +26,7 @@ void account_idle_time_irq(void)
 	struct s390_idle_data *idle = this_cpu_ptr(&s390_idle);
 	unsigned long idle_time;
 
-	idle_time = get_lowcore()->int_clock - idle->clock_idle_enter;
+	idle_time = get_lowcore()->int_clock.tod - idle->clock_idle_enter.tod;
 
 	/* Account time spent with enabled wait psw loaded as idle time. */
 	__atomic64_add(idle_time, &idle->idle_time);
@@ -49,7 +49,7 @@ void noinstr arch_cpu_idle(void)
 	set_cpu_flag(CIF_ENABLED_WAIT);
 	if (smp_cpu_mtid)
 		stcctm(MT_DIAG, smp_cpu_mtid, (u64 *)&idle->mt_cycles_enter);
-	idle->clock_idle_enter = get_tod_clock_fast();
+	store_tod_clock_ext(&idle->clock_idle_enter);
 	idle->timer_idle_enter = get_cpu_timer();
 	bpon();
 	__load_psw_mask(psw_mask);
diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index d10a17e6531d..24f44f4a3aac 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -103,9 +103,10 @@ static const struct irq_class irqclass_sub_desc[] = {
 
 static void do_IRQ(struct pt_regs *regs, int irq)
 {
-	if (tod_after_eq(get_lowcore()->int_clock,
-			 get_lowcore()->clock_comparator))
-		/* Serve timer interrupts first. */
+	struct lowcore *lc = get_lowcore();
+
+	/* Serve timer interrupts first */
+	if (tod_after_eq(lc->int_clock.tod, lc->clock_comparator))
 		clock_comparator_work();
 	generic_handle_irq(irq);
 }
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index 7e594a800525..c1e09fa34e77 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -695,7 +695,7 @@ static void qdio_int_handler_pci(struct qdio_irq *irq_ptr)
 		return;
 
 	qdio_deliver_irq(irq_ptr);
-	irq_ptr->last_data_irq_time = get_lowcore()->int_clock;
+	irq_ptr->last_data_irq_time = get_lowcore()->int_clock.tod;
 }
 
 static void qdio_handle_activate_check(struct qdio_irq *irq_ptr,
diff --git a/drivers/s390/cio/qdio_thinint.c b/drivers/s390/cio/qdio_thinint.c
index 85ca8650adeb..e167aa75c3df 100644
--- a/drivers/s390/cio/qdio_thinint.c
+++ b/drivers/s390/cio/qdio_thinint.c
@@ -99,7 +99,7 @@ static inline u32 clear_shared_ind(void)
 static void tiqdio_thinint_handler(struct airq_struct *airq,
 				   struct tpi_info *tpi_info)
 {
-	u64 irq_time = get_lowcore()->int_clock;
+	u64 irq_time = get_lowcore()->int_clock.tod;
 	u32 si_used = clear_shared_ind();
 	struct qdio_irq *irq;
 
-- 
2.51.0

