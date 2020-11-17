Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 17 Nov 2020 19:28:45 +0100
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: irq-loongson-pch-pic.c:undefined reference to `of_iomap'
Message-ID: <20201117182845.GB4746@osiris>
References: <202011140757.5QyVghe2-lkp@intel.com>
 <4f6f2244-033c-8413-818d-0b9c1b0b33ae@infradead.org>
 <CAK8P3a0w5MpvExp1jShAhqZ3Z08HjMALic6x2K+1_0eqFUi5QA@mail.gmail.com>
 <CAMuHMdU2L5GcEHdCHh_1-WaVVQNGkm0-CwFW5D1KS0dkqBQ3zw@mail.gmail.com>
 <CAK8P3a2+DvA4zwRBh_0cCuXJWxsg3SX8rQRZYfgB=8We9R6uiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2+DvA4zwRBh_0cCuXJWxsg3SX8rQRZYfgB=8We9R6uiQ@mail.gmail.com>
List-ID: <linux-s390.vger.kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Randy Dunlap <rdunlap@infradead.org>, kernel test robot <lkp@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, kbuild-all@lists.01.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Mon, Nov 16, 2020 at 10:21:26AM +0100, Arnd Bergmann wrote:
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

I'll add a patch to the s390 tree which disables CONFIG_COMPILE_TEST
for s390. I wouldn't like to start again chasing/adding missing
'select' or 'depends on' statements in various config files.
