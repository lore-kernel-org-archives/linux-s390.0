From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 19 Apr 2018 08:08:21 +0000
Subject: Re: [-next] "y2038: s390: remove unneeded ipc uapi header files" causes build failure
Message-Id: <CAK8P3a3oUn1CVVRvourPk908OHGhDTrvpr=DgnBu5n1ikfSTvw@mail.gmail.com>
In-Reply-To: <20180419074030.GA6317@osiris>
References: <20180419074030.GA6317@osiris>
To: linux-s390@vger.kernel.org, linux-next@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Apr 19, 2018 at 9:40 AM, Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
> Hi Arnd,
>
> your patch "y2038: s390: remove unneeded ipc uapi header files" causes
> "make headers_install" to fail on s390:
>
> scripts/Makefile.headersinst:63: *** Some mandatory headers (msgbuf.h sembuf.h shmbuf.h) are missing in arch/s390/include/uapi/asm.  Stop.
>
> Apparently you added the three new "generic-y" entries to
> the wrong Kbuild file:
>
> arch/s390/include/asm/Kbuild
>
> instead of
>
> arch/s390/include/uapi/asm/Kbuild.
>
> Please apply/merge the patch below. Thanks!

Thanks a lot for the report. I found that I made the same mistake in
two additonal
architectures. Fixed all three in place now, will upload the fixed branch after
some more testing.

       Arnd
