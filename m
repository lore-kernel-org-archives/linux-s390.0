Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAFkk2KQ+ybTQF4U9eHqhi-Hg8ML1Z72DsXij2sM58S5HHg6C-Q@mail.gmail.com>
References: <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAK7LNARdm7UESEEh-2qEP9R8jWSwzZ4d2x=pZZPuj6EVAsXnAA@mail.gmail.com>
 <CAFkk2KQ+ybTQF4U9eHqhi-Hg8ML1Z72DsXij2sM58S5HHg6C-Q@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 12 Feb 2018 22:53:30 +0900
Message-ID: <CAK7LNAR1tgw0hnjRF=T1tPkqA=_wSwn8x6Ux-LYsNCrqrbEyLg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
List-ID: <linux-s390.vger.kernel.org>

2018-02-12 20:44 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:

>>
>> I think Linus's comment was dismissed here.
>>
>>
>> Linus said:
>>
>>> But yes, I also reacted to your earlier " It can't silently rewrite it
>>> to _REGULAR because the compiler support for _STRONG regressed."
>>> Because it damn well can. If the compiler doesn't support
>>> -fstack-protector-strong, we can just fall back on -fstack-protector.
>>> Silently. No extra crazy complex logic for that either.
>>
>>
>> If I understood his comment correctly,
>> we do not need either WANT_* or _AUTO.
>>
>>
>>
>>
>> Kees' comment:
>>
>>> In the stack-protector case, this becomes quite important, since the
>>> goal is to record the user's selection regardless of compiler
>>> capability. For example, if someone selects _REGULAR, it shouldn't
>>> "upgrade" to _STRONG. (Similarly for _NONE.)
>>
>> No.  Kconfig will not do this silently.
>
> (Playing devil's advocate...)
>
> If the user selected _STRONG and it becomes unavailable later, it
> seems to silently fall back on other options, even for oldnoconfig
> (which just checks if there are any new symbols in the choice).
>
> It would be possible to also check if the old user selection still
> applies btw. I do that in Kconfiglib. It's arguable whether that
> matches the intent of oldnoconfig.
>
>>
>>
>> "make oldconfig" (or "make silentoldconfig" as well)
>> always ask users about new symbols.
>>
>>
>> For example, let's say your compiler supports -fstack-protector
>> but not -fstack-protector-strong.
>> CC_STACKPROTECTOR_REGULAR is the best you can choose.
>>
>> Then, let's say you upgrade your compiler and the new compiler supports
>> -fstack-protector-strong as well.
>>
>> In this case, CC_STACKPROTECTOR_STRONG is a newly visible symbol,
>> so Kconfig will ask you
>> "Hey, you were previously using _REGULAR, but your new compiler
>> also supports _STRONG.  Do you want to use it?"
>>
>>
>> The "make oldconfig" will look like follows:
>>
>>
>> masahiro@grover:~/workspace/linux-kbuild$ make oldconfig
>>   HOSTCC  scripts/kconfig/conf.o
>>   HOSTLD  scripts/kconfig/conf
>> scripts/kconfig/conf  --oldconfig Kconfig
>> *
>> * Restart config...
>> *
>> *
>> * Linux Kernel Configuration
>> *
>> Stack Protector buffer overflow detection
>>   1. Strong (CC_STACKPROTECTOR_STRONG) (NEW)
>>> 2. Regular (CC_STACKPROTECTOR_REGULAR)
>>   3. None (CC_STACKPROTECTOR_NONE)
>> choice[1-3?]:
>>
>>
>>
>> Please notice the Strong is marked as "(NEW)".
>>
>> Kconfig handles this really nicely with Linus' suggestion.
>>
>> [1] Users can select only features supported by your compiler
>>     - this makes sense.
>>
>> [2] If you upgrade your compiler and it provides more capability,
>>     "make (silent)oldconfig" will ask you about new choices.
>>      - this also makes sense.
>
> If you switch to a compiler that provides less capability, it'll
> silently forget the old user preference though.


Yes, forget.

So, "make oldconfig" will ask user preference again
when you switch back to a compiler that provides more capability.
This is not rude, right?




To remember user preference (for both upgrade/downgrade capability),
we need 3 symbols for each feature.

[1] WANT_FOO
    A user can enable this option regardless of compiler capability.
    This will remember your preference forever.

[2] CC_HAS_FOO
    Compiler capability.

[3] FOO
    logical 'and' of WANT_FOO and CC_HAS_FOO.

If we do this way, what's the point of
moving compiler capability tests to Kconfig?


[1] is the same as what we do now.

Then, it will be disabled later
if it turns out unsupported by your compiler.

The only difference is,
whether we calculate [2], [3] in Makefile or Kconfig.

Kconfig is, in the end, inter-symbol dependency/visibility solver.
The WANT_ is not using the benefit of Kconfig.
We can calculate the logical 'and' by other means.





The problem I see in this approach is 'savedefconfig'.

'make defconfig && make savedefconfig'
will produce the subset of user preference and compiler capability.

To make arbitrary set of CONFIG options,
we need a full-featured compiler
in order to enable all CC_HAS_... options.


Maybe, we can add a new environment to ease this.

KCONFIG_SHELL_ALWAYS_TRUE
  If this environment is specified, all 'option shell=...'
  will be evaluated as true.  So, all symbols that depend on
  CC_HAS_  will be visible.   This is useful to make
  arbitrary set of CONFIG options regardless of
  your compiler capability.


$ KCONFIG_SHELL_ALWAYS_TRUE=1  make  menuconfig
   -> build up your favorite config setting

$ KCONFIG_SHELL_ALWAYS_TRUE=1 make savedefconfig
   ->  write out the minimum set of config


Thought?







>>
>>
>>
>> So, the following simple implementation works well enough,
>> doesn't it?
>>
>> ---------------->8---------------
>> choice
>>         prompt "Stack Protector buffer overflow detection"
>>
>> config CC_STACKPROTECTOR_STRONG
>>         bool "Strong"
>>         depends on CC_HAS_STACKPROTECTOR_STRONG
>>         select CC_STACKPROTECTOR
>>
>> config CC_STACKPROTECTOR_REGULAR
>>         bool "Regular"
>>         depends on CC_HAS_STACKPROTECTOR
>>         select CC_STACKPROTECTOR
>>
>> config CC_STACKPROTECTOR_NONE
>>         bool "None"
>>
>> endchoice
>> ---------------->8-------------------------
>
> Obviously much neater at least. :)
>
>>
>>
>>
>> BTW, do we need to use 'choice' ?
>>
>>
>> The problem of using 'choice' is,
>> it does not work well with allnoconfig.
>>
>>
>> For all{yes,mod}config, we want to enable as many features as possible.
>> For allnoconfig, we want to disable as many as possible.
>
> Oh... right. For allnoconfig, it would always pick the default, so if
> the default is "on", it's bad there.
>
>>
>> However, the default of 'choice' is always the first visible value.
>>
>>
>> So, I can suggest to remove _REGULAR and _NONE.
>>
>> We have just two bool options, like follows.
>>
>> ------------------->8-----------------
>> config CC_STACKPROTECTOR
>>         bool "Use stack protector"
>>         depends on CC_HAS_STACKPROTECTOR
>>
>> config CC_STACKPROTECTOR_STRONG
>>         bool "Use strong strong stack protector"
>>         depends on CC_STACKPROTECTOR
>>         depends on CC_HAS_STACKPROTECTOR_STRONG
>> -------------------->8------------------
>
> Even neater. Much easier to understand.
>
>>
>> This will work well for all{yes,mod,no}config.
>>
>> We will not have a case where
>> -fstack-protector-strong is supported, but -fstack-protector is not.
>>
>>
>> --
>> Best Regards
>> Masahiro Yamada
>
> So there's just the caveat about possibly "forgetting" the user
> preferences and automatically falling back on
> CC_STACKPROTECTOR_REGULAR or CC_STACKPROTECTOR_NONE when the
> environment changes, instead of erroring out.
>
> When you have to think hard about cases where something might break,
> it might be a sign that it's not a huge problem in practice, but I
> can't really speak for the priorities here.
>

-- 
Best Regards
Masahiro Yamada
