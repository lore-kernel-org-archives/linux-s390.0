From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Wed, 30 Dec 2009 21:33:51 +0000
Subject: Re: [patch 2/3] S390-HWBKPT: :S390 architecture specific Hardware
Message-Id: <20091230213349.GE6322@nowhere>
In-Reply-To: <20091219131710.GA4608@osiris.boeblingen.de.ibm.com>
References: <20091219131710.GA4608@osiris.boeblingen.de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, Dec 19, 2009 at 02:17:10PM +0100, Heiko Carstens wrote:
> On Sat, Dec 19, 2009 at 01:40:28AM +0100, Frederic Weisbecker wrote:
> > On Fri, Dec 18, 2009 at 11:34:31PM +0100, Heiko Carstens wrote:
> > > This selects PERF_EVENTS unconditionally. Just be saying "we support
> > > HW_BREAKPOINT" we will get additional cpu overhead by perf events?
> > > Not good.
> > 
> > Yep, if s390 doesn't have breakpoints over ptrace support (which I
> > don't know) then I guess that can be an option.
> 
> Converting s390 to use hw breakpoints for ptrace was the third patch
> in the series, which I think would be a nice cleanup.
> Just wondering why using having hw breakpoints implicitly implies
> enabling perf events.



Because the hardwar breakpoint implementation is based of perf events.
We've made it on top of the Performance Monitoring Unit so that we
can use the register scheduling, context handling, etc... provided
by perf.


 
> > > The big question is: what will this feature buy us? I currently can't
> > > see a strong reason why we want to have HW breakpoint support on s390.
> > 
> > 
> > There is a cross-arch reason: you can profile memory accesses.
> > 
> > Say you want to profile tasklist_lock accesses:
> > 
> > $ grep tasklist_lock /proc/kallsyms
> > ffffffff81c09000 D tasklist_lock
> > 
> > $ perf record -f -g -a -e mem:0xffffffff81c09000:rw sleep 5
> > 
> > $ perf report
> > 
> > # Overhead          Command      Shared Object  Symbol
> > # ........  ...............  .................  ......
> > #
> >     47.73%     hal-acl-tool  [kernel]           [k] do_raw_read_lock
> >                |
> >                --- do_raw_read_lock
> >                    _raw_read_lock
> >                    do_wait
> >                    sys_wait4
> >                    system_call_fastpath
> >                    __waitpid
> >                   |          
> >                   |--50.00%-- 0x1b432a000000030
> >                   |          
> >                   |--41.67%-- 0x1b40f4000000030
> >                   |          
> >                    --8.33%-- 0x1b40f4000000000
> 
> Yes, that looks nice. Unfortunately s390 traps only on write accesses and
> not on read accesses. But it still should give some nice numbers.



Sure, in this case you would need to set the w flag only:

perf record -f -g -a -e mem:0xffffffff81c09000:w sleep 5



> Btw (haven't read the code) what is the default memory length that is
> being watched on if you specify an address like above?
> On s390 you would have to specify the start and end address in control
> registers, that's why I'm asking.


It defaults to 4.
length is not yet supported on perf tools command line but
it is planned to. breakpoint ranges will then be supported in the
same shot, since ranges are just a breakpoint with a high length
by definition.
