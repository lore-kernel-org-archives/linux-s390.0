Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33628 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728474AbgDGLK5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Apr 2020 07:10:57 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 037B7bAT047915
        for <linux-s390@vger.kernel.org>; Tue, 7 Apr 2020 07:10:56 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 308rc4028x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 07 Apr 2020 07:10:55 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Tue, 7 Apr 2020 12:10:29 +0100
Date: Tue, 7 Apr 2020 13:00:13 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v2 2/5] KVM: s390: vsie: Fix delivery of addressing
 exceptions
In-Reply-To: <20200403153050.20569-3-david@redhat.com>
References: <20200403153050.20569-1-david@redhat.com>
        <20200403153050.20569-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20200407130013.2898fb57@p-imbrenda>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, stable@vger.kernel.org

On Fri,  3 Apr 2020 17:30:47 +0200
David Hildenbrand <david@redhat.com> wrote:

> Whenever we get an -EFAULT, we failed to read in guest 2 physical
> address space. Such addressing exceptions are reported via a program
> intercept to the nested hypervisor.
> 
> We faked the intercept, we have to return to guest 2. Instead, right
> now we would be returning -EFAULT from the intercept handler,
> eventually crashing the VM.
> 
> Addressing exceptions can only happen if the g2->g3 page tables
> reference invalid g2 addresses (say, either a table or the final page
> is not accessible - so something that basically never happens in sane
> environments.
> 
> Identified by manual code inspection.
> 
> Fixes: a3508fbe9dc6 ("KVM: s390: vsie: initial support for nested
> virtualization") Cc: <stable@vger.kernel.org> # v4.8+
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kvm/vsie.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 076090f9e666..4f6c22d72072 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -1202,6 +1202,7 @@ static int vsie_run(struct kvm_vcpu *vcpu,
> struct vsie_page *vsie_page) scb_s->iprcc = PGM_ADDRESSING;
>  		scb_s->pgmilc = 4;
>  		scb_s->gpsw.addr = __rewind_psw(scb_s->gpsw, 4);
> +		rc = 1;
>  	}
>  	return rc;
>  }

so, the reason why we never noticed this issue before is simply that
nobody tried running a misbehaving nested guest?

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
