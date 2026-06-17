Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE7B26AF4
	for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 11:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781696254; cv=none; b=SUKGEpY2WhzB3LfWP2Szd9Ry63FDiv1AaMZxuglJ++yEGMrk6Nl6qvWsNizLte27b67gDVd0eWDMj2r/55vHl/fRTuishy15ll2sQOaNh2PIlu0ZmTuo/v4Jw1eU1oyrSTJlz1vpN/xo+1mtQcAes6Tyvsxv/Hn/XBsCfNYynuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781696254; c=relaxed/simple;
	bh=nGVX31YYOom9H3mQKrMaTFdaDCODnjQB8zt5vzNSAz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RaVbGmmQlhgBk3xQLVfUC12C4GQ8Uvu0BhDoIrwiTy34o7voUMdeosKMLnW+ecieX4phb6Oxbt0tomuMIfBP10ZUW2JnmF5pz0stnOm32BDmLeiMMTzaFla8Q9Y6Wwrtryt2mF72QfSx7TeAhykTbVrNL/YSuvQsXB2OqoQOcR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pawfum7M; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pawfum7M"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8mUd64003151
	for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 11:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=YyhSJ+nUKKOV990s6123TPS7NYvG6xmnA4fXev06H
	6Q=; b=pawfum7MeYtiD0daq5z2NNTp6SEit0gtsc+Z/vNgV1LOsLPkXDss1Momr
	l9dVO+qc10ZPPkIfaUgoAWbZ32KYS05Rmho72x0wTPuHWY/6EkVEOHtJbzhw3g18
	SU3I1KidiDigrv46DAMXb8KRjIWd6WmBv0jeuCt5RAtlD23qnyrPX61qSb6PrgtC
	rYK4snLMc8dqJntNwTZ0/N+Tnt2HH446r4ss0mXhhft0BCnO1+6fm5JAu8OWBFrM
	gJiTrdWBWc9Ez1evw9Le83sRRYkMOOYFbcgJ6hAC3YTgx8ctNgwBrJt45cd0cI98
	foeNArL+i2VJLDUXRUNsW+5kylkgA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx2m1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 11:37:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65HBYkEb007246
	for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 11:37:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eudvajw04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 11:37:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65HBbRoK46727672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2026 11:37:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 628BE20043;
	Wed, 17 Jun 2026 11:37:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 455B320040;
	Wed, 17 Jun 2026 11:37:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Jun 2026 11:37:27 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH] s390/traps: Add exception statistics
Date: Wed, 17 Jun 2026 13:37:26 +0200
Message-ID: <20260617113726.2079324-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ab8a25FhiQKQnjMlXqzIYH0khV-hhysQ
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a3286fc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=UF_5xjjxcRRI6jKi6FQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEwNyBTYWx0ZWRfX0B+BireeGEdw
 v0+VghJYkjczsaeSqIK2jyDKKB16Sf8M0in0Z+DsgX9eodxnYJAefleCut1r7qD69L+IEuLQa4l
 P5AU7BuqgDYxfFOgoxDVXW+/QQqT+gs=
X-Proofpoint-ORIG-GUID: Ab8a25FhiQKQnjMlXqzIYH0khV-hhysQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEwNyBTYWx0ZWRfXzGruoyy2c27X
 /bfOLzzXbKvtWt0hlOSXlRJIQ+geltlCoC1663kAHZI88gUQ+Xvxt+mORCAJ8hsu190y98pl6Ux
 xv9Omiztgx3oX/pw1EfHZv3mhLzgta9/WBKxKnph/QenJgkOMK9/3cEazNR6WN5Y5XfmlIwLpct
 iGmZWH08QUOkQreg6UNFRWZln0O4JR3RB3LtOlAnH0feLgHqnwXOaa8SUSLeQnoY50qjk+iMNGr
 MluPbGyYMIsED5kLDFQ766sIDLwnMHKKfVF8W+ZyxPBE8TG5BVN2FhzX4KjO1mAKSUw5WuC59v/
 kAgkPRLFYr7PkYHMldKzzQoOGMkXGpbYzIe9dM+R5PQZaHCZLJ57xpLYan6whSlc/Z2yGkJQHwK
 3NRCZqZfNq9gAz+dKAxLLMcJln/Bn7bizL3LK1QcERwyJmn6SUX5h4FWDMlOiF4VeAHFmoHWbaH
 KU9sdVdAuh2DErZ7xkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170107

