Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH] s390: block: dasd_devmap.c:  Cleaning up missing null-terminate in conjunction with strncpy
References: <1406384860-2775-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Date: Mon, 28 Jul 2014 10:37:34 -0400
In-Reply-To: <1406384860-2775-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
	(Rickard Strandqvist's message of "Sat, 26 Jul 2014 16:27:40 +0200")
Message-ID: <x49k36xpn0x.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Stefan Weinhuber <wein@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se> writes:

> Replacing strncpy with strlcpy to avoid strings that lacks null terminate.
>
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> ---
>  drivers/s390/block/dasd_devmap.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
> index 2ead7e7..4a60ef8 100644
> --- a/drivers/s390/block/dasd_devmap.c
> +++ b/drivers/s390/block/dasd_devmap.c
> @@ -424,7 +424,7 @@ dasd_add_busid(const char *bus_id, int features)
>  	if (!devmap) {
>  		/* This bus_id is new. */
>  		new->devindex = dasd_max_devindex++;
> -		strncpy(new->bus_id, bus_id, DASD_BUS_ID_SIZE);
> +		strlcpy(new->bus_id, bus_id, DASD_BUS_ID_SIZE);

NACK

kzalloc'd.

Did you put thought into *any* of these conversions?
