Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Kconfig label updates
In-Reply-To: <20190111112024.GD14180@gate.crashing.org>
References: <20190108223024.GA147017@google.com> <87tviiroqy.fsf@concordia.ellerman.id.au> <83241c8b-8f44-162b-b42a-0f4f9bb858e7@linux.vnet.ibm.com> <874lafg23v.fsf@concordia.ellerman.id.au> <20190111112024.GD14180@gate.crashing.org>
Date: Mon, 14 Jan 2019 21:42:48 +1100
Message-ID: <87muo3zfiv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-pci/>
List-Post: <mailto:linux-pci@vger.kernel.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, Bjorn Helgaas <helgaas@kernel.org>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

Segher Boessenkool <segher@kernel.crashing.org> writes:

> On Fri, Jan 11, 2019 at 05:06:12PM +1100, Michael Ellerman wrote:
>> Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:
>> > It is basically the predecessor to PAPR "Power Architecture Platform Reference".
>> > Which the LoPAPR document is available through power.org. Not sure if there is
>> > any desire to adopt PAPR in place of RPA. It is the platform reference doc that
>> > outlines how we do DLPAR and PCI Hotplug.
>> 
>> True. But a user is unlikely to know "PAPR" either, and it googles badly.
>
> Googling for "powerpc papr" works fine afais?  With a working link to a
> pdf on the first page and all!

True if you know to add "powerpc".

I only get a link to LoPAPR, which is similar but not identical. If
there's a link to PAPR then someone is in trouble :)

cheers
