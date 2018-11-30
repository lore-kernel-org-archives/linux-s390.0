From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 30 Nov 2018 14:51:06 +0000
Subject: Re: [PATCH v4 01/10] KVM: s390: unregister debug feature on failing arch init
Message-Id: <63d10fb9-27a1-0cf0-07cc-e155d3c2164d@de.ibm.com>
In-Reply-To: <20181130143215.69496-2-mimu@linux.ibm.com>
References: <20181130143215.69496-2-mimu@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 30.11.2018 15:32, Michael Mueller wrote:
> Make sure the debug feature and its allocated resources get
> released upon unsuccessful architecture initialization.
> 
> A related indication of the issue will be reported as kernel
> message.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

Thanks applied.
> ---
>  Documentation/kmsg/s390/kvm | 12 ++++++++++++
>  arch/s390/kvm/kvm-s390.c    | 17 ++++++++++++++---
>  2 files changed, 26 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/kmsg/s390/kvm
> 
> diff --git a/Documentation/kmsg/s390/kvm b/Documentation/kmsg/s390/kvm
> new file mode 100644
> index 000000000000..76ffe2012254
> --- /dev/null
> +++ b/Documentation/kmsg/s390/kvm
> @@ -0,0 +1,12 @@
> +/*?
> + * Text: "Failed to register FLIC rc=%d\n"
> + * Severity: Error
> + * Parameter:
> + *   @1: return code of the FLIC registration call
> + * Description:
> + * The registration of the FLIC (Floating Interrupt Controller Interface)
> + * was not successful.
> + * User action:
> + * If this problem persists after a reload of the kvm kernel module, gather
> + * Linux debug data and contact your support organization.
> + */
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index fe24150ff666..d8d8e0788157 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -417,19 +417,30 @@ static void kvm_s390_cpu_feat_init(void)
>  
>  int kvm_arch_init(void *opaque)
>  {
> +	int rc;
> +
>  	kvm_s390_dbf = debug_register("kvm-trace", 32, 1, 7 * sizeof(long));
>  	if (!kvm_s390_dbf)
>  		return -ENOMEM;
>  
>  	if (debug_register_view(kvm_s390_dbf, &debug_sprintf_view)) {
> -		debug_unregister(kvm_s390_dbf);
> -		return -ENOMEM;
> +		rc = -ENOMEM;
> +		goto out_debug_unreg;
>  	}
>  
>  	kvm_s390_cpu_feat_init();
>  
>  	/* Register floating interrupt controller interface. */
> -	return kvm_register_device_ops(&kvm_flic_ops, KVM_DEV_TYPE_FLIC);
> +	rc = kvm_register_device_ops(&kvm_flic_ops, KVM_DEV_TYPE_FLIC);
> +	if (rc) {
> +		pr_err("Failed to register FLIC rc=%d\n", rc);
> +		goto out_debug_unreg;
> +	}
> +	return 0;
> +
> +out_debug_unreg:
> +	debug_unregister(kvm_s390_dbf);
> +	return rc;
>  }
>  
>  void kvm_arch_exit(void)
> 
