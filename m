From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 01/23] all: syscall wrappers: add documentation
Date: Wed, 15 Jun 2016 02:08:38 +0300
Message-ID: <20160614230838.GA15130@yury-N73SV>
References: <6293194.tGy03QJ9ME@wuerfel>
 <20160525.135039.244098606649448826.davem@davemloft.net>
 <6407614.fdv5XFSBue@wuerfel>
 <20160525.142821.1719403997976778673.davem@davemloft.net>
 <20160526204819.GA10274@yury-N73SV>
 <20160526222943.GA16729@MBP.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160526222943.GA16729@MBP.local>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Miller <davem@davemloft.net>, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

Hi Catalin, David, all

> COMPAT_SYSCALL_WRAP2(creat, ...):
> 	mov	w0, w0
> 	b	<sys_creat>
> 
> > > Cost wise, this seems like it all cancels out in the end, but what
> > > do I know?
> > 
> > I think you know something, and I also think Heiko and other s390 guys
> > know something as well. So I'd like to listen their arguments here.
> > 
> > For me spark64 way is looking reasonable only because it's really simple
> > and takes less coding. I'll try it on some branch and share here what happened.
> 
> The kernel code will definitely look simpler ;). It would be good to see
> if there actually is any performance impact. Even with 16 more cycles on
> syscall entry, would they be lost in the noise? You don't need a full
> implementation, just some dummy mov x0, x0 on the entry path.
> 
> -- 
> Catalin

I wrote a simple test:

        struct timeval start, end;
        unsigned long long ut;

        int main()
        {
                gettimeofday(&start, NULL);

                for (int i = 1000000; i; i--)
                        syscall(__NR_getrusage, 100 /* EINVAL */, NULL);

                gettimeofday(&end, NULL);
                
                ut = (end.tv_sec - start.tv_sec) * 1000000ULL
                        + end.tv_usec - start.tv_usec;

                printf("%lld\n", ut);

                exit(EXIT_SUCCESS);
        }

In kernel there's minimal overhead:
diff --git a/kernel/sys.c b/kernel/sys.c
index 89d5be4..003d5ad 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1634,6 +1634,17 @@ COMPAT_SYSCALL_DEFINE2(getrusage, int, who,
struct compat_rusage __user *, ru)
{
        struct rusage r;
         
+       asm volatile (
+       "       mov w0, w0      \n"
+       "       mov w1, w1      \n"
+       "       mov w2, w2      \n"
+       "       mov w3, w3      \n"
+       "       mov w4, w4      \n"
+       "       mov w5, w5      \n"
+       "       mov w6, w6      \n"
+       "       mov w7, w7      \n"
+       );
+
        if (who != RUSAGE_SELF && who != RUSAGE_CHILDREN &&
            who != RUSAGE_THREAD)
                return -EINVAL;

On QEMU:
With MOVs:      W/O MOVs:
832015          814564
840639          803165
830482          813116
832895          802928
832083          832658
834461          802993
829405          812465
846677          822651
828409          803393
836845          821470
828716          801044
831620          821301
825423          800278
829946          821476

We have 83 mS vs 81 mS, ~2.6% of performance degradation.
And I can show bigger numbers if I'll use asm svc instead of
syscall() wrapper which increases time as well. 

It's definitely more than 0, but not so big anyway. For syscalls
with heavy payload it will be non-measurable. So the choice
is still there. Should we use wrappers and save 2.5% of syscall
performance. Or clear top-halves unconditionally and win in simplicity?

If QEMU is looking non-representative, I can run test on real
hardware, but it takes a time, and I think will end up with similar
results.

Latest kernel with wrappers and library are here:
https://github.com/norov/linux/commits/ilp32
https://github.com/norov/glibc/commits/ilp32-dev

BTW, notice the change in ABI: syscalls that take stat and statfs
structures now routed to (wrapped) native handlers, after switching
userspace to use 64-bit off_t, ino_t, blkcnt_t, fsblkcnt_t and
fsfilcnt_t types.

Yury.
