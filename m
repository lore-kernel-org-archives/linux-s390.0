Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJ02qRCcqTK_M9sFtekizz+0WoHBCBKF_mh-A870eg6eg@mail.gmail.com>
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
 <1518106752-29228-8-git-send-email-yamada.masahiro@socionext.com> <CAGXu5jJ02qRCcqTK_M9sFtekizz+0WoHBCBKF_mh-A870eg6eg@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 9 Feb 2018 13:13:43 +0900
Message-ID: <CAK7LNAQiY7rixHGbuLynRFKUeCDon4dMS+LdxSD4o2SbSp7Kbg@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] Test stackprotector options in Kconfig to kill CC_STACKPROTECTOR_AUTO
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

2018-02-09 3:30 GMT+09:00 Kees Cook <keescook@chromium.org>:
> On Fri, Feb 9, 2018 at 3:19 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Add CC_HAS_STACKPROTECTOR(_STRONG) and proper dependency.
>>
>> I re-arranged the choice values, _STRONG, _REGULAR, _NONE in this order
>> because the default of choice is the first visible symbol.
>> [...]
>> +# is this necessary?
>> +#ifeq ($(CONFIG_CC_STACKPROTECTOR_NONE),y)
>> +#KBUILD_CFLAGS += -fno-stack-protector
>> +#endif
>
> Yes, and also in the case of a broken stack protector, because some
> compilers enable stack protector by default, so if we've selected it
> to be NONE or detected it as broken, we need to force it off in the
> compiler.
>
>> +# TODO: run scripts/gcc-$(SRCARCH)_$(BITS)-has-stack-protector.sh from Kconfig
>
> FWIW, this is the part that I got stuck on.
> gcc-$(SRCARCH)_$(BITS)-has-stack-protector.sh depends on the KBUILD
> flags that got built up and detected up to this point in the Makefile,
> so I couldn't find a way to run it out of Kconfig since it didn't know
> what the KBUILD flags were yet.


SRCARCH is fixed when loading Kconfig files.

BITS is derived from CONFIG_64BIT.

config 64BIT
        bool "64-bit kernel" if ARCH = "x86"
        default ARCH != "i386"
        ---help---
          Say yes to build a 64-bit kernel - formerly known as x86_64
          Say no to build a 32-bit kernel - formerly known as i386


This is a more difficult part because users can toggle this option
from menuconfig, etc.

If this option is changed, the compiler options must be re-computed,
i.e. system() must be called again.

This is missing in my first draft.

I have not checked how slow it is.




>> +
>>  ifeq ($(cc-name),clang)
>>  KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
>>  KBUILD_CFLAGS += $(call cc-disable-warning, unused-variable)
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 76c0b54..50723d8 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -538,10 +538,20 @@ config HAVE_CC_STACKPROTECTOR
>>           - its compiler supports the -fstack-protector option
>>           - it has implemented a stack canary (e.g. __stack_chk_guard)
>>
>> +config CC_HAS_STACKPROTECTOR
>> +       bool
>> +       option shell="$CC -Werror -fstack-protector -c -x c /dev/null"
>> +
>> +config CC_HAS_STACKPROTECTOR_STRONG
>> +       bool
>> +       option shell="$CC -Werror -fstack-protector-strong -c -x c /dev/null"
>
> I'm nervous we'll get tripped up here, since $CC may not include the
> right $(KBUILD_CPPFLAGS) and $(CC_OPTION_CFLAGS) as in cc-option, both
> of which are calculated during the Makefile run. But maybe it won't be
> a problem in actual use.


Right, I had noticed this is a problem, but not implemented yet.

At least, some basic compiler options must be imported into Kconfig.

Especially this is a problem for clang.
One clang executable is built with lots of
architecture back-ends.
So,
CLANG_TARGET    := --target=$(notdir $(CROSS_COMPILE:%-=%))
etc. is mandatory.


If I remember correctly, there existed some options
that depend on others.

I am not sure about the stackprotector case.



>> +
>> +config CC_STACKPROTECTOR
>> +       bool
>> +
>>  choice
>>         prompt "Stack Protector buffer overflow detection"
>>         depends on HAVE_CC_STACKPROTECTOR
>> -       default CC_STACKPROTECTOR_AUTO
>>         help
>>           This option turns on the "stack-protector" GCC feature. This
>>           feature puts, at the beginning of functions, a canary value on
>> @@ -551,26 +561,10 @@ choice
>>           overwrite the canary, which gets detected and the attack is then
>>           neutralized via a kernel panic.
>>
>> -config CC_STACKPROTECTOR_NONE
>> -       bool "None"
>> -       help
>> -         Disable "stack-protector" GCC feature.
>> -
>> -config CC_STACKPROTECTOR_REGULAR
>> -       bool "Regular"
>> -       help
>> -         Functions will have the stack-protector canary logic added if they
>> -         have an 8-byte or larger character array on the stack.
>> -
>> -         This feature requires gcc version 4.2 or above, or a distribution
>> -         gcc with the feature backported ("-fstack-protector").
>> -
>> -         On an x86 "defconfig" build, this feature adds canary checks to
>> -         about 3% of all kernel functions, which increases kernel code size
>> -         by about 0.3%.
>> -
>>  config CC_STACKPROTECTOR_STRONG
>>         bool "Strong"
>> +       depends on CC_HAS_STACKPROTECTOR_STRONG
>> +       select CC_STACKPROTECTOR
>>         help
>>           Functions will have the stack-protector canary logic added in any
>>           of the following conditions:
>> @@ -588,11 +582,25 @@ config CC_STACKPROTECTOR_STRONG
>>           about 20% of all kernel functions, which increases the kernel code
>>           size by about 2%.
>>
>> -config CC_STACKPROTECTOR_AUTO
>> -       bool "Automatic"
>> +config CC_STACKPROTECTOR_REGULAR
>> +       bool "Regular"
>> +       depends on CC_HAS_STACKPROTECTOR
>> +       select CC_STACKPROTECTOR
>> +       help
>> +         Functions will have the stack-protector canary logic added if they
>> +         have an 8-byte or larger character array on the stack.
>> +
>> +         This feature requires gcc version 4.2 or above, or a distribution
>> +         gcc with the feature backported ("-fstack-protector").
>> +
>> +         On an x86 "defconfig" build, this feature adds canary checks to
>> +         about 3% of all kernel functions, which increases kernel code size
>> +         by about 0.3%.
>> +
>> +config CC_STACKPROTECTOR_NONE
>> +       bool "None"
>>         help
>> -         If the compiler supports it, the best available stack-protector
>> -         option will be chosen.
>> +         Disable "stack-protector" GCC feature.
>>
>>  endchoice
>
> I continue to love the idea, but we can't know a given ssp option is
> _working_ until we run the test script, which may depend on compiler
> flags. Regardless, I'll give this series a try and see if I can fix
> anything I trip over. I've got a lot of notes on testing after getting
> ..._AUTO working. Whatever happens, I hugely prefer having the
> automatic selection possible in the Kconfig! Thanks for working on
> this! :)

Yes, your help is appreciated.
We will find more TODO items during trial and error.  :)



-- 
Best Regards
Masahiro Yamada
