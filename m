From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v1 6/7] vfio: ap: register guest ISC with GISA and GIB
Date: Tue, 6 Nov 2018 15:21:14 -0500
Message-ID: <382fe325-e12d-8be8-7f30-c3c64bd37505@linux.ibm.com>
References: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
 <1541009577-29656-7-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541009577-29656-7-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 10/31/18 2:12 PM, Pierre Morel wrote:
> Register to the GIB Alert list and retrieve the GAL_ISC
> to pass to the GISA registration.
> 
> Unregister on error and when clearing the interrupt.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index f68102163bf4..232168797fb8 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -903,16 +903,20 @@ static int ap_ioctl_setirq(struct ap_matrix_mdev *matrix_mdev,
>   	struct ap_status ap_status = reg2status(0);
>   	unsigned long p;
>   	int ret = -1;
> -	int apqn;
> +	int apqn, gal_isc;
>   	uint32_t gd;
>   
> +	gal_isc = kvm_s390_gisc_register(matrix_mdev->kvm, matrix_mdev->gisc);
> +	if (gal_isc < 0)
> +		return -EIO;
> +
>   	apqn = (int)(parm->cmd & 0xffff);
>   
>   	gd = matrix_mdev->kvm->vcpus[0]->arch.sie_block->gd;
>   	if (gd & 0x01)
>   		aqic_gisa.f = 1;
>   	aqic_gisa.gisc = matrix_mdev->gisc;
> -	aqic_gisa.isc = GAL_ISC;
> +	aqic_gisa.isc = gal_isc;
>   	aqic_gisa.ir = 1;
>   	aqic_gisa.gisao = gisa->next_alert >> 4;
>   
> @@ -923,7 +927,11 @@ static int ap_ioctl_setirq(struct ap_matrix_mdev *matrix_mdev,
>   	parm->status = ret;
>   
>   	ap_status = reg2status(ret);
> -	return (ap_status.rc) ? -EIO : 0;
> +	if (ap_status.rc) {
> +		kvm_s390_gisc_unregister(matrix_mdev->kvm, matrix_mdev->gisc);
> +		return -EIO;
> +	}
> +	return 0;
>   }
>   
>   static int ap_ioctl_clrirq(struct ap_matrix_mdev *matrix_mdev,
> @@ -946,6 +954,8 @@ static int ap_ioctl_clrirq(struct ap_matrix_mdev *matrix_mdev,
>   	parm->status = retval;
>   
>   	ap_status = reg2status(retval);
> +	/* unregister the IAM from the GIB anyway! */
> +	kvm_s390_gisc_unregister(matrix_mdev->kvm, matrix_mdev->gisc);

The case statement in patch 4 does not set mdev->gisc, so the
presumption here is that VFIO_AP_SET_IRQ has been previously called and
has set the value for matrix_mdev->gisc. Is it possible for
VFIO_AP_CLEAR_IRQ to get invoked without a prior call to
VFIO_AP_SET_IRQ? In any case, shouldn't the GISC value be taken from
bits 61-63 of 'parm'?

>   	return (ap_status.rc) ? -EIO : 0;
>   }
>   
> 
