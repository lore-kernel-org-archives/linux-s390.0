From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Date: Tue, 26 Jan 2016 12:11:43 -0800
Message-ID: <20160126201143.GV4503@linux.vnet.ibm.com>
References: <20160113204844.GV6357@twins.programming.kicks-ass.net>
	<5696BA6E.4070508@imgtec.com> <20160114120445.GB15828@arm.com>
	<56980145.5030901@imgtec.com>
	<20160114204827.GE3818@linux.vnet.ibm.com>
	<56981212.7050301@imgtec.com>
	<20160114222046.GH3818@linux.vnet.ibm.com>
	<20160126102402.GE6357@twins.programming.kicks-ass.net>
	<20160126103200.GI6375@twins.programming.kicks-ass.net>
	<20160126110053.GA21553@arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160126110053.GA21553@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org, james.hogan@imgtec.com, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, adi-buildroot-devel@lists.sourceforge.net, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, ddaney.cavm@gmail.com, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jan 26, 2016 at 11:09:27AM +0000, Will Deacon wrote:
> On Tue, Jan 26, 2016 at 11:32:00AM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 26, 2016 at 11:24:02AM +0100, Peter Zijlstra wrote:
> > 
> > > Yeah, this goes under the header: memory-barriers.txt is _NOT_ a
> > > specification (I seem to keep repeating this).
> > 
> > Do we want this ?

Seems likely to me.  ;-)

> > ---
> >  Documentation/memory-barriers.txt | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> > index a61be39c7b51..433326ebdc26 100644
> > --- a/Documentation/memory-barriers.txt
> > +++ b/Documentation/memory-barriers.txt
> > @@ -1,3 +1,4 @@
> > +
> >  			 ============================
> >  			 LINUX KERNEL MEMORY BARRIERS
> >  			 ============================
> > @@ -5,6 +6,22 @@
> >  By: David Howells <dhowells@redhat.com>
> >      Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >  
> > +==========
> > +DISCLAIMER
> > +==========
> > +
> > +This document is not a specification; it is intentionally (for the sake of
> > +brevity) and unintentionally (due to being human) incomplete. This document is
> > +meant as a guide to using the various memory barriers provided by Linux, but
> > +in case of any doubt (and there are many) please ask.
> 
> It might be worth adding you and me to the top of the file, to save Paul
> Cc'ing us on questions (get_maintainer.pl points at poor old Corbet for
> this file).
> 
> But yes, it seems that something like this is required.

So Peter, would you like to update your patch to include yourself
and Will as authors?

						Thanx, Paul
