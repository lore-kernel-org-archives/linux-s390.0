From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [RFC] asm-generic/pci_iomap.h: make custom PCI BAR requirements
 explicit
Date: Fri, 28 Aug 2015 19:13:08 -0700
Message-ID: <55E11534.2050508@infradead.org>
References: <1440807447-584-1-git-send-email-mcgrof@do-not-panic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <1440807447-584-1-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, arnd@arndb.de, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, bp@suse.de, linux@roeck-us.net, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org, "Luis R. Rodriguez" <mcgrof@suse.com>
List-ID: <linux-s390.vger.kernel.org>

On 08/28/15 17:17, Luis R. Rodriguez wrote:
> 
>  arch/s390/Kconfig                 |  8 +++++
>  arch/s390/include/asm/io.h        | 11 -------
>  arch/s390/include/asm/pci.h       |  2 --
>  arch/s390/include/asm/pci_iomap.h | 33 +++++++++++++++++++++
>  arch/s390/pci/pci.c               |  2 ++
>  include/asm-generic/io.h          | 12 --------
>  include/asm-generic/iomap.h       | 10 -------
>  include/asm-generic/pci_iomap.h   | 62 +++++++++++++++++++++++++++++++++++----
>  lib/Kconfig                       |  1 +
>  lib/pci_iomap.c                   |  5 ++++
>  10 files changed, 105 insertions(+), 41 deletions(-)
>  create mode 100644 arch/s390/include/asm/pci_iomap.h
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 1d57000b1b24..1217b7db4265 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -614,6 +614,14 @@ endif	# PCI
>  config PCI_DOMAINS
>  	def_bool PCI
>  
> +config ARCH_PCI_NON_DISJUNCTIVE
> +	def_bool PCI
> +	help
> +	  On the S390 architecture PCI BAR spaces are not disjunctive, as such

	are not disjoint?  may be overlapping?

> +	  the PCI bar is required on a series of otherwise asm generic PCI
> +	  routines, as such S390 requires itw own implemention for these

	                                  its own implementation

> +	  routines.
> +
>  config HAS_IOMEM
>  	def_bool PCI
>  


-- 
~Randy
