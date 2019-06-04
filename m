Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbfFDIMG (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 4 Jun 2019 04:12:06 -0400
Subject: Re: [RFC V2] mm: Generalize notify_page_fault()
References: <1559630046-12940-1-git-send-email-anshuman.khandual@arm.com>
 <20190604065401.GE3402@hirez.programming.kicks-ass.net>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <afe886e5-8420-0c33-ed2f-159cd3d55882@arm.com>
Date: Tue, 4 Jun 2019 13:42:10 +0530
MIME-Version: 1.0
In-Reply-To: <20190604065401.GE3402@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrey Konovalov <andreyknvl@google.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>



On 06/04/2019 12:24 PM, Peter Zijlstra wrote:
> On Tue, Jun 04, 2019 at 12:04:06PM +0530, Anshuman Khandual wrote:
>> diff --git a/mm/memory.c b/mm/memory.c
>> index ddf20bd..b6bae8f 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -52,6 +52,7 @@
>>  #include <linux/pagemap.h>
>>  #include <linux/memremap.h>
>>  #include <linux/ksm.h>
>> +#include <linux/kprobes.h>
>>  #include <linux/rmap.h>
>>  #include <linux/export.h>
>>  #include <linux/delayacct.h>
>> @@ -141,6 +142,21 @@ static int __init init_zero_pfn(void)
>>  core_initcall(init_zero_pfn);
>>  
>>  
>> +int __kprobes notify_page_fault(struct pt_regs *regs, unsigned int trap)
>> +{
>> +	int ret = 0;
>> +
>> +	/*
>> +	 * To be potentially processing a kprobe fault and to be allowed
>> +	 * to call kprobe_running(), we have to be non-preemptible.
>> +	 */
>> +	if (kprobes_built_in() && !preemptible() && !user_mode(regs)) {
>> +		if (kprobe_running() && kprobe_fault_handler(regs, trap))
>> +			ret = 1;
>> +	}
>> +	return ret;
>> +}
> 
> That thing should be called kprobe_page_fault() or something,
> notify_page_fault() is a horribly crap name for this function.

Agreed. kprobe_page_fault() sounds good.
