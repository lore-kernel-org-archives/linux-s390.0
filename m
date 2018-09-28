From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v11 11/26] s390: vfio-ap: implement mediated device open
 callback
Date: Fri, 28 Sep 2018 12:14:29 +0200
Message-ID: <20180928121429.7323d78b.cohuck@redhat.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
        <20180925231641.4954-12-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925231641.4954-12-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 25 Sep 2018 19:16:26 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Implements the open callback on the mediated matrix device.
> The function registers a group notifier to receive notification
> of the VFIO_GROUP_NOTIFY_SET_KVM event. When notified,
> the vfio_ap device driver will get access to the guest's
> kvm structure. The open callback must ensure that only one
> mediated device shall be opened per guest.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
> Acked-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h      |   1 +
>  drivers/s390/crypto/vfio_ap_ops.c     | 159 ++++++++++++++++++++++++++
>  drivers/s390/crypto/vfio_ap_private.h |   5 +
>  3 files changed, 165 insertions(+)
> 

> +static void vfio_ap_mdev_copy_masks(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	int nbytes;
> +	unsigned long *apm, *aqm, *adm;
> +	struct kvm_s390_crypto_cb *crycb = matrix_mdev->kvm->arch.crypto.crycb;
> +
> +	switch (matrix_mdev->kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK) {
> +	case CRYCB_FORMAT2:
> +		apm = (unsigned long *)crycb->apcb1.apm;
> +		aqm = (unsigned long *)crycb->apcb1.aqm;
> +		adm = (unsigned long *)crycb->apcb1.adm;
> +		break;
> +	case CRYCB_FORMAT1:
> +	case CRYCB_FORMAT0:
> +	default:

That one looks a tad odd: the masking above should guarantee that we
hit either the format 2, 1, or 0 cases, so the default case should
never hit. Moreover, if the mask above will ever be changed, we don't
know where we should look for the correct masks (what will a FORMAT<n>
use: apcb1, apcb0, or something else?) Would it be better to moan in
the default case and copy nothing?

> +		apm = (unsigned long *)crycb->apcb0.apm;
> +		aqm = (unsigned long *)crycb->apcb0.aqm;
> +		adm = (unsigned long *)crycb->apcb0.adm;
> +		break;
> +	}
> +
> +	nbytes = DIV_ROUND_UP(matrix_mdev->matrix.apm_max + 1, BITS_PER_BYTE);
> +	memcpy(apm, matrix_mdev->matrix.apm, nbytes);
> +	nbytes = DIV_ROUND_UP(matrix_mdev->matrix.aqm_max + 1, BITS_PER_BYTE);
> +	memcpy(aqm, matrix_mdev->matrix.aqm, nbytes);
> +	nbytes = DIV_ROUND_UP(matrix_mdev->matrix.adm_max + 1, BITS_PER_BYTE);
> +	memcpy(adm, matrix_mdev->matrix.adm, nbytes);
> +}

Anyway, that can be easily changed later on; in general,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
