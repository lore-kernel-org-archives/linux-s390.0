Return-Path: <mhocko@kernel.org>
Date: Wed, 14 Feb 2018 10:20:45 +0100
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: samples/seccomp/ broken when cross compiling s390, ppc
 allyesconfig
Message-ID: <20180214092045.GZ3443@dhcp22.suse.cz>
References: <20180212133731.GE3443@dhcp22.suse.cz>
 <87r2ppvaeq.fsf@concordia.ellerman.id.au>
 <CAGXu5j+DnkUv9pZn93wxA6_2s+c3Ap_Q34OR0weY7Y9MJ1aP9Q@mail.gmail.com>
 <87d1192nzc.fsf@concordia.ellerman.id.au>
 <20180213103213.GP3443@dhcp22.suse.cz>
 <CAGXu5jJZROQMxzxu+Dp3mVMktSg-oTB6pqk7fUyM_6_2oa9c_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <CAGXu5jJZROQMxzxu+Dp3mVMktSg-oTB6pqk7fUyM_6_2oa9c_A@mail.gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Kees Cook <keescook@chromium.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Will Drewry <wad@chromium.org>, linux-s390 <linux-s390@vger.kernel.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>
Content-Transfer-Encoding: 8bit

On Tue 13-02-18 13:27:30, Kees Cook wrote:
> On Tue, Feb 13, 2018 at 2:32 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > On Tue 13-02-18 21:16:55, Michael Ellerman wrote:
> >> Kees Cook <keescook@chromium.org> writes:
> >>
> >> > On Mon, Feb 12, 2018 at 7:25 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> >> >> Michal Hocko <mhocko@kernel.org> writes:
> >> >>> Hi,
> >> >>> my build test machinery chokes on samples/seccomp when cross compiling
> >> >>> s390 and ppc64 allyesconfig. This has been the case for quite some
> >> >>> time already but I never found time to look at the problem and report
> >> >>> it. It seems this is not new issue and similar thing happend for
> >> >>> MIPS e9107f88c985 ("samples/seccomp/Makefile: do not build tests if
> >> >>> cross-compiling for MIPS").
> >> >>>
> >> >>> The build logs are attached.
> >> >>>
> >> >>> What is the best way around this? Should we simply skip compilation on
> >> >>> cross compile or is actually anybody relying on that? Or should I simply
> >> >>> disable it for s390 and ppc?
> >> >>
> >> >> The whole thing seems very confused. It's not building for the target,
> >> >> it's building for the host, ie. the Makefile sets hostprogs-m and
> >> >> HOSTCFLAGS etc.
> >> >>
> >> >> So it can't possibly work with cross compiling as it's currently
> >> >> written.
> >> >>
> >> >> Either the Makefile needs some serious work to properly support cross
> >> >> compiling or it should just be disabled when cross compiling.
> >> >
> >> > Hrm, yeah, the goal was to entirely disable cross compiling, but I
> >> > guess we didn't hit it with a hard enough hammer. :)
> >>
> >> Do you know why it is written that way? Why doesn't it just try to cross
> >> compile like normal code?
> >
> > No idea, sorry. All I know about this code is that it breaks my build
> > testing.
> 
> IIRC, one of the problems is with build ordering problems: the kernel
> headers used by the samples aren't available when cross compiling.
> 
> I'm happy to kill it entirely with Michal's patch, though. Feel free
> to carry in your tree!
> 
> Acked-by: Kees Cook <keescook@chromium.org>

OK, so let's try to nuke it. How should I route this patch?

From 8d8457e96296538508e478f598d1c8b3406a8626 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Wed, 14 Feb 2018 10:15:12 +0100
Subject: [PATCH] samples/seccomp: do not compile when cross compiled
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

samples/seccomp relies on the host setting which is not suitable for
crosscompilation and it actually fails when crosscompiling s390 and
powerpc all{yes,mod}config on x86_64 with

samples/seccomp/bpf-helper.h:135:2: error: #error __BITS_PER_LONG value unusable.
 #error __BITS_PER_LONG value unusable.
  ^
In file included from samples/seccomp/bpf-fancy.c:13:0:
samples/seccomp/bpf-fancy.c: In function ‘main’:
samples/seccomp/bpf-fancy.c:38:11: error: ‘__NR_exit’ undeclared (first use in this function)
   SYSCALL(__NR_exit, ALLOW),

and many others. I am doing these for compile testing and it's been
quite useful to catch issues. Crosscompiling sample code on the other
hand doesn't seem all that important so it seems like the easiest way to
simply disable samples/seccomp when crosscompiling.

Fixing this properly is not that easy as Kees explains:
: IIRC, one of the problems is with build ordering problems: the kernel
: headers used by the samples aren't available when cross compiling.

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 samples/seccomp/Makefile | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
index 0e349b80686e..ba942e3ead89 100644
--- a/samples/seccomp/Makefile
+++ b/samples/seccomp/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+ifndef CROSS_COMPILE
 hostprogs-$(CONFIG_SAMPLE_SECCOMP) := bpf-fancy dropper bpf-direct
 
 HOSTCFLAGS_bpf-fancy.o += -I$(objtree)/usr/include
@@ -16,7 +17,6 @@ HOSTCFLAGS_bpf-direct.o += -idirafter $(objtree)/include
 bpf-direct-objs := bpf-direct.o
 
 # Try to match the kernel target.
-ifndef CROSS_COMPILE
 ifndef CONFIG_64BIT
 
 # s390 has -m31 flag to build 31 bit binaries
@@ -35,12 +35,4 @@ HOSTLOADLIBES_bpf-fancy += $(MFLAG)
 HOSTLOADLIBES_dropper += $(MFLAG)
 endif
 always := $(hostprogs-m)
-else
-# MIPS system calls are defined based on the -mabi that is passed
-# to the toolchain which may or may not be a valid option
-# for the host toolchain. So disable tests if target architecture
-# is MIPS but the host isn't.
-ifndef CONFIG_MIPS
-always := $(hostprogs-m)
-endif
 endif
-- 
2.15.1

-- 
Michal Hocko
SUSE Labs
