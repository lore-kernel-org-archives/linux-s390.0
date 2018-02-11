Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
References: <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Sun, 11 Feb 2018 19:34:34 +0100
Message-ID: <CAFkk2KRAjA80Y74Nahf2Nk_5yOucoa1y2Xp54F2k-Hv0xgTAFg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, Arnd Bergmann <arnd@arndb.de>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Feb 11, 2018 at 6:56 PM, Kees Cook <keescook@chromium.org> wrote:
> Old? That's not the case. The check for -fno-stack-protector will
> likely be needed forever, as some distro compilers enable
> stack-protector by default. So when someone wants to explicitly build
> without stack-protector (or if the compiler's stack-protector is
> detected as broken), we must force it off for the kernel build.

What I meant is whether it makes sense to test if the
-fno-stack-protector option is supported. Can we reasonably assume
that passing -fno-stack-protector to the compiler won't cause an
error?

Is it possible to build GCC with no "no stack protector" support? Do
we need to support any compilers that would choke on the
-fno-stack-protector flag itself?

If we can reasonably assume that passing -fno-stack-protector is safe,
then CC_HAS_STACKPROTECTOR_NONE isn't needed.

Cheers,
Ulf
