Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 9 Jul 2018 11:30:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Build/qemu test results for v4.18-rc4
Message-ID: <20180709183053.GB31159@roeck-us.net>
References: <20180709175550.GA7469@roeck-us.net>
 <CAGXu5j+rn+69QiLR=Rbd6ys7atL8Z8THyazW_T3Z=CAw0n8xzg@mail.gmail.com>
 <3207f3de-0a10-f575-f24f-210a2a926c4c@de.ibm.com>
 <CAGXu5jKyESyPD1MyM7BrVFPKDY9+HqRCpXcKG5ikCZwdGZLaSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKyESyPD1MyM7BrVFPKDY9+HqRCpXcKG5ikCZwdGZLaSw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linus Torvalds <torvalds@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jul 09, 2018 at 11:19:17AM -0700, Kees Cook wrote:
> On Mon, Jul 9, 2018 at 11:16 AM, Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
> >
> >
> > On 07/09/2018 08:06 PM, Kees Cook wrote:
> >> On Mon, Jul 9, 2018 at 10:55 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> >>> s390:allmodconfig:
> >>>
> >>> arch/s390/kernel/als.o: In function `verify_facilities':
> >>> als.c:(.init.text+0x24): undefined reference to `latent_entropy'
> >>> als.c:(.init.text+0xae): undefined reference to `latent_entropy'
> >>> make[3]: *** [arch/s390/boot/compressed/vmlinux] Error 1
> >>> make[2]: *** [arch/s390/boot/compressed/vmlinux] Error 2
> >>> make[1]: *** [bzImage] Error 2
> >>>
> >>> This problem is only seen when using a compiler which has the relevant
> >>> plugins enabled. Bisect points to commit 1658dcee3d43ed ("gcc-plugins:
> >>> allow to enable GCC_PLUGINS for COMPILE_TEST") as the culprit. I don't
> >>> know if a fix for v4.18 has been submitted. The s390 boot code in -next
> >>> has been rearranged and the problem is no longer seen there.
> >>
> >> Hm, that would imply that mm/page_alloc.o wasn't visible during the
> >> als.o linking? But ... if the problem is gone, I guess... good?
> >
> > als.o is used to detect if the kernel was compiled for a newer generation
> > than the hardware that we are running on (very early). So it is compiled
> > without gcov, kcov,ubsan and with a different march -in other words special.
> > In linux-next we moved the als part to the decompressor which avoids all
> > these kind of special handling. As this is part of a bigger patch set it
> > would be  non-trivial to backport that for 4.18.
> > So unless we want to have it fixed for 4.18 I think we are fine.
> 
> Okay, cool. If you want to fix it for 4.18, it should just be
> something like this in the Makefile:
> 
> CFLAGS_als.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
> 

Yes, I confirmed that this fixes the problem.

Thanks,
Guenter
