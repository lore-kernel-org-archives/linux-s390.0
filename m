Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281E6C433FE
	for <linux-s390@archiver.kernel.org>; Tue, 26 Oct 2021 10:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1033660EFE
	for <linux-s390@archiver.kernel.org>; Tue, 26 Oct 2021 10:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbhJZKrZ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 26 Oct 2021 06:47:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1626 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231345AbhJZKrT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 26 Oct 2021 06:47:19 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19QACcFa017652;
        Tue, 26 Oct 2021 10:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=1n7mnSNZ+Rk0qwg17rqm+CEpaTcpDRpPBQdtSjtzAfg=;
 b=UZg426mbNa2HfhwgLchyAFLInF3xseYDCfir5aEB8Okmt6gl9AJUt2Q8qKLPVTi/G79H
 HDV04OexvwBMOf8bu1jf9bKDnWCPXMk+NAi+NRr16KvwTHmAEccjI1HA1EWVxG58664P
 msr2H83cSz30XJQANkIrYBJHOFtm1ogwRbGe2WMMaPmfY05ftkK6obBLMXr4oYmTUlIm
 NdAmZdVmMCij4XfZBNhPNBh7mjaz/MDKmYbjOxleW+bmU5uUvI3/J8ClmcUBBjnECvY9
 zrHNxQU/9UBq2XnL9Msg9QMAHRVQacV3hKGBRPHUfVE03UldLWgyb6smoXot9T+K7+5V 1w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bx4ygh4c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 10:43:53 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19Q9i910024580;
        Tue, 26 Oct 2021 10:43:52 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bx4ygh4at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 10:43:52 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19QAgsw8004676;
        Tue, 26 Oct 2021 10:43:49 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3bx4f14h3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 10:43:49 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19QAhj9L46268726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Oct 2021 10:43:45 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8477C4C749;
        Tue, 26 Oct 2021 10:43:45 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 627E84C74F;
        Tue, 26 Oct 2021 10:43:43 +0000 (GMT)
Received: from li-43c5434c-23b8-11b2-a85c-c4958fb47a68.ibm.com (unknown [9.171.51.215])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Oct 2021 10:43:43 +0000 (GMT)
Subject: Re: [PATCH 2/2] futex: remove futex_cmpxchg detection
To:     Arnd Bergmann <arnd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org
References: <20211026100432.1730393-1-arnd@kernel.org>
 <20211026100432.1730393-2-arnd@kernel.org>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <0d188eb1-32ee-aa1b-4f80-e711c11ca7eb@de.ibm.com>
Date:   Tue, 26 Oct 2021 12:43:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211026100432.1730393-2-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jZDzBdCv_0ekg1eKCzJZDVbif86qRHPb
X-Proofpoint-GUID: sumje8skGt9LY3pfbqlcp7WmcMbc1DYk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-26_02,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 clxscore=1011 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110260060
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Am 26.10.21 um 12:03 schrieb Arnd Bergmann:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Now that all architectures have a working futex implementation
> in any configuration, remove the runtime detection code.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

