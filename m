Return-Path: <jpoimboe@redhat.com>
Date: Mon, 12 Dec 2016 08:04:05 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 00/15] livepatch: hybrid consistency model
Message-ID: <20161212140405.ai5hpgwqqvlataey@treble>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <1481348777.28041.1.camel@gmail.com>
 <20161210171707.cpupmxyuhob4tc3i@treble>
 <aac5fa04-c15c-5210-bce7-c72e16373964@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <aac5fa04-c15c-5210-bce7-c72e16373964@gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, live-patching@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>, Chris J Arges <chris.j.arges@canonical.com>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Dec 11, 2016 at 01:08:33PM +1100, Balbir Singh wrote:
> 
> 
> On 11/12/16 04:17, Josh Poimboeuf wrote:
> > On Sat, Dec 10, 2016 at 04:46:17PM +1100, Balbir Singh wrote:
> >> On Thu, 2016-12-08 at 12:08 -0600, Josh Poimboeuf wrote:
> >>> Dusting the cobwebs off the consistency model again.  This is based on
> >>> linux-next/master.
> >>>  
> >>> v1 was posted on 2015-02-09:
> >>>  
> >>>   https://lkml.kernel.org/r/cover.1423499826.git.jpoimboe@redhat.com
> >>>  
> >>> v2 was posted on 2016-04-28:
> >>>  
> >>>   https://lkml.kernel.org/r/cover.1461875890.git.jpoimboe@redhat.com
> >>>  
> >>> The biggest issue from v2 was finding a decent way to detect preemption
> >>> and page faults on the stack of a sleeping task.  
> >>
> >> Could you please elaborate on this? Preemption of a sleeping task and
> >> faults as in the future (time) preemption and faults?
> > 
> > The normal way for a task to go to sleep is to call schedule().  objtool
> > ensures the stack trace is reliable in that case, by making sure that
> > all functions save the frame pointer on the stack before calling out to
> > another function.
> > 
> > But a task can also go to sleep in a few other ways.  One way is by
> > preemption, where an interrupt handler interrupts the task and calls
> > preempt_schedule_irq().
> 
> It's preempted, not sleeping. It's on_rq but not on_cpu.

You're right, I used the word "sleeping" when I meant "not currently
executing on a CPU".  (Peter Z also pointed that out.)

>   Another way is by a page fault exception.  In
> > both cases, there's no guarantee that the interrupted function saved the
> > frame pointer on the stack beforehand.  So the stack trace might be
> > unreliable.  Fortunately, interrupts and exceptions leave evidence
> > behind on the stack.  So when walking the stack of a sleeping task, we
> > can detect when an IRQ or exception occurred, and consider such a stack
> > unreliable.
> > 
> 
> Thanks for the explanation. I presume a whole lot of this is arch specific
> code? I'll look at the patches as well

Most of the new livepatch code is arch-independent, but the consistency
model part of it (i.e., !klp_patch.immediate) is currently only
supported by x86_64.

For adding support for other architectures, there are a few options:

1) Add CONFIG_HAVE_RELIABLE_STACKTRACE.  This means porting objtool, and
   for non-DWARF unwinders, also making sure there's a way for the stack
   tracing code to detect interrupts on the stack.

2) Alternatively, figure out a way to patch kthreads without stack
   checking.  If all kthreads sleep in the same place, then we can
   designate that place as a patching point.  I think Petr M has been
   working on that?  In that case, arches without
   HAVE_RELIABLE_STACKTRACE would still be able to use the
   non-stack-checking parts of the consistency model:

   a) patching user tasks when they cross the kernel/user space
      boundary; and

   b) patching kthreads and idle tasks at their designated patch points.

   This option isn't as good as option 1 because it requires signaling
   most of the tasks to patch them.  But it could still be a good backup
   option for those architectures which don't have reliable stack traces
   yet.

In the meantime, other architectures can keep today's behavior by
setting klp_patch.immediate to true.

-- 
Josh
