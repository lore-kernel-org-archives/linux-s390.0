Return-Path: <mbenes@suse.cz>
Date: Mon, 9 May 2016 17:42:41 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
Subject: Re: barriers: was: [RFC PATCH v2 17/18] livepatch: change to a
 per-task consistency model
In-Reply-To: <20160504172517.tdatoj2nlkqwyd4g@treble>
Message-ID: <alpine.LNX.2.00.1605091729450.22758@pobox.suse.cz>
References: <cover.1461875890.git.jpoimboe@redhat.com>
 <d60b2b9ce6911bb10dbbf244df58df31c7a8af66.1461875890.git.jpoimboe@redhat.com>
 <20160504123940.GR2749@pathway.suse.cz>
 <20160504141205.GS2749@pathway.suse.cz>
 <20160504172517.tdatoj2nlkqwyd4g@treble>
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
Cc: Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 4 May 2016, Josh Poimboeuf wrote:

> On Wed, May 04, 2016 at 04:12:05PM +0200, Petr Mladek wrote:
> > On Wed 2016-05-04 14:39:40, Petr Mladek wrote:
> > > 		 *
> > > 		 * Note that the task must never be migrated to the target
> > > 		 * state when being inside this ftrace handler.
> > > 		 */
> > > 
> > > We might want to move the second paragraph on top of the function.
> > > It is a basic and important fact. It actually explains why the first
> > > read barrier is not needed when the patch is being disabled.
> > 
> > I wrote the statement partly intuitively. I think that it is really
> > somehow important. And I am slightly in doubts if we are on the safe side.
> > 
> > First, why is it important that the task->patch_state is not switched
> > when being inside the ftrace handler?
> > 
> > If we are inside the handler, we are kind-of inside the called
> > function. And the basic idea of this consistency model is that
> > we must not switch a task when it is inside a patched function.
> > This is normally decided by the stack.
> > 
> > The handler is a bit special because it is called right before the
> > function. If it was the only patched function on the stack, it would
> > not matter if we choose the new or old code. Both decisions would
> > be safe for the moment.
> > 
> > The fun starts when the function calls another patched function.
> > The other patched function must be called consistently with
> > the first one. If the first function was from the patch,
> > the other must be from the patch as well and vice versa.
> > 
> > This is why we must not switch task->patch_state dangerously
> > when being inside the ftrace handler.
> > 
> > Now I am not sure if this condition is fulfilled. The ftrace handler
> > is called as the very first instruction of the function. Does not
> > it break the stack validity? Could we sleep inside the ftrace
> > handler? Will the patched function be detected on the stack?
> > 
> > Or is my brain already too far in the fantasy world?
> 
> I think this isn't a possibility.
> 
> In today's code base, this can't happen because task patch states are
> only switched when sleeping or when exiting the kernel.  The ftrace
> handler doesn't sleep directly.
> 
> If it were preempted, it couldn't be switched there either because we
> consider preempted stacks to be unreliable.

And IIRC ftrace handlers cannot sleep and are called with preemption 
disabled as of now. The code is a bit obscure, but see 
__ftrace_ops_list_func for example. This is "main" ftrace handler that 
calls all the registered ones in case FTRACE_OPS_FL_DYNAMIC is set (which 
is always true for handlers coming from modules) and CONFIG_PREEMPT is 
on. If it is off and there is only one handler registered for a function 
dynamic trampoline is used. See commit 12cce594fa8f ("ftrace/x86: Allow 
!CONFIG_PREEMPT dynamic ops to use allocated trampolines"). I think 
Steven had a plan to implement dynamic trampolines even for 
CONFIG_PREEMPT case but he still hasn't done it. It should use RCU_TASKS 
infrastructure.

The reason for all the mess is that ftrace needs to be sure that no task 
is in the handler when the handler/trampoline is freed.

So we should be safe for now even from this side.

Miroslav
