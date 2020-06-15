Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:56425 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgFOSrW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 15 Jun 2020 14:47:22 -0400
MIME-Version: 1.0
References: <20200615130032.931285-1-hch@lst.de> <20200615130032.931285-3-hch@lst.de>
 <CAK8P3a0bRD3RzE_X6Tjzu9Tj+OhHhP+S=k6+VYODBGko8oQhew@mail.gmail.com>
 <20200615141239.GA12951@lst.de> <CAMzpN2heSzZzg16ws3yQkd7YZwmPPx_4RFCpb9JYfFWJ9gfPhA@mail.gmail.com>
In-Reply-To: <CAMzpN2heSzZzg16ws3yQkd7YZwmPPx_4RFCpb9JYfFWJ9gfPhA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 15 Jun 2020 20:47:02 +0200
Message-ID: <CAK8P3a3q-hC7kZwLPbc+E5VYcqthQS4J4Rqo+rKkBRU2n071XA@mail.gmail.com>
Subject: Re: [PATCH 2/6] exec: simplify the compat syscall handling
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>, Luis Chamberlain <mcgrof@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, the arch/x86 maintainers <x86@kernel.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jun 15, 2020 at 4:48 PM Brian Gerst <brgerst@gmail.com> wrote:
> On Mon, Jun 15, 2020 at 10:13 AM Christoph Hellwig <hch@lst.de> wrote:
> > On Mon, Jun 15, 2020 at 03:31:35PM +0200, Arnd Bergmann wrote:

> >
> > I'd rather keep it in common code as that allows all the low-level
> > exec stuff to be marked static, and avoid us growing new pointless
> > compat variants through copy and paste.
> > smart compiler to d
> >
> > > I don't really understand
> > > the comment, why can't this just use this?
> >
> > That errors out with:
> >
> > ld: arch/x86/entry/syscall_x32.o:(.rodata+0x1040): undefined reference to
> > `__x32_sys_execve'
> > ld: arch/x86/entry/syscall_x32.o:(.rodata+0x1108): undefined reference to
> > `__x32_sys_execveat'
> > make: *** [Makefile:1139: vmlinux] Error 1
>
> I think I have a fix for this, by modifying the syscall wrappers to
> add an alias for the __x32 variant to the native __x64_sys_foo().
> I'll get back to you with a patch.

Do we actually need the __x32 prefix any more, or could we just
change all x32 specific calls to use __x64_compat_sys_foo()?

      Arnd
