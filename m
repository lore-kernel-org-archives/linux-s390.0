Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D990E38333E;
	Mon,  1 Jun 2026 07:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297859; cv=none; b=KuWdgjjnCs9vp9y59MAkXhMK5gkc50nWgt7khGs4ULuItEOLEovcrHRIJ+rwL/qkE4+PvxIw3L/HvzbI3tzSMjMs0peFlSSJMVhWNBRxUeNzIREO59HUxKbli4D4AEOABJuChPjpSwL5BEiP4fziP70Q0s7vbvY76fw3iA48x5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297859; c=relaxed/simple;
	bh=sWuf1TmaZtGlNsW20XhyG0lzTaRKcNGdJntS4eIf7Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ad1M6C3cBqRfuSvndI3ARL59ueh7jKW8r5kVB+kNxZbNdaTg0zNfa6NLFS5NXOD37jvE/WnoXj5Pcq9jc7MZHrJua29GM9dyCSoYXlmLE0AnK9Ft1EWcJhwSVGrKZM6bUJ2pdzblvOfzNVxMCyatM4WNxNQAkruS30KfYwjozJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AtV3x1iR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AtV3x1iR"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VCRhTM2841744;
	Mon, 1 Jun 2026 07:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=YyZTVtsRFTK4rvnIjFu4SUwJUmw07R
	TiH/Id85oHPz8=; b=AtV3x1iRNX9xgNpcRlchhC26bXdh2LBBH+aPuuwrzisbtA
	n1q5or+JW0HzKtXotZI9XzSue6f3RVur2SO3d5pMwxg2H5r76/Hhu7UFnzn0zq32
	iBNpIDtSDV/GZsU0L5r/Oau39XXMOE8HmtoBjsr+KUzy4iInqhkBdxaYxJEIbX0t
	b9G8KlwdVBONAMnN83KVgRcz08rL9T379XvooIWEqxEUw59BeGoqIl0eHFd+ZWTB
	GpHaEwE5A8d7FsmRcifq9OTUzbEp6vCCCcFMITZGyCi8BV1uVNH5+c1CYf8XcHmD
	ucOgdxABxFfv1m/dBye8nuyHMkci+J3dEiUEGeXg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahfc97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 07:10:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65179INl012233;
	Mon, 1 Jun 2026 07:10:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7q547g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 07:10:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6517AnN741615660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 07:10:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A963C2004D;
	Mon,  1 Jun 2026 07:10:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C96320043;
	Mon,  1 Jun 2026 07:10:49 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.87.158.69])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  1 Jun 2026 07:10:49 +0000 (GMT)
Date: Mon, 1 Jun 2026 09:10:47 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 1/7] s390/percpu: Infrastructure for more efficient
 this_cpu operations
Message-ID: <403de21c-957e-41ca-8c03-0bd110c49ec3-agordeev@linux.ibm.com>
References: <20260526055702.1429061-1-hca@linux.ibm.com>
 <20260526055702.1429061-2-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526055702.1429061-2-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA3MCBTYWx0ZWRfXyK0d0D1bTbQh
 1TDpI7lkiV+EGUeXyY7Ktak9d/cCBMQnyRIkHe+M/gRQjTrIKWG3ARcbtyPNG0YievBSOUDUrvo
 mHJ3KVUiRDULh1iXwj2M3T2g8LKmbmQBfTGkLod0z/PW/sFkg8hP6scOtnYGpayFTExJTb5D8Mu
 bjdNqTkBBH6pVN3xYLbeTEIfcZ9DAJwMM6JzwYvR35wITh1xYIggQRX2WpSOfYr/oxje9/mH77Y
 MNX99n8NHB3jFB3JLuelW9zlfiBelenP1I7UQvtD2PpeyqMdduIEwUZ85WRLfrca/X17Mthoux0
 2QBi7z0vMxLNSBtU5opy65e9Y3cfgrensF63/IxjNqzTFNh1AArGXyAhWOsWvp4VwXLmAkLm4PS
 grDbBgf+bGe6C3WeIUnrdqvB4BV6ekp2souRjMxNAyksKcEKHbINWUYVi5MVwoHJBDBPjIZR0bW
 37x9jY/Sk1uaSDALYzA==
