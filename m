Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BE333ADBA;
	Fri, 20 Mar 2026 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773998487; cv=none; b=TNuy9zTGdNtNVocvNswLUiLeidTDF3XYoD0vfonprWhUAcxJi5AIJYHKHIAlSg9UfGbGj7jD0hRqsYVF3rSyHDuMrifsgW3Dx/ihFUSmouyk7wUEfAfW5YzpoxUhN/ytHCPbUDWdK//O0Fmv0h1vVWsVKklNZon5ZyaIYe3XJWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773998487; c=relaxed/simple;
	bh=3m8Eshu25DLuulkOFyj7c2pOEu+9wu8nxRGbBQ/DhQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lONxlu375+Rq/1D/CmjdwLNhGo4wqGN8mJxH2uND+oaL/rWLus1BPRA87r5iasPp/nu0bhl3usQrYmZ6xdzKzbUBZ6+30q7Za+l8uo4r1cJwr9fOCZwtuZ7ZYhsAuVZeBp6k2R5WKfwcOF+FX/vps5Wm2O9/X9nrde81AjH3bb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FgyWhZ0T; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FgyWhZ0T"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Vg0WdVEqTXSBpZm4qvokjHJVOQZLDCFu+VDlhdAL6G4=;
	b=FgyWhZ0T5h9S4nlhkYys1pcjT6ZC/1I85cy8eT5YS7tx3+DSGmHWZ10EZE3CZ2WXQs5VhM6MF
	FnvwCFH/7bx7ugv5LebsKdkh1RL7gPXdbAmgbld9PJVIxQZXNKqbgTz8AP3Gwom/WPQmUNz4hGI
	i1pUtNpz2oiLDKm+uTscfwk=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fccPZ6NfrzKm4D;
	Fri, 20 Mar 2026 17:16:18 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B5B6402AB;
	Fri, 20 Mar 2026 17:21:20 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 20 Mar 2026 17:21:17 +0800
Message-ID: <6a01d0ee-86b2-7dcf-eb62-61bc8b5864ef@huawei.com>
Date: Fri, 20 Mar 2026 17:21:15 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v13 RESEND 13/14] arm64: Use generic TIF bits for common
 thread flags
Content-Language: en-US
To: Kevin Brodsky <kevin.brodsky@arm.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <oleg@redhat.com>, <chenhuacai@kernel.org>,
	<kernel@xen0n.name>, <hca@linux.ibm.com>, <gor@linux.ibm.com>,
	<agordeev@linux.ibm.com>, <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <arnd@arndb.de>,
	<peterz@infradead.org>, <luto@kernel.org>, <shuah@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <deller@gmx.de>, <macro@orcam.me.uk>,
	<akpm@linux-foundation.org>, <ldv@strace.io>, <anshuman.khandual@arm.com>,
	<ryan.roberts@arm.com>, <mark.rutland@arm.com>, <thuth@redhat.com>,
	<song@kernel.org>, <ada.coupriediaz@arm.com>, <linusw@kernel.org>,
	<broonie@kernel.org>, <pengcan@kylinos.cn>, <liqiang01@kylinos.cn>,
	<ziyao@disroot.org>, <guanwentao@uniontech.com>, <guoren@kernel.org>,
	<schuster.simon@siemens-energy.com>, <jremus@linux.ibm.com>,
	<david@kernel.org>, <mathieu.desnoyers@efficios.com>, <edumazet@google.com>,
	<kmal@cock.li>, <dvyukov@google.com>, <reddybalavignesh9979@gmail.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-s390@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20260317082020.737779-1-ruanjinjie@huawei.com>
 <20260317082020.737779-14-ruanjinjie@huawei.com>
 <16598f59-df24-488b-af74-e3f2a2732755@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <16598f59-df24-488b-af74-e3f2a2732755@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2026/3/20 1:07, Kevin Brodsky wrote:
