Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQpS6dYBnt_PjL5zrX1=eccSg80khu=WYCjnHNvDiKa3w@mail.gmail.com>
References: <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
 <CAK7LNAQpS6dYBnt_PjL5zrX1=eccSg80khu=WYCjnHNvDiKa3w@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 12 Feb 2018 07:24:45 -0800
Message-ID: <CAGXu5j+7kv=jrg2u7jaxFEXwHoyzDXP_jyKHYA682_BrYuHwQQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, Arnd Bergmann <arnd@arndb.de>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Feb 12, 2018 at 6:39 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-02-12 2:56 GMT+09:00 Kees Cook <keescook@chromium.org>:
>> I think it would work to skip KBUILD_CPPFLAGS right up until it
>> didn't. Since we have the arch split, we can already add -m32 to the
>> 32-bit case, etc. However, I worry about interaction with other
>> selected build options. For example, while retpoline doesn't interact
>> stack-protector, it's easy to imagine things that might.

I want to be sure I clarify: I'm not aware of any negative interaction
between stack-protector and other options at present. I was just
trying to think of an illustrative example. I do know we're about to
get some per-architecture stack protector options (e.g. arm64 using a
per-process canary instead of global), but I *think* that can be
handled in the new Kconfig too.

> One ugly solution could be
> to add one more CC_HAS_ for the combination of the two ?

Yeah, that seems reasonable, but it's a fix after the fact. I guess
we'll have to see.

>> (And in thinking about this, does Kconfig know the true $CC in use?
>> i.e. the configured cross compiler, etc?)
>
> I was thinking of removing CONFIG_CROSS_COMPILE.
>
> A user can dynamically change CROSS_COMPILE from
> "make menuconfig".

Most builds I've seen implement cross compilers as an environment
variable during all "make" invocations.

> If we continue to support this, $CC changes
> according to CONFIG_CROSS_COMPILE.
> Then, compiler flags must be re-evaluated
> every time a user changes a compiler in use.
> It will introduce much more complexity.

Right now, this is just handled in the Makefile: all the right
variables exist, etc.

-Kees

-- 
Kees Cook
Pixel Security
