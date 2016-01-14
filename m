From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Date: Thu, 14 Jan 2016 13:24:34 -0800
Message-ID: <56981212.7050301@imgtec.com>
References: <20160112102555.GV6373@twins.programming.kicks-ass.net>
	<20160112104012.GW6373@twins.programming.kicks-ass.net>
	<20160112114111.GB15737@arm.com> <569565DA.2010903@imgtec.com>
	<20160113104516.GE25458@arm.com> <56969F4B.7070001@imgtec.com>
	<20160113204844.GV6357@twins.programming.kicks-ass.net>
	<5696BA6E.4070508@imgtec.com> <20160114120445.GB15828@arm.com>
	<56980145.5030901@imgtec.com>
	<20160114204827.GE3818@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160114204827.GE3818@linux.vnet.ibm.com>
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
To: paulmck@linux.vnet.ibm.com
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org, james.hogan@imgtec.com, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, adi-buildroot-devel@lists.sourceforge.net, ddaney.cavm@gmail.com, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.orglinux-a
List-ID: <linux-s390.vger.kernel.org>

On 01/14/2016 12:48 PM, Paul E. McKenney wrote:
>
> So SYNC_RMB is intended to implement smp_rmb(), correct?
Yes.
>
> You could use SYNC_ACQUIRE() to implement read_barrier_depends() and
> smp_read_barrier_depends(), but SYNC_RMB probably does not suffice.

If smp_read_barrier_depends() is used to separate not only two reads but 
read pointer and WRITE basing on that pointer (example below) - yes. I 
just doesn't see any example of this in famous 
Documentation/memory-barriers.txt and had no chance to know what you use 
it in this way too.

> The reason for this is that smp_read_barrier_depends() must order the
> pointer load against any subsequent read or write through a dereference
> of that pointer.

I can't see that requirement anywhere in Documents directory. I mean - 
the words "write through a dereference of that pointer" or similar for 
smp_read_barrier_depends.

>    For example:
>
> 	p = READ_ONCE(gp);
> 	smp_rmb();
> 	r1 = p->a; /* ordered by smp_rmb(). */
> 	p->b = 42; /* NOT ordered by smp_rmb(), BUG!!! */
> 	r2 = x; /* ordered by smp_rmb(), but doesn't need to be. */
>
> In contrast:
>
> 	p = READ_ONCE(gp);
> 	smp_read_barrier_depends();
> 	r1 = p->a; /* ordered by smp_read_barrier_depends(). */
> 	p->b = 42; /* ordered by smp_read_barrier_depends(). */
> 	r2 = x; /* not ordered by smp_read_barrier_depends(), which is OK. */
>
> Again, if your hardware maintains local ordering for address
> and data dependencies, you can have read_barrier_depends() and
> smp_read_barrier_depends() be no-ops like they are for most
> architectures.

It is not so simple, I mean "local ordering for address and data 
dependencies". Local ordering is NOT enough. It happens that current 
MIPS R6 doesn't require in your example smp_read_barrier_depends() but 
in discussion it comes out that it may not. Because without 
smp_read_barrier_depends() your example can be a part of Will's 
WRC+addr+addr and we found some design which easily can bump into this 
test. And that design actually performs "local ordering for address and 
data dependencies" too.

- Leonid.
