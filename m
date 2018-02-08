Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAK7LNARSd6QOcr05z-V9UGCspib=yMDSjdBLXB5h1CGXCmwKjw@mail.gmail.com>
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
 <1518106752-29228-6-git-send-email-yamada.masahiro@socionext.com> <CAK7LNARSd6QOcr05z-V9UGCspib=yMDSjdBLXB5h1CGXCmwKjw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Feb 2018 09:45:09 -0800
Message-ID: <CA+55aFy-gyap4YS3ycgYgMqQJLCjXF9Ua7C-xyvi3J=14Ddqnw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/7] kconfig: invoke silentoldconfig when compiler is updated
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Feb 8, 2018 at 9:19 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Should this be checked?
> Or, is it just "Don't do it" thing?

I think it's probably a "Don't do it".

In fact, maybe we should just make it very explicit that you need to
re-run "make *config" by hand if you have updated your compiler.

So instead of your "run silentoldconfig" if the compiler version has
changed, just literally error out and say "compiler has changed,
re-run configuration".

That way there are no subtle silent failures where you might end up -
by mistake - building just modules with a new compiler and different
options. Because people would be *aware* of the re-configuration.

Anyway, I suspect this is a tiny detail that we don't have to set in
stone right now. Maybe worry about it more when/if it actually becomes
something that people notice?

              Linus
