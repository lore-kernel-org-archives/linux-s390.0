Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20200615130032.931285-1-hch@lst.de> <20200615130032.931285-3-hch@lst.de>
 <CAK8P3a0bRD3RzE_X6Tjzu9Tj+OhHhP+S=k6+VYODBGko8oQhew@mail.gmail.com>
 <20200615141239.GA12951@lst.de> <CAK8P3a2MeZhayZWkPbd4Ckq3n410p_n808NJTwN=JjzqHRiAXg@mail.gmail.com>
 <20200615144310.GA15101@lst.de>
In-Reply-To: <20200615144310.GA15101@lst.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 15 Jun 2020 16:46:15 +0200
Message-ID: <CAK8P3a17h782gO65qJ9Mmz0EuiTSKQPEyr_=nvqOtnmQZuh9Kw@mail.gmail.com>
Subject: Re: [PATCH 2/6] exec: simplify the compat syscall handling
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Luis Chamberlain <mcgrof@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, the arch/x86 maintainers <x86@kernel.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jun 15, 2020 at 4:43 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jun 15, 2020 at 04:40:28PM +0200, Arnd Bergmann wrote:
> > > ld: arch/x86/entry/syscall_x32.o:(.rodata+0x1040): undefined reference to
> > > `__x32_sys_execve'
> > > ld: arch/x86/entry/syscall_x32.o:(.rodata+0x1108): undefined reference to
> > > `__x32_sys_execveat'
> > > make: *** [Makefile:1139: vmlinux] Error 1
> >
> > Ah, I see: it's marked x32-only, so arch/x86/entry/syscall_x32.c
> > uses the __x32 prefix instead of the __x64 one. Marking it 'common'
> > instead would make it work, but also create an extra entry point
> > for native processes, something that commit
> > 6365b842aae4 ("x86/syscalls: Split the x32 syscalls into their own table")
> > was trying to avoid.
>
> Marking it common also doesn't compile at all because __NR_execve
> and __NR_execveat get redefined in unistd_64.h.  I then tried to rename
> the x32 versions, which failed in yet another way.  At that point I gave
> up instead of digging myself into a deeper hole..

How about this one:

diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index 3d8d70d3896c..0ce15807cf54 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -16,6 +16,9 @@
 #undef __SYSCALL_X32
 #undef __SYSCALL_COMMON

+#define __x32_sys_execve __x64_sys_execve
+#define __x32_sys_execveat __x64_sys_execveat
+
 #define __SYSCALL_X32(nr, sym) [nr] = __x32_##sym,
 #define __SYSCALL_COMMON(nr, sym) [nr] = __x64_##sym,

Still ugly, but much simpler and more localized (if it works).

        Arnd
