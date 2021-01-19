Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33306 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391650AbhASOY1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 Jan 2021 09:24:27 -0500
Subject: Re: [PATCH v1 1/4] s390/kvm: VSIE: stop leaking host addresses
References: <20201218141811.310267-1-imbrenda@linux.ibm.com>
 <20201218141811.310267-2-imbrenda@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <4265bc48-40f9-54be-8a87-bcd50c7c628a@linux.ibm.com>
Date: Tue, 19 Jan 2021 15:23:35 +0100
MIME-Version: 1.0
In-Reply-To: <20201218141811.310267-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: borntraeger@de.ibm.com, david@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, stable@vger.kernel.org

On 12/18/20 3:18 PM, Claudio Imbrenda wrote:
> The addresses in the SIE control block of the host should not be
> forwarded to the guest. They are only meaningful to the host, and
> moreover it would be a clear security issue.
> 
> Subsequent patches will actually put the right values in the guest SIE
> control block.
> 
> Fixes: a3508fbe9dc6d ("KVM: s390: vsie: initial support for nested virtualization")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Looks reasonable.
Give me some time to have a deeper look it's a lot of architecture to read.

> ---
>  arch/s390/kvm/vsie.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 4f3cbf6003a9..ada49583e530 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -416,11 +416,6 @@ static void unshadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  		memcpy((void *)((u64)scb_o + 0xc0),
>  		       (void *)((u64)scb_s + 0xc0), 0xf0 - 0xc0);
>  		break;
> -	case ICPT_PARTEXEC:
> -		/* MVPG only */
> -		memcpy((void *)((u64)scb_o + 0xc0),
> -		       (void *)((u64)scb_s + 0xc0), 0xd0 - 0xc0);
> -		break;
>  	}
>  
>  	if (scb_s->ihcpu != 0xffffU)
> 
