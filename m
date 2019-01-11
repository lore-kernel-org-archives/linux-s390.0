Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Kconfig label updates
In-Reply-To: <83241c8b-8f44-162b-b42a-0f4f9bb858e7@linux.vnet.ibm.com>
References: <20190108223024.GA147017@google.com> <87tviiroqy.fsf@concordia.ellerman.id.au> <83241c8b-8f44-162b-b42a-0f4f9bb858e7@linux.vnet.ibm.com>
Date: Fri, 11 Jan 2019 17:06:12 +1100
Message-ID: <874lafg23v.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-pci/>
List-Post: <mailto:linux-pci@vger.kernel.org>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:
> On 01/09/2019 04:37 AM, Michael Ellerman wrote:
>> Bjorn Helgaas <helgaas@kernel.org> writes:
>>> I want to update the PCI Kconfig labels so they're more consistent and
>>> useful to users, something like the patch below.  IIUC, the items
>>> below are all IBM-related; please correct me if not.
>>>
>>> I'd also like to expand (or remove) "RPA" because Google doesn't find
>>> anything about "IBM RPA", except Robotic Process Automation, which I
>>> think must be something else.
>> 
>> Yeah I think just remove it, it's not a well known term and is unlikely
>> to help anyone these days.
>> 
>> It stands for "RISC Platform Architecture", which was some kind of
>> specification for Power machines back in the day, but from what I can
>> tell it was never used in marketing or manuals much (hence so few hits
>> on Google).
>
> It is basically the predecessor to PAPR "Power Architecture Platform Reference".
> Which the LoPAPR document is available through power.org. Not sure if there is
> any desire to adopt PAPR in place of RPA. It is the platform reference doc that
> outlines how we do DLPAR and PCI Hotplug.

True. But a user is unlikely to know "PAPR" either, and it googles badly.

LoPAPR I guess is better, you can google for it, though I'm not entirely
sure if everything used by this code is actually in LoPAPR, because some
bits of PAPR were ripped out of LoPAPR.

>>> Ideally the PCI Kconfig labels would match the terms used in
>>> arch/.../Kconfig, e.g.,
>>>
>>>   config PPC_POWERNV
>>>     bool "IBM PowerNV (Non-Virtualized) platform support"
>>>
>>>   config PPC_PSERIES
>>>     bool "IBM pSeries & new (POWER5-based) iSeries"
>> 
>> TBH these are pretty unhelpful too. PowerNV is not a marketing name and
>> so doesn't appear anywhere much in official manuals or brochures and
>> it's also used on non-IBM branded machines. And pSeries & iSeries were
>> marketing names but are no longer used.
>
> pseries is still used as a machine type for PAPR compliant qemu/kvm instances.

Yeah so I guess it's helpful for someone configuring a kernel with that
in mind.

But if you've bought an IBM branded system the "pseries" name is not
used anywhere AFAIK.

cheers
