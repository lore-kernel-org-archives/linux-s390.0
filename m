Return-Path: <SRS0=X3es=PR=vger.kernel.org=linux-pci-owner@kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Kconfig label updates
In-Reply-To: <20190108223024.GA147017@google.com>
References: <20190108223024.GA147017@google.com>
Date: Wed, 09 Jan 2019 23:37:09 +1100
Message-ID: <87tviiroqy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-pci/>
List-Post: <mailto:linux-pci@vger.kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Bjorn,

Bjorn Helgaas <helgaas@kernel.org> writes:
> Hi,
>
> I want to update the PCI Kconfig labels so they're more consistent and
> useful to users, something like the patch below.  IIUC, the items
> below are all IBM-related; please correct me if not.
>
> I'd also like to expand (or remove) "RPA" because Google doesn't find
> anything about "IBM RPA", except Robotic Process Automation, which I
> think must be something else.

Yeah I think just remove it, it's not a well known term and is unlikely
to help anyone these days.

It stands for "RISC Platform Architecture", which was some kind of
specification for Power machines back in the day, but from what I can
tell it was never used in marketing or manuals much (hence so few hits
on Google).

> Is there some text expansion of RPA that we could use that would be
> meaningful to a user, i.e., something he/she might find on a nameplate
> or in a user manual?

No I don't think so.

> Ideally the PCI Kconfig labels would match the terms used in
> arch/.../Kconfig, e.g.,
>
>   config PPC_POWERNV
>     bool "IBM PowerNV (Non-Virtualized) platform support"
>
>   config PPC_PSERIES
>     bool "IBM pSeries & new (POWER5-based) iSeries"

TBH these are pretty unhelpful too. PowerNV is not a marketing name and
so doesn't appear anywhere much in official manuals or brochures and
it's also used on non-IBM branded machines. And pSeries & iSeries were
marketing names but are no longer used.

We should probably update that text, but we can do that later, rather
than blocking this patch.

> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
> index e9f78eb390d2..1c1d145bfd84 100644
> --- a/drivers/pci/hotplug/Kconfig
> +++ b/drivers/pci/hotplug/Kconfig
> @@ -112,7 +112,7 @@ config HOTPLUG_PCI_SHPC
>  	  When in doubt, say N.
>  
>  config HOTPLUG_PCI_POWERNV
> -	tristate "PowerPC PowerNV PCI Hotplug driver"
> +	tristate "IBM PowerNV PCI Hotplug driver"

This is used in non-IBM machines as well.

So perhaps: ?

	tristate "IBM/OpenPower PowerNV (bare metal) PCI Hotplug driver"

> @@ -125,10 +125,11 @@ config HOTPLUG_PCI_POWERNV
>  	  When in doubt, say N.
>  
>  config HOTPLUG_PCI_RPA
> -	tristate "RPA PCI Hotplug driver"
> +	tristate "IBM Power Systems RPA PCI Hotplug driver"

I think just drop RPA here.

>  	depends on PPC_PSERIES && EEH
>  	help
>  	  Say Y here if you have a RPA system that supports PCI Hotplug.

s/RPA/IBM Power Systems/

> +	  This includes the earlier pSeries and iSeries.

To be complete:
	  This includes the earlier System p, System i, pSeries and iSeries.

>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called rpaphp.
> @@ -136,7 +137,7 @@ config HOTPLUG_PCI_RPA
>  	  When in doubt, say N.
>  
>  config HOTPLUG_PCI_RPA_DLPAR
> -	tristate "RPA Dynamic Logical Partitioning for I/O slots"
> +	tristate "IBM RPA Dynamic Logical Partitioning for I/O slots"

Again just drop RPA.


cheers