X-Proofpoint-ORIG-GUID: Bj5cFPdDXPLUnYUFFA1lKwkgqh1UOWnJ
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1d307e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=S4VIkK6wohBRevtDurAA:9 a=qhsQMaPbmv7MJ7zw:21 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Bj5cFPdDXPLUnYUFFA1lKwkgqh1UOWnJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010070

On Tue, May 26, 2026 at 07:56:56AM +0200, Heiko Carstens wrote:

Hi Heiko,

Please find some nitpicks below.

> With the intended removal of PREEMPT_NONE this_cpu operations based on
> atomic instructions, guarded with preempt_disable()/preempt_enable() pairs
> become more expensive: the preempt_disable() / preempt_enable() pairs are
> not optimized away anymore during compile time.
> 
> In particular the conditional call to preempt_schedule_notrace() after
> preempt_enable() adds additional code and register pressure.
> 
> E.g. this simple C code sequence
> 
> DEFINE_PER_CPU(long, foo);
> long bar(long a) { return this_cpu_add_return(foo, a); }
> 
> generates this code:
> 
>   11a976:       eb af f0 68 00 24       stmg    %r10,%r15,104(%r15)
>   11a97c:       b9 04 00 ef             lgr     %r14,%r15
>   11a980:       b9 04 00 b2             lgr     %r11,%r2
>   11a984:       e3 f0 ff c8 ff 71       lay     %r15,-56(%r15)
>   11a98a:       e3 e0 f0 98 00 24       stg     %r14,152(%r15)
>   11a990:       eb 01 03 a8 00 6a       asi     936,1            <- __preempt_count_add(1)
>   11a996:       c0 10 00 d2 ac b5       larl    %r1,1b70300      <- address of percpu var
>   11a9a0:       e3 10 23 b8 00 08       ag      %r1,952          <- add percpu offset
>   11a9a6:       eb ab 10 00 00 e8       laag    %r10,%r11,0(%r1) <- atomic op
>   11a9ac:       eb ff 03 a8 00 6e       alsi    936,-1           <- __preempt_count_dec_and_test()
>   11a9b2:       a7 54 00 05             jnhe    11a9bc <bar+0x4c>
>   11a9b6:       c0 e5 00 76 d1 bd       brasl   %r14,ff4d30 <preempt_schedule_notrace>
>   11a9bc:       b9 e8 b0 2a             agrk    %r2,%r10,%r11
>   11a9c0:       eb af f0 a0 00 04       lmg     %r10,%r15,160(%r15)
>   11a9c6        07 fe                   br      %r14
> 
> Even though the above example is more or less the worst case, since the
> branch to preempt_schedule_notrace() requires a stackframe, which
> otherwise wouldn't be necessary, there is also the conditional jnhe branch
> instruction.
> 
> Get rid of the conditional branch with the following code sequence:
> 
>   11a8e6:       c0 30 00 d0 c5 0d       larl    %r3,1b33300

Annotating with similar comments as above would help:

	... <- address of percpu var
	... <- add percpu offset

