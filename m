Return-Path: <linux-kernel-owner+w=401wt.eu-S1754414AbYGBXLd@vger.kernel.org>
Date: Wed, 2 Jul 2008 16:07:42 -0700
From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 02/04] s390: bus_id -> dev_set_name() changes
Message-ID: <20080702230742.GA708@kroah.com>
References: <20080702154811.GB31083@kroah.com> <20080702221401.GA15142@zarina>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080702221401.GA15142@zarina>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, Kay Sievers <kay.sievers@vrfy.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jul 03, 2008 at 02:14:01AM +0400, Anton Vorontsov wrote:
> On Wed, Jul 02, 2008 at 08:48:11AM -0700, Greg KH wrote:
> > From: Cornelia Huck <cornelia.huck@de.ibm.com>
> > 
> > Convert most s390 users setting bus_id to dev_set_name().
> > css and ccw busses are deferred since they need some special
> > treatment.
> > 
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > Cc: Kay Sievers <kay.sievers@vrfy.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> > ---
> >  drivers/s390/block/dcssblk.c |    2 +-
> >  drivers/s390/char/vmlogrdr.c |    3 +--
> >  drivers/s390/cio/ccwgroup.c  |    3 +--
> >  drivers/s390/cio/chp.c       |    3 +--
> >  drivers/s390/cio/css.c       |    4 ++--
> >  drivers/s390/crypto/ap_bus.c |    4 ++--
> >  drivers/s390/net/netiucv.c   |    2 +-
> >  drivers/s390/s390_rdev.c     |    2 +-
> >  drivers/s390/scsi/zfcp_aux.c |   23 ++++++++---------------
> >  9 files changed, 18 insertions(+), 28 deletions(-)
> > 
> > --- a/drivers/s390/block/dcssblk.c
> > +++ b/drivers/s390/block/dcssblk.c
> > @@ -349,7 +349,7 @@ dcssblk_add_store(struct device *dev, st
> >  	}
> >  
> >  	strcpy(dev_info->segment_name, local_buf);
> > -	strlcpy(dev_info->dev.bus_id, local_buf, BUS_ID_SIZE);
> > +	dev_set_name(&dev_info->dev, local_buf);
> 
> As I see it, dev_set_name accepts printf like string, so this
> dev_set_name is quite dangerous (since local_buf is formed
> by the module param), no?

So you would rather see:
	dev_set_name(&dev_info->dev, "%s", local_buf);

instead?

thanks,

greg k-h
