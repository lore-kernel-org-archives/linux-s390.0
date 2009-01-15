From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [BUILD_FAILURE] next-20090115 - s390x - mm/kmemleak.c
Date: Thu, 15 Jan 2009 12:20:01 +0100
Message-ID: <20090115112001.GC5093@osiris.boeblingen.de.ibm.com>
References: <20090115170415.3edc1df6.sfr@canb.auug.org.au> <20090115103504.GA5178@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090115103504.GA5178@linux.vnet.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, catalin.marinas@arm.com, penberg@cs.helsinki.fi
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 15, 2009 at 04:05:04PM +0530, Kamalesh Babulal wrote:
> Hi Stephen,
> 
> 	next-20090115 allyesconfig build fails on s390x
> 
> mm/built-in.o: In function `kmemleak_scan':
> mm/kmemleak.c:977: undefined reference to `_sdata'
> make: *** [.tmp_vmlinux1] Error 1

A lot of architectures don't have _sdata definined in their linker scripts.
On s390 _sdata would be the same as _etext. But that is not necessarily true
for all architectures.
