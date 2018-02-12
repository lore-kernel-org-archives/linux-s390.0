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
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 12 Feb 2018 23:39:29 +0900
Message-ID: <CAK7LNAQpS6dYBnt_PjL5zrX1=eccSg80khu=WYCjnHNvDiKa3w@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, Arnd Bergmann <arnd@arndb.de>
List-ID: <linux-s390.vger.kernel.org>

2018-02-12 2:56 GMT+09:00 Kees Cook <keescook@chromium.org>:

> I think it would work to skip KBUILD_CPPFLAGS right up until it
> didn't. Since we have the arch split, we can already add -m32 to the
> 32-bit case, etc. However, I worry about interaction with other
> selected build options. For example, while retpoline doesn't interact
> stack-protector, it's easy to imagine things that might.


One ugly solution could be
to add one more CC_HAS_ for the combination of the two ?


# If two compiler flags interact, the combination should be checked.
# Hopefully, we do not have many cases like this...
config CC_HAS_STACKPROTECTOR_WITH_RETPOLINE
       option cc_option "-fstackprotector  -mindirect-branch=thunk-extern"



> (And in thinking about this, does Kconfig know the true $CC in use?
> i.e. the configured cross compiler, etc?)


I was thinking of removing CONFIG_CROSS_COMPILE.

A user can dynamically change CROSS_COMPILE from
"make menuconfig".

If we continue to support this, $CC changes
according to CONFIG_CROSS_COMPILE.
Then, compiler flags must be re-evaluated
every time a user changes a compiler in use.
It will introduce much more complexity.

The easiest way would be to import $CC from environment
and fix the compiler capability before loading Kconfig.





>>     - How old do you need to go with GCC for -fno-stack-protector to give an
>>       error (i.e., for not even the option to be recognized)? Is it still
>>       warranted to test for it?
>
> Old? That's not the case. The check for -fno-stack-protector will
> likely be needed forever, as some distro compilers enable
> stack-protector by default. So when someone wants to explicitly build
> without stack-protector (or if the compiler's stack-protector is
> detected as broken), we must force it off for the kernel build.
>
>> Adding some CCs who worked on the stack protector test scripts.
>>
>> And yeah, I was assuming that needing support scripts would be rare, and that
>> you'd usually just check whether gcc accepts the flag.
>
> That would have been nice, yes. :(
>
>> When you Google "gcc broken stack protector", the top hits about are about the
>> scripts/gcc-x86_64-has-stack-protector.sh script in the kernel throwing a false
>> positive by the way (fixed in 82031ea29e45 ("scripts/has-stack-protector: add
>> -fno-PIE")).
>
> That's just the most recent case (from the case where some distro
> compilers enabled PIE by default). And was why I was hoping to drop
> the scripts entirely.
>
>> 2. Whether to hide the Kconfig stack protector alternatives or always show them
>>
>> Or equivalently, whether to automatically fall back on other stack protector
>> alternatives (including no stack protector) if the one specified in the .config
>> isn't available.
>>
>> I'll let you battle this one out. In any case, as a user, I'd want a
>> super-clear message telling me what to change if the build breaks because of
>> missing stack protector support.
>
> Yes, exactly.
>
> The reason I built the _AUTO support was to make this easier for
> people to not have to think about. I wanted to get rid of explicit
> support (i.e. _REGULAR or _STRONG) but some people didn't want _STRONG
> (since it has greater code-size impact than _REGULAR), so we've had to
> keep that too.
>
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
>
>> You could offload part of that check to Kconfig with something like
>>
>>         config CHOSEN_CC_STACKPROTECTOR_AVAILABLE
>>                 def_bool CC_STACKPROTECTOR_STRONG || \
>>                          CC_STACKPROTECTOR_REGULAR || \
>>                          CC_STACKPROTECTOR_NONE
>>
>> CHOSEN_STACKPROTECTOR_AVAILABLE could then be checked in the Makefile.
>> It has the advantage of making the constraint clear in the Kconfig file
>> at least.
>>
>> You could add some kind of assert feature to Kconfig too, but IMO it's not
>> warranted purely for one-offs like this at least.
>
> Agreed; I want to do whatever we can to simplify things. :)
>
>> That's details though. I'd want to explain it with a comment in any case if we
>> go with something like this, since it's slightly kludgy and subtle
>> (CC_STACKPROTECTOR_{STRONG,REGULAR,NONE} form a kind of choice, only you can't
>> express it like that directly, since it's derived from other symbols).
>>
>>
>> Here's an overview of the current Kconfig layout by the way, assuming
>> the old no-fallback behavior and CC_STACKPROTECTOR_AUTO being
>> implemented in Kconfig:
>>
>>         # Feature tests
>>         CC_HAS_STACKPROTECTOR_STRONG
>>         CC_HAS_STACKPROTECTOR_REGULAR
>>         CC_HAS_STACKPROTECTOR_NONE
>
> As long as the feature tests include actual compiler output tests,
> yeah, this seems fine.
>
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
>
>>         # Some possible output "nicities"
>>         CHOSEN_CC_STACKPROTECTOR_AVAILABLE
>>         CC_OPT_STACKPROTECTOR
>>
>> Does anyone have objections to the naming or other things? I saw some
>> references to "Santa's wish list" in messages of commits that dealt with other
>> variables named WANT_*, though I didn't look into those cases. ;)
>
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
>

As Ulf explained, this does not happen.

include/config/auto.conf and include/generated/autoconf.h
are the mirror of the .config.

If .config is updated, silentoldconfig is invoked to sync them.





-- 
Best Regards
Masahiro Yamada
