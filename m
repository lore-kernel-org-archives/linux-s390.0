From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v8 09/22] s390: vfio-ap: register matrix device with
 VFIO mdev framework
Date: Thu, 9 Aug 2018 13:06:07 +0200
Message-ID: <20180809130607.32781b72.cohuck@redhat.com>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1533739472-7172-10-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533739472-7172-10-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed,  8 Aug 2018 10:44:19 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index d7e39ad..6a827f3 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -12,6 +12,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> +#include <asm/zcrypt.h>
>  #include "vfio_ap_private.h"
>  
>  #define VFIO_AP_ROOT_NAME "vfio_ap"
> @@ -68,6 +69,18 @@ static int vfio_ap_matrix_dev_create(void)
>  {
>  	int ret;
>  
> +	mutex_init(&matrix_dev.lock);
> +	INIT_LIST_HEAD(&matrix_dev.mdev_list);
> +
> +	/* Test if PQAP(QCI) instruction is available */
> +	if (test_facility(12)) {
> +		ret = ap_qci(&matrix_dev.info);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	atomic_set(&matrix_dev.available_instances, MAX_ZDEV_ENTRIES_EXT);
> +
>  	ret = misc_register(&matrix_dev.misc_dev);

OK, you are adding more stuff other than the miscdevice after all...
still, I don't think that this is a good idea.

I think I had already asked this for a previous version: Why has this
been turned into a miscdevice? (I think my reaction to the answer was
'meh'... but I think more and more that we should not do that.)

>  	if (ret)
>  		return ret;
