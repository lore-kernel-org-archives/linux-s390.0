Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180709175550.GA7469@roeck-us.net>
References: <20180709175550.GA7469@roeck-us.net>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 9 Jul 2018 11:06:02 -0700
Message-ID: <CAGXu5j+rn+69QiLR=Rbd6ys7atL8Z8THyazW_T3Z=CAw0n8xzg@mail.gmail.com>
Subject: Re: Build/qemu test results for v4.18-rc4
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linus Torvalds <torvalds@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jul 9, 2018 at 10:55 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> s390:allmodconfig:
>
> arch/s390/kernel/als.o: In function `verify_facilities':
> als.c:(.init.text+0x24): undefined reference to `latent_entropy'
> als.c:(.init.text+0xae): undefined reference to `latent_entropy'
> make[3]: *** [arch/s390/boot/compressed/vmlinux] Error 1
> make[2]: *** [arch/s390/boot/compressed/vmlinux] Error 2
> make[1]: *** [bzImage] Error 2
>
> This problem is only seen when using a compiler which has the relevant
> plugins enabled. Bisect points to commit 1658dcee3d43ed ("gcc-plugins:
> allow to enable GCC_PLUGINS for COMPILE_TEST") as the culprit. I don't
> know if a fix for v4.18 has been submitted. The s390 boot code in -next
> has been rearranged and the problem is no longer seen there.

Hm, that would imply that mm/page_alloc.o wasn't visible during the
als.o linking? But ... if the problem is gone, I guess... good?

-Kees

-- 
Kees Cook
Pixel Security
