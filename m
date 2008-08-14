Return-Path: <linux-kernel-owner+w=401wt.eu-S1756014AbYHNPHe@vger.kernel.org>
Subject: Re: Fwd: [Patch 2.6] s390 - Allow ECKD devices to be used with
	older controllers and emulation
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <200808140108.00375.elendil@planet.nl>
References: <489C9494.9070504@vmfacility.fr>
	 <200808140108.00375.elendil@planet.nl>
Content-Type: text/plain
Date: Thu, 14 Aug 2008 17:07:06 +0200
Message-Id: <1218726426.25578.0.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Frans Pop <elendil@planet.nl>
Cc: linux-s390@vger.kernel.org, Ivan Warren <ivan@vmfacility.fr>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2008-08-14 at 01:07 +0200, Frans Pop wrote:
>     s390 dasd ECKD drivers issues a Perform Subsystem Function / Prepare
> for Read SubSystem Data with a length of 16.
>     However, older hardware and documentation specifies a length of 12
> leading to a possible Incorrect Length indication.
>     This patch activates the SLI CCW flag in order to avoid reporting
> the Incorrect Length indication since it is possible that the DASD
> control unit may be expecting a length of 12, not 16.
>         -- Ivan Warren (ivan@vmfacility.fr)
> 
> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c index 773b3fe..c4e3935 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -810,6 +810,7 @@ static int dasd_eckd_read_features(struct dasd_device *device)
>         ccw->cmd_code = DASD_ECKD_CCW_PSF;
>         ccw->count = sizeof(struct dasd_psf_prssd_data);
>         ccw->flags |= CCW_FLAG_CC;
> +       ccw->flags |= CCW_FLAG_SLI;
>         ccw->cda = (__u32)(addr_t) prssdp;
> 
>         /* Read Subsystem Data - feature codes */

That makes sense, can I get a signed-off-by for the patch please?

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
