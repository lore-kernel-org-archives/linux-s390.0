Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36163 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726225AbgBRJi7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 04:38:59 -0500
Subject: Re: [PATCH v2 29/42] KVM: s390: protvirt: Add diag 308 subcode 8 - 10
 handling
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-30-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9e5e7409-aaa2-47af-812f-169c2d290e18@redhat.com>
Date: Tue, 18 Feb 2020 10:38:49 +0100
MIME-Version: 1.0
In-Reply-To: <20200214222658.12946-30-borntraeger@de.ibm.com>
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
> If the host initialized the Ultravisor, we can set stfle bit 161
> (protected virtual IPL enhancements facility), which indicates that
> the IPL subcodes 8, 9, and 10 are valid. These subcodes are used by a
> normal guest to set/retrieve an IPL information block of type 5 (for
> protected virtual machines) and transition into protected mode.
> 
> Once in protected mode, the Ultravisor will conceal the facility bit.
> Therefore each boot into protected mode has to go through
> non-protected mode. There is no secure re-ipl with subcode 10 without
> a previous subcode 3.
> 
> In protected mode, there is no subcode 4 available, as the VM has no
> more access to its memory from non-protected mode. I.e., only a IPL
> clear is possible.
> 
> The error cases will all be handled in userspace.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 4a97d3b7840e..f96c1f530cc2 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2621,6 +2621,11 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  	if (css_general_characteristics.aiv && test_facility(65))
>  		set_kvm_facility(kvm->arch.model.fac_mask, 65);
>  
> +	if (is_prot_virt_host()) {
> +		set_kvm_facility(kvm->arch.model.fac_mask, 161);
> +		set_kvm_facility(kvm->arch.model.fac_list, 161);
> +	}
> +

Aren't these IPL subcodes completely emulated in QEMU? If so, rather
QEMU with support should enable them when the kernel capability for PV
(=== is_prot_virt_host()) is in place.

-- 
Thanks,

David / dhildenb
