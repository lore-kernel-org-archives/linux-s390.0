Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111439;
	b=3txyYs/YaTIyxBJPZNymOrtPsGXtN+Tirj8AlE/UX1Vo21ivjQxsawcVZbRnax7oRe3l
	 3zipTX8WDUHfjP0PWwsYV6sYqO1FqoIHMTuzodMntV8WnGzxdHFlF2IYT+Tste+tmnGfq
	 ghBczsEZgiDjY0l8BxaMkhdt1OS/6nNuPsMCXy2SpMrlgs4D0gq576IsiVQawUtByJYHa
	 aJl/x4VBxtZg3Of+orVrqYAHyTwVajK8isfTTNkzK/Hxg45133A+ulFlC9fpDdCbnaoiu
	 gZ7v1aCQhVUnG4sB8ksGsk6wP/RkN4c4EDsShhgSKE9GslQ4VUDSpkbjsDS/4jRCfeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111439;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=wjhfQIwaM8o7Q0lf5C4V762FRcKH6XvoJkff2c6Jv2k=;
	b=pAPtmf/DhAazA33nWIm+sf/th0yeC5wZMPP1qjMKjjmNgYdNBBdixR+oug+eST6gnDEu
	 GtOIL7Oz7PQ+Lh9mPLJtTOvEv5cc5yZbEvJKk13/Ec4kCk8yS0Lgn3s2GT7Dx/wWqvYW1
	 rJHgpI4MxzfY3vDz4lyBs1DD5xcy0BavzdpuE7NBQSBn5kyopGVmE9QnT2S3/fIuKtT69
	 bI7z5k00JfeE0Zb3hTbvXzrvDcNviI3sVtmUwpgQtrERMQKJrXo7DIepqK2Cmow1DNvor
	 3RbPrjNUPDuouDXmONiNoOczIHwHoPEC7PkSczWW5X34oKK1cW8K24zeLbobsPnC09g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DOloP5IB;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8D960A2606;
	Tue, 27 Oct 2026 14:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC8D960A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DOloP5IB
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69REEcX61520686;
	Tue, 27 Oct 2026 14:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wjhfQIwaM8o7Q0lf5
	C4V762FRcKH6XvoJkff2c6Jv2k=; b=DOloP5IBeGK+22Is2iKovJUevqGmL9xfz
	P0u2vyUERacP2KQVVSQ6pE5ZPvoHdLro+akbCib9Za5zrDr84lFfpDssF7YoCD27
	qrZ91ljrJKK8PIrSBjGeuxH0hfyoZnTKrxn3IjMhXNGl/AiCAVUwNfVJv3Sgd06f
	y48bnYRgWbvETqH/+bU398McPT4Bg5KiRR+kPhriIJ5UNpQUJim6kPxGVYHKrOib
	04Q+D8kO4FSlOGboArnbIbH0lDwWKPravoX+zVr7pERDwtd7GZdY/WOoBAb+rkpA
	+X+xDgLzA51Z8oy8AGewHvf7GPFCYf/lPmE/tcbPPHs0sT9DEuMYg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgk3fysgk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 14:30:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69RE5JgO050395;
	Tue, 27 Oct 2026 14:30:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh7cvk9as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 14:30:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69REUXhU44630526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 14:30:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC1322004E;
	Tue, 27 Oct 2026 14:30:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB41C2004B;
	Tue, 27 Oct 2026 14:30:32 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Oct 2026 14:30:32 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 10/10] s390/maccess: Remove spinlock from __s390_kernel_write()
Date: Tue, 27 Oct 2026 15:30:30 +0100
Message-ID: <20261027143030.3154657-11-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027143030.3154657-1-hca@linux.ibm.com>
References: <20261027143030.3154657-1-hca@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BOMmP1QG c=1 sm=1 tr=0 ts=6ae0b58d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=FzoIzC185IansMQY6p8A:9
X-Proofpoint-ORIG-GUID: AAc_NZJxmCz6O4engLrVV11sc-qgOfTV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfXxpW82471RYOn
 FOmb+mtjUOtoJUzwuNfKj+peUYkIJMZQ99HKOrkoPtFs1jm5ROkCe4JmW+oUdvFxRhlRIDBofIU
 jz5o0+ml6lW7xVs5ktQ1MYIgkU0HK1X255NbYbq3elrOwBZU37nrhFd4t3Of9gQbfb5uGg5K82M
 mwnIjAlbLi6PRe0IAP0H/ucQyDCA9XqYRzbhrdl259gaIZRbWVaDD3VAh+TL0WjjpQCihS4vCMp
 DzaEi+bH27CDeGzY17BPL2eeRiVQAbTV5PUqUMtEoFH9K9g9ktpFwEIAQymF1LvjgcMKTId7I6U
 RA+EA9WewRDZmTmFC3MTMHVGKhK+Q1CLgTr4Iu9of7CsTWfssi0o0R4mwQXf2UdSHnlELJIyLP9
 p4EWAvQe6E6ckJccnKBaQOFYS+B3HP3b4W3ruGnBCBYDKIfqwZuuCR4LdzQ/61dPKjAIboaQ6iu
 EgcIohcDF6pnI05HoLQ==
