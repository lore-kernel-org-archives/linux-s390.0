From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v6 15/21] s390: vfio-ap: configure the guest's AP matrix
Date: Thu, 12 Jul 2018 15:28:45 +0200
Message-ID: <fb3480f2-2cdb-d8fb-c92e-4af49e74327d@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-16-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530306683-7270-16-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 06/29/2018 11:11 PM, Tony Krowiak wrote:
> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Configures the AP adapters, usage domains and control domains for the

[..]

> +static inline void kvm_ap_clear_crycb_masks(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	memset(&matrix_mdev->kvm->arch.crypto.crycb->apcb0, 0,
> +	       sizeof(matrix_mdev->kvm->arch.crypto.crycb->apcb0));
> +	memset(&matrix_mdev->kvm->arch.crypto.crycb->apcb1, 0,
> +	       sizeof(matrix_mdev->kvm->arch.crypto.crycb->apcb1));
> +}
> +
> +static void kvm_ap_set_crycb_masks(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	int nbytes;
> +	unsigned long *apm, *aqm, *adm;
> +
> +	kvm_ap_clear_crycb_masks(matrix_mdev);
> +
> +	apm = kvm_ap_get_crycb_apm(matrix_mdev);
> +	aqm = kvm_ap_get_crycb_aqm(matrix_mdev);
> +	adm = kvm_ap_get_crycb_adm(matrix_mdev);
> +
> +	nbytes = KVM_AP_MASK_BYTES(matrix_mdev->matrix.apm_max + 1);
> +	memcpy(apm, matrix_mdev->matrix.apm, nbytes);
> +
> +	nbytes = KVM_AP_MASK_BYTES(matrix_mdev->matrix.aqm_max + 1);
> +	memcpy(aqm, matrix_mdev->matrix.aqm, nbytes);
> +
> +	/*
> +	 * Merge the AQM and ADM since the ADM is a superset of the
> +	 * AQM by agreed-upon convention.
> +	 */
> +	bitmap_or(adm, matrix_mdev->matrix.adm, matrix_mdev->matrix.aqm,
> +		  matrix_mdev->matrix.adm_max + 1);
> +}
> +

[..]

> +
> +static int kvm_ap_configure_matrix(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&matrix_mdev->kvm->lock);
> +
> +	ret = kvm_ap_validate_queue_sharing(matrix_mdev);
> +	if (ret)
> +		goto done;
> +
> +	kvm_ap_set_crycb_masks(matrix_mdev);
> +
> +done:
> +	mutex_unlock(&matrix_mdev->kvm->lock);
> +
> +	return ret;
> +}
> +
> +void kvm_ap_deconfigure_matrix(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	mutex_lock(&matrix_mdev->kvm->lock);
> +	kvm_ap_clear_crycb_masks(matrix_mdev);

The guest may be running at this point of time, or?

I think you need our safe update operation that we used to use for the
initial set too, but then somebody was like it ain't necessary because
we don't support hotplug (yet).


Regards,
Halil

> +	mutex_unlock(&matrix_mdev->kvm->lock);
> +}
> +
