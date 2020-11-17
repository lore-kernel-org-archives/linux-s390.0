Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wr1-f43.google.com ([209.85.221.43]:44850 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbgKQSfA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 17 Nov 2020 13:35:00 -0500
Date: Tue, 17 Nov 2020 19:34:55 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: irq-loongson-pch-pic.c:undefined reference to `of_iomap'
Message-ID: <20201117183455.GA101572@kozik-lap>
References: <202011140757.5QyVghe2-lkp@intel.com>
 <4f6f2244-033c-8413-818d-0b9c1b0b33ae@infradead.org>
 <CAK8P3a0w5MpvExp1jShAhqZ3Z08HjMALic6x2K+1_0eqFUi5QA@mail.gmail.com>
 <CAMuHMdU2L5GcEHdCHh_1-WaVVQNGkm0-CwFW5D1KS0dkqBQ3zw@mail.gmail.com>
 <CAK8P3a2+DvA4zwRBh_0cCuXJWxsg3SX8rQRZYfgB=8We9R6uiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a2+DvA4zwRBh_0cCuXJWxsg3SX8rQRZYfgB=8We9R6uiQ@mail.gmail.com>
List-ID: <linux-s390.vger.kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Randy Dunlap <rdunlap@infradead.org>, kernel test robot <lkp@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, kbuild-all@lists.01.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Mon, Nov 16, 2020 at 10:21:26AM +0100, Arnd Bergmann wrote:
> On Mon, Nov 16, 2020 at 9:37 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, Nov 16, 2020 at 9:33 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > > On Mon, Nov 16, 2020 at 5:33 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> > > > On 11/13/20 3:27 PM, kernel test robot wrote:
> > > (adding s390 folks to cc)
> > >
> > > I think fixing this requires a larger-scale effort. I tried building
> > > an s390 allmodconfig
> > > with CONFIG_PCI disabled, and got warnings and failures in many other places,
> > > see full log at the end of this mail.
> > >
> > > While in theory, all of those should depend on 'HAS_IOMEM' or some other symbol,
> > > keeping these dependencies sounds like an uphill battle, and there is not much
> > > to be gained from building the drivers for s390 on top of compile-testing them
> > > on more conventional architectures.
> >
> > Don't we need the dependencies on HAS_IOMEM for the CONFIG_UML=y
> > case, too?
> 
> I would have expected that as well, but I don't see the problem when building
> an arch/um kernel, all I get is
> 
> ERROR: modpost: "devm_platform_ioremap_resource"
> [drivers/iio/adc/adi-axi-adc.ko] undefined!
> ERROR: modpost: "devm_platform_ioremap_resource"
> [drivers/ptp/ptp_ines.ko] undefined!
> ERROR: modpost: "devm_ioremap_resource"
> [drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!
> ERROR: modpost: "devm_platform_ioremap_resource_byname"
> [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!
> ERROR: modpost: "devm_ioremap"
> [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!
> ERROR: modpost: "devm_of_iomap"
> [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!
> ERROR: modpost: "__open64_2" [fs/hostfs/hostfs.ko] undefined!
> 
> If I disable those five drivers, I can build and link a uml kernel without
> warnings. I could not find the difference compared to s390 here.
> 
> Looking a bit further, I now find that we ended up disabling CONFIG_COMPILE_TEST
> entirely for arch/um, which is clearly an option that would also work for s390.

Yes, that was the easier solution than to spread "depends on HAS_IOMEM"
all over Kconfigs.

+Cc Greg KH,

I got similar report around phy drivers:
https://lore.kernel.org/lkml/202011140335.tceVqHmN-lkp@intel.com/

When reproducing this, I saw multiple unmet dependencies on s390 for
MFD_SYSCON and MFD_STM32_TIMERS.

I suppose there is no point to fix them all because this will be
basically UML case, so HAS_IOMEM all over the tree.

Best regards,
Krzysztof