> On 17/03/2026 09:20, Jinjie Ruan wrote:
>> Use the generic TIF bits defined in <asm-generic/thread_info_tif.h> for
>> standard thread flags (TIF_SIGPENDING, TIF_NEED_RESCHED, TIF_NOTIFY_RESUME,
>> TIF_RESTORE_SIGMASK, TIF_SINGLESTEP, etc.) instead of defining
>> them locally.
>>
>> Arm64-specific bits (TIF_FOREIGN_FPSTATE, TIF_MTE_ASYNC_FAULT, TIF_SVE,
>> TIF_SSBD, etc.) are renumbered to start at bit 16 to avoid conflicts.
>>
>> This enables RSEQ optimizations which require CONFIG_HAVE_GENERIC_TIF_BITS
>> combined with the generic entry infrastructure (already used by arm64).
>>
>> Cc: Thomas Gleixner <tglx@kernel.org>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/arm64/Kconfig                   |  1 +
>>  arch/arm64/include/asm/thread_info.h | 62 ++++++++++++----------------
>>  2 files changed, 28 insertions(+), 35 deletions(-)
>>

[...]

>> + */
>> +#define HAVE_TIF_NEED_RESCHED_LAZY
>> +#define HAVE_TIF_RESTORE_SIGMASK
>> +#define HAVE_TIF_SINGLESTEP
>> +
>> +#include <asm-generic/thread_info_tif.h>
>> +
>> +#define TIF_FOREIGN_FPSTATE	16	/* CPU's FP state is not current's */
>> +#define TIF_MTE_ASYNC_FAULT	17	/* MTE Asynchronous Tag Check Fault */
>> +#define TIF_FREEZE		18
> 
> Turns out this flag became unused a long time ago, see commit
> d88e4cb67197 ("freezer: remove now unused TIF_FREEZE"), and it was
> probably reintroduced by mistake in the original arm64 implementation,
> commit b3901d54dc4f ("arm64: Process management"). Good opportunity to
> remove it I think.

Totally agree. Let's get rid of it. No point in keeping dead code.

Thanks for the review.

> 
> Otherwise:
> 
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> 
>> +#define TIF_32BIT		19      /* 32bit process */
>> +#define TIF_SVE			20	/* Scalable Vector Extension in use */
>> +#define TIF_SVE_VL_INHERIT	21	/* Inherit SVE vl_onexec across exec */
>> +#define TIF_SSBD		22	/* Wants SSB mitigation */
>> +#define TIF_TAGGED_ADDR		23	/* Allow tagged user addresses */
>> +#define TIF_SME			24	/* SME in use */
>> +#define TIF_SME_VL_INHERIT	25	/* Inherit SME vl_onexec across exec */
>> +#define TIF_KERNEL_FPSTATE	26	/* Task is in a kernel mode FPSIMD section */
>> +#define TIF_TSC_SIGSEGV		27	/* SIGSEGV on counter-timer access */
>> +#define TIF_LAZY_MMU_PENDING	28	/* Ops pending for lazy mmu mode exit */
>>  
>> -#define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>> -#define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
>> -#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
>> -#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
>> -#define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
>> -#define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
>> -#define _TIF_UPROBE		(1 << TIF_UPROBE)
>> -#define _TIF_32BIT		(1 << TIF_32BIT)
>> -#define _TIF_SVE		(1 << TIF_SVE)
>> -#define _TIF_MTE_ASYNC_FAULT	(1 << TIF_MTE_ASYNC_FAULT)
>> -#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
>> -#define _TIF_TSC_SIGSEGV	(1 << TIF_TSC_SIGSEGV)
>> +#define _TIF_FOREIGN_FPSTATE	BIT(TIF_FOREIGN_FPSTATE)
>> +#define _TIF_32BIT		BIT(TIF_32BIT)
>> +#define _TIF_SVE		BIT(TIF_SVE)
>> +#define _TIF_MTE_ASYNC_FAULT	BIT(TIF_MTE_ASYNC_FAULT)
>> +#define _TIF_TSC_SIGSEGV	BIT(TIF_TSC_SIGSEGV)
>>  
>>  #ifdef CONFIG_SHADOW_CALL_STACK
>>  #define INIT_SCS							\
> 
