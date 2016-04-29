From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 25/25] arm64:ilp32: add ARM64_ILP32 to Kconfig
Date: Fri, 29 Apr 2016 19:26:12 +0300
Message-ID: <20160429162612.GB16451@yury-N73SV>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1459894127-17698-26-git-send-email-ynorov@caviumnetworks.com>
 <20160429160334.GD30316@e104818-lin.cambridge.arm.com>
 <20160429160855.GA16451@yury-N73SV>
 <20160429161445.GE30316@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160429161445.GE30316@e104818-lin.cambridge.arm.com>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, arnd@arndb.de, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, joseph@codesourcery.com, linux-doc@vger.kernel.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, agraf@suse.de, klimov.linux@gmail.com, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, broonie@kernel.org, bamvor.zhangjian@huawei.com, Andrew Pinski <apinski@cavium.com>, schwidefsky@de.ibm.com, Nathan_Lynch@mentor.com, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, linux-arm-kernel@lists.infradead.org, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, Apr 29, 2016 at 05:14:46PM +0100, Catalin Marinas wrote:
> On Fri, Apr 29, 2016 at 07:08:55PM +0300, Yury Norov wrote:
> > On Fri, Apr 29, 2016 at 05:03:34PM +0100, Catalin Marinas wrote:
> > > On Wed, Apr 06, 2016 at 01:08:47AM +0300, Yury Norov wrote:
> > > > +config ARM64_ILP32
> > > > +	bool "Kernel support for ILP32"
> > > > +	select COMPAT_WRAPPER
> > > > +	help
> > > > +	  This option enables support for AArch64 ILP32 user space.  ILP32
> > > > +	  is an ABI where long and pointers are 32bits but it uses the AARCH64
> > > > +	  instruction set.
> > > 
> > > Is there any penalty for AArch32 tasks when selecting COMPAT_WRAPPER?
> > 
> > No. AARCH32 doesn't define __SC_WRAP and so __SYSCALL macro is used,
> > which fills syscall table with sys_xxx versions, not compat_sys_xxx.
> 
> Ah, I forgot it has its own unistd32.h.
> 
> Thanks.

Even if it was sharing generic unistd,h, it's OK as well. To use
wrappers, you have to enable COMPAT_WRAPPER (which is enabled even if
only a single ABI needs it) *and* define  __SC_WRAP in corresponding
sys_xxx.c, which is individual for each abi, of course.

> 
> -- 
> Catalin
