Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41084 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726776AbgCIPj7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Mar 2020 11:39:59 -0400
Subject: Re: [PATCH 3/4] KVM: s390: Also reset registers in sync regs for
 initial cpu reset
References: <20200309150026.4329-1-borntraeger@de.ibm.com>
 <20200309150026.4329-4-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0c644633-b3db-d095-d309-6fb90183f2dc@redhat.com>
Date: Mon, 9 Mar 2020 16:39:51 +0100
MIME-Version: 1.0
In-Reply-To: <20200309150026.4329-4-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, stable@vger.kernel.org

On 09.03.20 16:00, Christian Borntraeger wrote:
> When we do the initial CPU reset we must not only clear the registers
> in the internal data structures but also in kvm_run sync_regs. For
> modern userspace sync_regs is the only place that it looks at.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7de3f1423ff943 ("KVM: s390: Add new reset vcpu API")
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 6b1842a9feed..81f54ddedb3d 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3529,7 +3529,10 @@ static void kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
>  	/* Initial reset is a superset of the normal reset */
>  	kvm_arch_vcpu_ioctl_normal_reset(vcpu);
>  
> -	/* this equals initial cpu reset in pop, but we don't switch to ESA */
> +	/*
> +	 * This equals initial cpu reset in pop, but we don't switch to ESA.
> +	 * We do not even reset the internal data, but also ...

s/even/only ?

-- 
Thanks,

David / dhildenb
