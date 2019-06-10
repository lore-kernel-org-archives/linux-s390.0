Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:35064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387400AbfFJCXG (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 9 Jun 2019 22:23:06 -0400
Subject: Re: [RFC V3] mm: Generalize and rename notify_page_fault() as
 kprobe_page_fault()
References: <1559903655-5609-1-git-send-email-anshuman.khandual@arm.com>
 <20190607220326.1e21fc9c@canb.auug.org.au>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <632eae55-92f5-1bfc-bfe4-24673558e1d8@arm.com>
Date: Mon, 10 Jun 2019 07:53:15 +0530
MIME-Version: 1.0
In-Reply-To: <20190607220326.1e21fc9c@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Andrey Konovalov <andreyknvl@google.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>



On 06/07/2019 05:33 PM, Stephen Rothwell wrote:
> Hi Anshuman,
> 
> On Fri,  7 Jun 2019 16:04:15 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>
>> +static nokprobe_inline bool kprobe_page_fault(struct pt_regs *regs,
>> +					      unsigned int trap)
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
> Since this is now declared as "bool" (thanks for that), you should make
> "ret" be bool and use true and false;

Sure, done.
