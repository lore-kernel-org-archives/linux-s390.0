From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [-next Nov 16] s390 build failure (arch/s390/kernel/time)
Date: Tue, 17 Nov 2009 08:59:17 +0100
Message-ID: <20091117075917.GA5124@osiris.boeblingen.de.ibm.com>
References: <20091116181453.b42247cf.sfr@canb.auug.org.au>
 <4B02283D.8040103@in.ibm.com>
 <20091117162546.16bb00b0.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091117162546.16bb00b0.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-next@vger.kernel.org, Tejun Heo <tj@kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, Christoph Lameter <cl@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Sachin Sant <sachinp@in.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Nov 17, 2009 at 04:25:46PM +1100, Stephen Rothwell wrote:
> On Tue, 17 Nov 2009 10:06:13 +0530 Sachin Sant <sachinp@in.ibm.com> wrote:
> >
> > Next 20091116 build failed on a s390 box with
> > 
> > arch/s390/kernel/time.c: In function 'get_sync_clock':
> > arch/s390/kernel/time.c:337: error: 'clock_sync_sync' undeclared (first use in this function)
> > arch/s390/kernel/time.c:337: error: (Each undeclared identifier is reported only once
> > arch/s390/kernel/time.c:337: error: for each function it appears in.)
> > arch/s390/kernel/time.c: In function 'check_sync_clock':
> > arch/s390/kernel/time.c:387: error: 'clock_sync_sync' undeclared (first use in this function)
> 
> Caused by commits 8283cb43ab3e92a039d3486a0f6253df95a5fa55 ("[S390] clock
> sync mode flags") (which entered Linus' tree during 2.6.30-rc1) and
> commit d2fec595511b5718bdb65645b3d5d99800d97943 ("[S390] stp support")
> (which entered Linus' tree during 2.6.27-rc1) but only exposed by commit
> e0fdb0e050eae331046385643618f12452aa7e73 ("percpu: add __percpu for
> sparse") from the percpu tree.
> 
> Needs to be fixed in the s390 tree.  (put_per_cpu() now references its
> argument, so that had better be a real variable :-))

Weird... at least it wasn't a bug. Patch below will fix compile breakage.

---
 arch/s390/kernel/time.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-next/arch/s390/kernel/time.c
===================================================================
--- linux-next.orig/arch/s390/kernel/time.c
+++ linux-next/arch/s390/kernel/time.c
@@ -334,7 +334,7 @@ int get_sync_clock(unsigned long long *c
 	sw0 = atomic_read(sw_ptr);
 	*clock = get_clock();
 	sw1 = atomic_read(sw_ptr);
-	put_cpu_var(clock_sync_sync);
+	put_cpu_var(clock_sync_word);
 	if (sw0 == sw1 && (sw0 & 0x80000000U))
 		/* Success: time is in sync. */
 		return 0;
@@ -384,7 +384,7 @@ static inline int check_sync_clock(void)
 
 	sw_ptr = &get_cpu_var(clock_sync_word);
 	rc = (atomic_read(sw_ptr) & 0x80000000U) != 0;
-	put_cpu_var(clock_sync_sync);
+	put_cpu_var(clock_sync_word);
 	return rc;
 }
 
