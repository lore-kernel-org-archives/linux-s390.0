Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40247 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727187AbgBXTA4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 24 Feb 2020 14:00:56 -0500
Subject: Re: [PATCH v4 22/36] KVM: s390: protvirt: STSI handling
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
 <20200224114107.4646-23-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8fa8ebf6-ceed-940f-9ae2-e146c241ccb6@redhat.com>
Date: Mon, 24 Feb 2020 20:00:45 +0100
MIME-Version: 1.0
In-Reply-To: <20200224114107.4646-23-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 24.02.20 12:40, Christian Borntraeger wrote:
> From: Janosch Frank <frankja@linux.ibm.com>
> 
> Save response to sidad and disable address checking for protected
> guests.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/priv.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index ed52ffa8d5d4..69a824f9ef0b 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -2,7 +2,7 @@
>  /*
>   * handling privileged instructions
>   *
> - * Copyright IBM Corp. 2008, 2018
> + * Copyright IBM Corp. 2008, 2020
>   *
>   *    Author(s): Carsten Otte <cotte@de.ibm.com>
>   *               Christian Borntraeger <borntraeger@de.ibm.com>
> @@ -872,7 +872,7 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
>  
>  	operand2 = kvm_s390_get_base_disp_s(vcpu, &ar);
>  
> -	if (operand2 & 0xfff)
> +	if (!kvm_s390_pv_cpu_is_protected(vcpu) && (operand2 & 0xfff))
>  		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
>  
>  	switch (fc) {
> @@ -893,8 +893,13 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
>  		handle_stsi_3_2_2(vcpu, (void *) mem);
>  		break;
>  	}
> -
> -	rc = write_guest(vcpu, operand2, ar, (void *)mem, PAGE_SIZE);
> +	if (kvm_s390_pv_cpu_is_protected(vcpu)) {
> +		memcpy((void *)sida_origin(vcpu->arch.sie_block), (void *)mem,
> +		       PAGE_SIZE);
> +		rc = 0;
> +	} else {
> +		rc = write_guest(vcpu, operand2, ar, (void *)mem, PAGE_SIZE);
> +	}
>  	if (rc) {
>  		rc = kvm_s390_inject_prog_cond(vcpu, rc);
>  		goto out;
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
