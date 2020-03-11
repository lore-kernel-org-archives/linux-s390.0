Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49358 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726160AbgCKIlb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Mar 2020 04:41:31 -0400
Subject: Re: [PATCH] KVM: s390: mark sie block as 512 byte aligned
References: <20200311083304.3725276-1-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9e15182c-f7ef-23b1-91e9-4b21b6bd5d99@redhat.com>
Date: Wed, 11 Mar 2020 09:41:22 +0100
MIME-Version: 1.0
In-Reply-To: <20200311083304.3725276-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>

On 11.03.20 09:33, Christian Borntraeger wrote:
> The sie block must be aligned to 512 bytes. Mark it as such.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 0ea82152d2f7..2d50f6c432e2 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -344,7 +344,7 @@ struct kvm_s390_sie_block {
>  	__u64	itdba;			/* 0x01e8 */
>  	__u64   riccbd;			/* 0x01f0 */
>  	__u64	gvrd;			/* 0x01f8 */
> -} __attribute__((packed));
> +} __packed __aligned(512);
>  

I guess there is no change in the code/behavior, because we always place
into well defined spots within a page.

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb
