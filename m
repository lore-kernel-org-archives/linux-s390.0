Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127CC3815F9;
	Sat,  9 May 2026 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778350494; cv=none; b=q8Qscd4j5/ebm3FvAFvS36JIockv5fUcmOJyOpZN2+OJSUu4bL1SI3/gMyQ5CZkoS4WbkcqllG0sIe8WJlxGl2E+8FGFqZ6mEeN8hq4ZBTdrpNUTdMtxUizPf9LcRGyvT8aiYg0OHy+sMOk3ou4Gti+MzPg3Z+gUlERfYZ+8kkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778350494; c=relaxed/simple;
	bh=nz3MlMuq9VQ6OSMUkMQKhSewbgiT/J+9NUh5fh2tCqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4tQULIMdqu4w1xFQX2qS4WBIVIbL/bovNvY1pO9+rU1YwyTDSGI8fG8psgZXyj3RsYrHQLg1fDomW763x+yKHj6FjqF3JrxKOf6ZyDDXssW8PsDKzOf0Wdzhm19leJWOqsADLUUF1nArG2kKpH4HomYD+Jb3uYa0demNGYJgaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ijqbGiim; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ijqbGiim"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6492xrhx2535630;
	Sat, 9 May 2026 18:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=S/MCSOaQ0nlNf54Mc/IxAOJtZ0x7vR
	4YYIVU9R9ZJnY=; b=ijqbGiimL5jxGM+Y+Eqc3/XjT/TAjeFx2RjwEMLqd18zzz
	REdXoNc1utddwq2TlQwRlX5i4PuOrMDhOlynnuTtu91CupnWkwlqp64Wv0OXw4Bf
	zUihpBLhgI+KlHuWOV1AMSYxUbm69V5RT/jdfpBhHniyneoa2aTR+G3aucf4Q8NX
	5iNynOZn/JA0JH+qKcu04E/pB9wDAjQvljasKEN57/IrD/gLh5N/MZNhh93DGN2v
	7qDJRchGUvazWRlE6KORTwu4X7KsEDahbnMhHacaA4p2BrtPqnAj/NJw1NM/vS7w
	vxnn/5jArYWCKDcsILToWFMaLw26d3C+3CcAg6cQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vkqjdfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 09 May 2026 18:12:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 649I9dH6024723;
	Sat, 9 May 2026 18:12:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuywnj5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 09 May 2026 18:12:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 649ICrAJ39322096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 9 May 2026 18:12:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 477A820043;
	Sat,  9 May 2026 18:12:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A78320040;
	Sat,  9 May 2026 18:12:51 +0000 (GMT)
Received: from osiris (unknown [9.111.50.57])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  9 May 2026 18:12:51 +0000 (GMT)
Date: Sat, 9 May 2026 20:12:49 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Boqun Feng <boqun@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Ada Couprie Diaz <ada.coupriediaz@arm.com>,
        Lyude Paul <lyude@redhat.com>, Sohil Mehta <sohil.mehta@intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        "Xin Li (Intel)" <xin@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, Yury Norov <ynorov@nvidia.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-arch@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 00/11] Refcounted interrupt disable and SpinLockIrq for
 rust (Part 1)
Message-ID: <20260509181249.16281C67-hca@linux.ibm.com>
References: <20260508042111.24358-1-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508042111.24358-1-boqun@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDE5NyBTYWx0ZWRfX6pGkhNTsA/OV
 gr9pjpqbgiLS1vKfbg6649JXKVJ5uCeYC8KC4g4wV4uOZq2zuSmG6kE3JtjK98W/NtzHV/Eyb6h
 wbf71nVGHX7M+sc5h9tVYmvl8kLkas1kEcJjBWrcOKa4CQhAyyGvM1m4h0D+J5j6ouDzSnmSDBJ
 6n/SKSBcs6strBw3PUhMHOZjVaL6XC4agAwLnlZtAh/6xX0sAePD2GfwyOpIqG9QZeaVIVLM2Lx
 6R9ZL1pKlUCX9zAqY7GAdaDgujURIlRXsZEDfT5cr4i6EKhDPxBYmRrSHPhKZ8ecVf/KZ1HPwPD
 PQtrk0qfKNfHOZc2EwIXZvvPnov3lJK4wySA9RZU2N5UrHd7ZgY60dDEuGCF0E10b+xwhI2mK+w
 Cqva7YbpCAPrMae42h1wIKGuyuczyy3GwOIJniK6iZB33FB3BresREqsEi+EbQ8j5MJAAWj81zw
 6Q+3n3Yrkg8OW25Y6qw==
X-Authority-Analysis: v=2.4 cv=OaWoyBTY c=1 sm=1 tr=0 ts=69ff792b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=WsHKUha7AAAA:8 a=VnNF1IyMAAAA:8 a=ds5L8nLIzT8GVSnV0BoA:9
 a=CjuIK1q_8ugA:10 a=H4LAKuo8djmI0KOkngUh:22
X-Proofpoint-ORIG-GUID: boTLgNtR1_6h_dQhuJiSifKtqWVufT6u
X-Proofpoint-GUID: JQ3oI8GhF3nv_hN_UsKw3E5wIIyMIXmW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_06,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1011 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605090197

On Thu, May 07, 2026 at 09:21:00PM -0700, Boqun Feng wrote:
> Hi Peter,
> 
> This is a follow-up for Lyude's work [1]. Per your feedback at [2], I
> did some digging and turned out that ARM64 already kinda did this. The
> basic idea is based on:
> 
> 1) preempt_count() previously mask our NEED_RESCHED bit, so the
>    effective bits is 31bits
> 2) with a 64bit preempt count implementation (as in your PREEMPT_LONG
>    proposal), the effective bits that record "whether we CAN preempt or
>    not" still fit in 32bit (i.e. an int)
> 
> as a result, I don't think we need to change the existing
> preempt_count() API, but rather keep "32bit vs 64bit" as an
> implementation detail. This saves us the need to change the printk code
> for preempt_count().
> 
> For people who have reviewed the previous version, patch 8-11 are new,
> please take a look.
> 
> The patchset passed the build and booting tests and also a "perf record"
> test on x86 for NMI code path.
> 
> I would like to target this changes for 7.2 if possible.
> 
> [1]: https://lore.kernel.org/all/20260121223933.1568682-1-lyude@redhat.com/
> [2]: https://lore.kernel.org/all/20260204111234.GA3031506@noisy.programming.kicks-ass.net/
> 
> Regards,
> Boqun
> 
> Boqun Feng (8):
>   preempt: Introduce HARDIRQ_DISABLE_BITS
>   preempt: Introduce __preempt_count_{sub, add}_return()
>   irq & spin_lock: Add counted interrupt disabling/enabling
>   locking: Switch to _irq_{disable,enable}() variants in cleanup guards
>   sched: Remove the unused preempt_offset parameter of __cant_sleep()
>   sched: Avoid signed comparison of preempt_count() in __cant_migrate()
>   preempt: Introduce PREEMPT_COUNT_64BIT
>   arm64: sched/preempt: Enable PREEMPT_COUNT_64BIT

The below is the s390 conversion to PREEMPT_COUNT_64BIT (or whatever the
future name might be). I'd appreciate if you would add that to your series.

From 827629e68ad67919f8c825d118863664badd227a Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Sat, 9 May 2026 19:23:08 +0200
Subject: [PATCH] s390/preempt: Enable PREEMPT_COUNT_64BIT

Convert s390's preempt_count to 64 bit, and change
the preempt primitives accordingly.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/Kconfig               |  1 +
 arch/s390/include/asm/lowcore.h | 13 +++++++----
 arch/s390/include/asm/preempt.h | 41 +++++++++++++++------------------
 3 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index ecbcbb781e40..efa52667b5d4 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -276,6 +276,7 @@ config S390
 	select PCI_MSI			if PCI
 	select PCI_MSI_ARCH_FALLBACKS	if PCI_MSI
 	select PCI_QUIRKS		if PCI
