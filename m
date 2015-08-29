From: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [PATCH] S390: add pci_iomap_wc() and pci_iomap_wc_range()
Date: Sat, 29 Aug 2015 02:14:52 +0200
Message-ID: <20150829001452.GJ8051@wotan.suse.de>
References: <1440632050-23648-1-git-send-email-mcgrof@do-not-panic.com>
 <20150828060605.GF26741@gmail.com>
 <55E01A43.9080109@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55E01A43.9080109@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Ingo Molnar <mingo@kernel.org>, "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, bp@suse.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, fengguang.wu@intel.com, akpm@linux-foundation.org, rostedt@goodmis.org, linux-arch@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Aug 28, 2015 at 01:22:27AM -0700, Guenter Roeck wrote:
> On 08/27/2015 11:06 PM, Ingo Molnar wrote:
> >
> >* Luis R. Rodriguez <mcgrof@do-not-panic.com> wrote:
> >
> >>From: "Luis R. Rodriguez" <mcgrof@suse.com>
> >>
> >>S390 requires its own implementation of pcio_iomap*() calls
> >>is because it has its "BAR spaces are not disjunctive on s390
> >>so we need the bar parameter of pci_iomap to find the corresponding
> >>device and create the mapping cookie" -- in summary, it has its own
> >>lookup/lock solution.
> >>
> >>It does not include asm-generic/pci_iomap.h
> >>
> >>Since it currenty maps ioremap_wc() to ioremap_nocache() and that's
> >>the architecture default we can easily just map the wc calls to
> >>the default calls as well.
> >>
> >>Cc: Guenter Roeck <linux@roeck-us.net>
> >>Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> >>Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> >>Cc: linux-fbdev@vger.kernel.org
> >>Cc: linux-kernel@vger.kernel.org
> >>Cc: Borislav Petkov <bp@suse.de>
> >>Cc: Ingo Molnar <mingo@kernel.org>
> >>Cc: Fengguang Wu <fengguang.wu@intel.com>
> >>Cc: Andrew Morton <akpm@linux-foundation.org>
> >>Cc: Steven Rostedt <rostedt@goodmis.org>
> >>Reported-by: 0 day bot
> >>Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
> >>---
> >>
> >>This broke through some series that went into Ingo's tip tree which
> >>I added. As such I *think* this should go through Ingo's tip tree.
> >>Let me know. Up to you guys.
> >
> >I fixed the changelog to explain all this.
> >
> >Also, is there any other architecture that got broken by:
> >
> >    1b3d4200c1e0 PCI: Add pci_iomap_wc() variants
> >
> 
> Should be the only one. There are only two implementations of pci_iomap(),
> one in s390 code and the generic implementation.

Indeed, sadly there is no semantics well defined to establish this requirement
so the best we can do is infer:

mcgrof@ergon ~/linux-next (git::20150805-pend-all)$ git grep pci_iomap_range arch/
arch/s390/include/asm/io.h:#define pci_iomap_wc_range pci_iomap_range
arch/s390/pci/pci.c:void __iomem *pci_iomap_range(struct pci_dev *pdev,
arch/s390/pci/pci.c:EXPORT_SYMBOL(pci_iomap_range);
arch/s390/pci/pci.c:    return pci_iomap_range(dev, bar, 0, maxlen);

To this end a Kconfig option to implicate this might be more well suited for
future lookups and make other architectures which are incompatible with
generic pci_iomap clearer. Will post an RFC.

  Luis
