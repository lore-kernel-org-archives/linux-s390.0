Return-Path: <jpoimboe@redhat.com>
Date: Mon, 16 May 2016 12:27:55 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC PATCH v2 17/18] livepatch: change to a per-task consistency
 model
Message-ID: <20160516172755.gro5enwei2gth3ko@treble>
References: <cover.1461875890.git.jpoimboe@redhat.com>
 <d60b2b9ce6911bb10dbbf244df58df31c7a8af66.1461875890.git.jpoimboe@redhat.com>
 <alpine.LNX.2.00.1605091131050.22758@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.LNX.2.00.1605091131050.22758@pobox.suse.cz>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Petr Mladek <pmladek@suse.com>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, May 09, 2016 at 11:41:37AM +0200, Miroslav Benes wrote:
> > +void klp_init_transition(struct klp_patch *patch, int state)
> > +{
> > +	struct task_struct *g, *task;
> > +	unsigned int cpu;
> > +	struct klp_object *obj;
> > +	struct klp_func *func;
> > +	int initial_state = !state;
> > +
> > +	klp_transition_patch = patch;
> > +
> > +	/*
> > +	 * If the patch can be applied or reverted immediately, skip the
> > +	 * per-task transitions.
> > +	 */
> > +	if (patch->immediate)
> > +		return;
> > +
> > +	/*
> > +	 * Initialize all tasks to the initial patch state to prepare them for
> > +	 * switching to the target state.
> > +	 */
> > +	read_lock(&tasklist_lock);
> > +	for_each_process_thread(g, task)
> > +		task->patch_state = initial_state;
> > +	read_unlock(&tasklist_lock);
> > +
> > +	/*
> > +	 * Ditto for the idle "swapper" tasks.
> > +	 */
> > +	get_online_cpus();
> > +	for_each_online_cpu(cpu)
> > +		idle_task(cpu)->patch_state = initial_state;
> > +	put_online_cpus();
> > +
> > +	/*
> > +	 * Ensure klp_ftrace_handler() sees the task->patch_state updates
> > +	 * before the func->transition updates.  Otherwise it could read an
> > +	 * out-of-date task state and pick the wrong function.
> > +	 */
> > +	smp_wmb();
> > +
> > +	/*
> > +	 * Set the func transition states so klp_ftrace_handler() will know to
> > +	 * switch to the transition logic.
> > +	 *
> > +	 * When patching, the funcs aren't yet in the func_stack and will be
> > +	 * made visible to the ftrace handler shortly by the calls to
> > +	 * klp_patch_object().
> > +	 *
> > +	 * When unpatching, the funcs are already in the func_stack and so are
> > +	 * already visible to the ftrace handler.
> > +	 */
> > +	klp_for_each_object(patch, obj)
> > +		klp_for_each_func(obj, func)
> > +			func->transition = true;
> > +
> > +	/*
> > +	 * Set the global target patch state which tasks will switch to.  This
> > +	 * has no effect until the TIF_PATCH_PENDING flags get set later.
> > +	 */
> > +	klp_target_state = state;
> 
> I am afraid there is a problem for (patch->immediate == true) patches. 
> klp_target_state is not set for those and the comment is not entirely 
> true, because klp_target_state has an effect in several places.

Ah, you're right.  I moved this assignment here for v2.  It was
originally done before the patch->immediate check.  If I remember
correctly, I moved it closer to the barrier for better readability (but
I created a bug in the process).

> I guess we need to set klp_target_state even for immediate patches. Should 
> we also initialize it with KLP_UNDEFINED and set it to KLP_UNDEFINED in 
> klp_complete_transition()?

Yes, to both.

-- 
Josh
