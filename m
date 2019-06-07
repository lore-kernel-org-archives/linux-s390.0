Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:51032 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728446AbfFGPGc (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 7 Jun 2019 11:06:32 -0400
Subject: Re: [RFC V3] mm: Generalize and rename notify_page_fault() as
 kprobe_page_fault()
References: <1559903655-5609-1-git-send-email-anshuman.khandual@arm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <6e095842-0f7f-f428-653d-2b6e98fea6b3@intel.com>
Date: Fri, 7 Jun 2019 08:06:30 -0700
MIME-Version: 1.0
In-Reply-To: <1559903655-5609-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrey Konovalov <andreyknvl@google.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>

On 6/7/19 3:34 AM, Anshuman Khandual wrote:
> +static nokprobe_inline bool kprobe_page_fault(struct pt_regs *regs,
> +					      unsigned int trap)
> +{
> +	int ret = 0;
> +
> +	/*
> +	 * To be potentially processing a kprobe fault and to be allowed
> +	 * to call kprobe_running(), we have to be non-preemptible.
> +	 */
> +	if (kprobes_built_in() && !preemptible() && !user_mode(regs)) {
> +		if (kprobe_running() && kprobe_fault_handler(regs, trap))
> +			ret = 1;
> +	}
> +	return ret;
> +}

Nits: Other that taking the nice, readable, x86 one and globbing it onto
a single line, looks OK to me.  It does seem a _bit_ silly to go to the
trouble of converting to 'bool' and then using 0/1 and an 'int'
internally instead of true/false and a bool, though.  It's also not a
horrible thing to add a single line comment to this sucker to say:

/* returns true if kprobes handled the fault */

In any case, and even if you don't clean any of this up:

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
