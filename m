Return-Path: <jeyu@redhat.com>
Date: Tue, 17 May 2016 18:53:58 -0400
From: Jessica Yu <jeyu@redhat.com>
Subject: Re: livepatch: change to a per-task consistency model
Message-ID: <20160517225357.GA30725@packer-debian-8-amd64.digitalocean.com>
References: <cover.1461875890.git.jpoimboe@redhat.com>
 <d60b2b9ce6911bb10dbbf244df58df31c7a8af66.1461875890.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Petr Mladek <pmladek@suse.com>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

+++ Josh Poimboeuf [28/04/16 15:44 -0500]:

[snip]

>diff --git a/Documentation/livepatch/livepatch.txt b/Documentation/livepatch/livepatch.txt
>index 6c43f6e..bee86d0 100644
>--- a/Documentation/livepatch/livepatch.txt
>+++ b/Documentation/livepatch/livepatch.txt
>@@ -72,7 +72,8 @@ example, they add a NULL pointer or a boundary check, fix a race by adding
> a missing memory barrier, or add some locking around a critical section.
> Most of these changes are self contained and the function presents itself
> the same way to the rest of the system. In this case, the functions might
>-be updated independently one by one.
>+be updated independently one by one.  (This can be done by setting the
>+'immediate' flag in the klp_patch struct.)
>
> But there are more complex fixes. For example, a patch might change
> ordering of locking in multiple functions at the same time. Or a patch
>@@ -86,20 +87,103 @@ or no data are stored in the modified structures at the moment.
> The theory about how to apply functions a safe way is rather complex.
> The aim is to define a so-called consistency model. It attempts to define
> conditions when the new implementation could be used so that the system
>-stays consistent. The theory is not yet finished. See the discussion at
>-http://thread.gmane.org/gmane.linux.kernel/1823033/focus=1828189
>-
>-The current consistency model is very simple. It guarantees that either
>-the old or the new function is called. But various functions get redirected
>-one by one without any synchronization.
>-
>-In other words, the current implementation _never_ modifies the behavior
>-in the middle of the call. It is because it does _not_ rewrite the entire
>-function in the memory. Instead, the function gets redirected at the
>-very beginning. But this redirection is used immediately even when
>-some other functions from the same patch have not been redirected yet.
>-
>-See also the section "Limitations" below.
>+stays consistent.
>+
>+Livepatch has a consistency model which is a hybrid of kGraft and
>+kpatch:  it uses kGraft's per-task consistency and syscall barrier
>+switching combined with kpatch's stack trace switching.  There are also
>+a number of fallback options which make it quite flexible.
>+
>+Patches are applied on a per-task basis, when the task is deemed safe to
>+switch over.  When a patch is enabled, livepatch enters into a
>+transition state where tasks are converging to the patched state.
>+Usually this transition state can complete in a few seconds.  The same
>+sequence occurs when a patch is disabled, except the tasks converge from
>+the patched state to the unpatched state.
>+
>+An interrupt handler inherits the patched state of the task it
>+interrupts.  The same is true for forked tasks: the child inherits the
>+patched state of the parent.
>+
>+Livepatch uses several complementary approaches to determine when it's
>+safe to patch tasks:
>+
>+1. The first and most effective approach is stack checking of sleeping
>+   tasks.  If no affected functions are on the stack of a given task,
>+   the task is patched.  In most cases this will patch most or all of
>+   the tasks on the first try.  Otherwise it'll keep trying
>+   periodically.  This option is only available if the architecture has
>+   reliable stacks (CONFIG_RELIABLE_STACKTRACE and
>+   CONFIG_STACK_VALIDATION).
>+
>+2. The second approach, if needed, is kernel exit switching.  A
>+   task is switched when it returns to user space from a system call, a
>+   user space IRQ, or a signal.  It's useful in the following cases:
>+
>+   a) Patching I/O-bound user tasks which are sleeping on an affected
>+      function.  In this case you have to send SIGSTOP and SIGCONT to
>+      force it to exit the kernel and be patched.

See below -

>+   b) Patching CPU-bound user tasks.  If the task is highly CPU-bound
>+      then it will get patched the next time it gets interrupted by an
>+      IRQ.
>+   c) Applying patches for architectures which don't yet have
>+      CONFIG_RELIABLE_STACKTRACE.  In this case you'll have to signal
>+      most of the tasks on the system.  However this isn't a complete
>+      solution, because there's currently no way to patch kthreads
>+      without CONFIG_RELIABLE_STACKTRACE.
>+
>+   Note: since idle "swapper" tasks don't ever exit the kernel, they
>+   instead have a kpatch_patch_task() call in the idle loop which allows
>+   them to patched before the CPU enters the idle state.
>+
>+3. A third approach (not yet implemented) is planned for the case where
>+   a kthread is sleeping on an affected function.  In that case we could
>+   kick the kthread with a signal and then try to patch the task from
>+   the to-be-patched function's livepatch ftrace handler when it
>+   re-enters the function.  This will require
>+   CONFIG_RELIABLE_STACKTRACE.
>+
>+All the above approaches may be skipped by setting the 'immediate' flag
>+in the 'klp_patch' struct, which will patch all tasks immediately.  This
>+can be useful if the patch doesn't change any function or data
>+semantics.  Note that, even with this flag set, it's possible that some
>+tasks may still be running with an old version of the function, until
>+that function returns.
>+
>+There's also an 'immediate' flag in the 'klp_func' struct which allows
>+you to specify that certain functions in the patch can be applied
>+without per-task consistency.  This might be useful if you want to patch
>+a common function like schedule(), and the function change doesn't need
>+consistency but the rest of the patch does.
>+
>+For architectures which don't have CONFIG_RELIABLE_STACKTRACE, there
>+are two options:
>+
>+a) the user can set the patch->immediate flag which causes all tasks to
>+   be patched immediately.  This option should be used with care, only
>+   when the patch doesn't change any function or data semantics; or
>+
>+b) use the kernel exit switching approach (this is the default).
>+   Note the patching will never complete because there's no currently no
>+   way to patch kthreads without CONFIG_RELIABLE_STACKTRACE.
>+
>+The /sys/kernel/livepatch/<patch>/transition file shows whether a patch
>+is in transition.  Only a single patch (the topmost patch on the stack)
>+can be in transition at a given time.  A patch can remain in transition
>+indefinitely, if any of the tasks are stuck in the initial patch state.
>+
>+A transition can be reversed and effectively canceled by writing the
>+opposite value to the /sys/kernel/livepatch/<patch>/enabled file while
>+the transition is in progress.  Then all the tasks will attempt to
>+converge back to the original patch state.
>+
>+There's also a /proc/<pid>/patch_state file which can be used to
>+determine which tasks are blocking completion of a patching operation.
>+If a patch is in transition, this file shows 0 to indicate the task is
>+unpatched and 1 to indicate it's patched.  Otherwise, if no patch is in
>+transition, it shows -1. Any tasks which are blocking the transition
>+can be signaled with SIGSTOP and SIGCONT to force them to change their
>+patched state.

What about tasks sleeping on affected functions in uninterruptible
sleep (possibly indefinitely)? Since all signals are ignored, we
wouldn't be able to patch those tasks in this way, right? Would that
be an unsupported case? Might be useful to mention this in the
documentation somewhere.

Jessica