+	select PREEMPT_COUNT_64BIT
 	select SPARSE_IRQ
 	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index 50ffe75adeb4..0974ab278169 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -160,10 +160,15 @@ struct lowcore {
 	/* SMP info area */
 	__u32	cpu_nr;				/* 0x03a0 */
 	__u32	softirq_pending;		/* 0x03a4 */
-	__s32	preempt_count;			/* 0x03a8 */
-	__u32	spinlock_lockval;		/* 0x03ac */
-	__u32	spinlock_index;			/* 0x03b0 */
-	__u8	pad_0x03b4[0x03b8-0x03b4];	/* 0x03b4 */
+	union {
+		struct {
+			__u32	need_resched;	/* 0x03a8 */
+			__u32	count;		/* 0x03ac */
+		} preempt;
+		__u64	preempt_count;		/* 0x03a8 */
+	};
+	__u32	spinlock_lockval;		/* 0x03b0 */
+	__u32	spinlock_index;			/* 0x03b4 */
 	__u64	percpu_offset;			/* 0x03b8 */
 	__u8	pad_0x03c0[0x0400-0x03c0];	/* 0x03c0 */
 
diff --git a/arch/s390/include/asm/preempt.h b/arch/s390/include/asm/preempt.h
index 0a25d4648b4c..1d5e4d7e9e1b 100644
--- a/arch/s390/include/asm/preempt.h
+++ b/arch/s390/include/asm/preempt.h
@@ -8,11 +8,8 @@
 #include <asm/cmpxchg.h>
 #include <asm/march.h>
 
-/*
- * Use MSB so it is possible to read preempt_count with LLGT which
- * reads the least significant 31 bits with a single instruction.
- */
-#define PREEMPT_NEED_RESCHED	0x80000000
+/* Use MSB for PREEMPT_NEED_RESCHED mostly because it is available. */
+#define PREEMPT_NEED_RESCHED	0x8000000000000000UL
 
 /*
  * We use the PREEMPT_NEED_RESCHED bit as an inverted NEED_RESCHED such
@@ -26,25 +23,25 @@
  */
 static __always_inline int preempt_count(void)
 {
-	unsigned long lc_preempt, count;
+	unsigned long lc_preempt;
+	int count;
 
-	BUILD_BUG_ON(sizeof_field(struct lowcore, preempt_count) != sizeof(int));
-	lc_preempt = offsetof(struct lowcore, preempt_count);
+	lc_preempt = offsetof(struct lowcore, preempt.count);
 	/* READ_ONCE(get_lowcore()->preempt_count) & ~PREEMPT_NEED_RESCHED */
 	asm_inline(
-		ALTERNATIVE("llgt	%[count],%[offzero](%%r0)\n",
-			    "llgt	%[count],%[offalt](%%r0)\n",
+		ALTERNATIVE("ly		%[count],%[offzero](%%r0)\n",
+			    "ly		%[count],%[offalt](%%r0)\n",
 			    ALT_FEATURE(MFEATURE_LOWCORE))
 		: [count] "=d" (count)
 		: [offzero] "i" (lc_preempt),
 		  [offalt] "i" (lc_preempt + LOWCORE_ALT_ADDRESS),
-		  "m" (((struct lowcore *)0)->preempt_count));
+		  "m" (((struct lowcore *)0)->preempt.count));
 	return count;
 }
 
-static __always_inline void preempt_count_set(int pc)
+static __always_inline void preempt_count_set(unsigned long pc)
 {
-	int old, new;
+	unsigned long old, new;
 
 	old = READ_ONCE(get_lowcore()->preempt_count);
 	do {
@@ -63,12 +60,12 @@ static __always_inline void preempt_count_set(int pc)
 
 static __always_inline void set_preempt_need_resched(void)
 {
-	__atomic_and(~PREEMPT_NEED_RESCHED, &get_lowcore()->preempt_count);
+	__atomic64_and(~PREEMPT_NEED_RESCHED, (long *)&get_lowcore()->preempt_count);
 }
 
 static __always_inline void clear_preempt_need_resched(void)
 {
-	__atomic_or(PREEMPT_NEED_RESCHED, &get_lowcore()->preempt_count);
+	__atomic64_or(PREEMPT_NEED_RESCHED, (long *)&get_lowcore()->preempt_count);
 }
 
 static __always_inline bool test_preempt_need_resched(void)
@@ -88,8 +85,8 @@ static __always_inline void __preempt_count_add(int val)
 
 			lc_preempt = offsetof(struct lowcore, preempt_count);
 			asm_inline(
-				ALTERNATIVE("asi	%[offzero](%%r0),%[val]\n",
-					    "asi	%[offalt](%%r0),%[val]\n",
+				ALTERNATIVE("agsi	%[offzero](%%r0),%[val]\n",
+					    "agsi	%[offalt](%%r0),%[val]\n",
 					    ALT_FEATURE(MFEATURE_LOWCORE))
 				: "+m" (((struct lowcore *)0)->preempt_count)
 				: [offzero] "i" (lc_preempt), [val] "i" (val),
@@ -98,7 +95,7 @@ static __always_inline void __preempt_count_add(int val)
 			return;
 		}
 	}
-	__atomic_add(val, &get_lowcore()->preempt_count);
+	__atomic64_add(val, (long *)&get_lowcore()->preempt_count);
 }
 
 static __always_inline void __preempt_count_sub(int val)
@@ -119,15 +116,15 @@ static __always_inline bool __preempt_count_dec_and_test(void)
 
 	lc_preempt = offsetof(struct lowcore, preempt_count);
 	asm_inline(
-		ALTERNATIVE("alsi	%[offzero](%%r0),%[val]\n",
-			    "alsi	%[offalt](%%r0),%[val]\n",
+		ALTERNATIVE("algsi	%[offzero](%%r0),%[val]\n",
+			    "algsi	%[offalt](%%r0),%[val]\n",
 			    ALT_FEATURE(MFEATURE_LOWCORE))
 		: "=@cc" (cc), "+m" (((struct lowcore *)0)->preempt_count)
 		: [offzero] "i" (lc_preempt), [val] "i" (-1),
 		[offalt] "i" (lc_preempt + LOWCORE_ALT_ADDRESS));
 	return (cc == 0) || (cc == 2);
 #else
-	return __atomic_add_const_and_test(-1, &get_lowcore()->preempt_count);
+	return __atomic64_add_const_and_test(-1, (long *)&get_lowcore()->preempt_count);
 #endif
 }
 
@@ -141,7 +138,7 @@ static __always_inline bool should_resched(int preempt_offset)
 
 static __always_inline int __preempt_count_add_return(int val)
 {
-	return val + __atomic_add(val, &get_lowcore()->preempt_count);
+	return val + __atomic64_add(val, (long *)&get_lowcore()->preempt_count);
 }
 
 static __always_inline int __preempt_count_sub_return(int val)
-- 
2.51.0

