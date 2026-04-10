Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72373318EC5;
	Fri, 10 Apr 2026 03:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775792396; cv=none; b=qFuD+nttFF+Q0nsGU5EHZKw+MRX0eiQuvkFD9WDx0cerwxai+gxKcnHsuFteroDoh/J3iacO5Ad8sYZGRU0QFJa12fdLICsBYqCfR3jPGTdfq6FpZtcpPv9JSkrG/+uHnuHZKgtLPlZjAzQ9CSdkth+im/PlpPEl8krumGwolMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775792396; c=relaxed/simple;
	bh=Luva0RKt6+1q6BxL1l8fksEpnuWf4hC0r+/4GslVpcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Kcel/7LtKXWn/Xhyr+FYsyKLCfBd0zw9ptY7ZxFtqImaknQ8MWGUOjjxJIkvS+jkMD7ttX6Bw4uyX1wzyq029pP6SCnVUS9be/Ux9zeWGAu1Hhyq88PQs0a4cnkhgrfoaPqy+ditOPLXISDDv+/UQF/yPWeZrllgLtK05X1/gTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Z5Q4uKAU; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Z5Q4uKAU"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=atwTW2sF/xt8n6uLhSlHA/c+wRjPdZV9aJAWAZYP3rs=;
	b=Z5Q4uKAUUcCz5eb9Pn5HrY4TU5BcEAvwteS8re84wU6O2L9PDCrQvRaO3FliJjSHa2c2SL2CE
	XRlyC2JXtwZ3lLlCiz3KsnEz/WH6bLb0koQG570iVTOGvqgLIoaCRROqol3KGMHmCG+beXnwyta
	ZlPsxaIHbFH/VbOrtFPR1Eo=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fsMpT0DM8z1K99S;
	Fri, 10 Apr 2026 11:33:37 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id E140E402AB;
	Fri, 10 Apr 2026 11:39:49 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 10 Apr 2026 11:39:47 +0800
Message-ID: <f890ed5b-3ac2-4a3b-7d26-103ea110936d@huawei.com>
Date: Fri, 10 Apr 2026 11:39:46 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v14 2/4] asm-generic: Move TIF_SINGLESTEP to generic TIF
 bits
Content-Language: en-US
To: Mark Rutland <mark.rutland@arm.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <chenhuacai@kernel.org>,
	<kernel@xen0n.name>, <hca@linux.ibm.com>, <gor@linux.ibm.com>,
	<agordeev@linux.ibm.com>, <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
	<oleg@redhat.com>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <arnd@arndb.de>,
	<shuah@kernel.org>, <kevin.brodsky@arm.com>, <yeoreum.yun@arm.com>,
	<anshuman.khandual@arm.com>, <thuth@redhat.com>, <ryan.roberts@arm.com>,
	<song@kernel.org>, <ziyao@disroot.org>, <linusw@kernel.org>,
	<schuster.simon@siemens-energy.com>, <jremus@linux.ibm.com>,
	<akpm@linux-foundation.org>, <mathieu.desnoyers@efficios.com>,
	<kmal@cock.li>, <dvyukov@google.com>, <reddybalavignesh9979@gmail.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-s390@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20260320104222.1381274-1-ruanjinjie@huawei.com>
 <20260320104222.1381274-3-ruanjinjie@huawei.com>
 <addYbV3_9eFZg_b4@J2N7QTR9R3>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <addYbV3_9eFZg_b4@J2N7QTR9R3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2026/4/9 15:42, Mark Rutland wrote:
> On Fri, Mar 20, 2026 at 06:42:20PM +0800, Jinjie Ruan wrote:
>> Currently, x86, ARM64, s390, and LoongArch all define and use
>> TIF_SINGLESTEP to track single-stepping state.
> 
> Do the architectures actually use the flag in the same way?

As far as I know, the behavior of setting and clearing the
TIF_SINGLESTEP flag is consistent across these architectures, at least
within the ptrace handling logic of user_enable_single_step() and
user_disable_single_step().

> 
> I'd expect that this is used subtly differently across those
> architectures, and so isn't necessarily generic.
> 
>> Since this flag is shared across multiple major architectures and serves
>> a common purpose in the generic entry/exit paths, move TIF_SINGLESTEP
>> into the generic Thread Information Flags (TIF) infrastructure.
>>
>> This consolidation reduces architecture-specific boilerplate code and
>> ensures consistency for generic features that rely on single-step
>> state tracking.
> 
> Is it necessary to make this generic in order to move to generic irq
> flags? I'd expect that generic code cannot make use of this due to the
> different semantics across architectures, as noted abobve.
> 
> I think it's probably better to keep this architecture-specific for now,
> where architectures can clearly define how they're using this bit.

