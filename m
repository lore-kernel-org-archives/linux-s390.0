Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 16 Nov 2018 13:20:33 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/1] s390: vfio-ap: include <asm/facility> for
 test_facility()
In-Reply-To: <20181116114748.590dfb45@ezekiel.suse.cz>
References: <20181116114748.590dfb45@ezekiel.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20181116132033.454ee131@oc0155643701>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Petr Tesarik <ptesarik@suse.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 16 Nov 2018 11:47:48 +0100
Petr Tesarik <ptesarik@suse.com> wrote:

> The driver uses test_facility(), but does not include the
> corresponding include file explicitly. The driver currently builds
> only thanks to the following include chain:
> 
>   vfio_ap_drv.c
>     <linux/module.h>
>       <linux/elf.h>
>         <asm/elf.h>
> 	  <linux/compat.h>
> 	    <asm/uaccess.h>
> 	      <asm/facility.h>
> 
> Files should not rely on such fragile implicit includes.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---
>  drivers/s390/crypto/vfio_ap_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c
> b/drivers/s390/crypto/vfio_ap_drv.c index 7667b38728f0..31c6c847eaca
> 100644 --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -11,6 +11,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> +#include <asm/facility.h>
>  #include "vfio_ap_private.h"
>  
>  #define VFIO_AP_ROOT_NAME "vfio_ap"

Applied. Is going to go via Martins S390 tree.

Thanks,
Halil
