Return-Path: <pmladek@suse.com>
Date: Mon, 10 Apr 2017 17:40:22 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v5 01/15] stacktrace/x86: add function for detecting
 reliable stack traces
Message-ID: <20170410154022.GC18673@pathway.suse.cz>
References: <cover.1487036215.git.jpoimboe@redhat.com>
 <baca30690796f3a0d938060b5f90b81375d76c30.1487036215.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <baca30690796f3a0d938060b5f90b81375d76c30.1487036215.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon 2017-02-13 19:42:28, Josh Poimboeuf wrote:
> For live patching and possibly other use cases, a stack trace is only
> useful if it can be assured that it's completely reliable.  Add a new
> save_stack_trace_tsk_reliable() function to achieve that.
> 
> Note that if the target task isn't the current task, and the target task
> is allowed to run, then it could be writing the stack while the unwinder
> is reading it, resulting in possible corruption.  So the caller of
> save_stack_trace_tsk_reliable() must ensure that the task is either
> 'current' or inactive.
> 
> save_stack_trace_tsk_reliable() relies on the x86 unwinder's detection
> of pt_regs on the stack.  If the pt_regs are not user-mode registers
> from a syscall, then they indicate an in-kernel interrupt or exception
> (e.g. preemption or a page fault), in which case the stack is considered
> unreliable due to the nature of frame pointers.
> 
> It also relies on the x86 unwinder's detection of other issues, such as:
> 
> - corrupted stack data
> - stack grows the wrong way
> - stack walk doesn't reach the bottom
> - user didn't provide a large enough entries array
> 
> Such issues are reported by checking unwind_error() and !unwind_done().
> 
> Also add CONFIG_HAVE_RELIABLE_STACKTRACE so arch-independent code can
> determine at build time whether the function is implemented.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Just for record, this version looks fine to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

PS: I was on the sick leave longer then expected. The patch set
has been pushed into the for-4.12 branch in jikos/livepatching.git
in the meantime. I check it there just for completeness. You do not
need to add my Reviewed-by tags.
