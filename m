Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
 <1518106752-29228-5-git-send-email-yamada.masahiro@socionext.com>
 <20180209053038.pscoijvowmyudyzf@huvuddator> <CAK7LNATRxYCx9sE1haw815votyA5K8GQrMPPh0Q+n3kYa=JsgA@mail.gmail.com>
 <20180209124607.akjhncb5sempjqcn@huvuddator> <CAGXu5j+hv6G3m+fgr7ibXAnoE-2GsxtXoqr0pd5AaaNdFVQxYg@mail.gmail.com>
 <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com> <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 10 Feb 2018 23:28:45 -0800
Message-ID: <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sat, Feb 10, 2018 at 8:46 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Argh. I wanted to get rid of all that entirely, and simplify this all.
> The mentioned script (and bugzilla) was from 2006, I assumed this was
> all historical.
>
> But if it has broken again since, I guess we need to have a silly script. Grr.

Ok, so this really ended up bothering me.

I was hoping to really just unify all the stupid compiler flag testing
in just the Kconfig files and hoping we could really just use

    config CC_xyz
        bool
        option cc_option "-fwhatever-xyz"

to set them, and then build Kconfig rules from that:

    config USE_xyz
        bool "Some question that needs xyz"
        depends on CC_xyz

and have a nice simple

    ccflags-$(CONFIG_USE_xyz) += -fwhataver-xyz

in the Makefiles.

And one thought I had was "hey, if we need a script for
-fstack-protector, maybe we can simply standardize on _everything_
using a script".

But doing the stats, we test about two _hundred_  different compiler
options, and it really looks like -fstack-protector is the _only_ one
that uses a dedicated script. Everything else is just using the "see
if the compiler accepts the flag". So no, we wouldn't want to
standardize around a script.

We do have a script for some other build options related to gcc
breakage, but not command line flags per se: both 'asm goto' and for
gcc version generation. And gcc plugin compatibility checking.

Oh well. It looks like we really have to have those nasty exceptions
from the normal rules.

                 Linus
