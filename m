Return-Path: <linux-kernel-owner+w=401wt.eu-S1753358Ab0AGVco@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
Subject: Re: s390 && user_enable_single_step() (Was: odd utrace testing
 results on s390x)
In-Reply-To: Martin Schwidefsky's message of  Thursday, 7 January 2010 10:00:50 +0100 <20100107100050.31724463@mschwide.boeblingen.de.ibm.com>
References: <1503844142.2061111261478093776.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1257887498.2061171261478252049.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<20100104155225.GA16650@redhat.com>
	<20100104171626.22ea2d9c@mschwide.boeblingen.de.ibm.com>
	<20100104181412.GA21146@redhat.com>
	<20100104211147.4CC94D532@magilla.sf.frob.com>
	<20100105105030.66bb8a0a@mschwide.boeblingen.de.ibm.com>
	<20100106205633.700CC134D@magilla.sf.frob.com>
	<20100107100050.31724463@mschwide.boeblingen.de.ibm.com>
Message-Id: <20100107213233.B49807300@magilla.sf.frob.com>
Date: Thu,  7 Jan 2010 13:32:33 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Oleg Nesterov <oleg@redhat.com>, caiqian@redhat.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Kratochvil <jkratoch@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, utrace-devel@redhat.com
List-ID: <linux-s390.vger.kernel.org>

> > Right.  That means we should leave the status quo of not clearing
> > TIF_SINGLE_STEP in user_disable_single_step.
> 
> Ok, although it seems a bit strange not to do it. Perhaps I should add a
> comment about it.

It doesn't seem strange to me, but then I've just been through all this.
user_*_step is about what the task will do next.  TIF_SINGLE_STEP is about
what the task has done recently.  Of course more good comments always help.
I might be inclined to change the name of TIF_SINGLE_STEP so that its true
purpose is more obvious.  

AFAICT, in fact it is not even about single-step per se.  It means some PER
trap happened and should produce SIGTRAP.  Don't you get the same thing if
you haven't used single-step, but instead used PTRACE_POKEUSR to set up
per_struct with bits that say to trigger for some other reason?

How about calling it TIF_PER_PENDING?

> So after everthing has been converted to utrace we always will load the
> control registers in FixPerRegisters.

Right.  (This could well still change in the future.  But that's how it is
in utrace now.  And regardless of possible future implementation changes it
will always be the case that sometimes it will be called on current.)

> We could use the same compare of the control registers as the code in
> __switch_to. See below.

Yes, sounds good.

> The PSW_MASK_PER is the "global" PER enablement switch, the PER_EM_MASK
> bits enable the different PER events. We check for the PER_EM_MASK bits
> because it is easier to access in __switch_to. The return PSW is stored
> in the pt_regs structure, we would have to get a pointer to it (what
> "regs = task_pt_regs(taks)" does in FixPerRegisters). In
> FixPerRegisters we can as well use the PSW_MASK_PER bit.

I see.  Thanks for the explanation.


Thanks,
Roland
