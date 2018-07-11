From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v6 15/21] s390: vfio-ap: configure the guest's AP matrix
Date: Thu, 12 Jul 2018 01:22:57 +0200
Message-ID: <74beb5b9-1a49-ca42-4ffe-3bf042718ed0@linux.ibm.com>
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
> KVM guest from the matrix configured via the mediated matrix device's
> sysfs attribute files.
> 
[..]
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

Are you sure this or works as expected? E.g. if adm_max == 15 the bitmaps
include the least significant 2 bytes but you want the other two.

> +}
