Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25403 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389239AbgFYGel (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 25 Jun 2020 02:34:41 -0400
Date: Thu, 25 Jun 2020 08:34:23 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 2/2] docs: kvm: fix rst formatting
Message-ID: <20200625083423.2ee75bb1.cohuck@redhat.com>
In-Reply-To: <20200624202200.28209-3-walling@linux.ibm.com>
References: <20200624202200.28209-1-walling@linux.ibm.com>
        <20200624202200.28209-3-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Collin Walling <walling@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, pbonzini@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com

On Wed, 24 Jun 2020 16:22:00 -0400
Collin Walling <walling@linux.ibm.com> wrote:

> KVM_CAP_S390_VCPU_RESETS and KVM_CAP_S390_PROTECTED needed
> just a little bit of rst touch-up
> 

Fixes: 7de3f1423ff9 ("KVM: s390: Add new reset vcpu API")
Fixes: 04ed89dc4aeb ("KVM: s390: protvirt: Add KVM api documentation")

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

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