s390 part
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>   arch/arc/Kconfig              |  1 -
>   arch/arm/Kconfig              |  1 -
>   arch/arm64/Kconfig            |  1 -
>   arch/csky/Kconfig             |  1 -
>   arch/m68k/Kconfig             |  1 -
>   arch/riscv/Kconfig            |  1 -
>   arch/s390/Kconfig             |  1 -
>   arch/sh/Kconfig               |  1 -
>   arch/um/Kconfig               |  1 -
>   arch/um/kernel/skas/uaccess.c |  1 -
>   arch/xtensa/Kconfig           |  1 -
>   init/Kconfig                  |  8 --------
>   kernel/futex/core.c           | 35 -----------------------------------
>   kernel/futex/futex.h          |  6 ------
>   kernel/futex/syscalls.c       | 22 ----------------------
>   15 files changed, 82 deletions(-)
> 
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index 248389278e8f..f9413041686f 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -31,7 +31,6 @@ config ARC
>   	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if ARC_MMU_V4
>   	select HAVE_DEBUG_STACKOVERFLOW
>   	select HAVE_DEBUG_KMEMLEAK
> -	select HAVE_FUTEX_CMPXCHG if FUTEX
>   	select HAVE_IOREMAP_PROT
>   	select HAVE_KERNEL_GZIP
>   	select HAVE_KERNEL_LZMA
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index bb5d2c45477b..6448d311635d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -93,7 +93,6 @@ config ARM
>   	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>   	select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
>   	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !(THUMB2_KERNEL && CC_IS_CLANG)
> -	select HAVE_FUTEX_CMPXCHG if FUTEX
>   	select HAVE_GCC_PLUGINS
>   	select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
>   	select HAVE_IRQ_TIME_ACCOUNTING
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 0efc501f77aa..6c3c2ff5cef8 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -193,7 +193,6 @@ config ARM64
>   	select HAVE_PERF_USER_STACK_DUMP
>   	select HAVE_REGS_AND_STACK_ACCESS_API
>   	select HAVE_FUNCTION_ARG_ACCESS_API
> -	select HAVE_FUTEX_CMPXCHG if FUTEX
>   	select MMU_GATHER_RCU_TABLE_FREE
>   	select HAVE_RSEQ
>   	select HAVE_STACKPROTECTOR
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 823d3d5a9e11..efd7c5feac8b 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -53,7 +53,6 @@ config CSKY
>   	select HAVE_FUNCTION_TRACER
>   	select HAVE_FUNCTION_GRAPH_TRACER
>   	select HAVE_FUNCTION_ERROR_INJECTION
> -	select HAVE_FUTEX_CMPXCHG if FUTEX && SMP
>   	select HAVE_FTRACE_MCOUNT_RECORD
>   	select HAVE_KERNEL_GZIP
>   	select HAVE_KERNEL_LZO
> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index 0b50da08a9c5..15a793c5b2dc 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -20,7 +20,6 @@ config M68K
>   	select HAVE_ASM_MODVERSIONS
>   	select HAVE_DEBUG_BUGVERBOSE
>   	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !CPU_HAS_NO_UNALIGNED
> -	select HAVE_FUTEX_CMPXCHG if MMU && FUTEX
>   	select HAVE_MOD_ARCH_SPECIFIC
>   	select HAVE_UID16
>   	select MMU_GATHER_NO_RANGE if MMU
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 77a088d0a7e9..037fea9fac14 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -84,7 +84,6 @@ config RISCV
>   	select HAVE_DMA_CONTIGUOUS if MMU
>   	select HAVE_EBPF_JIT if MMU
>   	select HAVE_FUNCTION_ERROR_INJECTION
> -	select HAVE_FUTEX_CMPXCHG if FUTEX
>   	select HAVE_GCC_PLUGINS
>   	select HAVE_GENERIC_VDSO if MMU && 64BIT
>   	select HAVE_IRQ_TIME_ACCOUNTING
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index f615c3f65f5a..1c9ecf619e04 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -164,7 +164,6 @@ config S390
>   	select HAVE_FUNCTION_ERROR_INJECTION
>   	select HAVE_FUNCTION_GRAPH_TRACER
>   	select HAVE_FUNCTION_TRACER
> -	select HAVE_FUTEX_CMPXCHG if FUTEX
>   	select HAVE_GCC_PLUGINS
>   	select HAVE_GENERIC_VDSO
>   	select HAVE_IOREMAP_PROT if PCI
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 6904f4bdbf00..93195d3368c0 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -34,7 +34,6 @@ config SUPERH
>   	select HAVE_FAST_GUP if MMU
>   	select HAVE_FUNCTION_GRAPH_TRACER
>   	select HAVE_FUNCTION_TRACER
> -	select HAVE_FUTEX_CMPXCHG if FUTEX
>   	select HAVE_FTRACE_MCOUNT_RECORD
>   	select HAVE_HW_BREAKPOINT
>   	select HAVE_IOREMAP_PROT if MMU && !X2TLB
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index c18b45f75d41..c906250d4970 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -14,7 +14,6 @@ config UML
>   	select HAVE_ARCH_SECCOMP_FILTER
>   	select HAVE_ASM_MODVERSIONS
>   	select HAVE_UID16
> -	select HAVE_FUTEX_CMPXCHG if FUTEX
>   	select HAVE_DEBUG_KMEMLEAK
>   	select HAVE_DEBUG_BUGVERBOSE
>   	select NO_DMA if !UML_DMA_EMULATION
> diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
> index a509be911026..9e37a7c05990 100644
> --- a/arch/um/kernel/skas/uaccess.c
> +++ b/arch/um/kernel/skas/uaccess.c
> @@ -348,7 +348,6 @@ EXPORT_SYMBOL(arch_futex_atomic_op_inuser);
>    * 0 - On success
>    * -EFAULT - User access resulted in a page fault
>    * -EAGAIN - Atomic operation was unable to complete due to contention
> - * -ENOSYS - Function not implemented (only if !HAVE_FUTEX_CMPXCHG)
>    */
>   
>   int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
> index 0e56bad058fa..8ac599aa6d99 100644
> --- a/arch/xtensa/Kconfig
> +++ b/arch/xtensa/Kconfig
> @@ -31,7 +31,6 @@ config XTENSA
>   	select HAVE_DMA_CONTIGUOUS
>   	select HAVE_EXIT_THREAD
>   	select HAVE_FUNCTION_TRACER
> -	select HAVE_FUTEX_CMPXCHG if !MMU && FUTEX
>   	select HAVE_HW_BREAKPOINT if PERF_EVENTS
>   	select HAVE_IRQ_TIME_ACCOUNTING
>   	select HAVE_PCI
> diff --git a/init/Kconfig b/init/Kconfig
> index c0f55ea5a71f..538688598f2f 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1597,14 +1597,6 @@ config FUTEX_PI
>   	depends on FUTEX && RT_MUTEXES
>   	default y
>   
> -config HAVE_FUTEX_CMPXCHG
> -	bool
> -	depends on FUTEX
> -	help
> -	  Architectures should select this if futex_atomic_cmpxchg_inatomic()
> -	  is implemented and always working. This removes a couple of runtime
> -	  checks.
> -
>   config EPOLL
>   	bool "Enable eventpoll support" if EXPERT
>   	default y
> diff --git a/kernel/futex/core.c b/kernel/futex/core.c
> index 25d8a88b32e5..926c2bb752bc 100644
> --- a/kernel/futex/core.c
> +++ b/kernel/futex/core.c
> @@ -41,11 +41,6 @@
>   #include "futex.h"
>   #include "../locking/rtmutex_common.h"
>   
> -#ifndef CONFIG_HAVE_FUTEX_CMPXCHG
> -int  __read_mostly futex_cmpxchg_enabled;
> -#endif
> -
> -
>   /*
>    * The base of the bucket array and its size are always used together
>    * (after initialization only in futex_hash()), so ensure that they
> @@ -776,9 +771,6 @@ static void exit_robust_list(struct task_struct *curr)
>   	unsigned long futex_offset;
>   	int rc;
>   
> -	if (!futex_cmpxchg_enabled)
> -		return;
> -
>   	/*
>   	 * Fetch the list head (which was registered earlier, via
>   	 * sys_set_robust_list()):
> @@ -874,9 +866,6 @@ static void compat_exit_robust_list(struct task_struct *curr)
>   	compat_long_t futex_offset;
>   	int rc;
>   
> -	if (!futex_cmpxchg_enabled)
> -		return;
> -
>   	/*
>   	 * Fetch the list head (which was registered earlier, via
>   	 * sys_set_robust_list()):
> @@ -950,8 +939,6 @@ static void exit_pi_state_list(struct task_struct *curr)
>   	struct futex_hash_bucket *hb;
>   	union futex_key key = FUTEX_KEY_INIT;
>   
> -	if (!futex_cmpxchg_enabled)
> -		return;
>   	/*
>   	 * We are a ZOMBIE and nobody can enqueue itself on
>   	 * pi_state_list anymore, but we have to be careful
> @@ -1125,26 +1112,6 @@ void futex_exit_release(struct task_struct *tsk)
>   	futex_cleanup_end(tsk, FUTEX_STATE_DEAD);
>   }
>   
> -static void __init futex_detect_cmpxchg(void)
> -{
> -#ifndef CONFIG_HAVE_FUTEX_CMPXCHG
> -	u32 curval;
> -
> -	/*
> -	 * This will fail and we want it. Some arch implementations do
> -	 * runtime detection of the futex_atomic_cmpxchg_inatomic()
> -	 * functionality. We want to know that before we call in any
> -	 * of the complex code paths. Also we want to prevent
> -	 * registration of robust lists in that case. NULL is
> -	 * guaranteed to fault and we get -EFAULT on functional
> -	 * implementation, the non-functional ones will return
> -	 * -ENOSYS.
> -	 */
> -	if (futex_cmpxchg_value_locked(&curval, NULL, 0, 0) == -EFAULT)
> -		futex_cmpxchg_enabled = 1;
> -#endif
> -}
> -
>   static int __init futex_init(void)
>   {
>   	unsigned int futex_shift;
> @@ -1163,8 +1130,6 @@ static int __init futex_init(void)
>   					       futex_hashsize, futex_hashsize);
>   	futex_hashsize = 1UL << futex_shift;
>   
> -	futex_detect_cmpxchg();
> -
>   	for (i = 0; i < futex_hashsize; i++) {
>   		atomic_set(&futex_queues[i].waiters, 0);
>   		plist_head_init(&futex_queues[i].chain);
> diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
> index 040ae4277cb0..c264cbeab71c 100644
> --- a/kernel/futex/futex.h
> +++ b/kernel/futex/futex.h
> @@ -27,12 +27,6 @@
>   #define FLAGS_CLOCKRT		0x02
>   #define FLAGS_HAS_TIMEOUT	0x04
>   
> -#ifdef CONFIG_HAVE_FUTEX_CMPXCHG
> -#define futex_cmpxchg_enabled 1
> -#else
> -extern int  __read_mostly futex_cmpxchg_enabled;
> -#endif
> -
>   #ifdef CONFIG_FAIL_FUTEX
>   extern bool should_fail_futex(bool fshared);
>   #else
> diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
> index 6f91a07a6a83..086a22d1adb7 100644
> --- a/kernel/futex/syscalls.c
> +++ b/kernel/futex/syscalls.c
> @@ -29,8 +29,6 @@
>   SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
>   		size_t, len)
>   {
> -	if (!futex_cmpxchg_enabled)
> -		return -ENOSYS;
>   	/*
>   	 * The kernel knows only one size for now:
>   	 */
> @@ -56,9 +54,6 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
>   	unsigned long ret;
>   	struct task_struct *p;
>   
> -	if (!futex_cmpxchg_enabled)
> -		return -ENOSYS;
> -
>   	rcu_read_lock();
>   
>   	ret = -ESRCH;
> @@ -103,17 +98,6 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
>   			return -ENOSYS;
>   	}
>   
> -	switch (cmd) {
> -	case FUTEX_LOCK_PI:
> -	case FUTEX_LOCK_PI2:
> -	case FUTEX_UNLOCK_PI:
> -	case FUTEX_TRYLOCK_PI:
> -	case FUTEX_WAIT_REQUEUE_PI:
> -	case FUTEX_CMP_REQUEUE_PI:
> -		if (!futex_cmpxchg_enabled)
> -			return -ENOSYS;
> -	}
> -
>   	switch (cmd) {
>   	case FUTEX_WAIT:
>   		val3 = FUTEX_BITSET_MATCH_ANY;
> @@ -323,9 +307,6 @@ COMPAT_SYSCALL_DEFINE2(set_robust_list,
>   		struct compat_robust_list_head __user *, head,
>   		compat_size_t, len)
>   {
> -	if (!futex_cmpxchg_enabled)
> -		return -ENOSYS;
> -
>   	if (unlikely(len != sizeof(*head)))
>   		return -EINVAL;
>   
> @@ -342,9 +323,6 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
>   	unsigned long ret;
>   	struct task_struct *p;
>   
> -	if (!futex_cmpxchg_enabled)
> -		return -ENOSYS;
> -
>   	rcu_read_lock();
>   
>   	ret = -ESRCH;
> 
