Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
 <1518106752-29228-5-git-send-email-yamada.masahiro@socionext.com>
 <20180209053038.pscoijvowmyudyzf@huvuddator> <CAK7LNATRxYCx9sE1haw815votyA5K8GQrMPPh0Q+n3kYa=JsgA@mail.gmail.com>
 <20180209124607.akjhncb5sempjqcn@huvuddator> <CAGXu5j+hv6G3m+fgr7ibXAnoE-2GsxtXoqr0pd5AaaNdFVQxYg@mail.gmail.com>
 <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 10 Feb 2018 20:13:31 -0800
Message-ID: <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sat, Feb 10, 2018 at 12:08 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sat, Feb 10, 2018 at 11:23 AM, Kees Cook <keescook@chromium.org> wrote:
>>
>> So, if this could do something like this:
>>
>>         config CC_HAS_STACKPROTECTOR_STRONG
>>                 bool
>>                 option
>> shell="scripts/gcc-${ARCH}_${BITS}-has-stack-protector.sh $CC
>> $KBUILD_CPPFLAGS"
>
> Guys, this is not that important.
>
> Don't make some stupid script for stackprotector. If the user doesn't
> have a gcc that supports -fstackprotector-*, then don't show the
> options. It matters NOT ONE WHIT whether that then means that
> stackprotector will be off by default later.

What? Maybe you're misunderstanding the script? This script already exists:

$ ls scripts/gcc-x86_*
scripts/gcc-x86_32-has-stack-protector.sh
scripts/gcc-x86_64-has-stack-protector.sh

It's been there since the very beginning when Arjan added it to
validate that the compiler actually produces a stack protector when
you give it -fstack-protector. Older gccs broke this entirely, more
recent misconfigurations (as seen with some of Arnd's local gcc
builds) did similar, and there have been regressions in some versions
where gcc's x86 support flipped to the global canary instead of the
%gs-offset canary.

> Seriously. This is classic "Kees thinks that _his_ code is so
> important that everybody should get the value _he_ cares about".

I care about the kernel build informing people about what's gone wrong
as early as possible instead of producing an unbootable image that
takes forever to debug.

-Kees

-- 
Kees Cook
Pixel Security
