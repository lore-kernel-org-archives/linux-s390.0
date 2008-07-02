Return-Path: <linux-kernel-owner+w=401wt.eu-S1754068AbYGBSyU@vger.kernel.org>
Date: Wed, 2 Jul 2008 11:49:43 -0700
From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 01/04] s390: bus_id -> dev_name conversions
Message-ID: <20080702184943.GA20938@kroah.com>
References: <20080702154630.GA31083@kroah.com> <20080702182832.1a087e8d@gondolin.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080702182832.1a087e8d@gondolin.boeblingen.de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, Kay Sievers <kay.sievers@vrfy.org>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jul 02, 2008 at 06:28:32PM +0200, Cornelia Huck wrote:
> On Wed, 2 Jul 2008 08:46:30 -0700,
> Greg KH <greg@kroah.com> wrote:
> 
> > @@ -529,7 +529,7 @@ cio_validate_subchannel (struct subchann
> >  	}
> >  	mutex_init(&sch->reg_mutex);
> >  	/* Set a name for the subchannel */
> > -	snprintf (sch->dev.bus_id, BUS_ID_SIZE, "0.%x.%04x", schid.ssid,
> > +	snprintf (dev_name(&sch->dev), BUS_ID_SIZE, "0.%x.%04x", schid.ssid,
> >  		  schid.sch_no);
> > 
> >  	/*
> 
> This hunk does not make much sense. Better just leave it alone until
> the dev_set_name()/init_name conversion later.

You are right.

390 maintainers, can you drop this hunk, or do you want me to respin it
and the other 3 patches (if needed)?

thanks,

greg k-h
