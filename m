Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727007AbgKQSjr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Nov 2020 13:39:47 -0500
Date: Tue, 17 Nov 2020 19:39:25 +0100
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: irq-loongson-pch-pic.c:undefined reference to `of_iomap'
Message-ID: <20201117183925.GC4746@osiris>
References: <202011140757.5QyVghe2-lkp@intel.com>
 <4f6f2244-033c-8413-818d-0b9c1b0b33ae@infradead.org>
 <CAK8P3a0w5MpvExp1jShAhqZ3Z08HjMALic6x2K+1_0eqFUi5QA@mail.gmail.com>
 <CAMuHMdU2L5GcEHdCHh_1-WaVVQNGkm0-CwFW5D1KS0dkqBQ3zw@mail.gmail.com>
 <CAK8P3a2+DvA4zwRBh_0cCuXJWxsg3SX8rQRZYfgB=8We9R6uiQ@mail.gmail.com>
 <20201117183455.GA101572@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117183455.GA101572@kozik-lap>
List-ID: <linux-s390.vger.kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Randy Dunlap <rdunlap@infradead.org>, kernel test robot <lkp@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, kbuild-all@lists.01.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Tue, Nov 17, 2020 at 07:34:55PM +0100, Krzysztof Kozlowski wrote:
> > Looking a bit further, I now find that we ended up disabling CONFIG_COMPILE_TEST
> > entirely for arch/um, which is clearly an option that would also work for s390.
> 
> Yes, that was the easier solution than to spread "depends on HAS_IOMEM"
> all over Kconfigs.
> 
> +Cc Greg KH,
> 
> I got similar report around phy drivers:
> https://lore.kernel.org/lkml/202011140335.tceVqHmN-lkp@intel.com/
> 
> When reproducing this, I saw multiple unmet dependencies on s390 for
> MFD_SYSCON and MFD_STM32_TIMERS.
> 
> I suppose there is no point to fix them all because this will be
> basically UML case, so HAS_IOMEM all over the tree.

FWIW, I just replied a couple of minutes, but you might have missed
that:
---
I'll add a patch to the s390 tree which disables CONFIG_COMPILE_TEST
for s390. I wouldn't like to start again chasing/adding missing
'select' or 'depends on' statements in various config files.
---
