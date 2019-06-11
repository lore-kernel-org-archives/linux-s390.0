Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:52938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390539AbfFKFNv (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Jun 2019 01:13:51 -0400
Subject: Re: [RFC V3] mm: Generalize and rename notify_page_fault() as
 kprobe_page_fault()
References: <1559903655-5609-1-git-send-email-anshuman.khandual@arm.com>
 <ec764ff4-f68a-fce5-ac1e-a4664e1123c7@c-s.fr>
 <97e9c9b3-89c8-d378-4730-841a900e6800@arm.com>
 <8dd6168592437378ff4a7c204e0f2962d002b44f.camel@linux.ibm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <7b0a7afd-2776-0d95-19c5-3e15959744eb@arm.com>
Date: Tue, 11 Jun 2019 10:44:00 +0530
MIME-Version: 1.0
In-Reply-To: <8dd6168592437378ff4a7c204e0f2962d002b44f.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Leonardo Bras <leonardo@linux.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, Matthew Wilcox <willy@infradead.org>, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrey Konovalov <andreyknvl@google.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Tony Luck <tony.luck@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>



On 06/10/2019 08:57 PM, Leonardo Bras wrote:
> On Mon, 2019-06-10 at 08:09 +0530, Anshuman Khandual wrote:
>>>> +    /*
>>>> +     * To be potentially processing a kprobe fault and to be allowed
>>>> +     * to call kprobe_running(), we have to be non-preemptible.
>>>> +     */
>>>> +    if (kprobes_built_in() && !preemptible() && !user_mode(regs)) {
>>>> +        if (kprobe_running() && kprobe_fault_handler(regs, trap))
>>>
>>> don't need an 'if A if B', can do 'if A && B'
>>
>> Which will make it a very lengthy condition check.
> 
> Well, is there any problem line-breaking the if condition?
> 
> if (A && B && C &&
>     D && E )
> 
> Also, if it's used only to decide the return value, maybe would be fine
> to do somethink like that:
> 
> return (A && B && C &&
>         D && E ); 

Got it. But as Dave and Matthew had pointed out earlier, the current x86
implementation has better readability. Hence will probably stick with it.
