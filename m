Return-Path: <pmladek@suse.com>
Date: Wed, 4 May 2016 10:42:23 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH v2 17/18] livepatch: change to a per-task consistency
 model
Message-ID: <20160504084223.GQ2749@pathway.suse.cz>
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
> Change livepatch to use a basic per-task consistency model.  This is the
> foundation which will eventually enable us to patch those ~10% of
> security patches which change function or data semantics.  This is the
> biggest remaining piece needed to make livepatch more generally useful.

> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -76,6 +76,7 @@
>  #include <linux/compiler.h>
>  #include <linux/sysctl.h>
>  #include <linux/kcov.h>
> +#include <linux/livepatch.h>
>  
>  #include <asm/pgtable.h>
>  #include <asm/pgalloc.h>
> @@ -1586,6 +1587,8 @@ static struct task_struct *copy_process(unsigned long clone_flags,
>  		p->parent_exec_id = current->self_exec_id;
>  	}
>  
> +	klp_copy_process(p);

I am in doubts here. We copy the state from the parent here. It means
that the new process might still need to be converted. But at the same
point print_context_stack_reliable() returns zero without printing
any stack trace when TIF_FORK flag is set. It means that a freshly
forked task might get be converted immediately. I seems that boot
operations are always done when copy_process() is called. But
they are contradicting each other.

I guess that print_context_stack_reliable() should either return
-EINVAL when TIF_FORK is set. Or it should try to print the
stack of the newly forked task.

Or do I miss something, please?

> +
>  	spin_lock(&current->sighand->siglock);
>  
>  	/*

[...]

> diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> new file mode 100644
> index 0000000..92819bb
> --- /dev/null
> +++ b/kernel/livepatch/transition.c
> +/*
> + * This function can be called in the middle of an existing transition to
> + * reverse the direction of the target patch state.  This can be done to
> + * effectively cancel an existing enable or disable operation if there are any
> + * tasks which are stuck in the initial patch state.
> + */
> +void klp_reverse_transition(void)
> +{
> +	struct klp_patch *patch = klp_transition_patch;
> +
> +	klp_target_state = !klp_target_state;
> +
> +	/*
> +	 * Ensure that if another CPU goes through the syscall barrier, sees
> +	 * the TIF_PATCH_PENDING writes in klp_start_transition(), and calls
> +	 * klp_patch_task(), it also sees the above write to the target state.
> +	 * Otherwise it can put the task in the wrong universe.
> +	 */
> +	smp_wmb();
> +
> +	klp_start_transition();
> +	klp_try_complete_transition();

It is a bit strange that we keep the work scheduled. It might be
better to use

       mod_delayed_work(system_wq, &klp_work, 0);

Which triggers more ideas from the nitpicking deparment:

I would move the work definition from core.c to transition.c because
it is closely related to klp_try_complete_transition();

When on it. I would make it more clear that the work is related
to transition. Also I would call queue_delayed_work() directly
instead of adding the klp_schedule_work() wrapper. The delay
might be defined using a constant, e.g.

#define KLP_TRANSITION_DELAY round_jiffies_relative(HZ)

queue_delayed_work(system_wq, &klp_transition_work, KLP_TRANSITION_DELAY);

Finally, the following is always called right after
klp_start_transition(), so I would call it from there.

	if (!klp_try_complete_transition())
		klp_schedule_work();


> +
> +	patch->enabled = !patch->enabled;
> +}
> +

It is really great work! I am checking this patch from left, right, top,
and even bottom and all seems to work well together.

Best Regards,
Petr
