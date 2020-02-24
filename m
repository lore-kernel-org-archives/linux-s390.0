Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38179 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727483AbgBXSVc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 24 Feb 2020 13:21:32 -0500
Received: by mail-wr1-f69.google.com with SMTP id d15so5991888wru.1
        for <linux-s390@vger.kernel.org>; Mon, 24 Feb 2020 10:21:28 -0800 (PST)
Subject: Re: [PATCH 1/1] KVM: s390: rstify new ioctls in api.rst
References: <20200224101559.27405-1-borntraeger@de.ibm.com>
 <20200224101559.27405-2-borntraeger@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d17d7aa2-c472-1efb-79eb-fdbe3af0fccc@redhat.com>
Date: Mon, 24 Feb 2020 19:21:26 +0100
MIME-Version: 1.0
In-Reply-To: <20200224101559.27405-2-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Jonathan Corbet <corbet@lwn.net>

On 24/02/20 11:15, Christian Borntraeger wrote:
> We also need to rstify the new ioctls that we added in parallel to the
> rstification of the kvm docs.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  Documentation/virt/kvm/api.rst | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 97a72a53fa4b..ebd383fba939 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -4611,35 +4611,38 @@ unpins the VPA pages and releases all the device pages that are used to
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

Applied, thanks.

Paolo
