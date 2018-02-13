Return-Path: <mhocko@kernel.org>
Date: Tue, 13 Feb 2018 09:59:28 +0100
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: samples/seccomp/ broken when cross compiling s390, ppc
 allyesconfig
Message-ID: <20180213085928.GK3443@dhcp22.suse.cz>
References: <20180212133731.GE3443@dhcp22.suse.cz>
 <87r2ppvaeq.fsf@concordia.ellerman.id.au>
 <CAGXu5j+DnkUv9pZn93wxA6_2s+c3Ap_Q34OR0weY7Y9MJ1aP9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGXu5j+DnkUv9pZn93wxA6_2s+c3Ap_Q34OR0weY7Y9MJ1aP9Q@mail.gmail.com>
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

On Mon 12-02-18 21:54:39, Kees Cook wrote:
> On Mon, Feb 12, 2018 at 7:25 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > Michal Hocko <mhocko@kernel.org> writes:
> >> Hi,
> >> my build test machinery chokes on samples/seccomp when cross compiling
> >> s390 and ppc64 allyesconfig. This has been the case for quite some
> >> time already but I never found time to look at the problem and report
> >> it. It seems this is not new issue and similar thing happend for
> >> MIPS e9107f88c985 ("samples/seccomp/Makefile: do not build tests if
> >> cross-compiling for MIPS").
> >>
> >> The build logs are attached.
> >>
> >> What is the best way around this? Should we simply skip compilation on
> >> cross compile or is actually anybody relying on that? Or should I simply
> >> disable it for s390 and ppc?
> >
> > The whole thing seems very confused. It's not building for the target,
> > it's building for the host, ie. the Makefile sets hostprogs-m and
> > HOSTCFLAGS etc.
> >
> > So it can't possibly work with cross compiling as it's currently
> > written.
> >
> > Either the Makefile needs some serious work to properly support cross
> > compiling or it should just be disabled when cross compiling.
> 
> Hrm, yeah, the goal was to entirely disable cross compiling, but I
> guess we didn't hit it with a hard enough hammer. :)

Hammer like this?

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
Michal Hocko
SUSE Labs
