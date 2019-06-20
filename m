Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 20 Jun 2019 16:19:17 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] mm: Generalize and rename notify_page_fault() as
 kprobe_page_fault()
Message-Id: <20190620161917.a713ea0ff38fa18a2c6f05c2@kernel.org>
In-Reply-To: <8b184218-6880-204e-a9dd-e627c5ca92ca@synopsys.com>
References: <1560420444-25737-1-git-send-email-anshuman.khandual@arm.com>
        <e5f45089-c3aa-4d78-2c8d-ed22f863d9ee@synopsys.com>
        <8b184218-6880-204e-a9dd-e627c5ca92ca@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Fenghua Yu <fenghua.yu@intel.com>, arcml <linux-snps-arc@lists.infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>

Hi,

On Tue, 18 Jun 2019 08:56:33 -0700
Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:

> +CC Masami San, Eugeniy
> 
> On 6/13/19 10:57 AM, Vineet Gupta wrote:
> 
> 
> > On 6/13/19 3:07 AM, Anshuman Khandual wrote:
> >> Questions:
> >>
> >> AFAICT there is no equivalent of erstwhile notify_page_fault() during page
> >> fault handling in arc and mips archs which can call this generic function.
> >> Please let me know if that is not the case.
> > 
> > For ARC do_page_fault() is entered for MMU exceptions (TLB Miss, access violations
> > r/w/x etc). kprobes uses a combination of UNIMP_S and TRAP_S instructions which
> > don't funnel into do_page_fault().
> > 
> > UINMP_S leads to
> > 
> > instr_service
> >    do_insterror_or_kprobe
> >       notify_die(DIE_IERR)
> >          kprobe_exceptions_notify
> >             arc_kprobe_handler
> > 
> > 
> > TRAP_S 2 leads to
> > 
> > EV_Trap
> >    do_non_swi_trap
> >       trap_is_kprobe
> >          notify_die(DIE_TRAP)
> >             kprobe_exceptions_notify
> >                arc_post_kprobe_handler
> > 
> > But indeed we are *not* calling into kprobe_fault_handler() - from eithet of those
> > paths and not sure if the existing arc*_kprobe_handler() combination does the
> > equivalent in tandem.

Interesting, it seems that the kprobe_fault_handler() has never been called.
Anyway, it is used for handling a page fault in kprobe's user handler or single
stepping. And a page fault in user handler will not hard to fix up. Only a hard
case is a page fault in single stepping. If ARC's kprobes using single-stepping
on copied buffer, it may crashes kernel, since fixup code can not find correct
address without kprobe_fault_handler.

Thank you,

> 
> @Eugeniy can you please investigate this - do we have krpobes bit rot in ARC port.
> 
> -Vineet
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
