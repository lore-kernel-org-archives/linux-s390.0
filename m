Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQPGht_wBPr_66shL-59mvaXRzDeuSNKicf+zu5Y1CmCA@mail.gmail.com>
References: <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
 <CAFkk2KSk_OpwagN_Ru0fHPyALK5HwtxHOcMhT8OHqeOH3hOP+w@mail.gmail.com>
 <CAFkk2KRm+_NQ2QLUta7fbezngLpD3eZ5NEp57SymBRMUZQZ4wQ@mail.gmail.com>
 <20180212125458.vb4ve3ieejvuvo65@huvuddator> <CAK7LNAQPGht_wBPr_66shL-59mvaXRzDeuSNKicf+zu5Y1CmCA@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 12 Feb 2018 23:23:37 +0900
Message-ID: <CAK7LNATZZPHMVM+2a_iXwggMT-VF=-nkMom7e4JYzgPpnC0RPg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, Arnd Bergmann <arnd@arndb.de>
List-ID: <linux-s390.vger.kernel.org>

2018-02-12 23:21 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> 2018-02-12 21:54 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
>> On Sun, Feb 11, 2018 at 09:42:09PM +0100, Ulf Magnusson wrote:
>>> On Sun, Feb 11, 2018 at 9:29 PM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
>>> > On Sun, Feb 11, 2018 at 6:56 PM, Kees Cook <keescook@chromium.org> wrote:
>>> >> Another case I mentioned before that I just want to make sure we don't
>>> >> reintroduce the problem of getting "stuck" with a bad .config file.
>>> >> While adding _STRONG support, I discovered the two-phase Kconfig
>>> >> resolution that happens during the build. If you selected _STRONG with
>>> >> a strong-capable compiler, everything was fine. If you then tried to
>>> >> build with an older compiler, you'd get stuck since _STRONG wasn't
>>> >> support (as detected during the first Kconfig phase) so the
>>> >> generated/autoconf.h would never get updated with the newly selected
>>> >> _REGULAR). I moved the Makefile analysis of available stack-protector
>>> >> options into the second phase (i.e. after all the Kconfig runs), and
>>> >> that worked to both unstick such configs and provide a clear message
>>> >> early in the build about what wasn't available.
>>> >>
>>> >> If all this detection is getting moved up into Kconfig, I'm worried
>>> >> we'll end up in this state again. If the answer is "you have to delete
>>> >> autoconf.h if you change compilers", then that's fine, but it sure
>>> >> seems unfriendly. :)
>>> >
>>> > Did you mean include/config/auto.conf? That's the one that gets
>>> > included by the Makefiles.
>>> >
>>> > If the feature detection is moved into Kconfig, you should only need
>>> > to rerun the configuration (make menuconfig/oldconfig/olddefconfig) if
>>> > you change the compiler. That will update .config while taking the new
>>> > features into account, and then the second phase during 'make' will
>>> > update include/config/auto.conf from .config.
>>> >
>>> > That second Kconfig phase generates include/generated/autoconf.h and
>>> > include/config/. The include/config/ directory implements dependencies
>>> > between source files and Kconfig symbols by turning the symbols into
>>> > (empty) files. When building (during the "second phase"), Kconfig
>>> > compares .config with include/config/auto.conf to see what changed,
>>> > and signals the changes to 'make' by touch'ing the files corresponding
>>> > to the changed symbols. The idea is to avoid having to do a full
>>> > rebuild whenever the configuration is changed.
>>> >
>>> > Check out scripts/basic/fixdep.c as well if you want to understand how it works.
>>> >
>>> > Cheers,
>>> > Ulf
>>>
>>> By the way:
>>>
>>> That second phase is also a "normal" Kconfig run in the sense that it
>>> does all the usual dependency checking stuff. Even if .config doesn't
>>> respect dependencies, include/config/auto.conf will. So I think you
>>> might not even need to rerun the configuration (though .config will be
>>> out-of-date until you do).
>>>
>>> Cheers,
>>> Ulf
>>
>> Seems you'd have to rerun the configuration, because
>> include/config/auto.conf is only regenerated if it's older than .config.
>>
>> Here's the bit in the root Makefile that does it (KCONFIG_CONFIG is
>> .config).
>>
>>         # If .config is newer than include/config/auto.conf, someone tinkered
>>         # with it and forgot to run make oldconfig.
>>         # if auto.conf.cmd is missing then we are probably in a cleaned tree so
>>         # we execute the config step to be sure to catch updated Kconfig files
>>         include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
>>                 $(Q)$(MAKE) -f $(srctree)/Makefile silentoldconfig
>>
>> silentoldconfig is a terrible name. What it actually does is run that
>> "second phase" stuff.
>
> Right.  This is a historical misnomer.
>
> My plan is, as already posted below, to rename 'silentoldconfig' to 'synconfig'
> https://lkml.org/lkml/2018/1/17/1359
>
>
>
>> Pretty sure that comment lies by the way. 'make oldconfig' doesn't
>> update include/config/auto.conf. It's probably outdated.
>
> Good catch.
>
>
>>
>> I wonder if it would be simpler to just always run silentoldconfig when
>> building. It's not that slow on my system:
>>
>>         $ export ARCH=x86 SRCARCH=x86 KERNELVERSION=`make kernelversion`
>>         $ time scripts/kconfig/conf --silentoldconfig Kconfig
>>
>>         real    0m0.167s
>>         user    0m0.162s
>>         sys     0m0.004s
>>
>> That'd both simplify the Makefiles, and make sure that the latest
>> features are always used if you do feature testing in Kconfig.
>>
>> I don't know how strongly people feel about a few tenths of a second
>> though.
>
>
> No.  NACK.
>
> silentoldconfig touches include/generated/autoconf.h
> so, files that depend on it will be re-compiled, unnecessarily.


Sorry, I take back this comment.
fixdep takes care of this.

So, autoconf.h is removed from dependency.





>
> silentoldconfig ( 'syncconfig' in a more proper name)
> should be run only when necessary.
>
>
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