>   11a8ec:       b9 04 00 43             lgr     %r4,%r3
>   11a8f0:       eb 00 43 c0 00 52       mviy    960,4
>   11a8f6:       e3 40 03 b8 00 08       ag      %r4,952
>   11a8fc:       eb 52 40 00 00 e8       laag    %r5,%r2,0(%r4)
>   11a902:       eb 00 03 c0 00 52       mviy    960,0
>   11a908:       b9 08 00 25             agr     %r2,%r5
>   11a90c        07 fe                   br      %r14
> 
> The general idea is that this_cpu operations based on atomic instructions
> are guarded with mviy instructions:
> 
> - The first mviy instruction writes the register number, which contains
>   the percpu address variable to lowcore. This also indicates that a
>   percpu code section is executed.
> 
> - The first instruction following the mviy instruction must be the ag
>   instruction which adds the percpu offset to the percpu address register.
> 
> - Afterwards the atomic percpu operation follows.
> 
> - Then a second mviy instruction writes a zero to lowcore, which indicates
>   the end of the percpu code section.
> 
> - In case of an interrupt/exception/nmi the register number which was
>   written to lowcore is copied to the exception frame (pt_regs), and a zero
>   is written to lowcore.
> 
> - On return to the previous context it is checked if a percpu code section
>   was executed (saved register number not zero), and if the process was
>   migrated to a different cpu. If the percpu offset was already added to
>   the percpu address register (instruction address does _not_ point to the
>   ag instruction) the content of the percpu address register is adjusted so
>   it points to percpu variable of the new cpu.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/entry-percpu.h | 80 ++++++++++++++++++++++++++++
>  arch/s390/include/asm/lowcore.h      |  3 +-
>  arch/s390/include/asm/percpu.h       | 62 +++++++++++++++++++++
>  arch/s390/include/asm/ptrace.h       |  2 +
>  arch/s390/kernel/irq.c               | 24 ++++++---
>  arch/s390/kernel/nmi.c               |  5 ++
>  arch/s390/kernel/traps.c             |  5 ++
>  7 files changed, 173 insertions(+), 8 deletions(-)
>  create mode 100644 arch/s390/include/asm/entry-percpu.h
> 
> diff --git a/arch/s390/include/asm/entry-percpu.h b/arch/s390/include/asm/entry-percpu.h
> new file mode 100644
> index 000000000000..4ef47265cfce
> --- /dev/null
> +++ b/arch/s390/include/asm/entry-percpu.h
> @@ -0,0 +1,80 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef ARCH_S390_ENTRY_PERCPU_H
> +#define ARCH_S390_ENTRY_PERCPU_H
> +
> +#include <linux/kprobes.h>
> +#include <linux/percpu.h>
> +#include <asm/lowcore.h>
> +#include <asm/ptrace.h>
> +#include <asm/asm-offsets.h>
> +
> +static __always_inline void percpu_entry(struct pt_regs *regs)
> +{
> +	struct lowcore *lc = get_lowcore();
> +
> +	if (user_mode(regs))
> +		return;
> +	regs->cpu = lc->cpu_nr;
> +	regs->percpu_register = lc->percpu_register;
> +	lc->percpu_register = 0;

This assignment is required when the task is migrated to a new CPU, so
the lowcore would not be corrupted with the stale percpu_register value.
Otherwise, it is restored in percpu_exit() if there was no migration.
Right?

> +}
> +
> +static __always_inline bool percpu_code_check(struct pt_regs *regs)
> +{
> +	unsigned int insn, disp;
> +	struct kprobe *p;
> +
> +	if (likely(user_mode(regs) || !regs->percpu_register))
> +		return false;
> +	/*
> +	 * Within a percpu code section - check if the percpu base register
> +	 * needs to be updated. This is the case if the PSW does not point to
> +	 * the ADD instruction within the section.
> +	 * - AG %rx,percpu_offset_in_lowcore(%r0,%r0)
> +	 * which adds the percpu offset to the percpu base register.
> +	 */
> +	lockdep_assert_preemption_disabled();
> +again:
> +	insn = READ_ONCE(*(u16 *)psw_bits(regs->psw).ia);
> +	if (unlikely(insn == BREAKPOINT_INSTRUCTION)) {
> +		p = get_kprobe((void *)psw_bits(regs->psw).ia);
> +		/*
> +		 * If the kprobe is concurrently removed on a different CPU
> +		 * it might not be found anymore. However text must have
> +		 * been restored - try again.
> +		 */
> +		if (!p)
> +			goto again;
> +		insn = p->opcode;
> +	}
> +	if ((insn & 0xff0f) != 0xe300)

Any reason mask/not to check the register number as well?

> +		return true;
> +	disp = offsetof(struct lowcore, percpu_offset);
> +	if (machine_has_relocated_lowcore())
> +		disp += LOWCORE_ALT_ADDRESS;
> +	insn = (disp & 0xff000) >> 4 | (disp & 0x00fff) << 16 | 0x8;
> +	if (*(u32 *)(psw_bits(regs->psw).ia + 2) != insn)
> +		return true;
> +	return false;
> +}
> +
> +static __always_inline void percpu_exit(struct pt_regs *regs, bool needs_fixup)
> +{
> +	struct lowcore *lc = get_lowcore();
> +	unsigned char reg;
> +
> +	if (user_mode(regs))
> +		return;
> +	reg = regs->percpu_register;
> +	lc->percpu_register = reg;
> +	if (likely(!needs_fixup))
> +		return;
> +	/* Check if process has been migrated to a different CPU. */
> +	if (regs->cpu == lc->cpu_nr)
> +		return;
> +	/* Fixup percpu base register */
> +	regs->gprs[reg] -= __per_cpu_offset[regs->cpu];
> +	regs->gprs[reg] += lc->percpu_offset;

Such one reads bit better:

	regs->gprs[reg] -= __per_cpu_offset[regs->cpu];
	regs->gprs[reg] += __per_cpu_offset[reg];

> +}
> +
> +#endif
> diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
> index 50ffe75adeb4..cd1ddfdb5d35 100644
> --- a/arch/s390/include/asm/lowcore.h
> +++ b/arch/s390/include/asm/lowcore.h
> @@ -165,7 +165,8 @@ struct lowcore {
>  	__u32	spinlock_index;			/* 0x03b0 */
>  	__u8	pad_0x03b4[0x03b8-0x03b4];	/* 0x03b4 */
>  	__u64	percpu_offset;			/* 0x03b8 */
> -	__u8	pad_0x03c0[0x0400-0x03c0];	/* 0x03c0 */
> +	__u8	percpu_register;		/* 0x03c0 */
> +	__u8	pad_0x03c1[0x0400-0x03c1];	/* 0x03c1 */
>  
>  	__u32	return_lpswe;			/* 0x0400 */
>  	__u32	return_mcck_lpswe;		/* 0x0404 */
> diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
> index b18a96f3a334..78602d2f5eba 100644
> --- a/arch/s390/include/asm/percpu.h
> +++ b/arch/s390/include/asm/percpu.h
> @@ -60,6 +60,68 @@
>  #define this_cpu_or_1(pcp, val)		arch_this_cpu_to_op_simple(pcp, val, |)
>  #define this_cpu_or_2(pcp, val)		arch_this_cpu_to_op_simple(pcp, val, |)
>  
> +/*
> + * Macros to be used for percpu code section based on atomic instructions.
> + *
> + * Avoid the need to use preempt_disable() / preempt_disable() pairs and the
> + * conditional preempt_schedule_notrace() function calls which come with
> + * this. The idea is that this_cpu operations based on atomic instructions are
> + * guarded with mviy instructions:
> + *
> + * - The first mviy instruction writes the register number, which contains the
> + *   percpu address variable to lowcore. This also indicates that a percpu
> + *   code section is executed.
> + *
> + * - The first mviy instruction following the mviy instruction must be the ag
> + *   instruction which adds the percpu offset to the percpu address register.
> + *
> + * - Afterwards the atomic percpu operation follows.
> + *
> + * - Then a second mviy instruction writes a zero to lowcore, which indicates
> + *   the end of the percpu code section.
> + *
> + * - In case of an interrupt/exception/nmi the register number which was
> + *   written to lowcore is copied to the exception frame (pt_regs), and a zero
> + *   is written to lowcore.
> + *
> + * - On return to the previous context it is checked if a percpu code section
> + *   was executed (saved register number not zero), and if the process was
> + *   migrated to a different cpu. If the percpu offset was already added to
> + *   the percpu address register (instruction address does _not_ point to the
> + *   ag instruction) the content of the percpu address register is adjusted so
> + *   it points to percpu variable of the new cpu.
> + *
> + * Inline assemblies making use of this typically have a code sequence like:
> + *
> + *   MVIY_PERCPU(...) <- start of percpu code section
> + *   AG_ALT(...)      <- add percpu offset; must be the second instruction
> + *   atomic_op	      <- atomic op
                 \t here, but should be spaces?

Probably it worth noting that no extra instructions between atomic_op
and MVIY_ALT may exist (e.g. in the future), especially ones that use
the percpu_register.

> + *   MVIY_ALT(...)    <- end of percpu code section
> + */
> +
> +#define MVIY_PERCPU(disp, dispalt, reg)						\
> +	".macro GEN_MVIY disp reg\n"						\
> +	".irp	rs,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15\n"			\
> +	"	.ifc \\reg,%%r\\rs\n"						\
> +	"	mviy	\\disp(%%r0),\\rs\n"					\
> +	"	.endif\n"							\
> +	".endr\n"								\
> +	".endm\n"								\
> +	ALTERNATIVE("GEN_MVIY " __stringify(disp)    " " __stringify(reg) "\n",	\
> +		    "GEN_MVIY " __stringify(dispalt) " " __stringify(reg) "\n",	\
> +		    ALT_FEATURE(MFEATURE_LOWCORE))				\
> +	".purgem GEN_MVIY\n"
> +
> +#define MVIY_ALT(disp, dispalt)							\
> +	ALTERNATIVE("	mviy	" disp	  "(%%r0),0\n",				\
> +		    "	mviy	" dispalt "(%%r0),0\n",				\
> +		    ALT_FEATURE(MFEATURE_LOWCORE))
> +
> +#define AG_ALT(disp, dispalt, reg)						\
> +	ALTERNATIVE("	ag	" reg ", " disp	   "(%%r0)\n",			\
> +		    "	ag	" reg ", " dispalt "(%%r0)\n",			\
> +		    ALT_FEATURE(MFEATURE_LOWCORE))
> +
>  #ifndef MARCH_HAS_Z196_FEATURES
>  
>  #define this_cpu_add_4(pcp, val)	arch_this_cpu_to_op_simple(pcp, val, +)
> diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
> index aaceb1d9110a..495e310c3d6d 100644
> --- a/arch/s390/include/asm/ptrace.h
> +++ b/arch/s390/include/asm/ptrace.h
> @@ -134,6 +134,8 @@ struct pt_regs {
>  	};
>  	unsigned long flags;
>  	unsigned long last_break;
> +	unsigned int cpu;
> +	unsigned char percpu_register;

May be name it as this_cpu and this_cpu_reg(ister)?

>  };
>  
>  /*
> diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
> index d10a17e6531d..efb988833c88 100644
> --- a/arch/s390/kernel/irq.c
> +++ b/arch/s390/kernel/irq.c
> @@ -33,6 +33,7 @@
>  #include <asm/softirq_stack.h>
>  #include <asm/vtime.h>
>  #include <asm/asm.h>
> +#include <asm/entry-percpu.h>
>  #include "entry.h"
>  
>  DEFINE_PER_CPU_SHARED_ALIGNED(struct irq_stat, irq_stat);
> @@ -142,10 +143,13 @@ static int irq_pending(struct pt_regs *regs)
>  
>  void noinstr do_io_irq(struct pt_regs *regs)
>  {
> -	irqentry_state_t state = irqentry_enter(regs);
> -	struct pt_regs *old_regs = set_irq_regs(regs);
> -	bool from_idle;
> +	bool from_idle, percpu_needs_fixup;
> +	struct pt_regs *old_regs;
> +	irqentry_state_t state;
>  
> +	percpu_entry(regs);
> +	state = irqentry_enter(regs);
> +	old_regs = set_irq_regs(regs);
>  	from_idle = test_and_clear_cpu_flag(CIF_ENABLED_WAIT);
>  	if (from_idle)
>  		update_timer_idle();
> @@ -170,21 +174,25 @@ void noinstr do_io_irq(struct pt_regs *regs)
>  			do_irq_async(regs, IO_INTERRUPT);
>  	} while (machine_is_lpar() && irq_pending(regs));
>  
> +	percpu_needs_fixup = percpu_code_check(regs);
>  	irq_exit_rcu();
> -
>  	set_irq_regs(old_regs);
>  	irqentry_exit(regs, state);
>  
>  	if (from_idle)
>  		regs->psw.mask &= ~(PSW_MASK_EXT | PSW_MASK_IO | PSW_MASK_WAIT);
> +	percpu_exit(regs, percpu_needs_fixup);
>  }
>  
>  void noinstr do_ext_irq(struct pt_regs *regs)
>  {
> -	irqentry_state_t state = irqentry_enter(regs);
> -	struct pt_regs *old_regs = set_irq_regs(regs);
> -	bool from_idle;
> +	bool from_idle, percpu_needs_fixup;
> +	struct pt_regs *old_regs;
> +	irqentry_state_t state;
>  
> +	percpu_entry(regs);
> +	state = irqentry_enter(regs);
> +	old_regs = set_irq_regs(regs);
>  	from_idle = test_and_clear_cpu_flag(CIF_ENABLED_WAIT);
>  	if (from_idle)
>  		update_timer_idle();
> @@ -206,12 +214,14 @@ void noinstr do_ext_irq(struct pt_regs *regs)
>  
>  	do_irq_async(regs, EXT_INTERRUPT);
>  
> +	percpu_needs_fixup = percpu_code_check(regs);
>  	irq_exit_rcu();
>  	set_irq_regs(old_regs);
>  	irqentry_exit(regs, state);
>  
>  	if (from_idle)
>  		regs->psw.mask &= ~(PSW_MASK_EXT | PSW_MASK_IO | PSW_MASK_WAIT);
> +	percpu_exit(regs, percpu_needs_fixup);
>  }
>  
>  static void show_msi_interrupt(struct seq_file *p, int irq)
> diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
> index 94fbfad49f62..e17a59d4d5a4 100644
> --- a/arch/s390/kernel/nmi.c
> +++ b/arch/s390/kernel/nmi.c
> @@ -22,6 +22,7 @@
>  #include <linux/module.h>
>  #include <linux/sched/signal.h>
>  #include <linux/kvm_host.h>
> +#include <asm/entry-percpu.h>
>  #include <asm/lowcore.h>
>  #include <asm/ctlreg.h>
>  #include <asm/fpu.h>
> @@ -363,6 +364,7 @@ NOKPROBE_SYMBOL(s390_backup_mcck_info);
>   */
>  void notrace s390_do_machine_check(struct pt_regs *regs)
>  {
> +	bool percpu_needs_fixup;
>  	static int ipd_count;
>  	static DEFINE_SPINLOCK(ipd_lock);
>  	static unsigned long long last_ipd;
> @@ -374,6 +376,7 @@ void notrace s390_do_machine_check(struct pt_regs *regs)
>  	unsigned long mcck_dam_code;
>  	int mcck_pending = 0;
>  
> +	percpu_entry(regs);
>  	irq_state = irqentry_nmi_enter(regs);
>  
>  	if (user_mode(regs))
> @@ -495,7 +498,9 @@ void notrace s390_do_machine_check(struct pt_regs *regs)
>  	if (mcck_pending)
>  		schedule_mcck_handler();
>  
> +	percpu_needs_fixup = percpu_code_check(regs);
>  	irqentry_nmi_exit(regs, irq_state);
> +	percpu_exit(regs, percpu_needs_fixup);
>  }
>  NOKPROBE_SYMBOL(s390_do_machine_check);
>  
> diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
> index 1b5c6fc431cc..564403496a7c 100644
> --- a/arch/s390/kernel/traps.c
> +++ b/arch/s390/kernel/traps.c
> @@ -24,6 +24,7 @@
>  #include <linux/entry-common.h>
>  #include <linux/kmsan.h>
>  #include <linux/bug.h>
> +#include <asm/entry-percpu.h>
>  #include <asm/asm-extable.h>
>  #include <asm/irqflags.h>
>  #include <asm/ptrace.h>
> @@ -329,6 +330,7 @@ static void (*pgm_check_table[128])(struct pt_regs *regs);
>  void noinstr __do_pgm_check(struct pt_regs *regs)
>  {
>  	struct lowcore *lc = get_lowcore();
> +	bool percpu_needs_fixup;
>  	irqentry_state_t state;
>  	unsigned int trapnr;
>  	union teid teid;
> @@ -349,6 +351,7 @@ void noinstr __do_pgm_check(struct pt_regs *regs)
>  		current->thread.gmap_int_code = regs->int_code & 0xffff;
>  		return;
>  	}
> +	percpu_entry(regs);
>  	state = irqentry_enter(regs);
>  	if (user_mode(regs)) {
>  		update_timer_sys();
> @@ -385,7 +388,9 @@ void noinstr __do_pgm_check(struct pt_regs *regs)
>  		pgm_check_table[trapnr](regs);
>  out:
>  	local_irq_disable();
> +	percpu_needs_fixup = percpu_code_check(regs);
>  	irqentry_exit(regs, state);
> +	percpu_exit(regs, percpu_needs_fixup);
>  }
>  
>  /*
> -- 
> 2.51.0
> 
