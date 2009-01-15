From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [BUILD_FAILURE] next-20090115 - s390x - mm/kmemleak.c
Date: Thu, 15 Jan 2009 14:08:00 +0200
Message-ID: <1232021280.11860.0.camel@penberg-laptop>
References: <20090115170415.3edc1df6.sfr@canb.auug.org.au>
	 <20090115103504.GA5178@linux.vnet.ibm.com>
	 <20090115112001.GC5093@osiris.boeblingen.de.ibm.com>
	 <1232020540.32016.19.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <1232020540.32016.19.camel@pc1117.cambridge.arm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2009-01-15 at 11:55 +0000, Catalin Marinas wrote:
> On Thu, 2009-01-15 at 12:20 +0100, Heiko Carstens wrote:
> > On Thu, Jan 15, 2009 at 04:05:04PM +0530, Kamalesh Babulal wrote:
> > > Hi Stephen,
> > > 
> > > 	next-20090115 allyesconfig build fails on s390x
> > > 
> > > mm/built-in.o: In function `kmemleak_scan':
> > > mm/kmemleak.c:977: undefined reference to `_sdata'
> > > make: *** [.tmp_vmlinux1] Error 1
> > 
> > A lot of architectures don't have _sdata definined in their linker scripts.
> > On s390 _sdata would be the same as _etext. But that is not necessarily true
> > for all architectures.
> 
> Kmemleak has only been tested on ARM and x86. I can add patches for the
> other architectures so that the compilation is fine but can't really run
> such kernels.

Yeah, but you could just depend on X86 || ARM in Kconfig, no?
