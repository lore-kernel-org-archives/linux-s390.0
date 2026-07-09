Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0617644999A
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783626958; cv=none; b=Oc9JVrWFlHGunKImt8rNhUnvOlQodTKvCjkGMwRFmLiy+K90/6tq7t5KfF+caWw59S+sMbbFZeRhm3oSIoVf7lYSWYu/9V2gS/EqH1td9tItA3SM03dsrLXu0Ih3O582PBVaNvn5u161o0b6/Mjw3Hh70INwFX92hcE4fYWxonQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783626958; c=relaxed/simple;
	bh=Pk+eR3Ze0DQCKOQrp8oTf7r00FzvVBDx1MEqL3MRAOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGwWp5BlzCgI+STIv51e7YxHCCoL6HSDgLcwJelJqmJa4rYomNqYoiC1eTHkNzp5NR78I798MXdQ81XweFmE9n1Y71dst8tvRAIEmgKjShg7UKY0bceRlOTtX+sv4KgshQihveKCNRLj0vez9YF1ywImvBE5NRCBZKfVV9dtRDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LZDHHOdU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LZDHHOdU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669Hms7p3005539
	for <linux-s390@vger.kernel.org>; Thu, 9 Jul 2026 19:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=f3C3jB1ufOVUF23na
	FYeQB68KevVdVuVSoiM+ZehvpU=; b=LZDHHOdUqEcFRrDstqZ9cEENLWuVevdU/
	AgbeKAxXz4zrhIGRGJ/hf8XD5+/IB8PWTpIBOifgBKt4diniABK7Zg5LM8SzIVSv
	ZzWoiky8gENWFVR6JQkVh72Pn1hWNI5I/8a2pxM4wzsJNRVvV7IwOy4BYiIWXHJY
	dcW8JQIA0nCIHcoJBhOSAgCrOTx6V8VETeRE1FHto5+iX0QsHFS6/6SRJH/c2XWx
	TXWjC+T1MuoOAxG4W4h7I9cQVutF2fwId/HWmDqPs4DvIOMETnQnQVRHcOzZompF
	CGSME7VeN9PUw+McmGg49rsIxafVgH/SzvYLIp4vh2384pp/pN0Cw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qkntvfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 19:55:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669JnfiK030698
	for <linux-s390@vger.kernel.org>; Thu, 9 Jul 2026 19:55:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6yeeb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 19:55:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669Jtpu345154596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 19:55:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F03762004E;
	Thu,  9 Jul 2026 19:55:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBF052004B;
	Thu,  9 Jul 2026 19:55:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu,  9 Jul 2026 19:55:50 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id B14B21616F3; Thu, 09 Jul 2026 21:55:50 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, borntraeger@linux.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH 2/2] s390/syscalls: Use define instead of '1' to indicate PER trap
Date: Thu,  9 Jul 2026 21:55:00 +0200
Message-ID: <20260709195500.1241833-3-svens@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709195500.1241833-1-svens@linux.ibm.com>
References: <20260709195500.1241833-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4ffccb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=EbrABBnbUIysQEU_i1YA:9
X-Proofpoint-GUID: 0g2iRbAGV1u3Bwxb5xv3wzEAwwuPfw5U
X-Proofpoint-ORIG-GUID: 0g2iRbAGV1u3Bwxb5xv3wzEAwwuPfw5U
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE5NyBTYWx0ZWRfXywIvnox+C2Zx
 vggdFA6AWP4gVRd7W7ecnDQaUlsiTptzwnDpq0UZQJml+e8+1doIewSQQGdbtZGougDyvP9CgZ3
 ZhN+aNt2e8VFGjmfZIdNUll1PsmWZA0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE5NyBTYWx0ZWRfXwUYIB5hhThfG
 WDNFd+hlLEnoOFcZU4OD7n7nwrCtSZ7+NtAH9XzAFcJuHxgg9Y1U4BrTH5mf2odWoB9L3updoHF
 m0qFyjU3/hPCcfP+NG0WtyJaDRBwbkoLeUKpFsN3aiPafgUl/7NqUTxK2BQlVF9ervra87SEBte
 eV1blsQammKwhdq0cmjWGiQhuOnrkogGRVcSUzwEFQCuk0b/p1GNDYcvwUGpvP490GcF8JycO1k
 fmKQxj+6/VfznuSRBWqFhJinPV7OCnIDxndePOGMx0wkeqCJMs4/waWJkYR5UVILTcu8XTPSu4r
 TIn8ZkH25Y9SDhomkNeGuek3jg3YvI4S9zFMqxk6mUjF3GJ+pMFrLuwehdbeLZI+DxgBZNA1Y/y
 /CSOn7LQY5uA+WsJDv6/nOeefAfY5M1WAjWO+4PFOl3shZlPLXTs+6N94WW/Gd9sq074F2dveuj
 WT2/1IAfCX2NKqZGzow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090197

