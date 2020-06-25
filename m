Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50363 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389923AbgFYHJ1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 25 Jun 2020 03:09:27 -0400
Subject: Re: [PATCH 2/2] docs: kvm: fix rst formatting
References: <20200624202200.28209-1-walling@linux.ibm.com>
 <20200624202200.28209-3-walling@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <7ac2c896-bf55-5b0b-7289-3a3797ddd2cf@redhat.com>
Date: Thu, 25 Jun 2020 09:09:19 +0200
MIME-Version: 1.0
In-Reply-To: <20200624202200.28209-3-walling@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Collin Walling <walling@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, cohuck@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com

On 24.06.20 22:22, Collin Walling wrote:
> KVM_CAP_S390_VCPU_RESETS and KVM_CAP_S390_PROTECTED needed
> just a little bit of rst touch-up
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>  Documentation/virt/kvm/api.rst | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 056608e8f243..2d1572d92616 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6134,16 +6134,17 @@ in CPUID and only exposes Hyper-V identification. In this case, guest
>  thinks it's running on Hyper-V and only use Hyper-V hypercalls.
>  
>  8.22 KVM_CAP_S390_VCPU_RESETS
> +-----------------------------
>  
> -Architectures: s390
> +:Architectures: s390
>  
>  This capability indicates that the KVM_S390_NORMAL_RESET and
>  KVM_S390_CLEAR_RESET ioctls are available.
>  
>  8.23 KVM_CAP_S390_PROTECTED
> +---------------------------
>  
> -Architecture: s390
> -
> +:Architecture: s390
>  
>  This capability indicates that the Ultravisor has been initialized and
>  KVM can therefore start protected VMs.
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
