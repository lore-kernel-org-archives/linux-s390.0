Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60999 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729048AbfLENJ7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Dec 2019 08:09:59 -0500
Subject: Re: [PATCH] KVM: s390: ENOTSUPP -> EOPNOTSUPP fixups
References: <20191205125147.229367-1-borntraeger@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <087b1693-6ec0-94e3-d94a-f55c2e717438@redhat.com>
Date: Thu, 5 Dec 2019 14:09:50 +0100
MIME-Version: 1.0
In-Reply-To: <20191205125147.229367-1-borntraeger@de.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Julian Wiedmann <jwi@linux.ibm.com>

On 05/12/2019 13.51, Christian Borntraeger wrote:
> There is no ENOTSUPP for userspace
> 
> Reported-by: Julian Wiedmann <jwi@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 2a711bae69a7..bd9b339bbb5e 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2312,7 +2312,7 @@ static int flic_ais_mode_get_all(struct kvm *kvm, struct kvm_device_attr *attr)
>  		return -EINVAL;
>  
>  	if (!test_kvm_facility(kvm, 72))
> -		return -ENOTSUPP;
> +		return -EOPNOTSUPP;
>  
>  	mutex_lock(&fi->ais_lock);
>  	ais.simm = fi->simm;
> @@ -2621,7 +2621,7 @@ static int modify_ais_mode(struct kvm *kvm, struct kvm_device_attr *attr)
>  	int ret = 0;
>  
>  	if (!test_kvm_facility(kvm, 72))
> -		return -ENOTSUPP;
> +		return -EOPNOTSUPP;
>  
>  	if (copy_from_user(&req, (void __user *)attr->addr, sizeof(req)))
>  		return -EFAULT;
> @@ -2701,7 +2701,7 @@ static int flic_ais_mode_set_all(struct kvm *kvm, struct kvm_device_attr *attr)
>  	struct kvm_s390_ais_all ais;
>  
>  	if (!test_kvm_facility(kvm, 72))
> -		return -ENOTSUPP;
> +		return -EOPNOTSUPP;
>  
>  	if (copy_from_user(&ais, (void __user *)attr->addr, sizeof(ais)))
>  		return -EFAULT;
> 

Good catch.

Reviewed-by: Thomas Huth <thuth@redhat.com>

There seems to be another one in arch/s390/include/asm/uv.h, are you
going to fix that, too?
