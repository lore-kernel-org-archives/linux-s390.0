Return-Path: <jpoimboe@redhat.com>
Date: Sat, 10 Dec 2016 11:17:07 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 00/15] livepatch: hybrid consistency model
Message-ID: <20161210171707.cpupmxyuhob4tc3i@treble>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <1481348777.28041.1.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <1481348777.28041.1.camel@gmail.com>
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
Content-Transfer-Encoding: 8bit

On Sat, Dec 10, 2016 at 04:46:17PM +1100, Balbir Singh wrote:
> On Thu, 2016-12-08 at 12:08 -0600, Josh Poimboeuf wrote:
> > Dusting the cobwebs off the consistency model again.  This is based on
> > linux-next/master.
> > 
> > v1 was posted on 2015-02-09:
> > 
> >   https://lkml.kernel.org/r/cover.1423499826.git.jpoimboe@redhat.com
> > 
> > v2 was posted on 2016-04-28:
> > 
> >   https://lkml.kernel.org/r/cover.1461875890.git.jpoimboe@redhat.com
> > 
> > The biggest issue from v2 was finding a decent way to detect preemption
> > and page faults on the stack of a sleeping task.  
> 
> Could you please elaborate on this? Preemption of a sleeping task and
> faults as in the future (time) preemption and faults?

The normal way for a task to go to sleep is to call schedule().  objtool
ensures the stack trace is reliable in that case, by making sure that
all functions save the frame pointer on the stack before calling out to
another function.

But a task can also go to sleep in a few other ways.  One way is by
preemption, where an interrupt handler interrupts the task and calls
preempt_schedule_irq().  Another way is by a page fault exception.  In
both cases, there's no guarantee that the interrupted function saved the
frame pointer on the stack beforehand.  So the stack trace might be
unreliable.  Fortunately, interrupts and exceptions leave evidence
behind on the stack.  So when walking the stack of a sleeping task, we
can detect when an IRQ or exception occurred, and consider such a stack
unreliable.

-- 
Josh
