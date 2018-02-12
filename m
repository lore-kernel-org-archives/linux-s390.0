Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQ8twMnB9wEb+2gjzW2oDGPJf+p7qW=wja7SPGj9Nixyw@mail.gmail.com>
References: <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
 <CAFkk2KSk_OpwagN_Ru0fHPyALK5HwtxHOcMhT8OHqeOH3hOP+w@mail.gmail.com>
 <CAFkk2KRm+_NQ2QLUta7fbezngLpD3eZ5NEp57SymBRMUZQZ4wQ@mail.gmail.com>
 <20180212125458.vb4ve3ieejvuvo65@huvuddator> <CAK7LNAQPGht_wBPr_66shL-59mvaXRzDeuSNKicf+zu5Y1CmCA@mail.gmail.com>
 <CAFkk2KTdXNWNGgGw32NXOG6+10mUDDJ9ngXkcOAQ7QnYtd2TYw@mail.gmail.com> <CAK7LNAQ8twMnB9wEb+2gjzW2oDGPJf+p7qW=wja7SPGj9Nixyw@mail.gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Mon, 12 Feb 2018 16:35:38 +0100
Message-ID: <CAFkk2KQHxxLSVuXtv+U=C1OEhi2f2SMe8fk3x3B49qgXWXfV1w@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, Arnd Bergmann <arnd@arndb.de>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Feb 12, 2018 at 4:22 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-02-12 23:53 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
>> On Mon, Feb 12, 2018 at 3:21 PM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>> 'syncconfig' in a more proper name
>>
>> Wonder if --update-config-files-for-build or something would be an
>> even better name.
>
> I want to use a name that ends with 'config' like any other config targets
> because:
>
> - I want use the same name for scripts/kconfig/conf option
>   and Makefile target to take advantage of 'simple-targets'  [1]
>
> - I want to use pattern rule to descend into scripts/kconfig/  [2]
>
>
> [1] https://github.com/torvalds/linux/blob/v4.16-rc1/scripts/kconfig/Makefile#L84
> [2] https://github.com/torvalds/linux/blob/v4.16-rc1/Makefile#L506
>
>
>
> It would be possible to directly descend into scripts/kconfig/ like follows,
> but I do not have a good reason to break the convention.
>
> include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
>        $(Q)$(MAKE) $(build)=scripts/kconfig  update-config-files-for-build
>

Ah, right, didn't think of that. Thought it might be nice to hint that
it's related to the build phase somehow at least.

Not that important I guess. --syncconfig is a big improvement already.

Cheers,
Ulf
