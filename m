Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43942 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726808AbfK2Obu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 29 Nov 2019 09:31:50 -0500
Subject: Re: [PATCH] KVM: s390: Add new reset vcpu API
References: <20191129142122.21528-1-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <bc1d057f-03a0-b850-dff8-a7156bfe3274@redhat.com>
Date: Fri, 29 Nov 2019 15:31:41 +0100
MIME-Version: 1.0
In-Reply-To: <20191129142122.21528-1-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, mihajlov@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 29.11.19 15:21, Janosch Frank wrote:
> The architecture states that we need to reset local IRQs for all CPU
> resets. Because the old reset interface did not support the normal CPU
> reset we never did that.
> 
> Now that we have a new interface, let's properly clear out local IRQs
> and let this commit be a reminder.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 25 ++++++++++++++++++++++++-
>  include/uapi/linux/kvm.h |  7 +++++++
>  2 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index d9e6bf3d54f0..2f74ff46b176 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -529,6 +529,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_S390_CMMA_MIGRATION:
>  	case KVM_CAP_S390_AIS:
>  	case KVM_CAP_S390_AIS_MIGRATION:
> +	case KVM_CAP_S390_VCPU_RESETS:
>  		r = 1;
>  		break;
>  	case KVM_CAP_S390_HPAGE_1M:
> @@ -3293,6 +3294,25 @@ static int kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
>  	return 0;
>  }
>  
> +static int kvm_arch_vcpu_ioctl_reset(struct kvm_vcpu *vcpu, unsigned long type)
> +{
> +	int rc = -EINVAL;
> +
> +	switch (type) {
> +	case KVM_S390_VCPU_RESET_NORMAL:
> +		rc = 0;
> +		kvm_clear_async_pf_completion_queue(vcpu);
> +		kvm_s390_clear_local_irqs(vcpu);
> +		break;
> +	case KVM_S390_VCPU_RESET_INITIAL:
> +		/* fallthrough */
> +	case KVM_S390_VCPU_RESET_CLEAR:
> +		rc = kvm_arch_vcpu_ioctl_initial_reset(vcpu);

As we now have two interfaces to achieve the same thing (initial reset),
I do wonder if we should simply introduce

KVM_S390_NORMAL_RESET
KVM_S390_CLEAR_RESET

instead ...

Then you can do KVM_S390_NORMAL_RESET for the bugfix and
KVM_S390_CLEAR_RESET later for PV.

Does anything speak against that?

-- 
Thanks,

David / dhildenb
