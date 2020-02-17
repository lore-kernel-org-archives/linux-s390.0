Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49099 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726267AbgBQLBU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 17 Feb 2020 06:01:20 -0500
Subject: Re: [PATCH v2 19/42] KVM: s390: protvirt: Add new gprs location
 handling
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-20-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <38b60f61-db18-ee7a-6b8e-192a7bb9d259@redhat.com>
Date: Mon, 17 Feb 2020 12:01:03 +0100
MIME-Version: 1.0
In-Reply-To: <20200214222658.12946-20-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 14.02.20 23:26, Christian Borntraeger wrote:
> From: Janosch Frank <frankja@linux.ibm.com>
> 
> Guest registers for protected guests are stored at offset 0x380.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  4 +++-
>  arch/s390/kvm/kvm-s390.c         | 11 +++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index ba3364b37159..4fcbb055a565 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -343,7 +343,9 @@ struct kvm_s390_itdb {
>  struct sie_page {
>  	struct kvm_s390_sie_block sie_block;
>  	struct mcck_volatile_info mcck_info;	/* 0x0200 */
> -	__u8 reserved218[1000];		/* 0x0218 */
> +	__u8 reserved218[360];		/* 0x0218 */
> +	__u64 pv_grregs[16];		/* 0x0380 */
> +	__u8 reserved400[512];		/* 0x0400 */
>  	struct kvm_s390_itdb itdb;	/* 0x0600 */
>  	__u8 reserved700[2304];		/* 0x0700 */
>  };
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index a85e50075d99..6ebb0dae5a2e 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3999,6 +3999,7 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
>  static int __vcpu_run(struct kvm_vcpu *vcpu)
>  {
>  	int rc, exit_reason;
> +	struct sie_page *sie_page = (struct sie_page *)vcpu->arch.sie_block;
>  
>  	/*
>  	 * We try to hold kvm->srcu during most of vcpu_run (except when run-
> @@ -4020,8 +4021,18 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
>  		guest_enter_irqoff();
>  		__disable_cpu_timer_accounting(vcpu);
>  		local_irq_enable();
> +		if (kvm_s390_pv_is_protected(vcpu->kvm)) {
> +			memcpy(sie_page->pv_grregs,
> +			       vcpu->run->s.regs.gprs,
> +			       sizeof(sie_page->pv_grregs));
> +		}
>  		exit_reason = sie64a(vcpu->arch.sie_block,
>  				     vcpu->run->s.regs.gprs);
> +		if (kvm_s390_pv_is_protected(vcpu->kvm)) {
> +			memcpy(vcpu->run->s.regs.gprs,
> +			       sie_page->pv_grregs,
> +			       sizeof(sie_page->pv_grregs));
> +		}
>  		local_irq_disable();
>  		__enable_cpu_timer_accounting(vcpu);
>  		guest_exit_irqoff();
> 

As discussed, I think there is room for improvement in the future (which
we could have documented in the patch description), because this is
obviously sub-optimal.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
