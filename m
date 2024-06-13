Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919BA12E1F2;
	Thu, 13 Jun 2024 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293218; cv=none; b=n9m7/l5FZjfB3zEKq4DYpmNrCNwProGQtxQrqnSUp5/PMt/oKiu7gEqi0MoG4/dBdSZpwv0h7yZYJAsZ8IpljiQlcbqqCwkWnk79yGCawzujKP6VScjJ7gBtiOkR6M3Ok9eY0MqCDjakYnsCu7VQK5qKC8mR3IVOd5uQXKx6rvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293218; c=relaxed/simple;
	bh=O25mRw7S/ZC8M5ctPubCjPY5+A4szOidaddkhJ/87GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uID2nvOQGw4MZ6AI8JFo1bEJIw3+kEJyl8za7l5/S48oiQmw6Fk9bAeIFC0YVp4mNmgtr439LVnyzxKGHvzkafE28+usMILe+UrDQaj75a4Ql/60miZjuBa6+rTusC3BXdMwb1u2RJvNxopLd4k2jbBg56R64e6kNqIB1r245HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oNvZmbF4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oNvZmbF4"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DFL9hI017855;
	Thu, 13 Jun 2024 15:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=+zoFJVlk37wQa
	OMfwbNCgteXo249s6T95ikp3xQJB1k=; b=oNvZmbF4K+Py1jf/5icbM1AudoXW6
	51g5mW81oXPABJVfl8cQQxY3isYOHx+0CtD91DheqYBN1CvQdqdnq1/qYi/huM17
	qJ7rNH3AIB2rwIvQ2syI5/tT119S5UFHqCa7KPrKf4WG6zWhs6nIxwuOY+esRb4d
	+WALCQPp12bTjFWplrH+wwfiJf0y+eOYLubrXjMiZrjMnlsg36LecYlRuy7szI77
	IXTbPjlwSqvAZ+HeuuFiDUBy8o1qyqEsW+LzKCg99vjB14Mefn3jyeDIHERevoUT
	u/ZLR9cl/KRaMelg0dT1w8/AaJs+wV1bp14CC60HlsFLfQuKV4+EV/EKA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqy258xxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:39:56 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45DFdt94021165;
	Thu, 13 Jun 2024 15:39:55 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqy258xxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:39:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45DFBb7N020069;
	Thu, 13 Jun 2024 15:39:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn34nh0d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:39:54 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45DFdmkh52494780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 15:39:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E2152006C;
	Thu, 13 Jun 2024 15:39:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF64920065;
	Thu, 13 Jun 2024 15:39:47 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Jun 2024 15:39:47 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 28/35] s390/irqflags: Do not instrument arch_local_irq_*() with KMSAN
Date: Thu, 13 Jun 2024 17:34:30 +0200
Message-ID: <20240613153924.961511-29-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240613153924.961511-1-iii@linux.ibm.com>
References: <20240613153924.961511-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3YJV7_fgCmflF5r_am0hLna8GcLzFF1F
X-Proofpoint-GUID: _271Y5yjDhi0fa7CjP4Omqz2uyCbtCUn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_09,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130112

Lockdep generates the following false positives with KMSAN on s390x:

[    6.063666] DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())
[         ...]
[    6.577050] Call Trace:
[    6.619637]  [<000000000690d2de>] check_flags+0x1fe/0x210
[    6.665411] ([<000000000690d2da>] check_flags+0x1fa/0x210)
[    6.707478]  [<00000000006cec1a>] lock_acquire+0x2ca/0xce0
[    6.749959]  [<00000000069820ea>] _raw_spin_lock_irqsave+0xea/0x190
[    6.794912]  [<00000000041fc988>] __stack_depot_save+0x218/0x5b0
[    6.838420]  [<000000000197affe>] __msan_poison_alloca+0xfe/0x1a0
[    6.882985]  [<0000000007c5827c>] start_kernel+0x70c/0xd50
[    6.927454]  [<0000000000100036>] startup_continue+0x36/0x40

Between trace_hardirqs_on() and `stosm __mask, 3` lockdep thinks that
interrupts are on, but on the CPU they are still off. KMSAN
instrumentation takes spinlocks, giving lockdep a chance to see and
complain about this discrepancy.

KMSAN instrumentation is inserted in order to poison the __mask
variable. Disable instrumentation in the respective functions. They are
very small and it's easy to see that no important metadata updates are
lost because of this.

Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/include/asm/irqflags.h | 17 ++++++++++++++---
 drivers/s390/char/sclp.c         |  2 +-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/irqflags.h b/arch/s390/include/asm/irqflags.h
index 02427b205c11..bcab456dfb80 100644
--- a/arch/s390/include/asm/irqflags.h
+++ b/arch/s390/include/asm/irqflags.h
@@ -37,12 +37,18 @@ static __always_inline void __arch_local_irq_ssm(unsigned long flags)
 	asm volatile("ssm   %0" : : "Q" (flags) : "memory");
 }
 
-static __always_inline unsigned long arch_local_save_flags(void)
+#ifdef CONFIG_KMSAN
+#define arch_local_irq_attributes noinline notrace __no_sanitize_memory __maybe_unused
+#else
+#define arch_local_irq_attributes __always_inline
+#endif
+
+static arch_local_irq_attributes unsigned long arch_local_save_flags(void)
 {
 	return __arch_local_irq_stnsm(0xff);
 }
 
-static __always_inline unsigned long arch_local_irq_save(void)
+static arch_local_irq_attributes unsigned long arch_local_irq_save(void)
 {
 	return __arch_local_irq_stnsm(0xfc);
 }
@@ -52,7 +58,12 @@ static __always_inline void arch_local_irq_disable(void)
 	arch_local_irq_save();
 }
 
-static __always_inline void arch_local_irq_enable(void)
+static arch_local_irq_attributes void arch_local_irq_enable_external(void)
+{
+	__arch_local_irq_stosm(0x01);
+}
+
+static arch_local_irq_attributes void arch_local_irq_enable(void)
 {
 	__arch_local_irq_stosm(0x03);
 }
diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index d53ee34d398f..fb1d9949adca 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -736,7 +736,7 @@ sclp_sync_wait(void)
 	cr0_sync.val = cr0.val & ~CR0_IRQ_SUBCLASS_MASK;
 	cr0_sync.val |= 1UL << (63 - 54);
 	local_ctl_load(0, &cr0_sync);
-	__arch_local_irq_stosm(0x01);
+	arch_local_irq_enable_external();
 	/* Loop until driver state indicates finished request */
 	while (sclp_running_state != sclp_running_state_idle) {
 		/* Check for expired request timer */
-- 
2.45.1

