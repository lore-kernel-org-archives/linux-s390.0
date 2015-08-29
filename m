From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC] asm-generic/pci_iomap.h: make custom PCI BAR requirements
 explicit
Date: Sat, 29 Aug 2015 08:25:05 -0700
Message-ID: <20150829152505.GA23449@infradead.org>
References: <1440807447-584-1-git-send-email-mcgrof@do-not-panic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1440807447-584-1-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, mingo@kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, bp@suse.de, linux@roeck-us.net, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org, "Luis R. Rodriguez" <mcgrof@suse.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Aug 28, 2015 at 05:17:27PM -0700, Luis R. Rodriguez wrote:
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
> 
> While at it, as with the ioremap*() variants, since we have no clear
> semantics yet well defined provide a solution for them that returns
> NULL. This allows architectures to move forward by defining pci_ioremap*()
> variants without requiring immediate changes to all architectures. Each
> architecture then can implement their own solution as needed and
> when they get to it.

Now that you have the config symbol available why not move the S390
implementation to generic code based on that can kill of
asm/pci_iomap.h?  Seems like we're really not dealing with something
inherent to the architecture, but two possible implementations based
on architecture constraints.
