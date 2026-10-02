Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A27496D4B;
	Fri,  2 Oct 2026 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790954468; cv=none; b=FupPCxV16Jq15oxk0eeFPD/AM72JScLAYM86utOJQQF3hCWxU7L2m30p3sVMixqXJETQubGniSH7TpWiZ/6V2WMc8zfWHeFmsYSOMnHTyyJefeGaEpFaaOBGQPgs3edDAOQorLqhtZeNjrrhd2MiHlWMd9qDFNc2oKP3hlIt7Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790954468; c=relaxed/simple;
	bh=nVf5ZYMZGYpzdN2jx0tv3JNIvHdLmGL7epoPgZUxBaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYsIryaQotfUYY6JLwOD16CpPeuCoFNWVDpsTuLRpl3dmz2ix+MdgbZZSqoXIGjGLbfgJszoapIBJx43oasrmd9KmIENJzcVuEtlARsxeJrqyjlYZdG/J/1qQRbIjV2ZAdkfwBC2mQC1ea9V+d/6dGEMRLMxRXZviOk5SnST2Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VuL3AEBY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VuL3AEBY"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692DZs6a3590508;
	Fri, 2 Oct 2026 15:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JjtfdOicP+5BQEje9
	nRxFIBK+C5qmnOyAkhIIElkLvo=; b=VuL3AEBYnMpnm8wxT3iZwXd4pogfSCssR
	a28zD0cIG6+8KaqNHAThREAwe5uIjKpnjyFpct7VdozokzYie/2vc4oUqbSU9EMC
	/wM69oaHnwkxqlqygXUznvBjn3JlbMLPWzr3xxpcCFEC8KsudZdPE9UR9KukGLJY
	tqpOsVraZnT+UwNQuq0C0rELQzv0DxGm6sJkUSv4fdCdK5OHIlQ4K7kyL3d52RGv
	USv3Km2afFNokBjYtrI+Q+x/R9yKsLYwVK4Uk+TRCbmr+k37OIZfdHbIIJdPb+/G
	XHaLqxcsqHR5IkfYcKUK9iNkUKUgi9YE/iqthglVO/jgDZO4E0FPA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4ferjsf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 15:21:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 692FHacK2737445;
	Fri, 2 Oct 2026 15:21:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1aa80a6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 15:21:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 692FKuVr37290260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Oct 2026 15:20:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B6CE20043;
	Fri,  2 Oct 2026 15:20:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6123D2004D;
	Fri,  2 Oct 2026 15:20:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Oct 2026 15:20:56 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 2/2] s390/entry: Save lowcore on invalid kernel stack
Date: Fri,  2 Oct 2026 17:20:55 +0200
Message-ID: <20261002152055.3305184-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002152055.3305184-1-hca@linux.ibm.com>
References: <20261002152055.3305184-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abfcbdd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=fxMpc2KIn3iSyrXHmlgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2MCBTYWx0ZWRfXywAbsrYpq7k+
 YyIn2XLqDyWGzaYgdtHMulQ7C6rZDQAw7J+IIVKL/hPN+4jBy+Sycx/6eIb4miDdhY0Q05JLSUX
 3QZSzqTF8IQ9mwLLMXFfxRi0nZNXld0=
X-Proofpoint-ORIG-GUID: Xm7BLcFp8S3E7iCTjBt0ja1IGSogIIFy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2MCBTYWx0ZWRfX0BO6OtD7uaNZ
 VDqX3+o3aHG9Q7T6ysT9uLIGKYFwvGqK1HFBJfR6wKCh05zSLM6LuG74mP5WQbsL7cgVHyVwT7K
 W/RpiZEfEpT6GGPIQAoOtVb/rLqvc5Vcc0a0Beze/w1DqEsoazr2BNjRqofigfh+7itZkkAYuuI
 e6wwHPIF3wCWozAPwtuA369VzLmEOPAweBlksNoqTzt5hgsptTbgssLq4ZPTNzWy57rGl742QgE
 bHkSvEbl652xwHHIcs2yoquA75UiP+UAapYEoN4ucRRxne+R7rPmizduW1MpzXZ9wjlP0IIR8yA
 rEnhmhYODHJdsrPC/JjHmPzyyeOz8WQlbX3njWG+yd2GOWAROmKtaR3O4S8CUzXfaeULqyH0FAc
 tQ+M8wrR2br/opiZs2dyYPIzXXr6tVLnw47MS1zCiaZSS94fHuOifZIVCpp+oNtAvsFEsKV9zcV
 Z8GhYEXnLz5wUMsvZLw==
