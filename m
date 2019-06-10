Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:63955 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbfFJE5c (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Jun 2019 00:57:32 -0400
Subject: Re: [RFC V3] mm: Generalize and rename notify_page_fault() as
 kprobe_page_fault()
References: <1559903655-5609-1-git-send-email-anshuman.khandual@arm.com>
 <20190607201202.GA32656@bombadil.infradead.org>
 <f1b109a3-ef4c-359c-a124-e219e84a6266@arm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <33c6a1cd-5c07-e623-28e5-f31f6fe30394@intel.com>
Date: Sun, 9 Jun 2019 21:57:29 -0700
MIME-Version: 1.0
In-Reply-To: <f1b109a3-ef4c-359c-a124-e219e84a6266@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Mark Rutland <mark.rutland@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrey Konovalov <andreyknvl@google.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org, James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>

On 6/9/19 9:34 PM, Anshuman Khandual wrote:
>> Do you really think this is easier to read?
>>
>> Why not just move the x86 version to include/linux/kprobes.h, and replace
>> the int with bool?
> Will just return bool directly without an additional variable here as suggested
> before. But for the conditional statement, I guess the proposed one here is more
> compact than the x86 one.

FWIW, I don't think "compact" is generally a good goal for code.  Being
readable is 100x more important than being compact and being un-compact
is only a problem when it hurts readability.

For a function like the one in question, having the individual return
conditions clearly commented is way more important than saving 10 lines
of code.
