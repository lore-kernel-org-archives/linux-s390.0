Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34130 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbfH2N62 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 29 Aug 2019 09:58:28 -0400
Subject: Re: [PATCH] KVM: s390: improve documentation for S390_MEM_OP
References: <20190829124746.28665-1-cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3f67bea5-83d9-321a-62e0-c463287c04ba@redhat.com>
Date: Thu, 29 Aug 2019 15:58:24 +0200
MIME-Version: 1.0
In-Reply-To: <20190829124746.28665-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On 29.08.19 14:47, Cornelia Huck wrote:
> Explicitly specify the valid ranges for size and ar, and reword
> buf requirements a bit.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> supposed to go on top of "KVM: s390: Test for bad access register and
> size at the start of S390_MEM_OP" (<20190829122517.31042-1-thuth@redhat.com>)
> ---
>  Documentation/virt/kvm/api.txt | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.txt b/Documentation/virt/kvm/api.txt
> index 2d067767b617..76c9d6fdbfdb 100644
> --- a/Documentation/virt/kvm/api.txt
> +++ b/Documentation/virt/kvm/api.txt
> @@ -3079,12 +3079,14 @@ This exception is also raised directly at the corresponding VCPU if the
>  flag KVM_S390_MEMOP_F_INJECT_EXCEPTION is set in the "flags" field.
>  
>  The start address of the memory region has to be specified in the "gaddr"
> -field, and the length of the region in the "size" field. "buf" is the buffer
> -supplied by the userspace application where the read data should be written
> -to for KVM_S390_MEMOP_LOGICAL_READ, or where the data that should be written
> -is stored for a KVM_S390_MEMOP_LOGICAL_WRITE. "buf" is unused and can be NULL
> -when KVM_S390_MEMOP_F_CHECK_ONLY is specified. "ar" designates the access
> -register number to be used.
> +field, and the length of the region in the "size" field (which must not
> +be 0). The maximum value for "size" can be obtained by checking the
> +KVM_CAP_S390_MEM_OP capability. "buf" is the buffer supplied by the
> +userspace application where the read data should be written to for
> +KVM_S390_MEMOP_LOGICAL_READ, or where the data that should be written is
> +stored for a KVM_S390_MEMOP_LOGICAL_WRITE. When KVM_S390_MEMOP_F_CHECK_ONLY
> +is specified, "buf" is unused and can be NULL. "ar" designates the access
> +register number to be used; the valid range is 0..15.
>  
>  The "reserved" field is meant for future extensions. It is not used by
>  KVM with the currently defined set of flags.
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
