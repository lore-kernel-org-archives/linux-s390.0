Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20200615130032.931285-1-hch@lst.de> <20200615130032.931285-3-hch@lst.de>
 <CAK8P3a0bRD3RzE_X6Tjzu9Tj+OhHhP+S=k6+VYODBGko8oQhew@mail.gmail.com>
 <20200615141239.GA12951@lst.de> <CAK8P3a2MeZhayZWkPbd4Ckq3n410p_n808NJTwN=JjzqHRiAXg@mail.gmail.com>
 <20200615144310.GA15101@lst.de> <CAK8P3a17h782gO65qJ9Mmz0EuiTSKQPEyr_=nvqOtnmQZuh9Kw@mail.gmail.com>
 <20200615150926.GA17108@lst.de>
In-Reply-To: <20200615150926.GA17108@lst.de>
From: Brian Gerst <brgerst@gmail.com>
Date: Mon, 15 Jun 2020 11:33:49 -0400
Message-ID: <CAMzpN2htYX7s6pmRg-c8qwZL1f1_+sB=ztDG_L=617hWsm-=8g@mail.gmail.com>
Subject: Re: [PATCH 2/6] exec: simplify the compat syscall handling
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>, Luis Chamberlain <mcgrof@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, the arch/x86 maintainers <x86@kernel.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jun 15, 2020 at 11:10 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jun 15, 2020 at 04:46:15PM +0200, Arnd Bergmann wrote:
> > How about this one:
> >
> > diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.=
c
> > index 3d8d70d3896c..0ce15807cf54 100644
> > --- a/arch/x86/entry/syscall_x32.c
> > +++ b/arch/x86/entry/syscall_x32.c
> > @@ -16,6 +16,9 @@
> >  #undef __SYSCALL_X32
> >  #undef __SYSCALL_COMMON
> >
> > +#define __x32_sys_execve __x64_sys_execve
> > +#define __x32_sys_execveat __x64_sys_execveat
> > +
>
>
> arch/x86/entry/syscall_x32.c:19:26: error: =E2=80=98__x64_sys_execve=E2=
=80=99 undeclared here (not in a function); did you mean =E2=80=98__x32_sys=
_execve=E2=80=99?
>    19 | #define __x32_sys_execve __x64_sys_execve
>       |                          ^~~~~~~~~~~~~~~~
> arch/x86/entry/syscall_x32.c:22:39: note: in expansion of macro =E2=80=98=
__x32_sys_execve=E2=80=99
>    22 | #define __SYSCALL_X32(nr, sym) [nr] =3D __x32_##sym,
>       |                                       ^~~~~~
> ./arch/x86/include/generated/asm/syscalls_64.h:344:1: note: in expansion =
of macro =E2=80=98__SYSCALL_X32=E2=80=99
>   344 | __SYSCALL_X32(520, sys_execve)
>       | ^~~~~~~~~~~~~
> arch/x86/entry/syscall_x32.c:20:28: error: =E2=80=98__x64_sys_execveat=E2=
=80=99 undeclared here (not in a function); did you mean =E2=80=98__x32_sys=
_execveat=E2=80=99?
>    20 | #define __x32_sys_execveat __x64_sys_execveat
>       |                            ^~~~~~~~~~~~~~~~~~
> arch/x86/entry/syscall_x32.c:22:39: note: in expansion of macro =E2=80=98=
__x32_sys_execveat=E2=80=99
>    22 | #define __SYSCALL_X32(nr, sym) [nr] =3D __x32_##sym,
>       |                                       ^~~~~~
> ./arch/x86/include/generated/asm/syscalls_64.h:369:1: note: in expansion =
of macro =E2=80=98__SYSCALL_X32=E2=80=99
>   369 | __SYSCALL_X32(545, sys_execveat)
>       | ^~~~~~~~~~~~~
> make[2]: *** [scripts/Makefile.build:281: arch/x86/entry/syscall_x32.o] E=
rror 1
> make[1]: *** [scripts/Makefile.build:497: arch/x86/entry] Error 2
> make[1]: *** Waiting for unfinished jobs....
> kernel/exit.o: warning: objtool: __x64_sys_exit_group()+0x14: unreachable=
 instruction
> make: *** [Makefile:1764: arch/x86] Error 2
> make: *** Waiting for unfinished jobs....

If you move those aliases above all the __SYSCALL_* defines it will
work, since that will get the forward declaration too.  This would be
the simplest workaround.

--
Brian Gerst
