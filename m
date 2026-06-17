Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B12221F20
	for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781699638; cv=none; b=JqqmaOs5x9Mz38+LefeGjiPELEEZiXla/TcIbm6Ybyhj5Dhn/KK+tONwhdYOjQxtQlVjEfjuupawDDCpAf3d2vtDBP7V3cMAXF8LvFwi+czi5GpPaWQHcHo31JxSdNJIiGMJNaMaSyDWyJ5WyxyjfOUbrfdSOIINWlbO2MgAixA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781699638; c=relaxed/simple;
	bh=ufAELgN3xv4VmorxD3EnDDgwCc9wXiip3i0zXE/JzlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VzTXMO7vrNIA6g5821CQRiWQEqUa/St/xGjkJ6ju9xoDyeeW+mc2kmgR1vzEJoitx7zlMCmbFvnuq5ydd8sna+gsHZtzGsNUclWOaoMFe52DD0/dOYOyHGsPpOhrnuyDwDLTdD+mgpKbGljf6tzGrLhkCQXCBF8Id5+DwKfTmJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hKIJOyQn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hKIJOyQn"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8mZ1h4022050
	for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 12:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=7L+b/kVYgAWHbJpsi5wZtpn984zJfUOmVnDhDwyvW
	ZE=; b=hKIJOyQniGP2oMPpgffP3iV3L6KbgGq/WugYikiVzQTbXholkDC1N3w3w
	1yX2c3EXljwEnGLiilxX3VhItqacWZQ3QPf2Oh0SDkC60M4ePQ0rl1XL4PtU0L2E
	tlfhisbzXoPh0qdoTYbEUzFUgJBu+7bEYqn4hVnJCdcNW/PRRtVFfjO0q9EBubEe
	tgMYD41yxGVPuMHjPtCDJbtbSdJQaysgG5Su1b6Gy0qh9NlqhMLnzJNp9pzeeS63
	EeDUeYN6UCnS/MR4XNwvjhwIXQ8845pbY4ZnYGe/QxsAnvORVyOk0Vt+6GM8TOAe
	aj6rCWJ6Pn+AVWhQnVviDIoOLGFyA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx2u1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 12:33:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65HCJaRs001471
	for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 12:33:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eudva340q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 12:33:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65HCXpH315204642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2026 12:33:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF4CA20040;
	Wed, 17 Jun 2026 12:33:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D64602004B;
	Wed, 17 Jun 2026 12:33:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Jun 2026 12:33:50 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH v2] s390/traps: Add exception statistics
Date: Wed, 17 Jun 2026 14:33:50 +0200
Message-ID: <20260617123350.3220729-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDExNyBTYWx0ZWRfX2AV80l24IU2e
 rIDGjAoIepWUUyxboaXnBSFgdLzgkH0lK2tpAKBuA8RK8HjK6MexvzoNpnpB1+sjaxI4XYABEHA
 ct3v3irkMfscMQc4YXLjqTTSuBZHyeXbOYCRdJDFpzmVP6cOBkGhS28kd6KfoC9sfDYW3JuOWJv
 9ghYEgIaHfL8DGsgom8yUX174a3EeaadSWodCqew8HOh45kk5w3bprYVmqWbFb1SpNaPw9s9YHg
 GC+A7xSvauJGgksNaBPacgaUUmNTrSu7heprrYy6E/vNtRMzOXupdNZvzCVjgi0i/wNDBMBpG+Y
 qRcVrjoUSaZ62x0i0CIjOQVVsonP4Om4xZP/Naedommgzol8vxPh/4NSTUGTZkgNBCX7MLXfIft
 JRkmNFLmdwH3bnap5jEBNM8raz2/Tvrm5C7vyqWCD98u//ezgmjuvW2EVFjxjL0tLUPOYjxXv1T
 Xy7AAN0tjqgdDG9WMFA==
X-Proofpoint-GUID: GuT8ye6zosluWbpRJmH_azUihkLpXUwy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDExNyBTYWx0ZWRfX/R+M8/QRR/mc
 ENKDb1NTaSKAmv2/mMoBH7aJj0fpYGMif9o9/3ggvBRlMmSQk0sD3RA5teXNZwYKbTU2eWIuUiJ
 rCt24UIBV0TDpd9H3+8Rs3rNIeUy/ao=
X-Proofpoint-ORIG-GUID: GuT8ye6zosluWbpRJmH_azUihkLpXUwy
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a329433 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8
 a=UF_5xjjxcRRI6jKi6FQA:9 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170117

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

Notes:
    v2:
    - Fix / remove broken iterator handling as reported by Sashiko:
      https://sashiko.dev/#/patchset/20260617113726.2079324-1-hca@linux.ibm.com?part=1

 arch/s390/kernel/traps.c | 41 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 564403496a7c..fcd8c1122ef5 100644
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
@@ -393,6 +405,33 @@ void noinstr __do_pgm_check(struct pt_regs *regs)
 	percpu_exit(regs, percpu_needs_fixup);
 }
 
+static int pgm_check_stat_show(struct seq_file *p, void *v)
+{
+	int i, cpu;
+
+	cpus_read_lock();
+	seq_puts(p, "          ");
+	for_each_online_cpu(cpu)
+		seq_printf(p, "CPU%-8d", cpu);
+	seq_putc(p, '\n');
+	for (i = 0; i < 128; i++) {
+		seq_printf(p, "%02x: ", i);
+		for_each_online_cpu(cpu)
+			seq_printf(p, "%10u ", per_cpu(pgm_stat, cpu).count[i]);
+		seq_putc(p, '\n');
+	}
+	cpus_read_unlock();
+	return 0;
+}
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