From: Sven Schnelle <svens@linux.ibm.com>

Add a new debugfs file which displays the number of exceptions (program
checks) per CPU. This is helpful for debugging purposes.

The statistics are typically available at
/sys/kernel/debug/s390/exceptions.

[ hca@linux.ibm.com: Forward ported code, changed file location ]

Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/traps.c | 44 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 564403496a7c..3de5c35be2f6 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -9,7 +9,9 @@
  *    Copyright (C) 1991, 1992 Linus Torvalds
  */
 
+#include <linux/capability.h>
 #include <linux/cpufeature.h>
+#include <linux/debugfs.h>
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
 #include <linux/randomize_kstack.h>
@@ -33,6 +35,12 @@
 #include <asm/fault.h>
 #include "entry.h"
 
+struct pgm_stat {
+	unsigned int count[128];
+};
+
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct pgm_stat, pgm_stat);
+
 static inline void __user *get_trap_ip(struct pt_regs *regs)
 {
 	unsigned long address;
@@ -332,6 +340,7 @@ void noinstr __do_pgm_check(struct pt_regs *regs)
 	struct lowcore *lc = get_lowcore();
 	bool percpu_needs_fixup;
 	irqentry_state_t state;
+	struct pgm_stat *stat;
 	unsigned int trapnr;
 	union teid teid;
 
@@ -339,6 +348,10 @@ void noinstr __do_pgm_check(struct pt_regs *regs)
 	regs->int_code = lc->pgm_int_code;
 	regs->int_parm_long = teid.val;
 	regs->monitor_code = lc->monitor_code;
+
+	trapnr = regs->int_code & PGM_INT_CODE_MASK;
+	stat = this_cpu_ptr(&pgm_stat);
+	stat->count[trapnr]++;
 	/*
 	 * In case of a guest fault, short-circuit the fault handler and return.
 	 * This way the sie64a() function will return 0; fault address and
@@ -383,7 +396,6 @@ void noinstr __do_pgm_check(struct pt_regs *regs)
 	if (!irqs_disabled_flags(regs->psw.mask))
 		trace_hardirqs_on();
 	__arch_local_irq_ssm(regs->psw.mask & ~PSW_MASK_PER);
-	trapnr = regs->int_code & PGM_INT_CODE_MASK;
 	if (trapnr)
 		pgm_check_table[trapnr](regs);
 out:
@@ -393,6 +405,36 @@ void noinstr __do_pgm_check(struct pt_regs *regs)
 	percpu_exit(regs, percpu_needs_fixup);
 }
 
+static int pgm_check_stat_show(struct seq_file *p, void *v)
+{
+	int cpu, i = *(loff_t *)v;
+
+	cpus_read_lock();
+	if (i == 0) {
+		seq_puts(p, "          ");
+		for_each_online_cpu(cpu)
+			seq_printf(p, "CPU%-8d", cpu);
+		seq_putc(p, '\n');
+	}
+	for (i = 0; i < 128; i++) {
+		seq_printf(p, "%02x: ", i);
+		for_each_online_cpu(cpu)
+			seq_printf(p, "%10u ", per_cpu(pgm_stat, cpu).count[i]);
+		seq_putc(p, '\n');
+	}
+	cpus_read_unlock();
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(pgm_check_stat);
+
+static int __init debugfs_pgm_check_init(void)
+{
+	debugfs_create_file("exceptions", 0400, arch_debugfs_dir, NULL, &pgm_check_stat_fops);
+	return 0;
+}
+late_initcall(debugfs_pgm_check_init);
+
 /*
  * The program check table contains exactly 128 (0x00-0x7f) entries. Each
  * line defines the function to be called corresponding to the program check
-- 
2.53.0

