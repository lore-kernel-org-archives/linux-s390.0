From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v4 5/7] s390: ap: implement PAPQ AQIC interception in
 kernel
Date: Thu, 28 Feb 2019 21:20:49 +0100
Message-ID: <a7be3d71-6392-4ff3-5bd5-60429b8a61c0@de.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-6-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550849400-27152-6-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 22.02.2019 16:29, Pierre Morel wrote:
> We register the AP PQAP instruction hook during the open
> of the mediated device. And unregister it on release.
> 
> In the AP PQAP instruction hook, if we receive a demand to
> enable IRQs,
> - we retrieve the vfio_ap_queue based on the APQN we receive
>   in REG1,
> - we retrieve the page of the guest address, (NIB), from
>   register REG2
> - we the mediated device to use the VFIO pinning infratrsucture
>   to pin the page of the guest address,
> - we retrieve the pointer to KVM to register the guest ISC
>   and retrieve the host ISC
> - finaly we activate GISA
> 
> If we receive a demand to disable IRQs,
> - we deactivate GISA
> - unregister from the GIB
> - unping the NIB
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h      |   1 +
>  drivers/s390/crypto/ap_bus.h          |   1 +
>  drivers/s390/crypto/vfio_ap_ops.c     | 199 +++++++++++++++++++++++++++++++++-
>  drivers/s390/crypto/vfio_ap_private.h |   1 +
>  4 files changed, 199 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 49cc8b0..5f3bb8c 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -720,6 +720,7 @@ struct kvm_s390_cpu_model {
>  struct kvm_s390_crypto {
>  	struct kvm_s390_crypto_cb *crycb;
>  	int (*pqap_hook)(struct kvm_vcpu *vcpu);
> +	void *vfio_private;
>  	__u32 crycbd;
>  	__u8 aes_kw;
>  	__u8 dea_kw;
> diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
> index bfc66e4..323f2aa 100644
> --- a/drivers/s390/crypto/ap_bus.h
> +++ b/drivers/s390/crypto/ap_bus.h
> @@ -43,6 +43,7 @@ static inline int ap_test_bit(unsigned int *ptr, unsigned int nr)
>  #define AP_RESPONSE_BUSY		0x05
>  #define AP_RESPONSE_INVALID_ADDRESS	0x06
>  #define AP_RESPONSE_OTHERWISE_CHANGED	0x07
> +#define AP_RESPONSE_INVALID_GISA	0x08
>  #define AP_RESPONSE_Q_FULL		0x10
>  #define AP_RESPONSE_NO_PENDING_REPLY	0x10
>  #define AP_RESPONSE_INDEX_TOO_BIG	0x11
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 1b5130a..0196065 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -43,7 +43,7 @@ struct vfio_ap_queue *vfio_ap_get_queue(int apqn, struct list_head *l)
>  	return NULL;
>  }
>  
> -static int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
> +int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
>  {
>  	struct ap_queue_status status;
>  	int retry = 20;
> @@ -75,6 +75,27 @@ static int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
>  	return -EBUSY;
>  }
>  
> +/**
> + * vfio_ap_free_irq:
> + * @q: The vfio_ap_queue
> + *
> + * Unpin the guest NIB
> + * Unregister the ISC from the GIB alert
> + * Clear the vfio_ap_queue intern fields
> + */
> +static void vfio_ap_free_irq(struct vfio_ap_queue *q)
> +{
> +	if (!q)
> +		return;
> +	if (q->g_pfn)
> +		vfio_unpin_pages(mdev_dev(q->matrix_mdev->mdev), &q->g_pfn, 1);
> +	if (q->isc)
> +		kvm_s390_gisc_unregister(q->matrix_mdev->kvm, q->isc);
> +	q->nib = 0;
> +	q->isc = 0;
> +	q->g_pfn = 0;
> +}

Pierre, unless there is some magic, I think we need to free the gisa stuff before kvm exit.

Imagine a malicious userspace that setups everything fine, but then closes all kvm file 
descriptors but not the vfio file descriptor. This might result in random access to the
memory that contained the gisa potentially resulting in random memory overwrites.

the problem is that kvm_destroy_vm calls kvm_arch_destroy_vm(kvm) before it calls
kvm_destroy_devices(kvm); So we already free the gisa before we do the unregister call.

What about calling kvm_get_kvm/put from some of the callbacks in the right places.

Debugging random memory overwrites is a PITA, so we either should document why I cannot
happen (even with malicious userspace) or simply fix the refcounting.
