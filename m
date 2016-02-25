From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 2/5] all: introduce COMPAT_WRAPPER option and enable it
 for s390
Date: Thu, 25 Feb 2016 23:19:26 +0300
Message-ID: <20160225201926.GA16123@yury-N73SV>
References: <1456338854-14901-1-git-send-email-ynorov@caviumnetworks.com>
 <1456338854-14901-3-git-send-email-ynorov@caviumnetworks.com>
 <20160225084943.GB3980@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160225084943.GB3980@osiris>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, arnd@arndb.de, linux-doc@vger.kernel.org, Prasun.Kapoor@caviumnetworks.com, catalin.marinas@arm.com, pinskia@gmail.com, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, agraf@suse.de, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, joseph@codesourcery.com, linux-arm-kernel@lists.infradead.org, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, Feb 25, 2016 at 09:49:43AM +0100, Heiko Carstens wrote:
> On Wed, Feb 24, 2016 at 09:34:11PM +0300, Yury Norov wrote:
> > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> > ---
> >  arch/Kconfig      | 4 ++++
> >  arch/s390/Kconfig | 1 +
> >  2 files changed, 5 insertions(+)
> > 
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index f6b649d..6393093 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -583,6 +583,10 @@ config HAVE_COPY_THREAD_TLS
> >  	  normal C parameter passing, rather than extracting the syscall
> >  	  argument from pt_regs.
> > 
> > +config COMPAT_WRAPPER
> > +	bool
> > +	depends on COMPAT
> > +
> >  #
> >  # ABI hall of shame
> >  #
> > diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> > index 3be9c83..082b861 100644
> > --- a/arch/s390/Kconfig
> > +++ b/arch/s390/Kconfig
> > @@ -333,6 +333,7 @@ config COMPAT
> >  	select COMPAT_BINFMT_ELF if BINFMT_ELF
> >  	select ARCH_WANT_OLD_COMPAT_IPC
> >  	select COMPAT_OLD_SIGACTION
> > +	select COMPAT_WRAPPER
> >  	depends on MULTIUSER
> >  	help
> >  	  Select this option if you want to enable your system kernel to
> 
> Maybe merge this into patch 4/5?

Then bisectability will suffer, as next patch needs COMPAT_WRAPPER
enabled.

> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
