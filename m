Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CA+55aFz3gUKQMr-X-b=ytLPX0AjGUaXNtLSUQ0_xZwZuDU33RQ@mail.gmail.com>
References: <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
 <CA+55aFz3gUKQMr-X-b=ytLPX0AjGUaXNtLSUQ0_xZwZuDU33RQ@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Sun, 11 Feb 2018 11:39:11 -0800
Message-ID: <CAGXu5jLV-i5OAbXMQiJC-idXB+XrxMCC+RigQ+4R6eZWqn4rgg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, Arnd Bergmann <arnd@arndb.de>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Feb 11, 2018 at 10:13 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sun, Feb 11, 2018 at 9:56 AM, Kees Cook <keescook@chromium.org> wrote:
>>
>>>     - How common are those broken compilers?
>>
>> I *thought* it was rare (i.e. gcc 4.2) but while working on ..._AUTO I
>> found breakage in akpm's 4.4 gcc, and all of Arnd's gccs due to some
>> very strange misconfiguration between the gcc build environment and
>> other options. So, it turns out this is unfortunately common. The good
>> news is that it does NOT appear to happen with most distro compilers,
>> though I've seen Android's compiler regress the global vs %gs at least
>> once about a year ago.
>
> Hmm. Ok, so it's not *that* common, and won't affect normal people.
>
> That actually sounds like we could just
>
>  (a) make gcc 4.5 be the minimum required version

I love bumping minimum for so many reason more than just stack protector. :)

>  (b) actually error out if we find a bad compiler

This made akpm and Arnd very very grumpy as it regressed their builds.
That's why I had to deal with the condition very carefully for _AUTO.

> Upgrading the minimum required gcc version to 4.5 is pretty much going
> to happen _anyway_, because we're starting to rely on "asm goto" for
> avoiding speculation.
>
> End result: maybe we can make the configuration phase just use the
> standard "does gcc support this flag" logic, and then just have a
> separate script that is run to validate that gcc doesn't generate
> garbage, and error out loudly if it does.

While it was entirely done in Makefile before, this is what we have
now (except no build failure in _AUTO mode). I think it'd be great to
push as much as possible into Kconfig, though.

One difference between what we have now and this proposal is that
right now, "best available option" detection includes the output test,
which means if you have a broken compiler you get a warning but the
build proceeds with "none" selected. If we only do flag detection,
then the build will fail during the make since the output is bad
(instead of fixing the flag to "none" and just warning).

-Kees

-- 
Kees Cook
Pixel Security
