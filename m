Return-Path: <linux-kernel-owner+w=401wt.eu-S1758237AbYGCIYp@vger.kernel.org>
Date: Thu, 3 Jul 2008 09:07:22 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 02/04] s390: bus_id -> dev_set_name() changes
Message-ID: <20080703090722.525b3930@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20080702230742.GA708@kroah.com>
References: <20080702154811.GB31083@kroah.com>
	<20080702221401.GA15142@zarina>
	<20080702230742.GA708@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, Kay Sievers <kay.sievers@vrfy.org>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2 Jul 2008 16:07:42 -0700,
Greg KH <greg@kroah.com> wrote:

> On Thu, Jul 03, 2008 at 02:14:01AM +0400, Anton Vorontsov wrote:
> > On Wed, Jul 02, 2008 at 08:48:11AM -0700, Greg KH wrote:
> > > --- a/drivers/s390/block/dcssblk.c
> > > +++ b/drivers/s390/block/dcssblk.c
> > > @@ -349,7 +349,7 @@ dcssblk_add_store(struct device *dev, st
> > >  	}
> > >  
> > >  	strcpy(dev_info->segment_name, local_buf);
> > > -	strlcpy(dev_info->dev.bus_id, local_buf, BUS_ID_SIZE);
> > > +	dev_set_name(&dev_info->dev, local_buf);
> > 
> > As I see it, dev_set_name accepts printf like string, so this
> > dev_set_name is quite dangerous (since local_buf is formed
> > by the module param), no?
> 
> So you would rather see:
> 	dev_set_name(&dev_info->dev, "%s", local_buf);
> 
> instead?

Hm, I thought the string had already been sanitized at that time, but
looking again it doesn't do many checks... so this looks better.
