Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7BD3E7BB9;
	Tue,  9 Jun 2026 07:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991577; cv=none; b=E3Ij+wvdW5Y5MIiyBi8GDkT/rdIRLq5T2WdRbIMRzQpQLyXr63Ysw2jrjdPawUkcnvC1cjNuV270otsCuXNKNgnIntt3gEuxZKiL6Ggvw/kmahfya7gjNcCGHpkSMZD6Ft43ME/WX9qtq8lJGCyy6z4mTdek1pSegBmz+4nwngo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991577; c=relaxed/simple;
	bh=zKlzlC31D+WoWMVzdIkGV3zLI8Gz7jaPRafQ2/Vg9LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgGezftZZxHa/kK2/N1KaeA9WnlmYRwk0Eavf6UvfeCoihGVd1MnFpV+uOUScu4jJbgNxSLxRkT0ViTmv6WkxMkjwrsRkV1k0W8C2uJGqJoSaW+zuKS5Id47uvGKCCPbpN72Vu0uxLBo9OASPcZMTobzpnehCivMFdmtOqHQbnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MLa9JiaV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MLa9JiaV"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658LPaDA1146606;
	Tue, 9 Jun 2026 07:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=r2PhJzGHUlDvtkway
	8HFR854vOh0Kisj+eOm61VoVWA=; b=MLa9JiaVE4HMlkRNs/SkGCm/ENzyme675
	0y5Tg7Zz6R2G2/fMLKs+lBXNZE41F1+l304MtbrCXo9VzF4a6hxq8ypl6cl6+1SN
	NiNbQi9CoSkBaSWPsA0P3nCyN1ZL/pxNZXhCCiRynSVduc+fTsfNo46xBlisVLn/
	tUmsliWkeDhR6GTvfovg10/50GGUpAh/itRE3plvtVvCwb4Q14XNlIHAoGaONQc2
	QJ2/kxttZ2URgIEygosWoD21+KgauEnUK0PLLhGs/c7xCnA6+6ktw1KNYSHWqCO+
	9aQJAeLTEUIA6jOC8j6kmBkjW8qI8V4Suzdc60ZsNcmj5b0VSWFOg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb95b1jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 07:52:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6597neTC011595;
	Tue, 9 Jun 2026 07:52:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq15dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 07:52:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6597qVxc52625730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 07:52:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A76C20040;
	Tue,  9 Jun 2026 07:52:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02DDE2004B;
	Tue,  9 Jun 2026 07:52:31 +0000 (GMT)
Received: from lenovo-pc.ehn-de.ibm.com (unknown [9.224.76.67])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 07:52:30 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Cc: Mete Durlu <meted@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] s390/tick: Remove CIF_NOHZ_DELAY flag
Date: Tue,  9 Jun 2026 09:52:09 +0200
Message-ID: <20260609075213.31094-2-meted@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609075213.31094-1-meted@linux.ibm.com>
References: <20260609075213.31094-1-meted@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a27c643 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=7PVU6fNTM30o4ork3uUA:9
X-Proofpoint-ORIG-GUID: Ex1-r6mXr7hXTa2ZG6sW_2rx-YixYmzT
X-Proofpoint-GUID: Ex1-r6mXr7hXTa2ZG6sW_2rx-YixYmzT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3MSBTYWx0ZWRfX61bXV4Zph5fm
 ojJzX9Y7atKNZEVjZrDauoYiho7ubOHujTJ4xdb/YK75q6G3I0kFTG1gzzHlbgcIekLUPwanuvX
 enOClJt9Mk4MjnagIg3X+lVVzS4VpVayjNs7gnMhZ8x1m144TdQXCeo9hPoGI2N8YaVUIH+o1Ut
 llwQ/2x81NVXb0iAnkDOeSPRrWetHcJ77WXqym0+EOZKZXQwMZd3M8rW/WzKbVe+pWSPgcYyeh/
 8cvTV7KYL2bBN2ckCjuY6BE5yis1OPs64hr61UfuXPgKv75tIDqVzbPWvwtlfypRKu9yN2rfLkV
 TDEzwo0Wk+Rg/lhCwEaxWJQ5NcJZ/IiexnTGA48ecMiLiATDqNQqNSLD2INKGXBbnluKY7Wjran
 +ekTQpfaTlw1+mL9PH90fcrEWXi+3lnTgB7oUlnVJBBJXE2y5b54Rc7GTuMLzEo5JyXF/A0qxJV
 gNlriBrAu5yM1UAJoYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1011 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090071

