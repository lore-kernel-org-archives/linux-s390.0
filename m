Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1478596565.29112.40.camel@tiscali.nl>
Subject: Re: [PATCH 1/2] s390: delete unneeded #include <linux/kconfig.h>
 from facilities_src.h
From: Paul Bolle <pebolle@tiscali.nl>
Date: Tue, 08 Nov 2016 10:16:05 +0100
In-Reply-To: <CAK7LNATU4enycbY-ch68FGC5F7if7U=6yhS97GEgay3AK0tk3w@mail.gmail.com>
References: <1478403928-20799-1-git-send-email-yamada.masahiro@socionext.com>
         <1478523175.29112.7.camel@tiscali.nl>
         <CAK7LNATU4enycbY-ch68FGC5F7if7U=6yhS97GEgay3AK0tk3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Mashiro,

On Tue, 2016-11-08 at 10:50 +0900, Masahiro Yamada wrote:
> 2016-11-07 21:52 GMT+09:00 Paul Bolle <pebolle@tiscali.nl>:
> > So it seems the odd $(LINUXINCLUDE) variable in that Makefile could be
> > replaced with something like:
> >     -include $(srctree)/include/generated/autoconf.h
> 
> This would break O= build because autoconf.h is a generated file.
> 
> Rather, it should be
>       -include $(objtree)/include/generated/autoconf.h

Three cheers for weasel words like "something like"!

> I thought of this at first, but I was not quite sure
> if the file path include/generated/autoconf.h is a guaranteed interface.
> 
> Basically, now we are supposed to include autoconf.h via kconfig.h.

Yes, that seems to go back to commit 2a11c8ea20bf ("kconfig: Introduce
IS_ENABLED(), IS_BUILTIN() and IS_MODULE()"). And when the current approach to
the IS_*() macros was introduced - with that breathtaking hack that introduced
__is_defined() - this was no longer needed but was not changed again.

> So, I thought $(LINUXINCLUDE) is a more stable interface
> than specifying the exact path to autoconf.h
> 
> I doubt that nobody would try to change it, but it is just two my cents.

A bit of cruft accumulated around LINUXINCLUDE: a few dubious uses of it (and
I think this is one of those); typos (ie, LINUX_INCLUDE); the pointless
USERINCLUDE; things like that. It would be nice to remove that cruft. But it
needs to be done carefully.

> Anyway, arch/x86/boot/Makefile already
> referenced the path to autoconf.h
> 
> So, if you want to change it, I will not oppose to it.


Paul Bolle