X-Proofpoint-GUID: AAc_NZJxmCz6O4engLrVV11sc-qgOfTV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfX3C/oInYP2R59
 vwg+6I6C6dewzDt4HSqUWBdiVL6MXNIwNx1zizHI8qMAqusFwIT7Xgaw0ikTdpMcuIB0hicZlQi
 rTkqauuqP5JUhCDOYPuPu/uU9kTzhLE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270056

The spinlock in __s390_kernel_write() was introduced to serialize the
read-modify-write sequence against concurrent callers. Now that all
runtime callers of s390_kernel_write() hold the text_mutex, the
spinlock is not required anymore.

Replace it with preempt_disable() / preempt_enable() and sync_core().
Previously, CPU serialization was implicitly done by other
instructions. Make this explicit with sync_core() instead of
relying on that.

Preemption is disabled so that sync_core() issues the CPU serialization
instruction on the same CPU that executed the stores. This completes all
previous stores and makes them visible to other CPUs.

Other CPUs need to perform CPU serialization, e.g. with text_poke_sync(),
to discard already prefetched instructions.

To verify that text_mutex is held instead of the spinlock, add a
lockdep_assert_held() call to s390_kernel_write(). To make that work
a change to the kprobes code is required:

swap_instruction(), which calls s390_kernel_write(), may be called in
stop_machine() context.
For that case the task which calls s390_kernel_write() is not the task
which called stop_machine() - lockdep_assert_held() will report that
text_mutex is not held by the current task, even though text_mutex is
held by the stop_machine() caller. Exclusive text write access is
guaranteed.
Work around that by calling the non-checking __s390_kernel_write(),
and add lockdep_assert_held() checks to arch_arm_kprobe() and
arch_disarm_kprobe().

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/text-patching.h | 7 +++++--
 arch/s390/kernel/kprobes.c            | 4 +++-
 arch/s390/mm/maccess.c                | 8 +++-----
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/text-patching.h b/arch/s390/include/asm/text-patching.h
index c2f87f20ff97..a382a3e7c2f8 100644
--- a/arch/s390/include/asm/text-patching.h
+++ b/arch/s390/include/asm/text-patching.h
@@ -19,9 +19,12 @@ void *__s390_kernel_write(void *dst, const void *src, size_t size);
 
 static inline void *s390_kernel_write(void *dst, const void *src, size_t size)
 {
-	if (__is_defined(__DECOMPRESSOR))
-		return memcpy(dst, src, size);
+#ifdef __DECOMPRESSOR
+	return memcpy(dst, src, size);
+#else
+	lockdep_assert_held(&text_mutex);
 	return __s390_kernel_write(dst, src, size);
+#endif
 }
 
 #endif /* _ASM_S390_TEXT_PATCHING_H */
diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index e806b124e4ba..ca7fb8b91c5a 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -148,7 +148,7 @@ static int swap_instruction(void *data)
 	u16 opc;
 
 	opc = args->arm_kprobe ? BREAKPOINT_INSTRUCTION : p->opcode;
-	s390_kernel_write(p->addr, &opc, sizeof(opc));
+	__s390_kernel_write(p->addr, &opc, sizeof(opc));
 	return 0;
 }
 NOKPROBE_SYMBOL(swap_instruction);
@@ -157,6 +157,7 @@ void arch_arm_kprobe(struct kprobe *p)
 {
 	struct swap_insn_args args = {.p = p, .arm_kprobe = 1};
 
+	lockdep_assert_held(&text_mutex);
 	if (cpu_has_seq_insn()) {
 		swap_instruction(&args);
 		text_poke_sync();
@@ -170,6 +171,7 @@ void arch_disarm_kprobe(struct kprobe *p)
 {
 	struct swap_insn_args args = {.p = p, .arm_kprobe = 0};
 
+	lockdep_assert_held(&text_mutex);
 	if (cpu_has_seq_insn()) {
 		swap_instruction(&args);
 		text_poke_sync();
diff --git a/arch/s390/mm/maccess.c b/arch/s390/mm/maccess.c
index 6b25203fb05c..cda3f81dfbc2 100644
--- a/arch/s390/mm/maccess.c
+++ b/arch/s390/mm/maccess.c
@@ -61,22 +61,20 @@ static notrace long s390_kernel_write_odd(void *dst, const void *src, size_t siz
  * bytes from destination at an eight byte boundary, modifies the bytes
  * requested and writes the result back in a loop.
  */
-static DEFINE_SPINLOCK(s390_kernel_write_lock);
-
 notrace void *__s390_kernel_write(void *dst, const void *src, size_t size)
 {
 	void *tmp = dst;
-	unsigned long flags;
 	long copied;
 
-	spin_lock_irqsave(&s390_kernel_write_lock, flags);
+	preempt_disable();
 	while (size) {
 		copied = s390_kernel_write_odd(tmp, src, size);
 		tmp += copied;
 		src += copied;
 		size -= copied;
 	}
-	spin_unlock_irqrestore(&s390_kernel_write_lock, flags);
+	sync_core();
+	preempt_enable();
 
 	return dst;
 }
-- 
2.53.0

