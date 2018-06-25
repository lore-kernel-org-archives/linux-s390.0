Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 25 Jun 2018 11:09:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v12 01/11] x86: text_poke() may access uninitialized
 struct pages
Message-ID: <20180625090915.GV2494@hirez.programming.kicks-ass.net>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-2-pasha.tatashin@oracle.com>
 <20180625081429.GS2494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1806251038190.8650@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806251038190.8650@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jun 25, 2018 at 10:39:24AM +0200, Thomas Gleixner wrote:
> On Mon, 25 Jun 2018, Peter Zijlstra wrote:
> > On Thu, Jun 21, 2018 at 05:25:08PM -0400, Pavel Tatashin wrote:
> > > -void *text_poke(void *addr, const void *opcode, size_t len)
> > > +void __ref *text_poke(void *addr, const void *opcode, size_t len)
> > >  {
> > >  	unsigned long flags;
> > >  	char *vaddr;
> > >  	struct page *pages[2];
> > >  	int i;
> > >  
> > > +	/* While boot memory allocator is runnig we cannot use struct
> > 
> > Broken comment style..
> > 
> > > +	 * pages as they are not yet initialized. However, we also know
> > > +	 * that this is early in boot, and it is safe to fallback to
> > > +	 * text_poke_early.
> > > +	 */
> > > +	if (unlikely(!after_bootmem))
> > > +		return text_poke_early(addr, opcode, len);
> > 
> > I'm not entirely sure this is right.. Because not only do we need the
> > whole fixmap stuff working, we also need #DB and the IPI handlers set-up
> > and working.
> 
> IPI? That's early UP boot why would you need an IPI?

Because the way this is called is from __jump_label_transform() ->
text_poke_bp() -> text_poke() -> text_poke_early().

And if you look at text_poke_bp(), you'll note it relies on #DB and
on_each_cpu() IPIs.

Which is of course exactly the reason I avoided text_poke_bp() entirely
in the first place.