Remove obsolete tick delay heuristic [1]. The upcoming cpuidle driver
handles frequent sleep/wakeup cycles more effectively.

[1] https://lore.kernel.org/all/20090929122533.402715150@de.ibm.com/

Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 arch/s390/include/asm/processor.h | 4 ----
 arch/s390/kernel/idle.c           | 1 -
 arch/s390/kernel/irq.c            | 4 ----
 arch/s390/kernel/smp.c            | 1 -
 4 files changed, 10 deletions(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 78195ee5e99f..3666198cc364 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -14,12 +14,10 @@
 
 #include <linux/bits.h>
 
-#define CIF_NOHZ_DELAY		2	/* delay HZ disable for a tick */
 #define CIF_ENABLED_WAIT	5	/* in enabled wait state */
 #define CIF_MCCK_GUEST		6	/* machine check happening in guest */
 #define CIF_DEDICATED_CPU	7	/* this CPU is dedicated */
 
-#define _CIF_NOHZ_DELAY		BIT(CIF_NOHZ_DELAY)
 #define _CIF_ENABLED_WAIT	BIT(CIF_ENABLED_WAIT)
 #define _CIF_MCCK_GUEST		BIT(CIF_MCCK_GUEST)
 #define _CIF_DEDICATED_CPU	BIT(CIF_DEDICATED_CPU)
@@ -96,8 +94,6 @@ static __always_inline bool test_cpu_flag_of(int flag, int cpu)
 	return test_bit(flag, &per_cpu(pcpu_devices, cpu).flags);
 }
 
-#define arch_needs_cpu() test_cpu_flag(CIF_NOHZ_DELAY)
-
 static inline void get_cpu_id(struct cpuid *ptr)
 {
 	asm volatile("stidp %0" : "=Q" (*ptr));
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index 1f1b06b6b4ef..8c63f440da2e 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -42,7 +42,6 @@ void noinstr arch_cpu_idle(void)
 	/* Wait for external, I/O or machine check interrupt. */
 	psw_mask = PSW_KERNEL_BITS | PSW_MASK_WAIT |
 		   PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK;
-	clear_cpu_flag(CIF_NOHZ_DELAY);
 	set_cpu_flag(CIF_ENABLED_WAIT);
 	if (smp_cpu_mtid)
 		stcctm(MT_DIAG, smp_cpu_mtid, (u64 *)&idle->mt_cycles_enter);
diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index d10a17e6531d..61d17954c34c 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -161,7 +161,6 @@ void noinstr do_io_irq(struct pt_regs *regs)
 	if (from_idle)
 		account_idle_time_irq();
 
-	set_cpu_flag(CIF_NOHZ_DELAY);
 	do {
 		regs->tpi_info = get_lowcore()->tpi_info;
 		if (get_lowcore()->tpi_info.adapter_IO)
@@ -358,9 +357,6 @@ static irqreturn_t do_ext_interrupt(int irq, void *dummy)
 	int index;
 
 	ext_code.int_code = regs->int_code;
-	if (ext_code.code != EXT_IRQ_CLK_COMP)
-		set_cpu_flag(CIF_NOHZ_DELAY);
-
 	index = ext_hash(ext_code.code);
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(p, &ext_int_hash[index], entry) {
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 50bb499cf3e5..cd5ccbe3a18d 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -910,7 +910,6 @@ int __cpu_disable(void)
 	cregs[6].val  &= ~0xff000000UL;	/* disable all I/O interrupts */
 	cregs[14].val &= ~0x1f000000UL;	/* disable most machine checks */
 	__local_ctl_load(0, 15, cregs);
-	clear_cpu_flag(CIF_NOHZ_DELAY);
 	return 0;
 }
 
-- 
2.54.0

