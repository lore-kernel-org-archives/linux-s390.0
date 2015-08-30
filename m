From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] asm-generic/pci_iomap.h: make custom PCI BAR requirements explicit
Date: Sun, 30 Aug 2015 21:30:26 +0200
Message-ID: <3544271.GfynADMPqZ@wuerfel>
References: <1440807447-584-1-git-send-email-mcgrof@do-not-panic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <1440807447-584-1-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: linux-arch@vger.kernel.org, mingo@kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, bp@suse.de, linux@roeck-us.net, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org, "Luis R. Rodriguez" <mcgrof@suse.com>
List-ID: <linux-s390.vger.kernel.org>

On Friday 28 August 2015 17:17:27 Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> 
> The S390 architecture requires a custom pci_iomap() implementation
> as the asm-generic implementation assumes there are disjunctions
> between PCI BARs, and on S390 PCI BAR are not disjunctive, S390 requires
> the bar parameter in order to find the corresponding device and create
> the mapping cookie.
> 
> This clash with the asm-generic pci_iomap() implementation is implicit,
> there are no current semantics to make this incompatability explicit.
> Make the S390 PCI BAR non-disjunction incompatibility explicit, and
> also pave the way for alternative incompatibilities to be defined.

I don't think we really need to spell it out here. s390 PCI is different
from everybody else's in a lot of ways, so a simple 'depends on PCI &&
!S390' for CONFIG_PCI_IOMAP seems simpler and more intuitive.

> While at it, as with the ioremap*() variants, since we have no clear
> semantics yet well defined provide a solution for them that returns
> NULL. This allows architectures to move forward by defining pci_ioremap*()
> variants without requiring immediate changes to all architectures. Each
> architecture then can implement their own solution as needed and
> when they get to it.

Which architectures are you thinking about here?

> Build tested with allyesconfig on:
> 
>         * S390
>         * x86_64
> 
> Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>

It's not really clear to me what the purpose of the patch is, is this 
meant as a cleanup, or are you trying to avoid some real-life bugs
you ran into?

> This came up as an idea after noting that S390 has no way to be
> explicit about its requirements, this also means we don't have a
> quick easy way to ensure that other architectures might have a
> conflict as well. This provides an easy way to do that by having
> the architectures define their incompatibilities and allowing those
> then to negate GENERIC_PCI_IOMAP on lib/Kconfig.

PCI_IOMAP seems much simpler than ioport_map here, as a lot of
architectures can have overlapping port numbers across PCI host
bridges.
 
> I think a next cleanup could be the move of the pci_iounmap() out to
> pci_iomap.h to avoid having each arch having to declare it. That's
> a separate atomic change though so should go in separately.

pci_iounmap() is rather tricky, and I think some architectures currently
get it wrong and will actually unmap parts of the I/O port ranges from
the PCI host controller mapping. It might be rare enough that it never
caused problems (that got reported), but it might be nice to actually
provide an implementation that has a chance of working.

The version from lib/iomap.c seems correct for uses of CONFIG_GENERIC_IOMAP,
but most architectures can do better without that option.

	Arnd
