Return-Path: <jpoimboe@redhat.com>
Date: Wed, 11 Jan 2017 09:26:39 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 13/15] livepatch: change to a per-task consistency model
Message-ID: <20170111152639.l6ehubjuys66if4l@treble>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <eeda3a8cf83bcbb569db4774c646ad739b8db415.1481220077.git.jpoimboe@redhat.com>
 <20161220173246.GC25166@pathway.suse.cz>
 <20161221212505.dbxeddu2skmjmwiq@treble>
 <20161222143452.GK25166@pathway.suse.cz>
 <20161222183137.sdfsiv5dpi7po6zk@treble>
 <20170110130058.GH20785@pathway.suse.cz>
 <20170110204646.a4wughlsu6atxu2i@treble>
 <20170111151828.GJ20785@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170111151828.GJ20785@pathway.suse.cz>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Petr Mladek <pmladek@suse.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jan 11, 2017 at 04:18:28PM +0100, Petr Mladek wrote:
> On Tue 2017-01-10 14:46:46, Josh Poimboeuf wrote:
> > On Tue, Jan 10, 2017 at 02:00:58PM +0100, Petr Mladek wrote:
> > > On Thu 2016-12-22 12:31:37, Josh Poimboeuf wrote:
> > > > On Thu, Dec 22, 2016 at 03:34:52PM +0100, Petr Mladek wrote:
> > > > > On Wed 2016-12-21 15:25:05, Josh Poimboeuf wrote:
> > > > > > On Tue, Dec 20, 2016 at 06:32:46PM +0100, Petr Mladek wrote:
> > > > > > > On Thu 2016-12-08 12:08:38, Josh Poimboeuf wrote:
> > > > > > > > +	read_unlock(&tasklist_lock);
> > > > > > > > +
> > > > > > > > +	/*
> > > > > > > > +	 * Ditto for the idle "swapper" tasks, though they never cross the
> > > > > > > > +	 * syscall barrier.  Instead they switch over in cpu_idle_loop().
> > > > > > > > +	 */
> > > > > > > > +	get_online_cpus();
> > > > > > > > +	for_each_online_cpu(cpu)
> > > > > > > > +		set_tsk_thread_flag(idle_task(cpu), TIF_PATCH_PENDING);
> > > > > > > > +	put_online_cpus();
> > > > > > > 
> > > > > > > Also this stage need to be somehow handled by CPU coming/going
> > > > > > > handlers.
> > > > > > 
> > > > > > Here I think we could automatically switch any offline CPUs' idle tasks.
> > > > > > And something similar in klp_try_complete_transition().
> > > > > 
> > > > > We still need to make sure to do not race with the cpu_up()/cpu_down()
> > > > > calls.
> > > > 
> > > > Hm, maybe we'd need to call cpu_hotplug_disable() before switching the
> > > > offline idle tasks?
> > > > 
> > > > > I would use here the trick with for_each_possible_cpu() and let
> > > > > the migration for the stack check.
> > > > 
> > > > There are a few issues with that:
> > > > 
> > > > 1) The idle task of a missing CPU doesn't *have* a stack, so it doesn't
> > > >    make much sense to try to check it.
> > > > 
> > > > 2) We can't rely *only* on the stack check, because not all arches have
> > > >    it.  The other way to migrate idle tasks is from the idle loop switch
> > > >    point.  But if the task's CPU is down, its idle loop isn't running so
> > > >    it can't migrate.
> > > > 
> > > >    (Note this is currently a theoretical point: we currently don't allow
> > > >    such arches to use the consistency model anyway because there's no
> > > >    way for them to migrate kthreads.)
> > > 
> > > Good points. My only concern is that the transaction might take a long
> > > or even forever. I am not sure if it is wise to disable cpu_hotplug
> > > for the entire transaction.
> > > 
> > > A compromise might be to disable cpu hotplug only when the task
> > > state is manipulated a more complex way. Hmm, cpu_hotplug_disable()
> > > looks like a rather costly function. We should not call it in
> > > klp_try_complete_transition(). But we could do:
> > > 
> > >   1. When the patch is being enabled, disable cpu hotplug,
> > >      go through each_possible_cpu and setup the transaction
> > >      only for CPUs that are online. Then we could enable
> > >      the hotplug again.
> > > 
> > >   2. Check only each_online_cpu in klp_try_complete_transition().
> > >      If all tasks are migrated, disable cpu hotplug and re-check
> > >      idle tasks on online CPUs. If any is not migrated, enable
> > >      hotplug and return failure. Othewise, continue with
> > >      completion of the transaction. [*]
> > > 
> > >   3. In klp_complete_transition, update all tasks including
> > >      the offline CPUs and enable cpu hotplug again.
> > > 
> > > If the re-check in the 2nd step looks ugly, we could add some hotlug
> > > notifiers to make sure that enabled/disabled CPUs are in a reasonable
> > > state. We still should disable the hotplug in the 1st and 3rd step.
> > > 
> > > BTW: There is a new API for the cpu hotplug callbacks. I was involved
> > > in one conversion. You might take inspiration in
> > > drivers/thermal/intel_powerclamp.c. See cpuhp_setup_state_nocalls()
> > > there.
> > 
> > Backing up a bit, although I brought up cpu_hotplug_disable(), I think I
> > misunderstood the race you mentioned.  I actually don't think
> > cpu_hotplug_disable() is necessary.
> 
> Great backing! You made me to study the difference. If I get it
> correctly:
> 
>   + cpu_hotplug_disable() works like a writer lock. It gets
>     exclusive access via cpu_hotplug_begin(). A side effect
>     is that do_cpu_up() and do_cpu_down() do not wait. They
>     return -EBUSY if hotplug is disabled.
> 
>   + get_online_cpus() is kind of reader lock. It makes sure
>     that all the hotplug operations are finished and "softly"
>     blocks other further operation. By "softly" I mean that
>     the operations wait for the exclusive (write) access
>     in cpu_hotplug_begin().
> 
> IMHO, we really have to use get_online_cpus() and avoid the
> the "hard" blocking.
> 
> 
> > What do you think about something like the following:
>  
> > In klp_start_transition:
> > 
> > 	get_online_cpus();
> > 	for_each_possible_cpu(cpu)
> > 		set_tsk_thread_flag(idle_task(cpu), TIF_PATCH_PENDING);
> > 	put_online_cpus();
> >
> > In klp_try_complete_transition:
> > 
> > 	get_online_cpus();
> > 	for_each_possible_cpu(cpu) {
> > 		task = idle_task(cpu);
> > 		if (cpu_online(cpu)) {
> > 			if (!klp_try_switch_task(task))
> > 				complete = false;
> > 		} else if (task->patch_state != klp_target_state) {
> > 			/* offline CPU idle tasks can be switched immediately */
> > 			clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
> > 			task->patch_state = klp_target_state;
> > 		}
> > 	}
> > 	put_online_cpus();
> 
> I like the idea. You are right that it is enough to always get/put
> CPUs only when a state of the per-CPU idle tasks are manipulated.
> In the meantime, we are safe because of the consistency model
> (clever ftrace handler).
> 
> Note that we have to use for_each_possible_cpu() everywhere,
> e.g. in klp_init_transition(), klp_complete_transition().
> Otherwise, we might see an inconsistent state.
> 
> For example, klp_ftrace_handler() might see KLP_UNDEFINED state
> if we do not set a valid one in klp_init_transition() and a CPU
> gets online.

Agreed!  I will try to have v4 soon-ish.

-- 
Josh
