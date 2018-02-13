Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <49c196ec-891d-2030-bd6c-7222feb22059@infradead.org>
References: <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
 <CAK7LNAQpS6dYBnt_PjL5zrX1=eccSg80khu=WYCjnHNvDiKa3w@mail.gmail.com>
 <CAGXu5j+7kv=jrg2u7jaxFEXwHoyzDXP_jyKHYA682_BrYuHwQQ@mail.gmail.com> <49c196ec-891d-2030-bd6c-7222feb22059@infradead.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 13 Feb 2018 10:41:10 +0900
Message-ID: <CAK7LNAREEJ_k9x2QXaT73nBg934pb9YvO9DfzhhU7+_fpDdH8g@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Kees Cook <keescook@chromium.org>, Ulf Magnusson <ulfalizer@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, Arnd Bergmann <arnd@arndb.de>
List-ID: <linux-s390.vger.kernel.org>

2018-02-13 8:48 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> On 02/12/2018 07:24 AM, Kees Cook wrote:
>> On Mon, Feb 12, 2018 at 6:39 AM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>
>>>> (And in thinking about this, does Kconfig know the true $CC in use?
>>>> i.e. the configured cross compiler, etc?)
>>>
>>> I was thinking of removing CONFIG_CROSS_COMPILE.
>>>
>>> A user can dynamically change CROSS_COMPILE from
>>> "make menuconfig".
>>
>> Most builds I've seen implement cross compilers as an environment
>> variable during all "make" invocations.
>
> I agree. I think you would break a bunch of build bots if you remove that.


For clarification, I suggested to remove CONFIG_CROSS_COMPILE.

The following code:
https://github.com/torvalds/linux/blob/v4.16-rc1/Makefile#L315
https://github.com/torvalds/linux/blob/v4.16-rc1/init/Kconfig#L58

I hope build bots are not using this.


Passing CROSS_COMPILE via the command line, environment
is still supported.



-- 
Best Regards
Masahiro Yamada
