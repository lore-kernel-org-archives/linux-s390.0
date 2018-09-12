From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Wed, 12 Sep 2018 10:11:06 +0000
Subject: Re: Livepatch consistency model, objtool, and s390x arch
Message-Id: <20180912121106.31ffa97c@mschwideX1>
In-Reply-To: <20180906161521.eqafgtsnuuqpyxtf@treble>
References: <20180906161521.eqafgtsnuuqpyxtf@treble>
To: linux-s390@vger.kernel.org, live-patching@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Josh,

On Thu, 6 Sep 2018 11:15:21 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> Ping.  We are trying to determine whether s390 needs objtool, for the
> livepatch consistency model, which needs reliable stack traces.
> 
> The test for that is: do all (runtime) functions use backchain pointers
> properly?
> 
> Our tentative conclusion, based on Joe's research below, is that misuse
> of backchain pointers is not a realistic concern, and thus that objtool
> is _not_ needed.
> 
> That said, we will probably need to add some error checking to the
> unwinder.  For example, it would need to properly detect unreliable
> stacks caused by page faults or preemption.  And some other error
> conditions.

The compiler is called with the -mbackchain option, all normal C function
will store the backchain in the function prologue. All functions written
in assembler code should do the same, if you find one that does not we
should fix that. The end result is that a task that *voluntarily* called
schedule() should have a proper backchain at all times.

Dependent on the use case this may or may not be enough. Asynchronous
interrupts may stop the CPU at the beginning of a function, if kernel
preemption is enabled we can end up with a broken backchain.
The production kernels for IBM Z are all compiled *without* kernel
preemption. So yes, we might get away without the objtool support.

On a side-note, we do have a line item to implement the ORC unwinder
for the kernel, that includes the objtool support. Once we have that
we can drop the -mbackchain option for the kernel build. That gives
us a nice little performance benefit. I hope that the change from
backchain to the ORC unwinder will not be too hard to implement in
the livepatch tools.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
