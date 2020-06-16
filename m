Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v8 02/16] s390/vfio-ap: use new AP bus interface to search
 for queue devices
References: <20200605214004.14270-1-akrowiak@linux.ibm.com>
 <20200605214004.14270-3-akrowiak@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <1f64ef13-412d-f124-60f3-36f8c639725e@de.ibm.com>
Date: Tue, 16 Jun 2020 17:38:57 +0200
MIME-Version: 1.0
In-Reply-To: <20200605214004.14270-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com



On 05.06.20 23:39, Tony Krowiak wrote:
[..]
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -18,6 +18,7 @@
>  #include <linux/delay.h>
>  #include <linux/mutex.h>
>  #include <linux/kvm_host.h>
> +#include <linux/hashtable.h>
>  
>  #include "ap_bus.h"
>  
> @@ -90,8 +91,6 @@ struct ap_matrix_mdev {
>  
>  extern int vfio_ap_mdev_register(void);
>  extern void vfio_ap_mdev_unregister(void);
> -int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
> -			     unsigned int retry);
>  
>  struct vfio_ap_queue {
>  	struct ap_matrix_mdev *matrix_mdev;
> @@ -100,5 +99,8 @@ struct vfio_ap_queue {
>  #define VFIO_AP_ISC_INVALID 0xff
>  	unsigned char saved_isc;
>  };
> -struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q);

This looks wrong and unrelated. 

> +
> +int vfio_ap_mdev_probe_queue(struct ap_queue *queue);
> +void vfio_ap_mdev_remove_queue(struct ap_queue *queue);
> +
>  #endif /* _VFIO_AP_PRIVATE_H_ */
> 