Hi Mark,

Thank you for the feedback. You are maybe right, and your concern aligns
with the original intent behind the generic TIF infrastructure.

I noticed that when the generic TIF infrastructure was first introduced
(see commit 29589343488e: "asm-generic: Provide generic TIF
infrastructure"), it explicitly mentioned:
"This could probably be extended by TIF_SINGLESTEP and BLOCKSTEP, but
those are only used in architecture specific code. So leave them alone
for now."

It seems that moving TIF_SINGLESTEP to generic TIF bits at this stage is
indeed premature. Furthermore, in the generic entry implementation, the
single-step exit handling is actually managed by
SYSCALL_WORK_SYSCALL_EXIT_TRAP rather than directly relying on a generic
TIF_SINGLESTEP flag.


Best regards,
Jinjie

> 
> Am I missing some reason why it's necessary to make this generic?
> 
> Mark.
> 
>> Cc: Thomas Gleixner <tglx@kernel.org>
>> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> Reviewed-by: Linus Walleij <linusw@kernel.org>
>> Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
>> Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/loongarch/include/asm/thread_info.h | 11 +++++------
>>  arch/s390/include/asm/thread_info.h      |  7 +++----
>>  arch/x86/include/asm/thread_info.h       |  6 ++----
>>  include/asm-generic/thread_info_tif.h    |  5 +++++
>>  4 files changed, 15 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/thread_info.h b/arch/loongarch/include/asm/thread_info.h
>> index 4d7117fcdc78..a2ec87f18e1d 100644
>> --- a/arch/loongarch/include/asm/thread_info.h
>> +++ b/arch/loongarch/include/asm/thread_info.h
>> @@ -70,6 +70,7 @@ register unsigned long current_stack_pointer __asm__("$sp");
>>   */
>>  #define HAVE_TIF_NEED_RESCHED_LAZY
>>  #define HAVE_TIF_RESTORE_SIGMASK
>> +#define HAVE_TIF_SINGLESTEP
>>  
>>  #include <asm-generic/thread_info_tif.h>
>>  
>> @@ -82,11 +83,10 @@ register unsigned long current_stack_pointer __asm__("$sp");
>>  #define TIF_32BIT_REGS		21	/* 32-bit general purpose registers */
>>  #define TIF_32BIT_ADDR		22	/* 32-bit address space */
>>  #define TIF_LOAD_WATCH		23	/* If set, load watch registers */
>> -#define TIF_SINGLESTEP		24	/* Single Step */
>> -#define TIF_LSX_CTX_LIVE	25	/* LSX context must be preserved */
>> -#define TIF_LASX_CTX_LIVE	26	/* LASX context must be preserved */
>> -#define TIF_USEDLBT		27	/* LBT was used by this task this quantum (SMP) */
>> -#define TIF_LBT_CTX_LIVE	28	/* LBT context must be preserved */
>> +#define TIF_LSX_CTX_LIVE	24	/* LSX context must be preserved */
>> +#define TIF_LASX_CTX_LIVE	25	/* LASX context must be preserved */
>> +#define TIF_USEDLBT		26	/* LBT was used by this task this quantum (SMP) */
>> +#define TIF_LBT_CTX_LIVE	27	/* LBT context must be preserved */
>>  
>>  #define _TIF_NOHZ		BIT(TIF_NOHZ)
>>  #define _TIF_USEDFPU		BIT(TIF_USEDFPU)
>> @@ -96,7 +96,6 @@ register unsigned long current_stack_pointer __asm__("$sp");
>>  #define _TIF_32BIT_REGS		BIT(TIF_32BIT_REGS)
>>  #define _TIF_32BIT_ADDR		BIT(TIF_32BIT_ADDR)
>>  #define _TIF_LOAD_WATCH		BIT(TIF_LOAD_WATCH)
>> -#define _TIF_SINGLESTEP		BIT(TIF_SINGLESTEP)
>>  #define _TIF_LSX_CTX_LIVE	BIT(TIF_LSX_CTX_LIVE)
>>  #define _TIF_LASX_CTX_LIVE	BIT(TIF_LASX_CTX_LIVE)
>>  #define _TIF_USEDLBT		BIT(TIF_USEDLBT)
>> diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
>> index 1bcd42614e41..95be5258a422 100644
>> --- a/arch/s390/include/asm/thread_info.h
>> +++ b/arch/s390/include/asm/thread_info.h
>> @@ -61,6 +61,7 @@ void arch_setup_new_exec(void);
>>   */
>>  #define HAVE_TIF_NEED_RESCHED_LAZY
>>  #define HAVE_TIF_RESTORE_SIGMASK
>> +#define HAVE_TIF_SINGLESTEP
>>  
>>  #include <asm-generic/thread_info_tif.h>
>>  
>> @@ -69,15 +70,13 @@ void arch_setup_new_exec(void);
>>  #define TIF_GUARDED_STORAGE	17	/* load guarded storage control block */
>>  #define TIF_ISOLATE_BP_GUEST	18	/* Run KVM guests with isolated BP */
>>  #define TIF_PER_TRAP		19	/* Need to handle PER trap on exit to usermode */
>> -#define TIF_SINGLESTEP		21	/* This task is single stepped */
>> -#define TIF_BLOCK_STEP		22	/* This task is block stepped */
>> -#define TIF_UPROBE_SINGLESTEP	23	/* This task is uprobe single stepped */
>> +#define TIF_BLOCK_STEP		20	/* This task is block stepped */
>> +#define TIF_UPROBE_SINGLESTEP	21	/* This task is uprobe single stepped */
>>  
>>  #define _TIF_ASCE_PRIMARY	BIT(TIF_ASCE_PRIMARY)
>>  #define _TIF_GUARDED_STORAGE	BIT(TIF_GUARDED_STORAGE)
>>  #define _TIF_ISOLATE_BP_GUEST	BIT(TIF_ISOLATE_BP_GUEST)
>>  #define _TIF_PER_TRAP		BIT(TIF_PER_TRAP)
>> -#define _TIF_SINGLESTEP	BIT(TIF_SINGLESTEP)
>>  #define _TIF_BLOCK_STEP		BIT(TIF_BLOCK_STEP)
>>  #define _TIF_UPROBE_SINGLESTEP	BIT(TIF_UPROBE_SINGLESTEP)
>>  
>> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
>> index 0067684afb5b..f59072ba1473 100644
>> --- a/arch/x86/include/asm/thread_info.h
>> +++ b/arch/x86/include/asm/thread_info.h
>> @@ -98,9 +98,8 @@ struct thread_info {
>>  #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
>>  #define TIF_SPEC_FORCE_UPDATE	23	/* Force speculation MSR update in context switch */
>>  #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
>> -#define TIF_SINGLESTEP		25	/* reenable singlestep on user return*/
>> -#define TIF_BLOCKSTEP		26	/* set when we want DEBUGCTLMSR_BTF */
>> -#define TIF_ADDR32		27	/* 32-bit address space on 64 bits */
>> +#define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
>> +#define TIF_ADDR32		26	/* 32-bit address space on 64 bits */
>>  
>>  #define _TIF_SSBD		BIT(TIF_SSBD)
>>  #define _TIF_SPEC_IB		BIT(TIF_SPEC_IB)
>> @@ -112,7 +111,6 @@ struct thread_info {
>>  #define _TIF_SPEC_FORCE_UPDATE	BIT(TIF_SPEC_FORCE_UPDATE)
>>  #define _TIF_FORCED_TF		BIT(TIF_FORCED_TF)
>>  #define _TIF_BLOCKSTEP		BIT(TIF_BLOCKSTEP)
>> -#define _TIF_SINGLESTEP		BIT(TIF_SINGLESTEP)
>>  #define _TIF_ADDR32		BIT(TIF_ADDR32)
>>  
>>  /* flags to check in __switch_to() */
>> diff --git a/include/asm-generic/thread_info_tif.h b/include/asm-generic/thread_info_tif.h
>> index da1610a78f92..b277fe06aee3 100644
>> --- a/include/asm-generic/thread_info_tif.h
>> +++ b/include/asm-generic/thread_info_tif.h
>> @@ -48,4 +48,9 @@
>>  #define TIF_RSEQ		11	// Run RSEQ fast path
>>  #define _TIF_RSEQ		BIT(TIF_RSEQ)
>>  
>> +#ifdef HAVE_TIF_SINGLESTEP
>> +#define TIF_SINGLESTEP		12	/* reenable singlestep on user return*/
>> +#define _TIF_SINGLESTEP		BIT(TIF_SINGLESTEP)
>> +#endif
>> +
>>  #endif /* _ASM_GENERIC_THREAD_INFO_TIF_H_ */
>> -- 
>> 2.34.1
>>
> 