X-Proofpoint-GUID: Xm7BLcFp8S3E7iCTjBt0ja1IGSogIIFy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020060

In case of an invalid kernel stack copy the current CPU's lowcore to
stack_invalid_lowcore, so it is available to debug tools after a crash.

The copy is helpful since the lowcore is modified e.g., when printing
messages before a dump is taken. Keep it as unmodified as possible and
as close to the event that caused register corruption.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/entry.S | 15 +++++++++++++++
 arch/s390/kernel/entry.h |  4 ++++
 arch/s390/kernel/traps.c |  6 ++++++
 3 files changed, 25 insertions(+)

diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 4e99ed559dbd..7346f8ad7f91 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -21,6 +21,7 @@
 #include <asm/thread_info.h>
 #include <asm/asm-offsets.h>
 #include <asm/unistd.h>
+#include <asm/lowcore.h>
 #include <asm/page.h>
 #include <asm/sigp.h>
 #include <asm/bug.h>
@@ -613,6 +614,8 @@ SYM_CODE_END(early_pgm_check_handler)
  * The synchronous or the asynchronous stack pointer is invalid. We are dead.
  * No need to properly save the registers, we are going to panic anyway.
  * Setup a pt_regs so that show_trace can provide a good call trace.
+ * Copy lowcore of the current CPU to stack_invalid_lowcore before it
+ * is modified by printing debug messages and crash handling.
  */
 SYM_CODE_START(stack_invalid)
 	GET_LC	%r15
@@ -623,6 +626,18 @@ SYM_CODE_START(stack_invalid)
 	mvc	__PT_R8(64,%r11),0(%r14)
 	GET_LC	%r2
 	mvc	__PT_LAST_BREAK(8,%r11),__LC_PGM_LAST_BREAK(%r2)
+	/* copy lowcore; skip if used by another CPU */
+	larl	%r4,stack_invalid_lowcore_used
+	lhi	%r1,0
+	lhi	%r3,1
+	cs	%r1,%r3,0(%r4)
+	jne	.Lskip
+	larl	%r0,stack_invalid_lowcore
+	lghi	%r1,LC_PAGES * PAGE_SIZE
+	lgr	%r4,%r2
+	lgr	%r5,%r1
+	mvcl	%r0,%r4
+.Lskip:
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
 	lgr	%r2,%r11		# pass pointer to pt_regs
 	jg	kernel_stack_invalid
diff --git a/arch/s390/kernel/entry.h b/arch/s390/kernel/entry.h
index dc84ab497251..5d6685e5bf5f 100644
--- a/arch/s390/kernel/entry.h
+++ b/arch/s390/kernel/entry.h
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include <linux/signal.h>
 #include <asm/extable.h>
+#include <asm/lowcore.h>
 #include <asm/ptrace.h>
 #include <asm/idle.h>
 
@@ -64,6 +65,9 @@ long sys_s390_sthyi(unsigned long function_code, void __user *buffer, u64 __user
 unsigned long stack_alloc(void);
 void stack_free(unsigned long stack);
 
+extern int stack_invalid_lowcore_used;
+extern struct lowcore stack_invalid_lowcore;
+
 extern char kprobes_insn_page[];
 
 extern char _samode31[], _eamode31[];
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index b6ba4465f59d..cd55729e5f8a 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -283,6 +283,12 @@ static void monitor_event_exception(struct pt_regs *regs)
 	}
 }
 
+/*
+ * Content of the faulting CPU's lowcore, copied by stack_invalid().
+ */
+struct lowcore stack_invalid_lowcore;
+int stack_invalid_lowcore_used;
+
 void kernel_stack_invalid(struct pt_regs *regs)
 {
 	/*
-- 
2.53.0

