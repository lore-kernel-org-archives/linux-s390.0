From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Date: Fri, 15 Jan 2016 10:54:32 -0800
Message-ID: <56994068.4050402@imgtec.com>
References: <569565DA.2010903@imgtec.com> <20160113104516.GE25458@arm.com>
	<56969F4B.7070001@imgtec.com>
	<20160113204844.GV6357@twins.programming.kicks-ass.net>
	<5696BA6E.4070508@imgtec.com> <20160114120445.GB15828@arm.com>
	<56980145.5030901@imgtec.com>
	<20160114204827.GE3818@linux.vnet.ibm.com>
	<56981212.7050301@imgtec.com>
	<20160114222046.GH3818@linux.vnet.ibm.com>
	<20160115095756.GA2131@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160115095756.GA2131@arm.com>
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
To: Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org, james.hogan@imgtec.com, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, adi-buildroot-devel@lists.sourceforge.net, ddaney.cavm@gmail.com, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, And
List-ID: <linux-s390.vger.kernel.org>

On 01/15/2016 01:57 AM, Will Deacon wrote:
> Paul,
>
>
> I think you figured this out while I was sleeping, but just to confirm:
>
>   1. The MIPS64 ISA doc [1] talks about SYNC in a way that applies only
>      to memory accesses appearing in *program-order* before the SYNC
>
>   2. We need WRC+sync+addr to work, which means that the SYNC in P1 must
>      also capture the store in P0 as being "before" the barrier. Leonid
>      reckons it works, but his explanation [2] focussed on the address
>      dependency in P2 as to why this works. If that is the case (i.e.
>      address dependency provides global transitivity), then WRC+addr+addr
>      should also work (even though its not required).

No, it is not correct. There is one old design which provides access to 
core (thread0 + thread1) write-buffers for threads load in advance of it 
is visible to other cores. It means, that WRC+sync+addr passes because 
of SYNC in write thread and register dependency inside other thread but 
WRC+addr+addr may fail because other core may get a stale data.

>
>   3. It seems that WRC+addr+addr doesn't work, so I'm still suspicious
>      about WRC+sync+addr, because neither the architecture document or
>      Leonid's explanation tell me that it should be forbidden.
>
> Will
>
> [1] https://imgtec.com/?do-download=4302
> [2] http://lkml.kernel.org/r/569565DA.2010903@imgtec.com (scroll to the end)
