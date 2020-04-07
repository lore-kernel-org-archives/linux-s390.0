Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728091AbgDGLKt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Apr 2020 07:10:49 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 037B4ge9108288
        for <linux-s390@vger.kernel.org>; Tue, 7 Apr 2020 07:10:48 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3082j8muyn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 07 Apr 2020 07:10:48 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Tue, 7 Apr 2020 12:10:43 +0100
Date: Tue, 7 Apr 2020 12:52:14 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v2 4/5] KVM: s390: vsie: Move conditional reschedule
In-Reply-To: <20200403153050.20569-5-david@redhat.com>
References: <20200403153050.20569-1-david@redhat.com>
        <20200403153050.20569-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20200407125214.35c70f2a@p-imbrenda>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Fri,  3 Apr 2020 17:30:49 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's move it to the outer loop, in case we ever run again into long
> loops, trying to map the prefix. While at it, convert it to
> cond_resched().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kvm/vsie.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 4f6c22d72072..ef05b4e167fb 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -1000,8 +1000,6 @@ static int do_vsie_run(struct kvm_vcpu *vcpu,
> struct vsie_page *vsie_page) 
>  	handle_last_fault(vcpu, vsie_page);
>  
> -	if (need_resched())
> -		schedule();
>  	if (test_cpu_flag(CIF_MCCK_PENDING))
>  		s390_handle_mcck();
>  
> @@ -1185,6 +1183,7 @@ static int vsie_run(struct kvm_vcpu *vcpu,
> struct vsie_page *vsie_page) kvm_s390_vcpu_has_irq(vcpu, 0) ||
>  		    kvm_s390_vcpu_sie_inhibited(vcpu))
>  			break;
> +		cond_resched();
>  	}
>  
>  	if (rc == -EFAULT) {

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
