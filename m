Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180211103432.pf2ot6nd7nbhdhsy@huvuddator>
References: <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com> <20180211103432.pf2ot6nd7nbhdhsy@huvuddator>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 12 Feb 2018 19:44:51 +0900
Message-ID: <CAK7LNARdm7UESEEh-2qEP9R8jWSwzZ4d2x=pZZPuj6EVAsXnAA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>, arjan.van.de.ven@intel.com
List-ID: <linux-s390.vger.kernel.org>

2018-02-11 19:34 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
> Looks to me like there's a few unrelated issues here:
>
>
> 1. The stack protector support test scripts
>
> Worthwhile IMO if they (*in practice*) prevent hard-to-debug build errors or a
> subtly broken kernel from being built.
>
> A few questions:
>
>     - How do things fail with a broken stack protector implementation?
>
>     - How common are those broken compilers?
>
>     - Do you really need to pass $(KBUILD_CPPFLAGS) when testing for breakage,
>       or would a simpler static test work in practice?
>
>       I don't know how messy it would be to get $(KBUILD_CPPFLAGS) into
>       Kconfig, but should make sure it's actually needed in any case.
>
>       The scripts are already split up as
>
>           scripts/gcc-$(SRCARCH)_$(BITS)-has-stack-protector.sh
>
>       by the way, though only gcc-x86_32-has-stack-protector.sh and
>       gcc-x86_64-has-stack-protector.sh exist.
>
>     - How old do you need to go with GCC for -fno-stack-protector to give an
>       error (i.e., for not even the option to be recognized)? Is it still
>       warranted to test for it?
>
> Adding some CCs who worked on the stack protector test scripts.
>
> And yeah, I was assuming that needing support scripts would be rare, and that
> you'd usually just check whether gcc accepts the flag.
>
> When you Google "gcc broken stack protector", the top hits about are about the
> scripts/gcc-x86_64-has-stack-protector.sh script in the kernel throwing a false
> positive by the way (fixed in 82031ea29e45 ("scripts/has-stack-protector: add
> -fno-PIE")).
>
>
> 2. Whether to hide the Kconfig stack protector alternatives or always show them
>
> Or equivalently, whether to automatically fall back on other stack protector
> alternatives (including no stack protector) if the one specified in the .config
> isn't available.
>
> I'll let you battle this one out. In any case, as a user, I'd want a
> super-clear message telling me what to change if the build breaks because of
> missing stack protector support.
>
>
> 3. Whether to implement CC_STACKPROTECTOR_AUTO in Kconfig or the Makefiles
>
> I'd just go with whatever is simplest here. I don't find the Kconfig version
> too bad, but I'm already very familiar with Kconfig, so it's harder for me to
> tell how it looks to other people.
>
> I'd add some comments to explain the idea in the final version.
>
> @Kees:
> I was assuming that the Makefiles would error out with a message if none of the
> CC_STACKPROTECTOR_* variables are set, in addition to the Kconfig warning.
>
> You could offload part of that check to Kconfig with something like
>
>         config CHOSEN_CC_STACKPROTECTOR_AVAILABLE
>                 def_bool CC_STACKPROTECTOR_STRONG || \
>                          CC_STACKPROTECTOR_REGULAR || \
>                          CC_STACKPROTECTOR_NONE
>
> CHOSEN_STACKPROTECTOR_AVAILABLE could then be checked in the Makefile.
> It has the advantage of making the constraint clear in the Kconfig file
> at least.
>
> You could add some kind of assert feature to Kconfig too, but IMO it's not
> warranted purely for one-offs like this at least.
>
> That's details though. I'd want to explain it with a comment in any case if we
> go with something like this, since it's slightly kludgy and subtle
> (CC_STACKPROTECTOR_{STRONG,REGULAR,NONE} form a kind of choice, only you can't
> express it like that directly, since it's derived from other symbols).
>
>
> Here's an overview of the current Kconfig layout by the way, assuming
> the old no-fallback behavior and CC_STACKPROTECTOR_AUTO being
> implemented in Kconfig:
>
>         # Feature tests
>         CC_HAS_STACKPROTECTOR_STRONG
>         CC_HAS_STACKPROTECTOR_REGULAR
>         CC_HAS_STACKPROTECTOR_NONE
>
>         # User request
>         WANT_CC_STACKPROTECTOR_AUTO
>         WANT_CC_STACKPROTECTOR_STRONG
>         WANT_CC_STACKPROTECTOR_REGULAR
>         WANT_CC_STACKPROTECTOR_NONE
>
>         # The actual "output" to the Makefiles
>         CC_STACKPROTECTOR_STRONG
>         CC_STACKPROTECTOR_REGULAR
>         CC_STACKPROTECTOR_NONE
>
>         # Some possible output "nicities"
>         CHOSEN_CC_STACKPROTECTOR_AVAILABLE
>         CC_OPT_STACKPROTECTOR
>
> Does anyone have objections to the naming or other things? I saw some
> references to "Santa's wish list" in messages of commits that dealt with other
> variables named WANT_*, though I didn't look into those cases. ;)
>



I think Linus's comment was dismissed here.


Linus said:

> But yes, I also reacted to your earlier " It can't silently rewrite it
> to _REGULAR because the compiler support for _STRONG regressed."
> Because it damn well can. If the compiler doesn't support
> -fstack-protector-strong, we can just fall back on -fstack-protector.
> Silently. No extra crazy complex logic for that either.


If I understood his comment correctly,
we do not need either WANT_* or _AUTO.




Kees' comment:

> In the stack-protector case, this becomes quite important, since the
> goal is to record the user's selection regardless of compiler
> capability. For example, if someone selects _REGULAR, it shouldn't
> "upgrade" to _STRONG. (Similarly for _NONE.)

No.  Kconfig will not do this silently.


"make oldconfig" (or "make silentoldconfig" as well)
always ask users about new symbols.


For example, let's say your compiler supports -fstack-protector
but not -fstack-protector-strong.
CC_STACKPROTECTOR_REGULAR is the best you can choose.

Then, let's say you upgrade your compiler and the new compiler supports
-fstack-protector-strong as well.

In this case, CC_STACKPROTECTOR_STRONG is a newly visible symbol,
so Kconfig will ask you
"Hey, you were previously using _REGULAR, but your new compiler
also supports _STRONG.  Do you want to use it?"


The "make oldconfig" will look like follows:


masahiro@grover:~/workspace/linux-kbuild$ make oldconfig
  HOSTCC  scripts/kconfig/conf.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf  --oldconfig Kconfig
*
* Restart config...
*
*
* Linux Kernel Configuration
*
Stack Protector buffer overflow detection
  1. Strong (CC_STACKPROTECTOR_STRONG) (NEW)
> 2. Regular (CC_STACKPROTECTOR_REGULAR)
  3. None (CC_STACKPROTECTOR_NONE)
choice[1-3?]:



Please notice the Strong is marked as "(NEW)".

Kconfig handles this really nicely with Linus' suggestion.

[1] Users can select only features supported by your compiler
    - this makes sense.

[2] If you upgrade your compiler and it provides more capability,
    "make (silent)oldconfig" will ask you about new choices.
     - this also makes sense.



So, the following simple implementation works well enough,
doesn't it?

---------------->8---------------
choice
        prompt "Stack Protector buffer overflow detection"

config CC_STACKPROTECTOR_STRONG
        bool "Strong"
        depends on CC_HAS_STACKPROTECTOR_STRONG
        select CC_STACKPROTECTOR

config CC_STACKPROTECTOR_REGULAR
        bool "Regular"
        depends on CC_HAS_STACKPROTECTOR
        select CC_STACKPROTECTOR

config CC_STACKPROTECTOR_NONE
        bool "None"

endchoice
---------------->8-------------------------



BTW, do we need to use 'choice' ?


The problem of using 'choice' is,
it does not work well with allnoconfig.


For all{yes,mod}config, we want to enable as many features as possible.
For allnoconfig, we want to disable as many as possible.

However, the default of 'choice' is always the first visible value.


So, I can suggest to remove _REGULAR and _NONE.

We have just two bool options, like follows.

------------------->8-----------------
config CC_STACKPROTECTOR
        bool "Use stack protector"
        depends on CC_HAS_STACKPROTECTOR

config CC_STACKPROTECTOR_STRONG
        bool "Use strong strong stack protector"
        depends on CC_STACKPROTECTOR
        depends on CC_HAS_STACKPROTECTOR_STRONG
-------------------->8------------------

This will work well for all{yes,mod,no}config.

We will not have a case where
-fstack-protector-strong is supported, but -fstack-protector is not.


-- 
Best Regards
Masahiro Yamada
