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
Date: Sun, 11 Feb 2018 22:22:04 +0100
Message-ID: <CAFkk2KQBCUT84rH22-+e6=hstQcdcpKQ7SM8=0SshrQ++vbMKg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, Arnd Bergmann <arnd@arndb.de>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Feb 11, 2018 at 6:56 PM, Kees Cook <keescook@chromium.org> wrote:
>> 3. Whether to implement CC_STACKPROTECTOR_AUTO in Kconfig or the Makefiles
>>
>> I'd just go with whatever is simplest here. I don't find the Kconfig version
>> too bad, but I'm already very familiar with Kconfig, so it's harder for me to
>> tell how it looks to other people.
>>
>> I'd add some comments to explain the idea in the final version.
>>
>> @Kees:
>> I was assuming that the Makefiles would error out with a message if none of the
>> CC_STACKPROTECTOR_* variables are set, in addition to the Kconfig warning.
>
> That doesn't happy either before nor after _AUTO. The default value
> before was _NONE, and the default value after is _AUTO, which will use
> whatever is available.

I was thinking in the case where you explicitly select one of
CC_STACKPROTECTOR_{STRONG,REGULAR} and it isn't available. With the
new WANT_* version, that will cause none of
CC_STACKPROTECTOR_{STRONG,REGULAR,NONE} to be set, and in that case
you'd error out to match the old behavior (if I understand it
correctly).

CHOSEN_CC_STACKPROTECTOR_AVAILABLE would just be a helper symbol to
detect that case. It's not like it's a huge deal to detect it on the
Makefile end either, but turns it pretty nice and readable, IMO, with
more of the logic in a single location.

>>         # User request
>>         WANT_CC_STACKPROTECTOR_AUTO
>>         WANT_CC_STACKPROTECTOR_STRONG
>>         WANT_CC_STACKPROTECTOR_REGULAR
>>         WANT_CC_STACKPROTECTOR_NONE
>>
>>         # The actual "output" to the Makefiles
>>         CC_STACKPROTECTOR_STRONG
>>         CC_STACKPROTECTOR_REGULAR
>>         CC_STACKPROTECTOR_NONE
>
> This should be fine too (though by this point, I think Kconfig would
> already know the specific option, so it could just pass it with a
> single output (CC_OPT_STACKPROTECTOR below?)

Ah, yeah, that'd be simpler if all that's needed is the compiler flag.

Cheers,
Ulf
