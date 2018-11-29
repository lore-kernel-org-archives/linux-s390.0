From: David Hildenbrand <david@redhat.com>
Date: Thu, 29 Nov 2018 12:57:42 +0000
Subject: Re: [PATCH v3 01/12] KVM: s390: unregister debug feature on failing arch init
Message-Id: <9edd3f40-3d40-1915-92ea-5455ac2e63ae@redhat.com>
In-Reply-To: <bf05ac3c-28ab-fa09-49f7-bd9728870b49@de.ibm.com>
References: <bf05ac3c-28ab-fa09-49f7-bd9728870b49@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 28.11.18 11:19, Michael Mueller wrote:
> Make sure the debug feature and its allocated resources get
> released upon unsuccessful architecture initialization.
> 
> A related idication of the issue will be reported by common
> kvm code.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index fe24150ff666..d9635d21563f 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -417,19 +417,29 @@ static void kvm_s390_cpu_feat_init(void)
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
> +		goto out_unreg;
>  	}
>  
>  	kvm_s390_cpu_feat_init();
>  
>  	/* Register floating interrupt controller interface. */
> -	return kvm_register_device_ops(&kvm_flic_ops, KVM_DEV_TYPE_FLIC);
> +	rc = kvm_register_device_ops(&kvm_flic_ops, KVM_DEV_TYPE_FLIC);
> +	if (rc)
> +		goto out_unreg;
> +
> +	return 0;
> +
> +out_unreg:

I would call this out_debug_unreg as we have two different registrations
here.

Reviewed-by: David Hildenbrand <david@redhat.com>

> +	debug_unregister(kvm_s390_dbf);
> +	return rc;
>  }
>  
>  void kvm_arch_exit(void)
> 

BTW, at first I thought we were missing

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index fe24150ff666..d6b911c4fc5b 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -434,6 +434,7 @@ int kvm_arch_init(void *opaque)

 void kvm_arch_exit(void)
 {
+       kvm_unregister_device_ops(KVM_DEV_TYPE_FLIC);
        debug_unregister(kvm_s390_dbf);
 }

But turns out the global table is part of the module that will be
recreated when reloading the module after it has been unloaded.


-- 

Thanks,

David / dhildenb
