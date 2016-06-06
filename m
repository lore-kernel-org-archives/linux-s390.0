Return-Path: <jpoimboe@redhat.com>
Date: Mon, 6 Jun 2016 09:29:22 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC PATCH v2 17/18] livepatch: change to a per-task consistency
 model
Message-ID: <20160606142922.wi5pad47cahr7a6t@treble>
References: <cover.1461875890.git.jpoimboe@redhat.com>
 <d60b2b9ce6911bb10dbbf244df58df31c7a8af66.1461875890.git.jpoimboe@redhat.com>
 <20160606135441.GB10840@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <20160606135441.GB10840@pathway.suse.cz>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Petr Mladek <pmladek@suse.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>
Content-Transfer-Encoding: 8bit

On Mon, Jun 06, 2016 at 03:54:41PM +0200, Petr Mladek wrote:
> On Thu 2016-04-28 15:44:48, Josh Poimboeuf wrote:
> > Change livepatch to use a basic per-task consistency model.  This is the
> > foundation which will eventually enable us to patch those ~10% of
> > security patches which change function or data semantics.  This is the
> > biggest remaining piece needed to make livepatch more generally useful.
> 
> > diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> > new file mode 100644
> > index 0000000..92819bb
> > --- /dev/null
> > +++ b/kernel/livepatch/transition.c
> > +/*
> > + * Try to safely switch a task to the target patch state.  If it's currently
> > + * running, or it's sleeping on a to-be-patched or to-be-unpatched function, or
> > + * if the stack is unreliable, return false.
> > + */
> > +static bool klp_try_switch_task(struct task_struct *task)
> > +{
> > +	struct rq *rq;
> > +	unsigned long flags;
> 
> This should be of type "struct rq_flags". Otherwise, I get compilation
> warnings:
> 
> kernel/livepatch/transition.c: In function ‘klp_try_switch_task’:
> kernel/livepatch/transition.c:349:2: warning: passing argument 2 of ‘task_rq_lock’ from incompatible pointer type [enabled by default]
>   rq = task_rq_lock(task, &flags);
>   ^
> In file included from kernel/livepatch/transition.c:24:0:
> kernel/livepatch/../sched/sched.h:1468:12: note: expected ‘struct rq_flags *’ but argument is of type ‘long unsigned int *’
>  struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
>             ^
> kernel/livepatch/transition.c:367:2: warning: passing argument 3 of ‘task_rq_unlock’ from incompatible pointer type [enabled by default]
>   task_rq_unlock(rq, task, &flags);
>   ^
> In file included from kernel/livepatch/transition.c:24:0:
> kernel/livepatch/../sched/sched.h:1480:1: note: expected ‘struct rq_flags *’ but argument is of type ‘long unsigned int *’
>  task_rq_unlock(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
> 
> 
> And even runtime warnings from lockdep:
> 
> [  212.847548] WARNING: CPU: 1 PID: 3847 at kernel/locking/lockdep.c:3532 lock_release+0x431/0x480
> [  212.847549] releasing a pinned lock
> [  212.847550] Modules linked in: livepatch_sample(E+)
> [  212.847555] CPU: 1 PID: 3847 Comm: modprobe Tainted: G            E K 4.7.0-rc1-next-20160602-4-default+ #336
> [  212.847556] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> [  212.847558]  0000000000000000 ffff880139823aa0 ffffffff814388dc ffff880139823af0
> [  212.847562]  0000000000000000 ffff880139823ae0 ffffffff8106fad1 00000dcc82b11390
> [  212.847565]  ffff88013fc978d8 ffffffff810eea1e ffff8800ba0ed6d0 0000000000000003
> [  212.847569] Call Trace:
> [  212.847572]  [<ffffffff814388dc>] dump_stack+0x85/0xc9
> [  212.847575]  [<ffffffff8106fad1>] __warn+0xd1/0xf0
> [  212.847578]  [<ffffffff810eea1e>] ? klp_try_switch_task.part.3+0x5e/0x2b0
> [  212.847580]  [<ffffffff8106fb3f>] warn_slowpath_fmt+0x4f/0x60
> [  212.847582]  [<ffffffff810cc151>] lock_release+0x431/0x480
> [  212.847585]  [<ffffffff8101e258>] ? dump_trace+0x118/0x310
> [  212.847588]  [<ffffffff8195d07c>] ? entry_SYSCALL_64_fastpath+0x1f/0xbd
> [  212.847590]  [<ffffffff8195c8bf>] _raw_spin_unlock+0x1f/0x30
> [  212.847600]  [<ffffffff810eea1e>] klp_try_switch_task.part.3+0x5e/0x2b0
> [  212.847603]  [<ffffffff810ef0e4>] klp_try_complete_transition+0x84/0x190
> [  212.847605]  [<ffffffff810ed370>] __klp_enable_patch+0xb0/0x130
> [  212.847607]  [<ffffffff810ed445>] klp_enable_patch+0x55/0x80
> [  212.847610]  [<ffffffffa0000030>] ? livepatch_cmdline_proc_show+0x30/0x30 [livepatch_sample]
> [  212.847613]  [<ffffffffa0000061>] livepatch_init+0x31/0x70 [livepatch_sample]
> [  212.847615]  [<ffffffffa0000030>] ? livepatch_cmdline_proc_show+0x30/0x30 [livepatch_sample]
> [  212.847617]  [<ffffffff8100041d>] do_one_initcall+0x3d/0x160
> [  212.847629]  [<ffffffff81196c9b>] ? do_init_module+0x27/0x1e4
> [  212.847632]  [<ffffffff810e7172>] ? rcu_read_lock_sched_held+0x62/0x70
> [  212.847634]  [<ffffffff811fdea2>] ? kmem_cache_alloc_trace+0x282/0x340
> [  212.847636]  [<ffffffff81196cd4>] do_init_module+0x60/0x1e4
> [  212.847638]  [<ffffffff81111fd2>] load_module+0x1482/0x1d40
> [  212.847640]  [<ffffffff8110ea10>] ? __symbol_put+0x40/0x40
> [  212.847643]  [<ffffffff81112aa9>] SYSC_finit_module+0xa9/0xd0
> [  212.847645]  [<ffffffff81112aee>] SyS_finit_module+0xe/0x10
> [  212.847647]  [<ffffffff8195d07c>] entry_SYSCALL_64_fastpath+0x1f/0xbd
> [  212.847649] ---[ end trace e4e9f09d45443049 ]---

Thanks, I also saw this when rebasing onto a newer linux-next.

> > +	int ret;
> > +	bool success = false;
> > +
> > +	/* check if this task has already switched over */
> > +	if (task->patch_state == klp_target_state)
> > +		return true;
> > +
> > +	/*
> > +	 * For arches which don't have reliable stack traces, we have to rely
> > +	 * on other methods (e.g., switching tasks at the syscall barrier).
> > +	 */
> > +	if (!IS_ENABLED(CONFIG_RELIABLE_STACKTRACE))
> > +		return false;
> > +
> > +	/*
> > +	 * Now try to check the stack for any to-be-patched or to-be-unpatched
> > +	 * functions.  If all goes well, switch the task to the target patch
> > +	 * state.
> > +	 */
> > +	rq = task_rq_lock(task, &flags);
> > +
> > +	if (task_running(rq, task) && task != current) {
> > +		pr_debug("%s: pid %d (%s) is running\n", __func__, task->pid,
> > +			 task->comm);
> 
> Also I think about using printk_deferred() inside the rq_lock but
> it is not strictly needed. Also we use only pr_debug() here which
> is a NOP when not enabled.

Good catch.  It's probably best to avoid it anyway.  klp_check_stack()
also has some pr_debug() calls.  I may restructure the code a bit to
release the lock before doing any of the pr_debug()'s.

-- 
Josh
