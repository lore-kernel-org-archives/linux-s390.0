Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2756 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731000AbfILKUx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Sep 2019 06:20:53 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8CAHV1T145461
        for <linux-s390@vger.kernel.org>; Thu, 12 Sep 2019 06:20:52 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uyhn6p11v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Sep 2019 06:20:51 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 12 Sep 2019 11:20:49 +0100
Subject: Re: [PATCH] KVM: s390: Remove unused parameter from
 __inject_sigp_restart()
References: <20190912070250.15131-1-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 12 Sep 2019 12:20:45 +0200
MIME-Version: 1.0
In-Reply-To: <20190912070250.15131-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <31218beb-f7e8-af61-2228-ee6f0727a4da@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On 12.09.19 09:02, Thomas Huth wrote:
> It's not required, so drop it to make it clear that this interrupt
> does not have any extra parameters.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

makes sense. Thanks applied. 
> ---
>  arch/s390/kvm/interrupt.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index b5fd6e85657c..3e7efdd9228a 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -1477,8 +1477,7 @@ static int __inject_sigp_stop(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
>  	return 0;
>  }
>  
> -static int __inject_sigp_restart(struct kvm_vcpu *vcpu,
> -				 struct kvm_s390_irq *irq)
> +static int __inject_sigp_restart(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
>  
> @@ -1997,7 +1996,7 @@ static int do_inject_vcpu(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
>  		rc = __inject_sigp_stop(vcpu, irq);
>  		break;
>  	case KVM_S390_RESTART:
> -		rc = __inject_sigp_restart(vcpu, irq);
> +		rc = __inject_sigp_restart(vcpu);
>  		break;
>  	case KVM_S390_INT_CLOCK_COMP:
>  		rc = __inject_ckc(vcpu);
> 
