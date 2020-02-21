Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24577 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728147AbgBUKra (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Feb 2020 05:47:30 -0500
Subject: Re: [PATCH v3 36/37] KVM: s390: rstify new ioctls in api.rst
References: <20200220104020.5343-1-borntraeger@de.ibm.com>
 <20200220104020.5343-37-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <766d49d0-531b-8ce7-55e4-bfb791e746c5@redhat.com>
Date: Fri, 21 Feb 2020 11:47:20 +0100
MIME-Version: 1.0
In-Reply-To: <20200220104020.5343-37-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On 20.02.20 11:40, Christian Borntraeger wrote:
> We also need to rstify the new ioctls that we added in parallel to the
> rstification of the kvm docs.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  Documentation/virt/kvm/api.rst | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 58be7aba0db2..faca9977cbe7 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -4613,35 +4613,38 @@ unpins the VPA pages and releases all the device pages that are used to
>  track the secure pages by hypervisor.
>  
>  4.122 KVM_S390_NORMAL_RESET
> +---------------------------
>  
> -Capability: KVM_CAP_S390_VCPU_RESETS
> -Architectures: s390
> -Type: vcpu ioctl
> -Parameters: none
> -Returns: 0
> +:Capability: KVM_CAP_S390_VCPU_RESETS
> +:Architectures: s390
> +:Type: vcpu ioctl
> +:Parameters: none
> +:Returns: 0
>  
>  This ioctl resets VCPU registers and control structures according to
>  the cpu reset definition in the POP (Principles Of Operation).
>  
>  4.123 KVM_S390_INITIAL_RESET
> +----------------------------
>  
> -Capability: none
> -Architectures: s390
> -Type: vcpu ioctl
> -Parameters: none
> -Returns: 0
> +:Capability: none
> +:Architectures: s390
> +:Type: vcpu ioctl
> +:Parameters: none
> +:Returns: 0
>  
>  This ioctl resets VCPU registers and control structures according to
>  the initial cpu reset definition in the POP. However, the cpu is not
>  put into ESA mode. This reset is a superset of the normal reset.
>  
>  4.124 KVM_S390_CLEAR_RESET
> +--------------------------
>  
> -Capability: KVM_CAP_S390_VCPU_RESETS
> -Architectures: s390
> -Type: vcpu ioctl
> -Parameters: none
> -Returns: 0
> +:Capability: KVM_CAP_S390_VCPU_RESETS
> +:Architectures: s390
> +:Type: vcpu ioctl
> +:Parameters: none
> +:Returns: 0
>  
>  This ioctl resets VCPU registers and control structures according to
>  the clear cpu reset definition in the POP. However, the cpu is not put
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
