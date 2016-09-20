From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH][RFC] Implement arch primitives for busywait loops
Date: Tue, 20 Sep 2016 22:27:32 +1000
Message-ID: <20160920222732.12301963@roar.ozlabs.ibm.com>
References: <20160916085736.7857-1-npiggin@gmail.com>
        <60adab94-f32e-2287-4821-81a88fa366d4@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <60adab94-f32e-2287-4821-81a88fa366d4@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 20 Sep 2016 13:19:30 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 09/16/2016 10:57 AM, Nicholas Piggin wrote:
> > Implementing busy wait loops with cpu_relax() in callers poses
> > some difficulties for powerpc.
> > 
> > First, we want to put our SMT thread into a low priority mode for the
> > duration of the loop, but then return to normal priority after exiting
> > the loop.  Dependong on the CPU design, 'HMT_low() ; HMT_medium();' as
> > cpu_relax() does may have HMT_medium take effect before HMT_low made
> > any (or much) difference.
> > 
> > Second, it can be beneficial for some implementations to spin on the
> > exit condition with a statically predicted-not-taken branch (i.e.,
> > always predict the loop will exit).
> > 
> > This is a quick RFC with a couple of users converted to see what
> > people think. I don't use a C branch with hints, because we don't want
> > the compiler moving the loop body out of line, which makes it a bit
> > messy unfortunately. If there's a better way to do it, I'm all ears.
> > 
> > I would not propose to switch all callers immediately, just some
> > core synchronisation primitives.  
> Just a FYA,
> 
> On s390 we have a private version of cpu_relax that yields the cpu
> time slice back to the hypervisor via a hypercall.

The powerpc guest also wants to yield to hypervisor in some busywait
situations.

> As this turned out
> to be problematic in some cases there is also now a cpu_relax_lowlatency.
> 
> Now, this seems still problematic as there are too many places still 
> using cpu_relax instead of cpu_relax_lowlatency. So my plan is to do 
> a change of that, make cpu_relax just be a barrier and add a new 
> cpu_relax_yield that gives up the time slice. (so that s390 cpu_relax
> is just like any other cpu_relax)
> 
> As far as I can tell the only place where I want to change cpu_relax
> to cpu_relax_lowlatency after that change is the stop machine run 
> code, so I hope to have no conflicts with your changes.

I don't think there should be any conflicts, but it would be good to
make sure busy wait primitives can be usable by s390. So I can add
_yield variants that can do the right thing for s390.

I need to think more about virtualization, so I'm glad you commented.
Powerpc would like to be told when a busywait loop knows the CPU it is
waiting for. So perhaps also a _yield_to_cpu variant as well.

Something that will work with mutex_spin_on_owner and similar would be
nice too. As far as I can tell, powerpc may want to yield to hypervisor
when the owner's vcpu is scheduled off in that case too.

Thanks,
Nick
