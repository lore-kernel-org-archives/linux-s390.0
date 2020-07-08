Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728965AbgGHM11 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Jul 2020 08:27:27 -0400
Subject: Re: [PATCH v8 04/16] s390/zcrypt: driver callback to indicate
 resource in use
References: <20200605214004.14270-1-akrowiak@linux.ibm.com>
 <20200605214004.14270-5-akrowiak@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <d7954c15-b14f-d6e5-0193-aadca61883a8@de.ibm.com>
Date: Wed, 8 Jul 2020 14:27:18 +0200
MIME-Version: 1.0
In-Reply-To: <20200605214004.14270-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com

On 05.06.20 23:39, Tony Krowiak wrote:
> Introduces a new driver callback to prevent a root user from unbinding
> an AP queue from its device driver if the queue is in use. The intent of
> this callback is to provide a driver with the means to prevent a root user
> from inadvertently taking a queue away from a matrix mdev and giving it to
> the host while it is assigned to the matrix mdev. The callback will
> be invoked whenever a change to the AP bus's sysfs apmask or aqmask
> attributes would result in one or more AP queues being removed from its
> driver. If the callback responds in the affirmative for any driver
> queried, the change to the apmask or aqmask will be rejected with a device
> in use error.

The alternative would be to tear down the connection in the matrix mdev in this
callback (so that the guest will see a hot unplug), but actually making this
a more conscious decision (requiring 2 steps from the host admin) is certainly
also fine.


> 
> For this patch, only non-default drivers will be queried. Currently,
> there is only one non-default driver, the vfio_ap device driver. The
> vfio_ap device driver facilitates pass-through of an AP queue to a
> guest. The idea here is that a guest may be administered by a different
> sysadmin than the host and we don't want AP resources to unexpectedly
> disappear from a guest's AP configuration (i.e., adapters, domains and
> control domains assigned to the matrix mdev). This will enforce the proper
> procedure for removing AP resources intended for guest usage which is to
> first unassign them from the matrix mdev, then unbind them from the
> vfio_ap device driver.

What I said above, we can force a hot unplug to the guest, but we require
to do 2 steps. I think this is fine.


> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/ap_bus.c | 148 ++++++++++++++++++++++++++++++++---
>  drivers/s390/crypto/ap_bus.h |   4 +
>  2 files changed, 142 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
> index e71ca4a719a5..40cb5861dad3 100644
> --- a/drivers/s390/crypto/ap_bus.c
> +++ b/drivers/s390/crypto/ap_bus.c
> @@ -35,6 +35,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/debugfs.h>
>  #include <linux/ctype.h>
> +#include <linux/module.h>
>  
>  #include "ap_bus.h"
>  #include "ap_debug.h"
> @@ -876,6 +877,23 @@ static int modify_bitmap(const char *str, unsigned long *bitmap, int bits)
>  	return 0;
>  }
>  
> +static int ap_parse_bitmap_str(const char *str, unsigned long *bitmap, int bits,
> +			       unsigned long *newmap)
> +{
> +	unsigned long size;
> +	int rc;
> +
> +	size = BITS_TO_LONGS(bits)*sizeof(unsigned long);                                  ^ ^ spaces around the *
> +	if (*str == '+' || *str == '-') {
> +		memcpy(newmap, bitmap, size);
> +		rc = modify_bitmap(str, newmap, bits);
> +	} else {
> +		memset(newmap, 0, size);
> +		rc = hex2bitmap(str, newmap, bits);
> +	}
> +	return rc;
> +}
> +
>  int ap_parse_mask_str(const char *str,
>  		      unsigned long *bitmap, int bits,
>  		      struct mutex *lock)
> @@ -895,14 +913,7 @@ int ap_parse_mask_str(const char *str,
>  		kfree(newmap);
>  		return -ERESTARTSYS;
>  	}
> -
> -	if (*str == '+' || *str == '-') {
> -		memcpy(newmap, bitmap, size);

Do we still need the size variable in here?

> -		rc = modify_bitmap(str, newmap, bits);
> -	} else {
> -		memset(newmap, 0, size);
> -		rc = hex2bitmap(str, newmap, bits);
> -	}
> +	rc = ap_parse_bitmap_str(str, bitmap, bits, newmap);
>  	if (rc == 0)
>  		memcpy(bitmap, newmap, size);
>  	mutex_unlock(lock);
> @@ -1092,12 +1103,70 @@ static ssize_t apmask_show(struct bus_type *bus, char *buf)
>  	return rc;
>  }
>  
> +int __verify_card_reservations(struct device_driver *drv, void *data)
> +{
> +	int rc = 0;
> +	struct ap_driver *ap_drv = to_ap_drv(drv);
> +	unsigned long *newapm = (unsigned long *)data;
> +
> +	/*
> +	 * No need to verify whether the driver is using the queues if it is the
> +	 * default driver.
> +	 */
> +	if (ap_drv->flags & AP_DRIVER_FLAG_DEFAULT)
> +		return 0;
> +
> +	/* The non-default driver's module must be loaded */> +	if (!try_module_get(drv->owner))
> +		return 0;
> +
> +	if (ap_drv->in_use)
> +		if (ap_drv->in_use(newapm, ap_perms.aqm))
> +			rc = -EADDRINUSE;

I think -EBUSY is more appropriate.  (also in the other places)
