Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 29 Nov 2019 19:16:50 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v4 2/2] s390/livepatch: Implement reliable stack tracing
 for the consistency model
In-Reply-To: <patch-2.thread-a0061f.git-a0061fcad34d.your-ad-here.call-01575012971-ext-9115@work.hours>
Message-ID: <alpine.LSU.2.21.1911291533450.23789@pobox.suse.cz>
References: <20191106095601.29986-5-mbenes@suse.cz> <cover.thread-a0061f.your-ad-here.call-01575012971-ext-9115@work.hours> <patch-2.thread-a0061f.git-a0061fcad34d.your-ad-here.call-01575012971-ext-9115@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, jpoimboe@redhat.com, joe.lawrence@redhat.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, jikos@kernel.org, pmladek@suse.com, nstange@suse.de, live-patching@vger.kernel.org

On Fri, 29 Nov 2019, Vasily Gorbik wrote:

> From: Miroslav Benes <mbenes@suse.cz>
> 
> The livepatch consistency model requires reliable stack tracing
> architecture support in order to work properly. In order to achieve
> this, two main issues have to be solved. First, reliable and consistent
> call chain backtracing has to be ensured. Second, the unwinder needs to
> be able to detect stack corruptions and return errors.
> 
> The "zSeries ELF Application Binary Interface Supplement" says:
> 
>   "The stack pointer points to the first word of the lowest allocated
>   stack frame. If the "back chain" is implemented this word will point to
>   the previously allocated stack frame (towards higher addresses), except
>   for the first stack frame, which shall have a back chain of zero (NULL).
>   The stack shall grow downwards, in other words towards lower addresses."
> 
> "back chain" is optional. GCC option -mbackchain enables it. Quoting
> Martin Schwidefsky [1]:
> 
>   "The compiler is called with the -mbackchain option, all normal C
>   function will store the backchain in the function prologue. All
>   functions written in assembler code should do the same, if you find one
>   that does not we should fix that. The end result is that a task that
>   *voluntarily* called schedule() should have a proper backchain at all
>   times.
> 
>   Dependent on the use case this may or may not be enough. Asynchronous
>   interrupts may stop the CPU at the beginning of a function, if kernel
>   preemption is enabled we can end up with a broken backchain.  The
>   production kernels for IBM Z are all compiled *without* kernel
>   preemption. So yes, we might get away without the objtool support.
> 
>   On a side-note, we do have a line item to implement the ORC unwinder for
>   the kernel, that includes the objtool support. Once we have that we can
>   drop the -mbackchain option for the kernel build. That gives us a nice
>   little performance benefit. I hope that the change from backchain to the
>   ORC unwinder will not be too hard to implement in the livepatch tools."
> 
> Since -mbackchain is enabled by default when the kernel is compiled, the
> call chain backtracing should be currently ensured and objtool should
> not be necessary for livepatch purposes.
> 
> Regarding the second issue, stack corruptions and non-reliable states
> have to be recognized by the unwinder. Mainly it means to detect
> preemption or page faults, the end of the task stack must be reached,
> return addresses must be valid text addresses and hacks like function
> graph tracing and kretprobes must be properly detected.
> 
> Unwinding a running task's stack is not a problem, because there is a
> livepatch requirement that every checked task is blocked, except for the
> current task. Due to that, we can consider a task's kernel/thread stack
> only and skip the other stacks.
> 
> [1] 20180912121106.31ffa97c@mschwideX1 [not archived on lore.kernel.org]
> 
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

Signed-off-by: Miroslav Benes <mbenes@suse.cz>

M
