Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 24 Nov 2017 15:01:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/9] drivers/s390/ license text cleanup
Message-ID: <20171124140100.GA10676@kroah.com>
References: <20171114173808.25092-1-gregkh@linuxfoundation.org>
 <20171124112339.GC4284@osiris>
 <20171124114541.GA1916@kroah.com>
 <20171124115234.GD4284@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171124115234.GD4284@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, Stefan Haberland <sth@linux.vnet.ibm.com>, Jan Hoeppner <hoeppner@linux.vnet.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Harald Freudenberger <freude@de.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Steffen Maier <maier@linux.vnet.ibm.com>, Benjamin Block <bblock@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Nov 24, 2017 at 12:52:35PM +0100, Heiko Carstens wrote:
> On Fri, Nov 24, 2017 at 12:45:41PM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Nov 24, 2017 at 12:23:39PM +0100, Heiko Carstens wrote:
> > > On Tue, Nov 14, 2017 at 06:37:59PM +0100, Greg Kroah-Hartman wrote:
> > > > Hi all,
> > > > 
> > > > Here are 9 patches against linux-next of today that add SPDX identifiers
> > > > to the remaining files that do not currently have them, and then it
> > > > cleans up the various different ways that the license text boilerplate
> > > > was written for the GPLv2 in a few files.  This cleanup was done in the
> > > > quest to remove the 700+ different ways the kernel describes GPLv2.
> > > > 
> > > > No copyright headers or any other non-license-description text was
> > > > removed in these patches.
> > > > 
> > > > FWIW, this license cleanup action has been "blessed" by IBM lawyers, but
> > > > feel free to check internally if you are curious.
> > > > 
> > > > Greg Kroah-Hartman (9):
> > > >   s390: block: add SPDX identifiers to the remaining files
> > > >   s390: crypto: add SPDX identifiers to the remaining files
> > > >   s390: cio: add SPDX identifiers to the remaining files
> > > >   s390: char: add SPDX identifiers to the remaining files
> > > >   s390: net: add SPDX identifiers to the remaining files
> > > >   s390: scsi: zfcp_aux: add SPDX identifier
> > > >   s390: virtio: add SPDX identifiers to the remaining files
> > > >   s390: crypto: Remove redundant license text
> > > >   s390: drivers: Remove redundant license text
> > > 
> > > Whole series applied. Thank you!
> > > 
> > > Will you or Thomas also provide patches for arch/s390? Or should we take
> > > care of that on our own?
> > 
> > I can do that if you want me to, just let me know.
> 
> Yes, please. As I understand it you have all the scripts in place which
> should just work and provide the correct result.

Now sent, thanks.

greg k-h
