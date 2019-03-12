Return-Path: <SRS0=h4L/=RP=vger.kernel.org=linux-mips-owner@kernel.org>
Subject: Re: [PATCH 00/14] entry: preempt_schedule_irq() callers scrub
References: <20190311224752.8337-1-valentin.schneider@arm.com>
From: Vineet Gupta <vineet.gupta1@synopsys.com>
Message-ID: <e604601e-f8e1-a8b5-d364-69ca967996ce@synopsys.com>
Date: Tue, 12 Mar 2019 11:03:55 -0700
MIME-Version: 1.0
In-Reply-To: <20190311224752.8337-1-valentin.schneider@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mips-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
To: Valentin Schneider <valentin.schneider@arm.com>, linux-kernel@vger.kernel.org
Cc: Julien Thierry <julien.thierry@arm.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, linux-xtensa@linux-xtensa.org, x86@kernel.org, sparclinux@vger.kernel.org, linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org
List-ID: <linux-s390.vger.kernel.org>

On 3/11/19 3:47 PM, Valentin Schneider wrote:
> Hi,
> 
> This is the continuation of [1] where I'm hunting down
> preempt_schedule_irq() callers because of [2].
> 
> I told myself the best way to get this moving forward wouldn't be to write
> doc about it, but to go write some fixes and get some discussions going,
> which is what this patch-set is about.
> 
> I've looked at users of preempt_schedule_irq(), and made sure they didn't
> have one of those useless loops. The list of offenders is:
> 
> $ grep -r -I "preempt_schedule_irq" arch/ | cut -d/ -f2 | sort | uniq
> 
...

> 
> Regarding that loop, archs seem to fall in 3 categories:
> A) Those that don't have the loop

Please clarify that this is the right thing to do (since core code already has the
loop) hence no fixing is required for this "category"

> B) Those that have a small need_resched() loop around the
>    preempt_schedule_irq() callsite
> C) Those that branch to some more generic code further up the entry code
>    and eventually branch back to preempt_schedule_irq()
> 
> arc, m68k, nios2 fall in A)

> sparc, ia64, s390 fall in C)
> all the others fall in B)
> 
> I've written patches for B) and C) EXCEPT for ia64 and s390 because I
> haven't been able to tell if it's actually fine to kill that "long jump"
> (and maybe I'm wrong on sparc). Hopefully folks who understand what goes on
> in there might be able to shed some light.
