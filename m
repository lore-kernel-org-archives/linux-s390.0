Return-Path: <SRS0=X3es=PR=vger.kernel.org=linux-pci-owner@kernel.org>
MIME-Version: 1.0
References: <20190108223024.GA147017@google.com>
In-Reply-To: <20190108223024.GA147017@google.com>
From: Oliver <oohall@gmail.com>
Date: Wed, 9 Jan 2019 12:00:58 +1100
Message-ID: <CAOSf1CFRjynR_qCOH=RXGEqpV6PuhHwzCHhKsniNPojEcif8rg@mail.gmail.com>
Subject: Re: Kconfig label updates
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-pci/>
List-Post: <mailto:linux-pci@vger.kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jan 9, 2019 at 9:31 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Hi,
>
> I want to update the PCI Kconfig labels so they're more consistent and
> useful to users, something like the patch below.  IIUC, the items
> below are all IBM-related; please correct me if not.
>
> I'd also like to expand (or remove) "RPA" because Google doesn't find
> anything about "IBM RPA", except Robotic Process Automation, which I
> think must be something else.
>
> Is there some text expansion of RPA that we could use that would be
> meaningful to a user, i.e., something he/she might find on a nameplate
> or in a user manual?

"RISC Platform Architecture" apparently. I couldn't find any
documentation written in the last decade that uses the term so it's
probably a hold-over from when pseries and iseries had separate
hardware platforms. Replacing "RPA" with "pseries" would be the least
confusing way to handle it.

> Ideally the PCI Kconfig labels would match the terms used in
> arch/.../Kconfig, e.g.,
>
>   config PPC_POWERNV
>     bool "IBM PowerNV (Non-Virtualized) platform support"
>
>   config PPC_PSERIES
>     bool "IBM pSeries & new (POWER5-based) iSeries"
>
>   config MARCH_Z900
>     bool "IBM zSeries model z800 and z900"
>
>   config MARCH_Z9_109
>     bool "IBM System z9"
>
> Bjorn
>
>
> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
> index e9f78eb390d2..1c1d145bfd84 100644
> --- a/drivers/pci/hotplug/Kconfig
> +++ b/drivers/pci/hotplug/Kconfig
> @@ -112,7 +112,7 @@ config HOTPLUG_PCI_SHPC
>           When in doubt, say N.
>
>  config HOTPLUG_PCI_POWERNV
> -       tristate "PowerPC PowerNV PCI Hotplug driver"
> +       tristate "IBM PowerNV PCI Hotplug driver"
>         depends on PPC_POWERNV && EEH
>         select OF_DYNAMIC
>         help
> @@ -125,10 +125,11 @@ config HOTPLUG_PCI_POWERNV
>           When in doubt, say N.
>
>  config HOTPLUG_PCI_RPA
> -       tristate "RPA PCI Hotplug driver"
> +       tristate "IBM Power Systems RPA PCI Hotplug driver"
>         depends on PPC_PSERIES && EEH
>         help
>           Say Y here if you have a RPA system that supports PCI Hotplug.
> +         This includes the earlier pSeries and iSeries.
>
>           To compile this driver as a module, choose M here: the
>           module will be called rpaphp.
> @@ -136,7 +137,7 @@ config HOTPLUG_PCI_RPA
>           When in doubt, say N.
>
>  config HOTPLUG_PCI_RPA_DLPAR
> -       tristate "RPA Dynamic Logical Partitioning for I/O slots"
> +       tristate "IBM RPA Dynamic Logical Partitioning for I/O slots"
>         depends on HOTPLUG_PCI_RPA
>         help
>           Say Y here if your system supports Dynamic Logical Partitioning
> @@ -157,7 +158,7 @@ config HOTPLUG_PCI_SGI
>           When in doubt, say N.
>
>  config HOTPLUG_PCI_S390
> -       bool "System z PCI Hotplug Support"
> +       bool "IBM System z PCI Hotplug Support"
>         depends on S390 && 64BIT
>         help
>           Say Y here if you want to use the System z PCI Hotplug
