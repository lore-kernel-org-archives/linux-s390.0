Return-Path: <mhocko@kernel.org>
Date: Thu, 22 Feb 2018 14:07:38 +0100
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: samples/seccomp/ broken when cross compiling s390, ppc
 allyesconfig
Message-ID: <20180222130738.GG30681@dhcp22.suse.cz>
References: <20180212133731.GE3443@dhcp22.suse.cz>
 <87r2ppvaeq.fsf@concordia.ellerman.id.au>
 <CAGXu5j+DnkUv9pZn93wxA6_2s+c3Ap_Q34OR0weY7Y9MJ1aP9Q@mail.gmail.com>
 <87d1192nzc.fsf@concordia.ellerman.id.au>
 <20180213103213.GP3443@dhcp22.suse.cz>
 <CAGXu5jJZROQMxzxu+Dp3mVMktSg-oTB6pqk7fUyM_6_2oa9c_A@mail.gmail.com>
 <20180214092045.GZ3443@dhcp22.suse.cz>
 <CAGXu5jJCN_Js9rvM4RMjxDCDd4tVzWDo-jdnFiZs1D9e3cunrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <CAGXu5jJCN_Js9rvM4RMjxDCDd4tVzWDo-jdnFiZs1D9e3cunrw@mail.gmail.com>
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

On Wed 14-02-18 09:14:47, Kees Cook wrote:
[...]
> I can send it through my seccomp tree via James Morris.

Could you please do it?

> >
> > From 8d8457e96296538508e478f598d1c8b3406a8626 Mon Sep 17 00:00:00 2001
> > From: Michal Hocko <mhocko@suse.com>
> > Date: Wed, 14 Feb 2018 10:15:12 +0100
> > Subject: [PATCH] samples/seccomp: do not compile when cross compiled
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=UTF-8
> > Content-Transfer-Encoding: 8bit
> >
> > samples/seccomp relies on the host setting which is not suitable for
> > crosscompilation and it actually fails when crosscompiling s390 and
> > powerpc all{yes,mod}config on x86_64 with
> >
> > samples/seccomp/bpf-helper.h:135:2: error: #error __BITS_PER_LONG value unusable.
> >  #error __BITS_PER_LONG value unusable.
> >   ^
> > In file included from samples/seccomp/bpf-fancy.c:13:0:
> > samples/seccomp/bpf-fancy.c: In function ‘main’:
> > samples/seccomp/bpf-fancy.c:38:11: error: ‘__NR_exit’ undeclared (first use in this function)
> >    SYSCALL(__NR_exit, ALLOW),
> >
> > and many others. I am doing these for compile testing and it's been
> > quite useful to catch issues. Crosscompiling sample code on the other
> > hand doesn't seem all that important so it seems like the easiest way to
> > simply disable samples/seccomp when crosscompiling.
> >
> > Fixing this properly is not that easy as Kees explains:
> > : IIRC, one of the problems is with build ordering problems: the kernel
> > : headers used by the samples aren't available when cross compiling.
> >
> > Acked-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  samples/seccomp/Makefile | 10 +---------
> >  1 file changed, 1 insertion(+), 9 deletions(-)
> >
> > diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
> > index 0e349b80686e..ba942e3ead89 100644
> > --- a/samples/seccomp/Makefile
> > +++ b/samples/seccomp/Makefile
> > @@ -1,4 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > +ifndef CROSS_COMPILE
> >  hostprogs-$(CONFIG_SAMPLE_SECCOMP) := bpf-fancy dropper bpf-direct
> >
> >  HOSTCFLAGS_bpf-fancy.o += -I$(objtree)/usr/include
> > @@ -16,7 +17,6 @@ HOSTCFLAGS_bpf-direct.o += -idirafter $(objtree)/include
> >  bpf-direct-objs := bpf-direct.o
> >
> >  # Try to match the kernel target.
> > -ifndef CROSS_COMPILE
> >  ifndef CONFIG_64BIT
> >
> >  # s390 has -m31 flag to build 31 bit binaries
> > @@ -35,12 +35,4 @@ HOSTLOADLIBES_bpf-fancy += $(MFLAG)
> >  HOSTLOADLIBES_dropper += $(MFLAG)
> >  endif
> >  always := $(hostprogs-m)
> > -else
> > -# MIPS system calls are defined based on the -mabi that is passed
> > -# to the toolchain which may or may not be a valid option
> > -# for the host toolchain. So disable tests if target architecture
> > -# is MIPS but the host isn't.
> > -ifndef CONFIG_MIPS
> > -always := $(hostprogs-m)
> > -endif
> >  endif
> > --
> > 2.15.1
> >
> > --
> > Michal Hocko
> > SUSE Labs
> 
> 
> 
> -- 
> Kees Cook
> Pixel Security

-- 
Michal Hocko
SUSE Labs
