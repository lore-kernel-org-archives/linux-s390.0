Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729099AbfLEOuv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Dec 2019 09:50:51 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB5ElL8c045984
        for <linux-s390@vger.kernel.org>; Thu, 5 Dec 2019 09:50:50 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wq1pnphes-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 05 Dec 2019 09:50:49 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 5 Dec 2019 14:50:45 -0000
Subject: Re: [PATCH] KVM: s390: ENOTSUPP -> EOPNOTSUPP fixups
References: <20191205125147.229367-1-borntraeger@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 5 Dec 2019 15:50:41 +0100
MIME-Version: 1.0
In-Reply-To: <20191205125147.229367-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <82377b35-79dc-05e1-cb1c-e84d397f4321@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Julian Wiedmann <jwi@linux.ibm.com>


On 05.12.19 13:51, Christian Borntraeger wrote:
> There is no ENOTSUPP for userspace
> 
> Reported-by: Julian Wiedmann <jwi@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

applied.

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
