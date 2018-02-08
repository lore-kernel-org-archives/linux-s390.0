Return-Path: <linux-kbuild-owner@vger.kernel.org>
Date: Thu, 8 Feb 2018 17:43:08 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 0/7] Kconfig: add new special property shell= to test
 compiler options in Kconfig
Message-ID: <20180208164308.GE9421@kroah.com>
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, linux-s390@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Feb 09, 2018 at 01:19:05AM +0900, Masahiro Yamada wrote:
> This was prompted by the email from Linus today's morning.
> 
> I implmented this in a rush today, so there are still many TODOs,
> but I put it here to start discussion.
> 
> I think it is working, but as you notice, it is tedious to repeat something
> like follows:
> 
> config CC_HAS_STACKPROTECTOR
>         bool
>         option shell="$CC -Werror -fstack-protector -c -x c /dev/null"
> 
> One possiblity is to put this ugly code into script like follows,
> 
> config CC_STACKPROTECTOR
>           bool
>           option shell="$srctree/scripts/cc-option.sh $CC -fstack-protector"
> 
> ... but this is longer.

But it's easier to remember and cut/paste from :)

> I was thinking of something like follows:
> 
> config CC_STACKPROTECTOR
>           bool
>           option shell="$(CC_OPTION -fstack-protector)"

Sure, that would be even nicer, if possible.  Is it?

Anyway, very nice work.  I like moving the cache stuff to the .config
file, that makes a lot of sense and will be even nicer to see in the
/proc/config.gz output for when we are curious as to what the build
options really were.

thanks,

greg k-h
