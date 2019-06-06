Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfFFCkX (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 5 Jun 2019 22:40:23 -0400
Subject: Re: [RFC V2] mm: Generalize notify_page_fault()
References: <1559630046-12940-1-git-send-email-anshuman.khandual@arm.com>
 <87sgsomg91.fsf@concordia.ellerman.id.au>
 <20190605112328.GB2025@bombadil.infradead.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <bc89341a-a2b6-bd34-d342-b46f6e902a7c@arm.com>
Date: Thu, 6 Jun 2019 08:10:28 +0530
MIME-Version: 1.0
In-Reply-To: <20190605112328.GB2025@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Mark Rutland <mark.rutland@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrey Konovalov <andreyknvl@google.com>, Paul Mackerras <paulus@samba.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>



On 06/05/2019 04:53 PM, Matthew Wilcox wrote:
> On Wed, Jun 05, 2019 at 09:19:22PM +1000, Michael Ellerman wrote:
>> Anshuman Khandual <anshuman.khandual@arm.com> writes:
>>> Similar notify_page_fault() definitions are being used by architectures
>>> duplicating much of the same code. This attempts to unify them into a
>>> single implementation, generalize it and then move it to a common place.
>>> kprobes_built_in() can detect CONFIG_KPROBES, hence notify_page_fault()
>>> need not be wrapped again within CONFIG_KPROBES. Trap number argument can
>>> now contain upto an 'unsigned int' accommodating all possible platforms.
>> ...
>>
>> You've changed several of the architectures from something like above,
>> where it disables preemption around the call into the below:
>>
>>
>> Which skips everything if we're preemptible. Is that an equivalent
>> change? If so can you please explain why in more detail.
> 
> See the discussion in v1 of this patch, which you were cc'd on.
> 
> I agree the description here completely fails to mention why the change.
> It should mention commit a980c0ef9f6d8c.

I will update the commit message to include an explanation for this new
preempt behavior in the generic definition.
