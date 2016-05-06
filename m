Return-Path: <pmladek@suse.com>
Date: Fri, 6 May 2016 13:33:01 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH v2 17/18] livepatch: change to a per-task consistency
 model
Message-ID: <20160506113301.GB2749@pathway.suse.cz>
References: <cover.1461875890.git.jpoimboe@redhat.com>
 <d60b2b9ce6911bb10dbbf244df58df31c7a8af66.1461875890.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d60b2b9ce6911bb10dbbf244df58df31c7a8af66.1461875890.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu 2016-04-28 15:44:48, Josh Poimboeuf wrote:
> diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
> index 782fbb5..b3b8639 100644
> --- a/kernel/livepatch/patch.c
> +++ b/kernel/livepatch/patch.c
> @@ -29,6 +29,7 @@
>  #include <linux/bug.h>
>  #include <linux/printk.h>
>  #include "patch.h"
> +#include "transition.h"
>  
>  static LIST_HEAD(klp_ops);
>  
> @@ -58,11 +59,42 @@ static void notrace klp_ftrace_handler(unsigned long ip,
>  	ops = container_of(fops, struct klp_ops, fops);
>  
>  	rcu_read_lock();
> +
>  	func = list_first_or_null_rcu(&ops->func_stack, struct klp_func,
>  				      stack_node);
> -	if (WARN_ON_ONCE(!func))
> +
> +	if (!func)
>  		goto unlock;
>  
> +	/*
> +	 * See the comment for the 2nd smp_wmb() in klp_init_transition() for
> +	 * an explanation of why this read barrier is needed.
> +	 */
> +	smp_rmb();
> +
> +	if (unlikely(func->transition)) {
> +
> +		/*
> +		 * See the comment for the 1st smp_wmb() in
> +		 * klp_init_transition() for an explanation of why this read
> +		 * barrier is needed.
> +		 */
> +		smp_rmb();

I would add here:

		WARN_ON_ONCE(current->patch_state == KLP_UNDEFINED);

We do not know in which context this is called, so the printk's are
not ideal. But it will get triggered only if there is a bug in
the livepatch implementation. It should happen on random locations
and rather early when a bug is introduced.

Anyway, better to die and catch the bug that let the system running
in an undefined state and produce cryptic errors later on.


> +		if (current->patch_state == KLP_UNPATCHED) {
> +			/*
> +			 * Use the previously patched version of the function.
> +			 * If no previous patches exist, use the original
> +			 * function.
> +			 */
> +			func = list_entry_rcu(func->stack_node.next,
> +					      struct klp_func, stack_node);
> +
> +			if (&func->stack_node == &ops->func_stack)
> +				goto unlock;
> +		}
> +	}

I am staring into the code for too long now. I need to step back for a
while. I'll do another look when you send the next version. Anyway,
you did a great work. I speak mainly for the livepatch part and
I like it.

Best Regards,
Petr
