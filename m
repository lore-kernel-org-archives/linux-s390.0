From: Greg KH <gregkh@suse.de>
Subject: Re: next-20091007 - comedi driver build breaks on S390x
Date: Wed, 7 Oct 2009 06:07:44 -0700
Message-ID: <20091007130744.GA26081@suse.de>
References: <20091007173517.abfcfa2a.sfr@canb.auug.org.au>
 <20091007105458.GA5472@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091007105458.GA5472@linux.vnet.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, devel@driverdev.osuosl.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Oct 07, 2009 at 04:24:58PM +0530, Kamalesh Babulal wrote:
> Hi Greg,
> 
> 	next-20091007 randconfig build breaks on s390x with build error
> 
> drivers/staging/comedi/comedi_fops.c: In function 'comedi_mmap':
> drivers/staging/comedi/comedi_fops.c:1453: error: 'PAGE_SHARED' undeclared (first use in this function)
> drivers/staging/comedi/comedi_fops.c:1453: error: (Each undeclared identifier is reported only once
> drivers/staging/comedi/comedi_fops.c:1453: error: for each function it appears in.)
> make[3]: *** [drivers/staging/comedi/comedi_fops.o] Error 1

Odd.  What changed in the header files to cause this?

thanks,

greg k-h
