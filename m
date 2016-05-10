Return-Path: <mbenes@suse.cz>
Date: Tue, 10 May 2016 13:39:17 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
Subject: Re: [RFC PATCH v2 17/18] livepatch: change to a per-task consistency
 model
In-Reply-To: <d60b2b9ce6911bb10dbbf244df58df31c7a8af66.1461875890.git.jpoimboe@redhat.com>
Message-ID: <alpine.LNX.2.00.1605101332330.22758@pobox.suse.cz>
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

On Thu, 28 Apr 2016, Josh Poimboeuf wrote:

> Change livepatch to use a basic per-task consistency model.  This is the
> foundation which will eventually enable us to patch those ~10% of
> security patches which change function or data semantics.  This is the
> biggest remaining piece needed to make livepatch more generally useful.
> 
> This code stems from the design proposal made by Vojtech [1] in November
> 2014.  It's a hybrid of kGraft and kpatch: it uses kGraft's per-task
> consistency and syscall barrier switching combined with kpatch's stack
> trace switching.  There are also a number of fallback options which make
> it quite flexible.
> 
> Patches are applied on a per-task basis, when the task is deemed safe to
> switch over.  When a patch is enabled, livepatch enters into a
> transition state where tasks are converging to the patched state.
> Usually this transition state can complete in a few seconds.  The same
> sequence occurs when a patch is disabled, except the tasks converge from
> the patched state to the unpatched state.
> 
> An interrupt handler inherits the patched state of the task it
> interrupts.  The same is true for forked tasks: the child inherits the
> patched state of the parent.
> 
> Livepatch uses several complementary approaches to determine when it's
> safe to patch tasks:
> 
> 1. The first and most effective approach is stack checking of sleeping
>    tasks.  If no affected functions are on the stack of a given task,
>    the task is patched.  In most cases this will patch most or all of
>    the tasks on the first try.  Otherwise it'll keep trying
>    periodically.  This option is only available if the architecture has
>    reliable stacks (CONFIG_RELIABLE_STACKTRACE and
>    CONFIG_STACK_VALIDATION).
> 
> 2. The second approach, if needed, is kernel exit switching.  A
>    task is switched when it returns to user space from a system call, a
>    user space IRQ, or a signal.  It's useful in the following cases:
> 
>    a) Patching I/O-bound user tasks which are sleeping on an affected
>       function.  In this case you have to send SIGSTOP and SIGCONT to
>       force it to exit the kernel and be patched.
>    b) Patching CPU-bound user tasks.  If the task is highly CPU-bound
>       then it will get patched the next time it gets interrupted by an
>       IRQ.
>    c) Applying patches for architectures which don't yet have
>       CONFIG_RELIABLE_STACKTRACE.  In this case you'll have to signal
>       most of the tasks on the system.  However this isn't a complete
>       solution, because there's currently no way to patch kthreads
>       without CONFIG_RELIABLE_STACKTRACE.
> 
>    Note: since idle "swapper" tasks don't ever exit the kernel, they
>    instead have a kpatch_patch_task() call in the idle loop which allows

s/kpatch_patch_task()/klp_patch_task()/

[...]

> --- a/Documentation/livepatch/livepatch.txt
> +++ b/Documentation/livepatch/livepatch.txt
> @@ -72,7 +72,8 @@ example, they add a NULL pointer or a boundary check, fix a race by adding
>  a missing memory barrier, or add some locking around a critical section.
>  Most of these changes are self contained and the function presents itself
>  the same way to the rest of the system. In this case, the functions might
> -be updated independently one by one.
> +be updated independently one by one.  (This can be done by setting the
> +'immediate' flag in the klp_patch struct.)
>  
>  But there are more complex fixes. For example, a patch might change
>  ordering of locking in multiple functions at the same time. Or a patch
> @@ -86,20 +87,103 @@ or no data are stored in the modified structures at the moment.
>  The theory about how to apply functions a safe way is rather complex.
>  The aim is to define a so-called consistency model. It attempts to define
>  conditions when the new implementation could be used so that the system
> -stays consistent. The theory is not yet finished. See the discussion at
> -http://thread.gmane.org/gmane.linux.kernel/1823033/focus=1828189
> -
> -The current consistency model is very simple. It guarantees that either
> -the old or the new function is called. But various functions get redirected
> -one by one without any synchronization.
> -
> -In other words, the current implementation _never_ modifies the behavior
> -in the middle of the call. It is because it does _not_ rewrite the entire
> -function in the memory. Instead, the function gets redirected at the
> -very beginning. But this redirection is used immediately even when
> -some other functions from the same patch have not been redirected yet.
> -
> -See also the section "Limitations" below.
> +stays consistent.
> +
> +Livepatch has a consistency model which is a hybrid of kGraft and
> +kpatch:  it uses kGraft's per-task consistency and syscall barrier
> +switching combined with kpatch's stack trace switching.  There are also
> +a number of fallback options which make it quite flexible.
> +
> +Patches are applied on a per-task basis, when the task is deemed safe to
> +switch over.  When a patch is enabled, livepatch enters into a
> +transition state where tasks are converging to the patched state.
> +Usually this transition state can complete in a few seconds.  The same
> +sequence occurs when a patch is disabled, except the tasks converge from
> +the patched state to the unpatched state.
> +
> +An interrupt handler inherits the patched state of the task it
> +interrupts.  The same is true for forked tasks: the child inherits the
> +patched state of the parent.
> +
> +Livepatch uses several complementary approaches to determine when it's
> +safe to patch tasks:
> +
> +1. The first and most effective approach is stack checking of sleeping
> +   tasks.  If no affected functions are on the stack of a given task,
> +   the task is patched.  In most cases this will patch most or all of
> +   the tasks on the first try.  Otherwise it'll keep trying
> +   periodically.  This option is only available if the architecture has
> +   reliable stacks (CONFIG_RELIABLE_STACKTRACE and
> +   CONFIG_STACK_VALIDATION).
> +
> +2. The second approach, if needed, is kernel exit switching.  A
> +   task is switched when it returns to user space from a system call, a
> +   user space IRQ, or a signal.  It's useful in the following cases:
> +
> +   a) Patching I/O-bound user tasks which are sleeping on an affected
> +      function.  In this case you have to send SIGSTOP and SIGCONT to
> +      force it to exit the kernel and be patched.
> +   b) Patching CPU-bound user tasks.  If the task is highly CPU-bound
> +      then it will get patched the next time it gets interrupted by an
> +      IRQ.
> +   c) Applying patches for architectures which don't yet have
> +      CONFIG_RELIABLE_STACKTRACE.  In this case you'll have to signal
> +      most of the tasks on the system.  However this isn't a complete
> +      solution, because there's currently no way to patch kthreads
> +      without CONFIG_RELIABLE_STACKTRACE.
> +
> +   Note: since idle "swapper" tasks don't ever exit the kernel, they
> +   instead have a kpatch_patch_task() call in the idle loop which allows

s/kpatch_patch_task()/klp_patch_task()/

Otherwise all the code that touches livepatch looks good to me. Apart from 
the things mentioned in another emails.

Miroslav
