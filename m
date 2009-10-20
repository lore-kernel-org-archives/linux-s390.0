From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Tue, 20 Oct 2009 08:00:40 +0000
Subject: Re: reading /proc/stat segfaults after long uptimes
Message-Id: <20091020100040.7a15d81b@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <20091020091315.5e23263e@mschwide.boeblingen.de.ibm.com>
References: <20091020091315.5e23263e@mschwide.boeblingen.de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 20 Oct 2009 09:13:15 +0200
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> On Mon, 19 Oct 2009 00:17:30 +0200
> Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> 
> > On Sun, 18 Oct 2009 05:35:29 -0400
> > Mike Frysinger <vapier@gentoo.org> wrote:
> > 
> > > this bug has been around for as long as i can remember (before 2.6.16.x), and 
> > > it is still in 2.6.27.10.  i'm upgrading to 2.6.31.4 now, but it'll be a while 
> > > before i can report back since the bug doesnt manifest itself for a long time.  
> > > current uptime is ~3 months.
> > > 
> > > $ cat /proc/stat
> > > Segmentation fault
> > > 
> > > $ dmesg
> > > ------------[ cut here ]------------
> > > Kernel BUG at 001b0c92 [verbose debug info unavailable]
> > > fixpoint divide exception: 0009 [#13] SMP
> > > Modules linked in: ipv6
> > > CPU: 1 Tainted: G      D   2.6.27.10 #5
> > > Process cat (pid: 21352, task: 1fb34138, ksp: 1d2a3d98)
> > > Krnl PSW : 070c2000 801b0c92 (show_stat+0x2ca/0x68c)
> > >            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:0 CC:2 PM:0
> > > Krnl GPRS: 00000001 00001388 00000bb8 0015d2a1
> > >            00000000 00000000 000003e8 0001fd91
> > >            00000000 00000000 0000129d eecd2ff0
> > >            1cc533b9 0036f780 801b0bce 1d2a3cc0
> > > Krnl Code: 801b0c86: f18890abf198       mvo     171(9,%r9),408(9,%r15)
> > >            801b0c8c: 98abf170           lm      %r10,%r11,368(%r15)
> > >            801b0c90: 1da1               dr      %r10,%r1
> > >           >801b0c92: 90abf170           stm     %r10,%r11,368(%r15)
> > >            801b0c96: 98abf190           lm      %r10,%r11,400(%r15)
> > >            801b0c9a: 1da1               dr      %r10,%r1
> > >            801b0c9c: 90abf190           stm     %r10,%r11,400(%r15)
> > >            801b0ca0: 18a3               lr      %r10,%r3
> > > Call Trace:
> > > ([<00000000001b09f4>] show_stat+0x2c/0x68c)
> > >  [<000000000018dcee>] seq_read+0xb2/0x364
> > >  [<00000000001a9980>] proc_reg_read+0x68/0x98
> > >  [<00000000001705ee>] vfs_read+0x6e/0xe8
> > >  [<0000000000170732>] sys_read+0x36/0x78
> > >  [<000000000010f750>] sysc_do_restart+0x12/0x16
> > >  [<0000000077f3ad6a>] 0x77f3ad6a
> > >  <4>---[ end trace 1436ea9559d3de9e ]---
> > > 
> > > i'm making sure to enable verbose debug this time in case the bug comes up 
> > > again, but perhaps someone can ninja this out before
> > 
> > The dr %r10,%r1 got a divide exception because the division result does
> > not fit into a 32 bit register. Does not happen on 64 bit because the
> > target register is larger. It is probably the idle time conversion to
> > ticks. I'll have a look.
> 
> The bug should show up on a completely idle machine after 49.7 days.
> cputime64_to_clock_t is broken. I'll post a patch shortly.

This patch should fix it:
--
Subject: [PATCH] cputime: fix overflow on 31 bit systems

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The cputime_to_msecs / cputime_to_clock_t and cputime64_to_clock_t
cause fixpoint divide exceptions if the cputime is too large.
On a machine that collected 49.7 days worth of idle time reading
from /proc/stat will generate oopses like this:

Kernel BUG at 001b0c92 [verbose debug info unavailable]
fixpoint divide exception: 0009 [#13] SMP
Modules linked in: ipv6
CPU: 1 Tainted: G      D   2.6.27.10 #5
Process cat (pid: 21352, task: 1fb34138, ksp: 1d2a3d98)
Krnl PSW : 070c2000 801b0c92 (show_stat+0x2ca/0x68c)
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:0 CC:2 PM:0
Krnl GPRS: 00000001 00001388 00000bb8 0015d2a1
           00000000 00000000 000003e8 0001fd91
           00000000 00000000 0000129d eecd2ff0
           1cc533b9 0036f780 801b0bce 1d2a3cc0
Krnl Code: 801b0c86: f18890abf198       mvo     171(9,%r9),408(9,%r15)
           801b0c8c: 98abf170           lm      %r10,%r11,368(%r15)
           801b0c90: 1da1               dr      %r10,%r1
          >801b0c92: 90abf170           stm     %r10,%r11,368(%r15)  
           801b0c96: 98abf190           lm      %r10,%r11,400(%r15)
           801b0c9a: 1da1               dr      %r10,%r1
           801b0c9c: 90abf190           stm     %r10,%r11,400(%r15)
           801b0ca0: 18a3               lr      %r10,%r3
Call Trace:
([<00000000001b09f4>] show_stat+0x2c/0x68c)
 [<000000000018dcee>] seq_read+0xb2/0x364
 [<00000000001a9980>] proc_reg_read+0x68/0x98
 [<00000000001705ee>] vfs_read+0x6e/0xe8
 [<0000000000170732>] sys_read+0x36/0x78
 [<000000000010f750>] sysc_do_restart+0x12/0x16
 [<0000000077f3ad6a>] 0x77f3ad6a
 <4>---[ end trace 1436ea9559d3de9e ]---

Reported-by: Mike Frysinger <vapier@gentoo.org>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/cputime.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/arch/s390/include/asm/cputime.h linux-2.6-patched/arch/s390/include/asm/cputime.h
--- linux-2.6/arch/s390/include/asm/cputime.h	2009-10-20 09:48:48.000000000 +0200
+++ linux-2.6-patched/arch/s390/include/asm/cputime.h	2009-10-20 09:48:56.000000000 +0200
@@ -78,7 +78,7 @@ cputime64_to_jiffies64(cputime64_t cputi
 static inline unsigned int
 cputime_to_msecs(const cputime_t cputime)
 {
-	return __div(cputime, 4096000);
+	return cputime_div(cputime, 4096000);
 }
 
 static inline cputime_t
@@ -160,7 +160,7 @@ cputime_to_timeval(const cputime_t cputi
 static inline clock_t
 cputime_to_clock_t(cputime_t cputime)
 {
-	return __div(cputime, 4096000000ULL / USER_HZ);
+	return cputime_div(cputime, 4096000000ULL / USER_HZ);
 }
 
 static inline cputime_t
@@ -175,7 +175,7 @@ clock_t_to_cputime(unsigned long x)
 static inline clock_t
 cputime64_to_clock_t(cputime64_t cputime)
 {
-       return __div(cputime, 4096000000ULL / USER_HZ);
+       return cputime_div(cputime, 4096000000ULL / USER_HZ);
 }
 
 struct s390_idle_data {
-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
