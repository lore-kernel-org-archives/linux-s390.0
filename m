Return-Path: <SRS0=9OyC=PS=vger.kernel.org=linux-pci-owner@kernel.org>
Subject: Re: Kconfig label updates
References: <20190108223024.GA147017@google.com>
 <87tviiroqy.fsf@concordia.ellerman.id.au>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Thu, 10 Jan 2019 12:37:22 -0800
MIME-Version: 1.0
In-Reply-To: <87tviiroqy.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <83241c8b-8f44-162b-b42a-0f4f9bb858e7@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-pci/>
List-Post: <mailto:linux-pci@vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 01/09/2019 04:37 AM, Michael Ellerman wrote:
> Hi Bjorn,
> 
> Bjorn Helgaas <helgaas@kernel.org> writes:
>> Hi,
>>
>> I want to update the PCI Kconfig labels so they're more consistent and
>> useful to users, something like the patch below.  IIUC, the items
>> below are all IBM-related; please correct me if not.
>>
>> I'd also like to expand (or remove) "RPA" because Google doesn't find
>> anything about "IBM RPA", except Robotic Process Automation, which I
>> think must be something else.
> 
> Yeah I think just remove it, it's not a well known term and is unlikely
> to help anyone these days.
> 
> It stands for "RISC Platform Architecture", which was some kind of
> specification for Power machines back in the day, but from what I can
> tell it was never used in marketing or manuals much (hence so few hits
> on Google).

It is basically the predecessor to PAPR "Power Architecture Platform Reference".
Which the LoPAPR document is available through power.org. Not sure if there is
any desire to adopt PAPR in place of RPA. It is the platform reference doc that
outlines how we do DLPAR and PCI Hotplug.

> 
>> Is there some text expansion of RPA that we could use that would be
>> meaningful to a user, i.e., something he/she might find on a nameplate
>> or in a user manual?
> 
> No I don't think so.
> 
>> Ideally the PCI Kconfig labels would match the terms used in
>> arch/.../Kconfig, e.g.,
>>
>>   config PPC_POWERNV
>>     bool "IBM PowerNV (Non-Virtualized) platform support"
>>
>>   config PPC_PSERIES
>>     bool "IBM pSeries & new (POWER5-based) iSeries"
> 
> TBH these are pretty unhelpful too. PowerNV is not a marketing name and
> so doesn't appear anywhere much in official manuals or brochures and
> it's also used on non-IBM branded machines. And pSeries & iSeries were
> marketing names but are no longer used.

pseries is still used as a machine type for PAPR compliant qemu/kvm instances.

Again, just my 2 cents. I'm pretty open to whatever makes the most sense.

-Tyrel

> 
> We should probably update that text, but we can do that later, rather
> than blocking this patch.
> 
>> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
>> index e9f78eb390d2..1c1d145bfd84 100644
>> --- a/drivers/pci/hotplug/Kconfig
>> +++ b/drivers/pci/hotplug/Kconfig
>> @@ -112,7 +112,7 @@ config HOTPLUG_PCI_SHPC
>>  	  When in doubt, say N.
>>  
>>  config HOTPLUG_PCI_POWERNV
>> -	tristate "PowerPC PowerNV PCI Hotplug driver"
>> +	tristate "IBM PowerNV PCI Hotplug driver"
> 
> This is used in non-IBM machines as well.
> 
> So perhaps: ?
> 
> 	tristate "IBM/OpenPower PowerNV (bare metal) PCI Hotplug driver"
> 
>> @@ -125,10 +125,11 @@ config HOTPLUG_PCI_POWERNV
>>  	  When in doubt, say N.
>>  
>>  config HOTPLUG_PCI_RPA
>> -	tristate "RPA PCI Hotplug driver"
>> +	tristate "IBM Power Systems RPA PCI Hotplug driver"
> 
> I think just drop RPA here.
> 
>>  	depends on PPC_PSERIES && EEH
>>  	help
>>  	  Say Y here if you have a RPA system that supports PCI Hotplug.
> 
> s/RPA/IBM Power Systems/
> 
>> +	  This includes the earlier pSeries and iSeries.
> 
> To be complete:
> 	  This includes the earlier System p, System i, pSeries and iSeries.
> 
>>  
>>  	  To compile this driver as a module, choose M here: the
>>  	  module will be called rpaphp.
>> @@ -136,7 +137,7 @@ config HOTPLUG_PCI_RPA
>>  	  When in doubt, say N.
>>  
>>  config HOTPLUG_PCI_RPA_DLPAR
>> -	tristate "RPA Dynamic Logical Partitioning for I/O slots"
>> +	tristate "IBM RPA Dynamic Logical Partitioning for I/O slots"
> 
> Again just drop RPA.
> 
> 
> cheers
> 
