Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] mm: Generalize and rename notify_page_fault() as
 kprobe_page_fault()
References: <1560420444-25737-1-git-send-email-anshuman.khandual@arm.com>
 <e5f45089-c3aa-4d78-2c8d-ed22f863d9ee@synopsys.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <8b184218-6880-204e-a9dd-e627c5ca92ca@synopsys.com>
Date: Tue, 18 Jun 2019 08:56:33 -0700
MIME-Version: 1.0
In-Reply-To: <e5f45089-c3aa-4d78-2c8d-ed22f863d9ee@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Fenghua Yu <fenghua.yu@intel.com>, arcml <linux-snps-arc@lists.infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>

+CC Masami San, Eugeniy

On 6/13/19 10:57 AM, Vineet Gupta wrote:


> On 6/13/19 3:07 AM, Anshuman Khandual wrote:
>> Questions:
>>
>> AFAICT there is no equivalent of erstwhile notify_page_fault() during page
>> fault handling in arc and mips archs which can call this generic function.
>> Please let me know if that is not the case.
> 
> For ARC do_page_fault() is entered for MMU exceptions (TLB Miss, access violations
> r/w/x etc). kprobes uses a combination of UNIMP_S and TRAP_S instructions which
> don't funnel into do_page_fault().
> 
> UINMP_S leads to
> 
> instr_service
>    do_insterror_or_kprobe
>       notify_die(DIE_IERR)
>          kprobe_exceptions_notify
>             arc_kprobe_handler
> 
> 
> TRAP_S 2 leads to
> 
> EV_Trap
>    do_non_swi_trap
>       trap_is_kprobe
>          notify_die(DIE_TRAP)
>             kprobe_exceptions_notify
>                arc_post_kprobe_handler
> 
> But indeed we are *not* calling into kprobe_fault_handler() - from eithet of those
> paths and not sure if the existing arc*_kprobe_handler() combination does the
> equivalent in tandem.

@Eugeniy can you please investigate this - do we have krpobes bit rot in ARC port.

-Vineet
