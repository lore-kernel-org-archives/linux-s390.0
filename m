Return-Path: <linux-kernel-owner+w=401wt.eu-S1755390AbYHRRIh@vger.kernel.org>
Message-ID: <48A9AC82.5060505@vmfacility.fr>
Date: Mon, 18 Aug 2008 19:08:18 +0200
From: Ivan Warren <ivan@vmfacility.fr>
MIME-Version: 1.0
Subject: Re: [PATCH] S390 : Set SLI on PSF/PRSSD on Dasd ECKD initialisation
References: <1218726426.25578.0.camel@localhost> <1218738411-21828-1-git-send-email-ivan@vmfacility.fr> <48A58F9A.8070301@linux.vnet.ibm.com>
In-Reply-To: <48A58F9A.8070301@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Stefan Weinhuber <wein@linux.vnet.ibm.com>
Cc: schwidefsky@de.ibm.com, elendil@planet.nl, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Stefan Weinhuber wrote:
> Hi Ivan,
>
> while I agree that your patch is technically correct, I think I'd
> rather like to fix the problematic data length instead of making
> the storage server ignore it. There is no need for the
> dasd_psf_prssd_data structure to be 16 bytes long as it is only used
> for suborders that require 12 bytes. The current layout of that
> structure was probably just a mistake. If we ever go to use a
> suborder that requires more data, we should either define a further
> structure specific to that purpose or find some other way to make
> sure that each suborder is called with the appropriate data length.
>
> The following patch works fine on current hardware. Can you please
> verify that it indeed fixes your problem as well?
>
> Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
> ---
>  drivers/s390/block/dasd_eckd.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: linux-2.6.26/drivers/s390/block/dasd_eckd.h
> ===================================================================
> --- linux-2.6.26.orig/drivers/s390/block/dasd_eckd.h
> +++ linux-2.6.26/drivers/s390/block/dasd_eckd.h
> @@ -379,7 +379,7 @@ struct dasd_psf_prssd_data {
>  	unsigned char flags;
>  	unsigned char reserved[4];
>  	unsigned char suborder;
> -	unsigned char varies[9];
> +	unsigned char varies[5];
>  } __attribute__ ((packed));
>  
>  /*
>
>   

Stefan,

Sorry for taking such a long time to respond..

I like the patch. You are right, it's probably better to set the right 
length then hide it ! My initial rationale to SLI instead of altering 
the length was that I couldn't know if there was any obscure reason for 
setting the length to 16 instead of 12 (I thought it could have been 
related to DS8K PAV/HyperPAV support)..

I also tried it on my rig, and it does seem to take care of the problem !

So I guess :

    Reviewed-by: Ivan Warren <ivan@vmfacility.fr>
    Tested-by: Ivan Warren <ivan@vmfacility.fr>

Thanks again !

--Ivan
