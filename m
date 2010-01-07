Return-Path: <linux-kernel-owner+w=401wt.eu-S932669Ab0AGJA6@vger.kernel.org>
Date: Thu, 7 Jan 2010 10:00:50 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: s390 && user_enable_single_step() (Was: odd utrace testing
 results on s390x)
Message-ID: <20100107100050.31724463@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <20100106205633.700CC134D@magilla.sf.frob.com>
References: <1503844142.2061111261478093776.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1257887498.2061171261478252049.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<20100104155225.GA16650@redhat.com>
	<20100104171626.22ea2d9c@mschwide.boeblingen.de.ibm.com>
	<20100104181412.GA21146@redhat.com>
	<20100104211147.4CC94D532@magilla.sf.frob.com>
	<20100105105030.66bb8a0a@mschwide.boeblingen.de.ibm.com>
	<20100106205633.700CC134D@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Roland McGrath <roland@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>, caiqian@redhat.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Kratochvil <jkratoch@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, utrace-devel@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Wed,  6 Jan 2010 12:56:33 -0800 (PST)
Roland McGrath <roland@redhat.com> wrote:

> > do_signal is called before do_single_step. The order of checks of the
> > TIF_ bits is 1) machine checks, 2) need resched, 3) signal pending, 4)
> > notify resume, 5) restarting system call, 6) single step.
> 
> I see.  Then the potential issue I raised would exist.
> 
> > But why is that important ? If the TIF_SINGLE_STEP bit is set the order
> > of do_signal vs. do_single_step does not seem to be important to me.
> > There will be a SIGTRAP if TIF_SINGLE_STEP is set, no ?
> 
> Right.  It only becomes relevant if something else clears TIF_SINGLE_STEP,
> which does not happen now.  I was discussing the scenario of having
> user_disable_single_step clear it.  That might happen inside a stop,
> i.e. inside do_signal (get_signal_to_deliver).  So given that order of
> checks, it becomes possible for user_disable_single_step to affect the
> pending-step-should-SIGTRAP situation.

That was the idea about the TIF_SINGLE_STEP bit. I can be set and later
unset if we don't want to deliver the SIGTRAP after all.

> > But I agree, it is probably better to make all arches look the same in
> > regard to that pending step report. 
> 
> Right.  That means we should leave the status quo of not clearing
> TIF_SINGLE_STEP in user_disable_single_step.

Ok, although it seems a bit strange not to do it. Perhaps I should add a
comment about it.

> > The LCTLG of multiple control registers is rather expensive. Does it
> > happen often that user_*_single_step is called without need? For gdb is
> > doesn't matter, the cost to switch between tracer and tracee is already
> > large, the cycles added to FixPerRegisters won't matter much. For
> > utrace things might be different.
> 
> In old (current) ptrace, user_*_single_step is never called on current.
> In utrace, it's always called on current, so utrace-based ptrace alone
> adds this second reload overhead beyond the same context-switch overhead
> old ptrace has.  Indeed that addition may be neglible.

So after everthing has been converted to utrace we always will load the
control registers in FixPerRegisters.
 
> In other circumstances with utrace, it is very possible to wind up with
> user_disable_single_step being called superfluously when there was no
> stop (and so not necessarily any context switch or other high overhead).
> On other machines, user_disable_single_step is pretty cheap even where
> user_enable_single_step is quite costly.  Given how simple and cheap it
> is to short-circuit the excess work on s390, I think it is worthwhile.

We could use the same compare of the control registers as the code in
__switch_to. See below.

> It looks like the context-switch code already checks some magic bits in
> per_info to decide whether to do the costly reload.  So it seems vaguely
> consistent with that to conditionalize FixPerRegisters similarly.  The
> single_step cases are a special case with an easy one-bit check to
> short-circuit, so skipping all of FixPerRegisters seems worthwhile IMHO.

What the magic code in __switch_to does is to check if the next process
wants to use per and do the load of the control registers only if the
current set of control registers 9 to 11 differ from the set for the
next process.
The check if the next process wants to use per is done with a
test-under-mask (TM) instruction and a mask of 0xe8. This checks for 4
bits: em_branching, em_instruction_fetch, em_storage_alteration and
em_store_real_address. If one of the bits is set then the current set
of control registers is stored, compared with the set for the next
process and only if they differ is the lctlg done.
The store of control registers is cheap (n cycles for n registers), the
load is expensive for specific control registers. For 9 to 11 it costs
more than 100 cycles.

> To be really optimization-happy about it, you'd also hack FixPerRegisters
> itself to do the reload on current only if PSW_MASK_PER is or was set (if
> I'm following the code correctly).  Or perhaps it should check PER_EM_MASK
> instead to match what __switch_to does.  (I don't understand the
> distinction between those two tests, if there is one.)  Extra frobbity
> would be to leave the old state too when clearing PSW_MASK_PER, and then
> just have the trap handler lazily ignore a hit when current doesn't have
> it set.  Then in a case where there is no hit before context switch,
> you haven't done anything.  But that is probably both excessive and
> not even a win if the PER use is single-step and so there will really
> very likely be a hit before context switch.

The PSW_MASK_PER is the "global" PER enablement switch, the PER_EM_MASK
bits enable the different PER events. We check for the PER_EM_MASK bits
because it is easier to access in __switch_to. The return PSW is stored
in the pt_regs structure, we would have to get a pointer to it (what
"regs = task_pt_regs(taks)" does in FixPerRegisters). In
FixPerRegisters we can as well use the PSW_MASK_PER bit.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
