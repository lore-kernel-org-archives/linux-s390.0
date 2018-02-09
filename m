Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180209124607.akjhncb5sempjqcn@huvuddator>
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
 <1518106752-29228-5-git-send-email-yamada.masahiro@socionext.com>
 <20180209053038.pscoijvowmyudyzf@huvuddator> <CAK7LNATRxYCx9sE1haw815votyA5K8GQrMPPh0Q+n3kYa=JsgA@mail.gmail.com>
 <20180209124607.akjhncb5sempjqcn@huvuddator>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 9 Feb 2018 12:46:54 -0800
Message-ID: <CAGXu5j+hv6G3m+fgr7ibXAnoE-2GsxtXoqr0pd5AaaNdFVQxYg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Feb 9, 2018 at 4:46 AM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
> One thing that makes Kconfig confusing (though it works well enough in
> practice) is that .config files both record user selections (the saved
> configuration) and serve as a configuration output format for make.
>
> It becomes easier to think about .config files once you realize that
> assignments to promptless symbols never have an effect on Kconfig
> itself: They're just configuration output, intermixed with the saved
> user selections.
>
> Assume 'option env' symbols got written out for example:
>
>         - For a non-user-assignable symbol, the entry in the .config
>           file is just configuration output and ignored by Kconfig,
>           which will fetch the value from the environment instead.
>
>         - For an assignable 'option env' symbol, the entry in the
>           .config file is a saved user selection (as well as
>           configuration output), and will be respected by Kconfig.

In the stack-protector case, this becomes quite important, since the
goal is to record the user's selection regardless of compiler
capability. For example, if someone selects _REGULAR, it shouldn't
"upgrade" to _STRONG. (Similarly for _NONE.) Having _AUTO provides a
way to pick "best possible for this compiler", though. If a user had
previously selected _STRONG but they're doing builds with an older
compiler (or a misconfigured newer compiler) without support, the goal
is to _fail_ to build, not silently select _REGULAR.

So, in this case, what's gained is the logic for _AUTO, and the logic
to not show, say, _STRONG when it's not available in the compiler. But
we must still fail to build if _STRONG was in the .config. It can't
silently rewrite it to _REGULAR because the compiler support for
_STRONG regressed.

-Kees

-- 
Kees Cook
Pixel Security
