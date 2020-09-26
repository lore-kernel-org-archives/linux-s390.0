Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 26 Sep 2020 03:38:08 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v10 06/16] s390/vfio-ap: introduce shadow APCB
Message-ID: <20200926033808.07e9d04f.pasic@linux.ibm.com>
In-Reply-To: <20200821195616.13554-7-akrowiak@linux.ibm.com>
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
 <20200821195616.13554-7-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

On Fri, 21 Aug 2020 15:56:06 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> The APCB is a field within the CRYCB that provides the AP configuration
> to a KVM guest. Let's introduce a shadow copy of the KVM guest's APCB and
> maintain it for the lifespan of the guest.
> 

AFAIU this is supposed to be a no change in behavior patch that lays the
groundwork.

> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c     | 32 ++++++++++++++++++++++-----
>  drivers/s390/crypto/vfio_ap_private.h |  2 ++
>  2 files changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index fc1aa6f947eb..efb229033f9e 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -305,14 +305,35 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>  	return 0;
>  }
>  
> +static void vfio_ap_matrix_clear_masks(struct ap_matrix *matrix)
> +{
> +	bitmap_clear(matrix->apm, 0, AP_DEVICES);
> +	bitmap_clear(matrix->aqm, 0, AP_DOMAINS);
> +	bitmap_clear(matrix->adm, 0, AP_DOMAINS);
> +}
> +
>  static void vfio_ap_matrix_init(struct ap_config_info *info,
>  				struct ap_matrix *matrix)
>  {
> +	vfio_ap_matrix_clear_masks(matrix);

I don't quite understand the idea behind this. The only place
vfio_ap_matrix_init() is used, is in create right after the whole
matrix_mdev got allocated with kzalloc.

>  	matrix->apm_max = info->apxa ? info->Na : 63;
>  	matrix->aqm_max = info->apxa ? info->Nd : 15;
>  	matrix->adm_max = info->apxa ? info->Nd : 15;
>  }
>  
> +static bool vfio_ap_mdev_has_crycb(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	return (matrix_mdev->kvm && matrix_mdev->kvm->arch.crypto.crycbd);
> +}
> +
> +static void vfio_ap_mdev_commit_crycb(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	kvm_arch_crypto_set_masks(matrix_mdev->kvm,
> +				  matrix_mdev->shadow_apcb.apm,
> +				  matrix_mdev->shadow_apcb.aqm,
> +				  matrix_mdev->shadow_apcb.adm);
> +}
> +
>  static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
>  {
>  	struct ap_matrix_mdev *matrix_mdev;
> @@ -1202,13 +1223,12 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>  	if (ret)
>  		return NOTIFY_DONE;
>  
> -	/* If there is no CRYCB pointer, then we can't copy the masks */
> -	if (!matrix_mdev->kvm->arch.crypto.crycbd)
> +	if (!vfio_ap_mdev_has_crycb(matrix_mdev))
>  		return NOTIFY_DONE;
>  
> -	kvm_arch_crypto_set_masks(matrix_mdev->kvm, matrix_mdev->matrix.apm,
> -				  matrix_mdev->matrix.aqm,
> -				  matrix_mdev->matrix.adm);
> +	memcpy(&matrix_mdev->shadow_apcb, &matrix_mdev->matrix,
> +	       sizeof(matrix_mdev->shadow_apcb));

A note on the thread safety of the access to matrix_mdev->matrix. I
guess the idea is, that this is still safe because we did
vfio_ap_mdev_set_kvm() and that is supposed to inhibit changes the
matrix.

There are two things that bother me with this:
1) the assign operations don't check matrix_mdev->kvm under the lock
2) with dynamic, this is supposed to change (So I have to be careful
about it when reviewing the following patches. A sneak-peek at the end
result makes me worried).

> +	vfio_ap_mdev_commit_crycb(matrix_mdev);
>  
>  	return NOTIFY_OK;
>  }
> @@ -1323,6 +1343,8 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
>  		kvm_put_kvm(matrix_mdev->kvm);
>  		matrix_mdev->kvm = NULL;
>  	}
> +
> +	vfio_ap_matrix_clear_masks(&matrix_mdev->shadow_apcb);

What is the idea behind this? From the above, it looks like we are going
to overwrite matrix_mdev->shadow_apcb with matrix_mdev->matrix before
the next commit anyway.

I suppose this is probably about no guest unolies no resources passed
through at the moment. If that is the case maybe we can document it
below. 

>  	mutex_unlock(&matrix_dev->lock);
>  
>  	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 0c796ef11426..055bce6d45db 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -75,6 +75,7 @@ struct ap_matrix {
>   * @list:	allows the ap_matrix_mdev struct to be added to a list
>   * @matrix:	the adapters, usage domains and control domains assigned to the
>   *		mediated matrix device.
> + * @shadow_apcb:    the shadow copy of the APCB field of the KVM guest's CRYCB
>   * @group_notifier: notifier block used for specifying callback function for
>   *		    handling the VFIO_GROUP_NOTIFY_SET_KVM event
>   * @kvm:	the struct holding guest's state
> @@ -82,6 +83,7 @@ struct ap_matrix {
>  struct ap_matrix_mdev {
>  	struct list_head node;
>  	struct ap_matrix matrix;
> +	struct ap_matrix shadow_apcb;
>  	struct notifier_block group_notifier;
>  	struct notifier_block iommu_notifier;
>  	struct kvm *kvm;
