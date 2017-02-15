Return-Path: <jpoimboe@redhat.com>
Date: Wed, 15 Feb 2017 08:40:44 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v5 01/15] stacktrace/x86: add function for detecting
 reliable stack traces
Message-ID: <20170215144044.yn63piijka7zqqlz@treble>
References: <cover.1487036215.git.jpoimboe@redhat.com>
 <baca30690796f3a0d938060b5f90b81375d76c30.1487036215.git.jpoimboe@redhat.com>
 <alpine.LSU.2.20.1702151317480.2793@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.LSU.2.20.1702151317480.2793@pobox.suse.cz>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Feb 15, 2017 at 01:18:40PM +0100, Miroslav Benes wrote:
> On Mon, 13 Feb 2017, Josh Poimboeuf wrote:
> 
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
> 
> I do not see any difference from 4.1 version, so my
> 
> Reviewed-by: Miroslav Benes <mbenes@suse.cz>

Sorry, forgot to add your Reviewed-by from last time.  The patch is
indeed the same.  Thanks!

-- 
Josh
