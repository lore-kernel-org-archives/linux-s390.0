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
Date: Sun, 11 Feb 2018 21:29:30 +0100
Message-ID: <CAFkk2KSk_OpwagN_Ru0fHPyALK5HwtxHOcMhT8OHqeOH3hOP+w@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, Arnd Bergmann <arnd@arndb.de>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Feb 11, 2018 at 6:56 PM, Kees Cook <keescook@chromium.org> wrote:
> Another case I mentioned before that I just want to make sure we don't
> reintroduce the problem of getting "stuck" with a bad .config file.
> While adding _STRONG support, I discovered the two-phase Kconfig
> resolution that happens during the build. If you selected _STRONG with
> a strong-capable compiler, everything was fine. If you then tried to
> build with an older compiler, you'd get stuck since _STRONG wasn't
> support (as detected during the first Kconfig phase) so the
> generated/autoconf.h would never get updated with the newly selected
> _REGULAR). I moved the Makefile analysis of available stack-protector
> options into the second phase (i.e. after all the Kconfig runs), and
> that worked to both unstick such configs and provide a clear message
> early in the build about what wasn't available.
>
> If all this detection is getting moved up into Kconfig, I'm worried
> we'll end up in this state again. If the answer is "you have to delete
> autoconf.h if you change compilers", then that's fine, but it sure
> seems unfriendly. :)

Did you mean include/config/auto.conf? That's the one that gets
included by the Makefiles.

If the feature detection is moved into Kconfig, you should only need
to rerun the configuration (make menuconfig/oldconfig/olddefconfig) if
you change the compiler. That will update .config while taking the new
features into account, and then the second phase during 'make' will
update include/config/auto.conf from .config.

That second Kconfig phase generates include/generated/autoconf.h and
include/config/. The include/config/ directory implements dependencies
between source files and Kconfig symbols by turning the symbols into
(empty) files. When building (during the "second phase"), Kconfig
compares .config with include/config/auto.conf to see what changed,
and signals the changes to 'make' by touch'ing the files corresponding
to the changed symbols. The idea is to avoid having to do a full
rebuild whenever the configuration is changed.

Check out scripts/basic/fixdep.c as well if you want to understand how it works.

Cheers,
Ulf
