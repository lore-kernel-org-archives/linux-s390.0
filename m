Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 9 Jun 2017 12:20:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 10/11] s390: drivers: convert to use DRIVER_ATTR_RO/WO
Message-ID: <20170609102043.GA11061@kroah.com>
References: <20170609090314.13991-1-gregkh@linuxfoundation.org>
 <20170609090314.13991-10-gregkh@linuxfoundation.org>
 <20170609101141.GB3617@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170609101141.GB3617@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Jun 09, 2017 at 12:11:41PM +0200, Heiko Carstens wrote:
> On Fri, Jun 09, 2017 at 11:03:13AM +0200, Greg Kroah-Hartman wrote:
> > We are trying to get rid of DRIVER_ATTR(), and the s390 drivers'
> > attributes can be trivially changed to use DRIVER_ATTR_RO() and
> > DRIVER_ATTR_WO().
> > 
> > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Cc: Julian Wiedmann <jwi@linux.vnet.ibm.com>
> > Cc: Ursula Braun <ubraun@linux.vnet.ibm.com>
> > Cc: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
> > Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> > Cc: <linux-s390@vger.kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/s390/char/sclp.c          | 12 ++++++------
> >  drivers/s390/char/vmlogrdr.c      |  7 ++-----
> >  drivers/s390/net/ctcm_main.c      |  6 +++---
> >  drivers/s390/net/lcs.c            |  6 +++---
> >  drivers/s390/net/netiucv.c        | 14 ++++++--------
> >  drivers/s390/net/qeth_core_main.c |  6 +++---
> >  6 files changed, 23 insertions(+), 28 deletions(-)
> 
> I assume this will go upstream via your tree.

Yup, I can take it.

> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Thanks for the review!

greg k-h
