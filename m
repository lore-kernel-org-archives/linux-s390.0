Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1478523175.29112.7.camel@tiscali.nl>
References: <1478403928-20799-1-git-send-email-yamada.masahiro@socionext.com> <1478523175.29112.7.camel@tiscali.nl>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 8 Nov 2016 10:50:31 +0900
Message-ID: <CAK7LNATU4enycbY-ch68FGC5F7if7U=6yhS97GEgay3AK0tk3w@mail.gmail.com>
Subject: Re: [PATCH 1/2] s390: delete unneeded #include <linux/kconfig.h> from facilities_src.h
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Paul,


2016-11-07 21:52 GMT+09:00 Paul Bolle <pebolle@tiscali.nl>:
> On Sun, 2016-11-06 at 12:45 +0900, Masahiro Yamada wrote:
>> The header facilities_src.h is only included from gen_facilities.c
>> and the tool is compiled with the following extra options:
>>
>>     HOSTCFLAGS_gen_facilities.o += -Wall $(LINUXINCLUDE)
>>
>> Please note $(LINUXINCLUDE) is expanded into build options including:
>>
>>     -include $(srctree)/include/linux/kconfig.h
>>
>> So, the Makefile always forces the tool to include kconfig.h, i.e.,
>> the #include <linux/kconfig.h> directive in the header is redundant.
>
> As far as I can see the only kernel header that gen_facilities.c is actually
> interested in is autoconf.h. (autoconf.h will be included via in kconfig.h.)
> So it seems the odd $(LINUXINCLUDE) variable in that Makefile could be
> replaced with something like:
>     -include $(srctree)/include/generated/autoconf.h


This would break O= build because autoconf.h is a generated file.

Rather, it should be
      -include $(objtree)/include/generated/autoconf.h



I thought of this at first, but I was not quite sure
if the file path include/generated/autoconf.h is a guaranteed interface.


Basically, now we are supposed to include autoconf.h via kconfig.h.

So, I thought $(LINUXINCLUDE) is a more stable interface
than specifying the exact path to autoconf.h

I doubt that nobody would try to change it, but it is just two my cents.

Anyway, arch/x86/boot/Makefile already
referenced the path to autoconf.h


So, if you want to change it, I will not oppose to it.



-- 
Best Regards
Masahiro Yamada
