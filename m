Return-Path: <peterz@infradead.org>
Date: Thu, 25 Jan 2018 10:04:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 13/15] livepatch: change to a per-task consistency model
Message-ID: <20180125090444.GB2339@hirez.programming.kicks-ass.net>
References: <cover.1487036215.git.jpoimboe@redhat.com>
 <a999d965d598b23564355c24db0ed6799f105fa6.1487036215.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a999d965d598b23564355c24db0ed6799f105fa6.1487036215.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Feb 13, 2017 at 07:42:40PM -0600, Josh Poimboeuf wrote:
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 6a4bae0..a8b3f1a 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -9,6 +9,7 @@
>  #include <linux/mm.h>
>  #include <linux/stackprotector.h>
>  #include <linux/suspend.h>
> +#include <linux/livepatch.h>
>  
>  #include <asm/tlb.h>
>  
> @@ -264,6 +265,9 @@ static void do_idle(void)
>  
>  	sched_ttwu_pending();
>  	schedule_preempt_disabled();
> +
> +	if (unlikely(klp_patch_pending(current)))
> +		klp_update_patch_state(current);
>  }

Can someone explain this one? This is a very weird place to add things.
What was the expectation?
