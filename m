Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25804 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728695AbgDFPGt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Apr 2020 11:06:49 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 036F4XqO171297
        for <linux-s390@vger.kernel.org>; Mon, 6 Apr 2020 11:06:48 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 306n24dwph-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 06 Apr 2020 11:06:48 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 6 Apr 2020 16:06:23 +0100
Subject: Re: [PATCH v2 4/5] KVM: s390: vsie: Move conditional reschedule
References: <20200403153050.20569-1-david@redhat.com>
 <20200403153050.20569-5-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 6 Apr 2020 17:06:40 +0200
MIME-Version: 1.0
In-Reply-To: <20200403153050.20569-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <ddaf8521-5220-a0f9-c13c-36dea04b4def@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>

On 03.04.20 17:30, David Hildenbrand wrote:
> Let's move it to the outer loop, in case we ever run again into long
> loops, trying to map the prefix. While at it, convert it to cond_resched().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>


> ---
>  arch/s390/kvm/vsie.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 4f6c22d72072..ef05b4e167fb 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -1000,8 +1000,6 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  
>  	handle_last_fault(vcpu, vsie_page);
>  
> -	if (need_resched())
> -		schedule();
>  	if (test_cpu_flag(CIF_MCCK_PENDING))
>  		s390_handle_mcck();
>  
> @@ -1185,6 +1183,7 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  		    kvm_s390_vcpu_has_irq(vcpu, 0) ||
>  		    kvm_s390_vcpu_sie_inhibited(vcpu))
>  			break;
> +		cond_resched();
>  	}
>  
>  	if (rc == -EFAULT) {
> 
