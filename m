Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from conssluserg-04.nifty.com ([210.131.2.83]:62942 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbfGVOYI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 22 Jul 2019 10:24:08 -0400
MIME-Version: 1.0
References: <20190721142008.30093-1-yamada.masahiro@socionext.com> <20190722123009.GA5864@osiris>
In-Reply-To: <20190722123009.GA5864@osiris>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 22 Jul 2019 23:23:18 +0900
Message-ID: <CAK7LNARSq=vchY4CT_17zHzJgv8a=Gtow599gJKq2HbM4Ffguw@mail.gmail.com>
Subject: Re: [PATCH] s390: use __u{16,32,64} instead of uint{16,32,64}_t in
 uapi header
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Harald Freudenberger <freude@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Jul 22, 2019 at 9:30 PM Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
>
> On Sun, Jul 21, 2019 at 11:20:08PM +0900, Masahiro Yamada wrote:
> > When CONFIG_UAPI_HEADER_TEST=y, exported headers are compile-tested to
> > make sure they can be included from user-space.
> >
> > Currently, zcrypt.h is excluded from the test coverage. To make it
> > join the compile-test, we need to fix the build errors attached below.
> >
> > For a case like this, we decided to use __u{8,16,32,64} variable types
> > in this discussion:
> >
> >   https://lkml.org/lkml/2019/6/5/18
> ...
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  arch/s390/include/uapi/asm/zcrypt.h | 35 +++++++++++++++--------------
> >  1 file changed, 18 insertions(+), 17 deletions(-)
>
> Applied, thanks!

Thanks.

> I also added the patch below:
>
> From b312d5e2244f635f83cbf19b850e26c1c443f465 Mon Sep 17 00:00:00 2001
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> Date: Mon, 22 Jul 2019 14:16:46 +0200
> Subject: [PATCH 2/2] kbuild: enable arch/s390/include/uapi/asm/zcrypt.h for
>  uapi header test
>
> Masahiro Yamada changed the zcrypt.h header file to use __u{16,32,64}
> instead of uint{16,32,64}_t with ("s390: use __u{16,32,64} instead of
> uint{16,32,64}_t in uapi header").
>
> This makes all s390 header files pass - remove zcrypt.h from the blacklist.
>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>


Yeah, I had noticed this.

I am sending out various patches to various subsystems.

To avoid potential conflicts, my plan was to sync the blacklist
from time to time, like the following commit:

commit 67bf47452ea00edd90e796054229b651e64b82c1
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed Jul 17 15:29:13 2019 +0900

    kbuild: update compile-test header list for v5.3-rc1


For this particular case, probably a merge conflict will not happen,
so either is fine.






> ---
>  usr/include/Makefile | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/usr/include/Makefile b/usr/include/Makefile
> index aa316d99e035..1fb6abe29b2f 100644
> --- a/usr/include/Makefile
> +++ b/usr/include/Makefile
> @@ -101,10 +101,6 @@ ifeq ($(SRCARCH),riscv)
>  header-test- += linux/bpf_perf_event.h
>  endif
>
> -ifeq ($(SRCARCH),s390)
> -header-test- += asm/zcrypt.h
> -endif
> -
>  ifeq ($(SRCARCH),sparc)
>  header-test- += asm/stat.h
>  header-test- += asm/uctx.h
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
