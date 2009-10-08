From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: next-20091007 - comedi driver build breaks on S390x
Date: Thu, 8 Oct 2009 10:55:28 +0200
Message-ID: <20091008105528.55616624@mschwide.boeblingen.de.ibm.com>
References: <20091007173517.abfcfa2a.sfr@canb.auug.org.au>
	<20091007105458.GA5472@linux.vnet.ibm.com>
	<20091007130744.GA26081@suse.de>
	<20091007173415.5155d995@mschwide.boeblingen.de.ibm.com>
	<20091007172715.GA28562@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20091007172715.GA28562@suse.de>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Greg KH <gregkh@suse.de>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, devel@driverdev.osuosl.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 7 Oct 2009 10:27:15 -0700
Greg KH <gregkh@suse.de> wrote:

> On Wed, Oct 07, 2009 at 05:34:15PM +0200, Martin Schwidefsky wrote:
> > On Wed, 7 Oct 2009 06:07:44 -0700
> > Greg KH <gregkh@suse.de> wrote:
> > 
> > > On Wed, Oct 07, 2009 at 04:24:58PM +0530, Kamalesh Babulal wrote:
> > > > Hi Greg,
> > > > 
> > > > 	next-20091007 randconfig build breaks on s390x with build error
> > > > 
> > > > drivers/staging/comedi/comedi_fops.c: In function 'comedi_mmap':
> > > > drivers/staging/comedi/comedi_fops.c:1453: error: 'PAGE_SHARED' undeclared (first use in this function)
> > > > drivers/staging/comedi/comedi_fops.c:1453: error: (Each undeclared identifier is reported only once
> > > > drivers/staging/comedi/comedi_fops.c:1453: error: for each function it appears in.)
> > > > make[3]: *** [drivers/staging/comedi/comedi_fops.o] Error 1
> > > 
> > > Odd.  What changed in the header files to cause this?
> > 
> > The problem has always been present, only now did randconfig find it.
> > The compile breaks because PAGE_SHARED is not defined for s390. The
> > equivalent define for s390 is PAGE_RW. The problem has not shown up so
> > far because all drivers who use the remap_pfn_range call with
> > PAGE_SHARED has dependencies not available on s390, e.g. CONFIG_PCI.
> > 
> > To fix this I see are two options: 1) add a PAGE_SHARED define to
> > arch/s390/include/asm/pgtable.h, 2) make comedi depend on !S390.
> 
> I'll drop s390 support for comedi, it doesn't make sense at all for that
> platform.
> 
> Actually, I'll just go off of PCI/ISA/USB/PCMCIA, that should drop s390
> automatically, right?

Correct.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
