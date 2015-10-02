From: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [RFC] asm-generic/pci_iomap.h: make custom PCI BAR requirements
 explicit
Date: Sat, 3 Oct 2015 01:17:06 +0200
Message-ID: <20151002231706.GI14464@wotan.suse.de>
References: <1440807447-584-1-git-send-email-mcgrof@do-not-panic.com>
 <55E11534.2050508@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55E11534.2050508@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, arnd@arndb.de, linux-arch@vger.kernel.org, mingo@kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, bp@suse.de, linux@roeck-us.net, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Aug 28, 2015 at 07:13:08PM -0700, Randy Dunlap wrote:
> On 08/28/15 17:17, Luis R. Rodriguez wrote:
> > 
> >  arch/s390/Kconfig                 |  8 +++++
> >  arch/s390/include/asm/io.h        | 11 -------
> >  arch/s390/include/asm/pci.h       |  2 --
> >  arch/s390/include/asm/pci_iomap.h | 33 +++++++++++++++++++++
> >  arch/s390/pci/pci.c               |  2 ++
> >  include/asm-generic/io.h          | 12 --------
> >  include/asm-generic/iomap.h       | 10 -------
> >  include/asm-generic/pci_iomap.h   | 62 +++++++++++++++++++++++++++++++++++----
> >  lib/Kconfig                       |  1 +
> >  lib/pci_iomap.c                   |  5 ++++
> >  10 files changed, 105 insertions(+), 41 deletions(-)
> >  create mode 100644 arch/s390/include/asm/pci_iomap.h
> > 
> > diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> > index 1d57000b1b24..1217b7db4265 100644
> > --- a/arch/s390/Kconfig
> > +++ b/arch/s390/Kconfig
> > @@ -614,6 +614,14 @@ endif	# PCI
> >  config PCI_DOMAINS
> >  	def_bool PCI
> >  
> > +config ARCH_PCI_NON_DISJUNCTIVE
> > +	def_bool PCI
> > +	help
> > +	  On the S390 architecture PCI BAR spaces are not disjunctive, as such
> 
> 	are not disjoint?  may be overlapping?
> 
> > +	  the PCI bar is required on a series of otherwise asm generic PCI
> > +	  routines, as such S390 requires itw own implemention for these
> 
> 	                                  its own implementation

Thanks, I've re-written this as:

mcgrof@ergon ~/linux-next (git::(no branch, rebasing 20150805-pend-all))$ git diff
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index f4725d1af438..8ba5826ed13b 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -618,10 +618,10 @@ config PCI_DOMAINS
 config ARCH_PCI_NON_DISJUNCTIVE
        def_bool PCI
        help
-         On the S390 architecture PCI BAR spaces are not disjunctive, as such
-         the PCI bar is required on a series of otherwise asm generic PCI
-         routines, as such S390 requires itw own implemention for these
-         routines.
+         On the S390 architecture PCI BAR spaces may overlap with each other,
+         because of this the PCI bar is required on a series of otherwise asm
+         generic PCI routines and this in turn requires S390 to provide its
+         own implementation for these routines.
 
 config HAS_IOMEM
        def_bool PCI
> 
