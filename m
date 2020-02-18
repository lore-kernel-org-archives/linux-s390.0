Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27013 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726539AbgBRJxk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 18 Feb 2020 04:53:40 -0500
Subject: Re: [PATCH v2 34/42] KVM: s390: protvirt: do not inject interrupts
 after start
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-35-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4651fa57-5b2f-3a05-2347-7767bc675fa3@redhat.com>
Date: Tue, 18 Feb 2020 10:53:30 +0100
MIME-Version: 1.0
In-Reply-To: <20200214222658.12946-35-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On 14.02.20 23:26, Christian Borntraeger wrote:
> As PSW restart is handled by the ultravisor (and we only get a start
> notification) we must re-check the PSW after a start before injecting
> interrupts.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 1b6963bbc96f..16af4d1a2c29 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -4436,6 +4436,13 @@ void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
>  	/* Let's tell the UV that we want to start again */
>  	kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_OPR, &rc, &rrc);
>  	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_STOPPED);
> +	/*
> +	 * The real PSW might have changed due to a RESTART interpreted by the
> +	 * ultravisor. We block all interrupts and let the next sie exit
> +	 * refresh our view.
> +	 */
> +	if (kvm_s390_pv_is_protected(vcpu->kvm))
> +		vcpu->arch.sie_block->gpsw.mask &= ~PSW_INT_MASK;

Same comment as to the previous patch.


-- 
Thanks,

David / dhildenb
