Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1478523175.29112.7.camel@tiscali.nl>
Subject: Re: [PATCH 1/2] s390: delete unneeded #include <linux/kconfig.h>
 from facilities_src.h
From: Paul Bolle <pebolle@tiscali.nl>
Date: Mon, 07 Nov 2016 13:52:55 +0100
In-Reply-To: <1478403928-20799-1-git-send-email-yamada.masahiro@socionext.com>
References: <1478403928-20799-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, 2016-11-06 at 12:45 +0900, Masahiro Yamada wrote:
> The header facilities_src.h is only included from gen_facilities.c
> and the tool is compiled with the following extra options:
> 
>     HOSTCFLAGS_gen_facilities.o += -Wall $(LINUXINCLUDE)
> 
> Please note $(LINUXINCLUDE) is expanded into build options including:
> 
>     -include $(srctree)/include/linux/kconfig.h
> 
> So, the Makefile always forces the tool to include kconfig.h, i.e.,
> the #include <linux/kconfig.h> directive in the header is redundant.

As far as I can see the only kernel header that gen_facilities.c is actually
interested in is autoconf.h. (autoconf.h will be included via in kconfig.h.)
So it seems the odd $(LINUXINCLUDE) variable in that Makefile could be
replaced with something like:
    -include $(srctree)/include/generated/autoconf.h


Paul Bolle