Make the code a bit easier to read by defining SYSCALL_PER_TRAP
instead of passing '1' to __do_syscall().

Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 arch/s390/kernel/entry.S   | 2 +-
 arch/s390/kernel/entry.h   | 3 ++-
 arch/s390/kernel/syscall.c | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index d70eef7a0b29..10dd9bbdf985 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -368,7 +368,7 @@ SYM_CODE_START(pgm_check_handler)
 	mvc	__LC_RETURN_PSW(8,%r13),__LC_SVC_NEW_PSW(%r13)
 	larl	%r14,.Lsysc_per
 	stg	%r14,__LC_RETURN_PSW+8(%r13)
-	lghi	%r14,1
+	lghi	%r14,SYSCALL_FLAG_PER_TRAP
 	LBEAR	__LC_PGM_LAST_BREAK(%r13)
 	LPSWEY	__LC_RETURN_PSW,__LC_RETURN_LPSWE # branch to .Lsysc_per
 SYM_CODE_END(pgm_check_handler)
diff --git a/arch/s390/kernel/entry.h b/arch/s390/kernel/entry.h
index d18a9a63f6b8..dc84ab497251 100644
--- a/arch/s390/kernel/entry.h
+++ b/arch/s390/kernel/entry.h
@@ -3,6 +3,7 @@
 #define _ENTRY_H
=20
 #define PGM_FLAG_GUEST_FAULT	1
+#define SYSCALL_FLAG_PER_TRAP	1
=20
 #ifndef __ASSEMBLER__
=20
@@ -26,7 +27,7 @@ void early_pgm_check_handler(void);
 struct task_struct *__switch_to_asm(struct task_struct *prev, struct tas=
k_struct *next);
 void __ret_from_fork(struct task_struct *prev, struct pt_regs *regs);
 void __do_pgm_check(struct pt_regs *regs, unsigned long flags);
-void __do_syscall(struct pt_regs *regs, int per_trap);
+void __do_syscall(struct pt_regs *regs, unsigned long flags);
 void __do_early_pgm_check(struct pt_regs *regs);
=20
 void do_protection_exception(struct pt_regs *regs);
diff --git a/arch/s390/kernel/syscall.c b/arch/s390/kernel/syscall.c
index 75d5a3cab14e..b6c643756a7c 100644
--- a/arch/s390/kernel/syscall.c
+++ b/arch/s390/kernel/syscall.c
@@ -93,7 +93,7 @@ SYSCALL_DEFINE0(ni_syscall)
 	return -ENOSYS;
 }
=20
-void noinstr __do_syscall(struct pt_regs *regs, int per_trap)
+void noinstr __do_syscall(struct pt_regs *regs, unsigned long flags)
 {
 	unsigned long nr;
=20
@@ -106,7 +106,7 @@ void noinstr __do_syscall(struct pt_regs *regs, int p=
er_trap)
 		current->thread.last_break =3D regs->last_break;
 	local_irq_enable();
 	regs->orig_gpr2 =3D regs->gprs[2];
-	if (unlikely(per_trap))
+	if (unlikely(flags & SYSCALL_FLAG_PER_TRAP))
 		set_thread_flag(TIF_PER_TRAP);
 	regs->flags =3D 0;
 	set_pt_regs_flag(regs, PIF_SYSCALL);
--=20
2.53.0

