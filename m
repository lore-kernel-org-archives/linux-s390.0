Return-Path: <SRS0=Ul9H=TA=vger.kernel.org=kvm-owner@kernel.org>
Date: Tue, 30 Apr 2019 16:00:31 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v7 3/4] s390: ap: implement PAPQ AQIC interception in
 kernel
In-Reply-To: <1556283688-556-4-git-send-email-pmorel@linux.ibm.com>
References: <1556283688-556-1-git-send-email-pmorel@linux.ibm.com>
        <1556283688-556-4-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190430160031.198b83c1.pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 26 Apr 2019 15:01:27 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 18dcc4d..7cc02ff 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -4,6 +4,7 @@
>   *
>   * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
>   *	      Halil Pasic <pasic@linux.ibm.com>
> + *	      Pierre Morel <pmorel@linux.ibm.com>
>   *
>   * Copyright IBM Corp. 2018
>   */
> @@ -90,4 +91,14 @@ struct ap_matrix_mdev {
>  extern int vfio_ap_mdev_register(void);
>  extern void vfio_ap_mdev_unregister(void);
>  
> +struct vfio_ap_queue {
> +	struct ap_matrix_mdev *matrix_mdev;
> +	unsigned long a_nib;
> +	unsigned long a_pfn;
> +	unsigned long p_pfn;
> +	int	apqn;
> +#define VFIO_AP_ISC_INVALID 0xff

How about -1?

> +	unsigned char a_isc;
> +	unsigned char p_isc;
> +};
>  #endif /* _VFIO_AP_PRIVATE_H_ */

I assume a_ and p_ are for argument and private, or? Anyway it would be
nice to have nicer names for these.

If the a_ members are really just arguments, we could probably live
without the. I'm fine either way.

Regards,
Halil
