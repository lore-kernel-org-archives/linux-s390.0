From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Date: Fri, 15 Jan 2016 14:01:47 -0800
Message-ID: <20160115220147.GD3818@linux.vnet.ibm.com>
References: <20160113104516.GE25458@arm.com> <5696CF08.8080700@imgtec.com>
	<20160114121449.GC15828@arm.com> <5697F6D2.60409@imgtec.com>
	<20160114203430.GC3818@linux.vnet.ibm.com>
	<56980C91.1010403@imgtec.com>
	<20160114212913.GF3818@linux.vnet.ibm.com>
	<20160115085554.GF3421@worktop>
	<20160115173912.GU3818@linux.vnet.ibm.com>
	<20160115212912.GN3421@worktop>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160115212912.GN3421@worktop>
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
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will.deacon@arm.com>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org, james.hogan@imgtec.com, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, adi-buildroot-devel@lists.sourceforge.net, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, ddaney.cavm@gmail.com, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Jan 15, 2016 at 10:29:12PM +0100, Peter Zijlstra wrote:
> On Fri, Jan 15, 2016 at 09:39:12AM -0800, Paul E. McKenney wrote:
> > Should we start putting litmus tests for the various examples
> > somewhere, perhaps in a litmus-tests directory within each participating
> > architecture?  I have a pile of powerpc-related litmus tests on my laptop,
> > but they probably aren't doing all that much good there.
> 
> Yeah, or a version of them in C that we can 'compile'?

That would be good as well.  I am guessing that architecture-specific
litmus tests will also be needed, but you are right that
architecture-independent versions are higher priority.

> > commit 2cb4e83a1b5c89c8e39b8a64bd89269d05913e41
> > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Date:   Fri Jan 15 09:30:42 2016 -0800
> > 
> >     documentation: Distinguish between local and global transitivity
> >     
> >     The introduction of smp_load_acquire() and smp_store_release() had
> >     the side effect of introducing a weaker notion of transitivity:
> >     The transitivity of full smp_mb() barriers is global, but that
> >     of smp_store_release()/smp_load_acquire() chains is local.  This
> >     commit therefore introduces the notion of local transitivity and
> >     gives an example.
> >     
> >     Reported-by: Peter Zijlstra <peterz@infradead.org>
> >     Reported-by: Will Deacon <will.deacon@arm.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> I think it fails to mention smp_mb__after_release_acquire(), although I
> suspect we didn't actually introduce the primitive yet, which raises the
> point, do we want to?

Well, it is not in v4.4.  I believe that we need good use cases before
we add it.

							Thanx, Paul
