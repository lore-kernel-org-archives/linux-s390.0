Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5128633A6E0;
	Thu, 18 Jun 2026 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781784068; cv=none; b=hpomkX6qoxkHI497F8/gbI4jzhr9xQtIOsc5AUy2DdzC8jDu3OugH6nABa+VWxqNoAcMenBfVeReSuYHps/p0DLLKYx4zN0pioLIe0Oh8gxNx/zYghVhR7j0Aa/3NBhml0AYZCDjxOQF9XqaddNNA6coP8MEzk9Ua/rwpUTr6vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781784068; c=relaxed/simple;
	bh=oGvCAv1qKwIOIx50qtJVB4FiAu/nQjGZQygI1opNvQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m+FjBK3wXrA1QuooKtdxzmxSUAGP71jzsSQzaqpFrAhz17zmdiX842sm5i81ChMoshqUK4D7FY/HUXj/4WW9che/3dNdKtO4moREoks+V50YllIsKAfxA+9ii7qCxuFlSMlMV0AhZ/H3LGInpmD+ASdxIrutUCj8sJd/nZFnqtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d3ckPy5Z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d3ckPy5Z"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IBJgTM3432848;
	Thu, 18 Jun 2026 12:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iKy08P
	VN/C0PqYR59MhJ/Y/ZrpMZsH1iMyTwvojo9cw=; b=d3ckPy5ZifqJbklH3zOgAx
	6ug2DOqA/2UCiv5ooj72Fd+4k2OOHwmwDle5gnK/oq1D9Ip53yKZNh1vc/p8GXWa
	t5e7iOjZT3pm8q/vraZRTMzB4gUs0rvHQKF1zOcAiKLNGnR8cYHsxfbrTHwrMQ08
	xgdM2C/NkBxSDZZ7/OO/ocSgfdeQ6MUm/zUzJ9Y51B/AfBXzq3R+IB9sqADgK4xV
	YcEAsNk5p7uwPku5QAOnRbXD6Ql2Lc8ulA6Rq78bj8aiObvGgSurwLiNZo63mfWZ
	Igyeusv9YFUIA6/gaERB0FgLehbdx2VStgQjC6fctXYUVUa8/tuYC9Ickr11X+0A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequ7w3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 12:00:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65IBnpYC009616;
	Thu, 18 Jun 2026 12:00:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172bj4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 12:00:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65IC0kiV39453156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 12:00:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1715520040;
	Thu, 18 Jun 2026 12:00:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B31C20043;
	Thu, 18 Jun 2026 12:00:45 +0000 (GMT)
Received: from [192.168.2.127] (unknown [9.111.73.152])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 12:00:45 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Thu, 18 Jun 2026 14:00:15 +0200
Subject: [PATCH v3 1/5] s390/tick: Remove CIF_NOHZ_DELAY flag
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-idledriver-v3-1-684061eecbcb@linux.ibm.com>
References: <20260618-idledriver-v3-0-684061eecbcb@linux.ibm.com>
In-Reply-To: <20260618-idledriver-v3-0-684061eecbcb@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>
Cc: Mete Durlu <meted@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExMCBTYWx0ZWRfX4eUxz30rnTXB
 wQlQx3NKVwxQRzPws5IHmgpfx5P/Y97nwGVo6WI1UTlIlLcIoyCLE+XgXbjmZcGpgY59Yj56NG/
 rvLen4cUt2l4xxA/t73H04ZFTVKs3ds=
X-Proofpoint-ORIG-GUID: wgofJJhBQi_oY-aEDT7qXbSD0E-4PfcP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExMCBTYWx0ZWRfX3/q/++NGuhKF
 8UlAGr2nuLS/8ywWnEWNnp0P90zWxVv1yYPh2OJsoZTAPDo0f5aeaCnajRhyn1O/hD9Q+7a8dpK
 +oitxcw2s9BvjD/E4Pqy7EkWDtlv/iW+59Tw8o5DmtutpVDxhBAQTakuuXFIjkxH1BZM/Bxlnx3
 ghQuAlCaYepSSn/R3E8gaAOU0g0K5hJM9+uUETwtNxxkP93iYbkBHj4AiLHbe2jZMMGjv8qEoPD
 agGvKBtJlAtyif+qkjDJZ8s7vWywnrRzz2tpVFAm6GnzdLFbBsP5X9A3M/lTtZDKnvsj4npGI8y
 08DOze0Y9d0bxeE6nP5I83668mYTX2fYJZLqhPupmnHg7sP9xO1BpeTYLfIeMUvV6nzlawcHQAh
 8pND4MzWotP771DeUPCEJZhYHkK7B7CPBz15OPUm1FjV4ToooundW/udGwRM0/Idt6g9sSImiYX
 ckzU/jZ1+XrYD5w3uQA==
X-Proofpoint-GUID: wgofJJhBQi_oY-aEDT7qXbSD0E-4PfcP
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a33ddf3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=7PVU6fNTM30o4ork3uUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180110

Remove obsolete tick delay heuristic [1]. The upcoming cpuidle driver
handles frequent sleep/wakeup cycles more effectively.

[1] https://lore.kernel.org/all/20090929122533.402715150@de.ibm.com/

Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Mete Durlu <meted@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
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

