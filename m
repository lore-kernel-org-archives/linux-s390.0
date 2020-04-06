Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54618 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728200AbgDFNSN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Apr 2020 09:18:13 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 036DHUvx016437
        for <linux-s390@vger.kernel.org>; Mon, 6 Apr 2020 09:18:11 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 306n24aurx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 06 Apr 2020 09:18:10 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 6 Apr 2020 14:17:46 +0100
Subject: Re: [PATCH v1 2/5] KVM: s390: vsie: Fix delivery of addressing
 exceptions
References: <20200402184819.34215-1-david@redhat.com>
 <20200402184819.34215-3-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 6 Apr 2020 15:17:57 +0200
MIME-Version: 1.0
In-Reply-To: <20200402184819.34215-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <0cd2822e-8486-d386-6c00-faadaa573e5e@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, stable@vger.kernel.org



On 02.04.20 20:48, David Hildenbrand wrote:
> Whenever we get an -EFAULT, we failed to read in guest 2 physical
> address space. Such addressing exceptions are reported via a program
> intercept to the nested hypervisor.
> 
> We faked the intercept, we have to return to guest 2. Instead, right
> now we would be returning -EFAULT from the intercept handler, eventually
> crashing the VM.
> 
> Addressing exceptions can only happen if the g2->g3 page tables
> reference invalid g2 addresses (say, either a table or the final page is
> not accessible - so something that basically never happens in sane
> environments.
> 
> Identified by manual code inspection.
> 
> Fixes: a3508fbe9dc6 ("KVM: s390: vsie: initial support for nested virtualization")
> Cc: <stable@vger.kernel.org> # v4.8+
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kvm/vsie.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 076090f9e666..4f6c22d72072 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -1202,6 +1202,7 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  		scb_s->iprcc = PGM_ADDRESSING;
>  		scb_s->pgmilc = 4;
>  		scb_s->gpsw.addr = __rewind_psw(scb_s->gpsw, 4);
> +		rc = 1;


kvm_s390_handle_vsie has 

 return rc < 0 ? rc : 0;


so rc = 0 would result in the same behaviour, correct?
Since we DO handle everything as we should, why rc = 1 ?
