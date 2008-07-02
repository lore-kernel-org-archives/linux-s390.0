Return-Path: <linux-kernel-owner+w=401wt.eu-S1757430AbYGBQ3e@vger.kernel.org>
Date: Wed, 2 Jul 2008 18:28:32 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 01/04] s390: bus_id -> dev_name conversions
Message-ID: <20080702182832.1a087e8d@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20080702154630.GA31083@kroah.com>
References: <20080702154630.GA31083@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Greg KH <greg@kroah.com>
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, Kay Sievers <kay.sievers@vrfy.org>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2 Jul 2008 08:46:30 -0700,
Greg KH <greg@kroah.com> wrote:

> @@ -529,7 +529,7 @@ cio_validate_subchannel (struct subchann
>  	}
>  	mutex_init(&sch->reg_mutex);
>  	/* Set a name for the subchannel */
> -	snprintf (sch->dev.bus_id, BUS_ID_SIZE, "0.%x.%04x", schid.ssid,
> +	snprintf (dev_name(&sch->dev), BUS_ID_SIZE, "0.%x.%04x", schid.ssid,
>  		  schid.sch_no);
> 
>  	/*

This hunk does not make much sense. Better just leave it alone until
the dev_set_name()/init_name conversion later.
