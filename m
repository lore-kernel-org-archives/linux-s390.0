Return-Path: <jpoimboe@redhat.com>
Date: Tue, 7 Mar 2017 10:12:30 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v5 01/15] stacktrace/x86: add function for detecting
 reliable stack traces
Message-ID: <20170307161230.44rvjm7ed7azgu6x@treble>
References: <cover.1487036215.git.jpoimboe@redhat.com>
 <baca30690796f3a0d938060b5f90b81375d76c30.1487036215.git.jpoimboe@redhat.com>
 <1488869455.4285.10.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1488869455.4285.10.camel@gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Mar 07, 2017 at 05:50:55PM +1100, Balbir Singh wrote:
> On Mon, 2017-02-13 at 19:42 -0600, Josh Poimboeuf wrote:
> > For live patching and possibly other use cases, a stack trace is only
> > useful if it can be assured that it's completely reliable.  Add a new
> > save_stack_trace_tsk_reliable() function to achieve that.
> > 
> > Note that if the target task isn't the current task, and the target task
> > is allowed to run, then it could be writing the stack while the unwinder
> > is reading it, resulting in possible corruption.  So the caller of
> > save_stack_trace_tsk_reliable() must ensure that the task is either
> > 'current' or inactive.
> > 
> > save_stack_trace_tsk_reliable() relies on the x86 unwinder's detection
> > of pt_regs on the stack.  If the pt_regs are not user-mode registers
> > from a syscall, then they indicate an in-kernel interrupt or exception
> > (e.g. preemption or a page fault), in which case the stack is considered
> > unreliable due to the nature of frame pointers.
> > 
> > It also relies on the x86 unwinder's detection of other issues, such as:
> > 
> > - corrupted stack data
> > - stack grows the wrong way
> > - stack walk doesn't reach the bottom
> > - user didn't provide a large enough entries array
> > 
> > Such issues are reported by checking unwind_error() and !unwind_done().
> > 
> > Also add CONFIG_HAVE_RELIABLE_STACKTRACE so arch-independent code can
> > determine at build time whether the function is implemented.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> 
> Could you comment on why we need a reliable trace for live-patching? Are
> we in any way reliant on the stack trace to patch something broken?

I tried to cover this comprehensively in patch 13/15 in
Documentation/livepatch/livepatch.txt.  Does that answer your questions?

-- 
Josh
