Return-Path: <mbenes@suse.cz>
Date: Mon, 9 May 2016 11:41:37 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
Subject: Re: [RFC PATCH v2 17/18] livepatch: change to a per-task consistency
 model
In-Reply-To: <d60b2b9ce6911bb10dbbf244df58df31c7a8af66.1461875890.git.jpoimboe@redhat.com>
Message-ID: <alpine.LNX.2.00.1605091131050.22758@pobox.suse.cz>
References: <cover.1461875890.git.jpoimboe@redhat.com>
 <d60b2b9ce6911bb10dbbf244df58df31c7a8af66.1461875890.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Petr Mladek <pmladek@suse.com>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>


[...]

> +static int klp_target_state;

[...]

> +void klp_init_transition(struct klp_patch *patch, int state)
> +{
> +	struct task_struct *g, *task;
> +	unsigned int cpu;
> +	struct klp_object *obj;
> +	struct klp_func *func;
> +	int initial_state = !state;
> +
> +	klp_transition_patch = patch;
> +
> +	/*
> +	 * If the patch can be applied or reverted immediately, skip the
> +	 * per-task transitions.
> +	 */
> +	if (patch->immediate)
> +		return;
> +
> +	/*
> +	 * Initialize all tasks to the initial patch state to prepare them for
> +	 * switching to the target state.
> +	 */
> +	read_lock(&tasklist_lock);
> +	for_each_process_thread(g, task)
> +		task->patch_state = initial_state;
> +	read_unlock(&tasklist_lock);
> +
> +	/*
> +	 * Ditto for the idle "swapper" tasks.
> +	 */
> +	get_online_cpus();
> +	for_each_online_cpu(cpu)
> +		idle_task(cpu)->patch_state = initial_state;
> +	put_online_cpus();
> +
> +	/*
> +	 * Ensure klp_ftrace_handler() sees the task->patch_state updates
> +	 * before the func->transition updates.  Otherwise it could read an
> +	 * out-of-date task state and pick the wrong function.
> +	 */
> +	smp_wmb();
> +
> +	/*
> +	 * Set the func transition states so klp_ftrace_handler() will know to
> +	 * switch to the transition logic.
> +	 *
> +	 * When patching, the funcs aren't yet in the func_stack and will be
> +	 * made visible to the ftrace handler shortly by the calls to
> +	 * klp_patch_object().
> +	 *
> +	 * When unpatching, the funcs are already in the func_stack and so are
> +	 * already visible to the ftrace handler.
> +	 */
> +	klp_for_each_object(patch, obj)
> +		klp_for_each_func(obj, func)
> +			func->transition = true;
> +
> +	/*
> +	 * Set the global target patch state which tasks will switch to.  This
> +	 * has no effect until the TIF_PATCH_PENDING flags get set later.
> +	 */
> +	klp_target_state = state;

I am afraid there is a problem for (patch->immediate == true) patches. 
klp_target_state is not set for those and the comment is not entirely 
true, because klp_target_state has an effect in several places.

[...]

> +void klp_start_transition(void)
> +{
> +	struct task_struct *g, *task;
> +	unsigned int cpu;
> +
> +	pr_notice("'%s': %s...\n", klp_transition_patch->mod->name,
> +		  klp_target_state == KLP_PATCHED ? "patching" : "unpatching");

Here...

> +
> +	/*
> +	 * If the patch can be applied or reverted immediately, skip the
> +	 * per-task transitions.
> +	 */
> +	if (klp_transition_patch->immediate)
> +		return;
> +

[...]

> +bool klp_try_complete_transition(void)
> +{
> +	unsigned int cpu;
> +	struct task_struct *g, *task;
> +	bool complete = true;
> +
> +	/*
> +	 * If the patch can be applied or reverted immediately, skip the
> +	 * per-task transitions.
> +	 */
> +	if (klp_transition_patch->immediate)
> +		goto success;
> +
> +	/*
> +	 * Try to switch the tasks to the target patch state by walking their
> +	 * stacks and looking for any to-be-patched or to-be-unpatched
> +	 * functions.  If such functions are found on a stack, or if the stack
> +	 * is deemed unreliable, the task can't be switched yet.
> +	 *
> +	 * Usually this will transition most (or all) of the tasks on a system
> +	 * unless the patch includes changes to a very common function.
> +	 */
> +	read_lock(&tasklist_lock);
> +	for_each_process_thread(g, task)
> +		if (!klp_try_switch_task(task))
> +			complete = false;
> +	read_unlock(&tasklist_lock);
> +
> +	/*
> +	 * Ditto for the idle "swapper" tasks.
> +	 */
> +	get_online_cpus();
> +	for_each_online_cpu(cpu)
> +		if (!klp_try_switch_task(idle_task(cpu)))
> +			complete = false;
> +	put_online_cpus();
> +
> +	/*
> +	 * Some tasks weren't able to be switched over.  Try again later and/or
> +	 * wait for other methods like syscall barrier switching.
> +	 */
> +	if (!complete)
> +		return false;
> +
> +success:
> +	/*
> +	 * When unpatching, all tasks have transitioned to KLP_UNPATCHED so we
> +	 * can now remove the new functions from the func_stack.
> +	 */
> +	if (klp_target_state == KLP_UNPATCHED) {

Here (this is the most important one I think).

> +		klp_unpatch_objects(klp_transition_patch);
> +
> +		/*
> +		 * Don't allow any existing instances of ftrace handlers to
> +		 * access any obsolete funcs before we reset the func
> +		 * transition states to false.  Otherwise the handler may see
> +		 * the deleted "new" func, see that it's not in transition, and
> +		 * wrongly pick the new version of the function.
> +		 */
> +		synchronize_rcu();
> +	}
> +
> +	pr_notice("'%s': %s complete\n", klp_transition_patch->mod->name,
> +		  klp_target_state == KLP_PATCHED ? "patching" : "unpatching");

Here

> +
> +	/* we're done, now cleanup the data structures */
> +	klp_complete_transition();
> +
> +	return true;
> +}
> +
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

And probably here.

All other references look safe.

I guess we need to set klp_target_state even for immediate patches. Should 
we also initialize it with KLP_UNDEFINED and set it to KLP_UNDEFINED in 
klp_complete_transition()?

Miroslav
