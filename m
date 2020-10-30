Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726703AbgJ3OXe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 30 Oct 2020 10:23:34 -0400
Subject: Re: [PATCH] kvm: s390: pv: Mark mm as protected after the set secure
 parameters and improve cleanup
References: <20201030140141.106641-1-frankja@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <f4381509-bf28-2159-b5a6-7dd9e9ee4816@de.ibm.com>
Date: Fri, 30 Oct 2020 15:23:26 +0100
MIME-Version: 1.0
In-Reply-To: <20201030140141.106641-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: david@redhat.com, thuth@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com

On 30.10.20 15:01, Janosch Frank wrote:
> We can only have protected guest pages after a successful set secure
> parameters call as only then the UV allows imports and unpacks.
> 
> By moving the test we can now also check for it in s390_reset_acc()
> and do an early return if it is 0.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Can we check this into devel to give it some test coverage?

> ---
>  arch/s390/kvm/kvm-s390.c | 2 +-
>  arch/s390/kvm/pv.c       | 3 ++-
>  arch/s390/mm/gmap.c      | 2 ++
>  3 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 6b74b92c1a58..08ea6c4735cd 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2312,7 +2312,7 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
>  		struct kvm_s390_pv_unp unp = {};
>  
>  		r = -EINVAL;
> -		if (!kvm_s390_pv_is_protected(kvm))
> +		if (!kvm_s390_pv_is_protected(kvm) || !mm_is_protected(kvm->mm))
>  			break;
>  
>  		r = -EFAULT;
> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
> index eb99e2f95ebe..f5847f9dec7c 100644
> --- a/arch/s390/kvm/pv.c
> +++ b/arch/s390/kvm/pv.c
> @@ -208,7 +208,6 @@ int kvm_s390_pv_init_vm(struct kvm *kvm, u16 *rc, u16 *rrc)
>  		return -EIO;
>  	}
>  	kvm->arch.gmap->guest_handle = uvcb.guest_handle;
> -	atomic_set(&kvm->mm->context.is_protected, 1);
>  	return 0;
>  }
>  
> @@ -228,6 +227,8 @@ int kvm_s390_pv_set_sec_parms(struct kvm *kvm, void *hdr, u64 length, u16 *rc,
>  	*rrc = uvcb.header.rrc;
>  	KVM_UV_EVENT(kvm, 3, "PROTVIRT VM SET PARMS: rc %x rrc %x",
>  		     *rc, *rrc);
> +	if (!cc)
> +		atomic_set(&kvm->mm->context.is_protected, 1);
>  	return cc ? -EINVAL : 0;
>  }
>  
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index cfb0017f33a7..64795d034926 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -2690,6 +2690,8 @@ static const struct mm_walk_ops reset_acc_walk_ops = {
>  #include <linux/sched/mm.h>
>  void s390_reset_acc(struct mm_struct *mm)
>  {
> +	if (!mm_is_protected(mm))
> +		return;
>  	/*
>  	 * we might be called during
>  	 * reset:                             we walk the pages and clear
> 
