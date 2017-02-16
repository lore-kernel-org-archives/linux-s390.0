Return-Path: <mbenes@suse.cz>
Date: Thu, 16 Feb 2017 15:33:26 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v5 13/15] livepatch: change to a per-task consistency model
In-Reply-To: <a999d965d598b23564355c24db0ed6799f105fa6.1487036215.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.20.1702161504020.16310@pobox.suse.cz>
References: <cover.1487036215.git.jpoimboe@redhat.com>
 <a999d965d598b23564355c24db0ed6799f105fa6.1487036215.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
List-ID: <linux-s390.vger.kernel.org>


> @@ -347,22 +356,36 @@ static int __klp_enable_patch(struct klp_patch *patch)
>  
>  	pr_notice("enabling patch '%s'\n", patch->mod->name);
>  
> +	klp_init_transition(patch, KLP_PATCHED);
> +
> +	/*
> +	 * Enforce the order of the func->transition writes in
> +	 * klp_init_transition() and the ops->func_stack writes in
> +	 * klp_patch_object(), so that klp_ftrace_handler() will see the
> +	 * func->transition updates before the handler is registered and the
> +	 * new funcs become visible to the handler.
> +	 */
> +	smp_wmb();
> +
>  	klp_for_each_object(patch, obj) {
>  		if (!klp_is_object_loaded(obj))
>  			continue;
>  
>  		ret = klp_patch_object(obj);
> -		if (ret)
> -			goto unregister;
> +		if (ret) {
> +			pr_warn("failed to enable patch '%s'\n",
> +				patch->mod->name);
> +
> +			klp_cancel_transition();
> +			return ret;
> +		}

[...]

> +static void klp_complete_transition(void)
> +{
> +	struct klp_object *obj;
> +	struct klp_func *func;
> +	struct task_struct *g, *task;
> +	unsigned int cpu;
> +
> +	if (klp_target_state == KLP_UNPATCHED) {
> +		/*
> +		 * All tasks have transitioned to KLP_UNPATCHED so we can now
> +		 * remove the new functions from the func_stack.
> +		 */
> +		klp_unpatch_objects(klp_transition_patch);
> +
> +		/*
> +		 * Make sure klp_ftrace_handler() can no longer see functions
> +		 * from this patch on the ops->func_stack.  Otherwise, after
> +		 * func->transition gets cleared, the handler may choose a
> +		 * removed function.
> +		 */
> +		synchronize_rcu();
> +	}
> +
> +	if (klp_transition_patch->immediate)
> +		goto done;
> +
> +	klp_for_each_object(klp_transition_patch, obj)
> +		klp_for_each_func(obj, func)
> +			func->transition = false;
> +
> +	/* Prevent klp_ftrace_handler() from seeing KLP_UNDEFINED state */
> +	if (klp_target_state == KLP_PATCHED)
> +		synchronize_rcu();
> +
> +	read_lock(&tasklist_lock);
> +	for_each_process_thread(g, task) {
> +		WARN_ON_ONCE(test_tsk_thread_flag(task, TIF_PATCH_PENDING));
> +		task->patch_state = KLP_UNDEFINED;
> +	}
> +	read_unlock(&tasklist_lock);
> +
> +	for_each_possible_cpu(cpu) {
> +		task = idle_task(cpu);
> +		WARN_ON_ONCE(test_tsk_thread_flag(task, TIF_PATCH_PENDING));
> +		task->patch_state = KLP_UNDEFINED;
> +	}
> +
> +done:
> +	klp_target_state = KLP_UNDEFINED;
> +	klp_transition_patch = NULL;
> +}
> +
> +/*
> + * This is called in the error path, to cancel a transition before it has
> + * started, i.e. klp_init_transition() has been called but
> + * klp_start_transition() hasn't.  If the transition *has* been started,
> + * klp_reverse_transition() should be used instead.
> + */
> +void klp_cancel_transition(void)
> +{
> +	klp_target_state = !klp_target_state;
> +	klp_complete_transition();
> +}

If we fail to enable patch in __klp_enable_patch(), we call 
klp_cancel_transition() and get to klp_complete_transition(). If the patch 
has immediate set to true, the module would not be allowed to go (the 
changes are in the last patch unfortunately, but my remark is closely 
related to klp_cancel_transition() and __klp_enable_patch()). This could 
annoy a user if it was due to a trivial reason. So we could call  
module_put() in this case. It should be safe as no task could be in a new 
function thanks to klp_ftrace_handler() logic.

Pity I have not spotted this earlier.

Putting module_put(patch->mod) right after klp_cancel_transition() call in 
__klp_enable_patch() would be the simplest fix (as a part of 15/15 patch). 
Maybe with a comment that it is safe to do it there.

What do you think?

Miroslav
