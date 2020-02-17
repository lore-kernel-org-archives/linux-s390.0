Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42479 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728066AbgBQOYs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 17 Feb 2020 09:24:48 -0500
Subject: Re: [PATCH v2 23/42] KVM: s390: protvirt: Write sthyi data to
 instruction data area
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-24-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0054ceb5-a1ab-5129-cc34-b785ee8ad782@redhat.com>
Date: Mon, 17 Feb 2020 15:24:35 +0100
MIME-Version: 1.0
In-Reply-To: <20200214222658.12946-24-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 14.02.20 23:26, Christian Borntraeger wrote:
> From: Janosch Frank <frankja@linux.ibm.com>
> 
> STHYI data has to go through the bounce buffer.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/intercept.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
> index 1e231058e4b3..cfabeecbb777 100644
> --- a/arch/s390/kvm/intercept.c
> +++ b/arch/s390/kvm/intercept.c
> @@ -392,7 +392,7 @@ int handle_sthyi(struct kvm_vcpu *vcpu)
>  		goto out;
>  	}
>  
> -	if (addr & ~PAGE_MASK)
> +	if (!kvm_s390_pv_is_protected(vcpu->kvm) && (addr & ~PAGE_MASK))
>  		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
>  
>  	sctns = (void *)get_zeroed_page(GFP_KERNEL);
> @@ -403,10 +403,15 @@ int handle_sthyi(struct kvm_vcpu *vcpu)
>  
>  out:
>  	if (!cc) {
> -		r = write_guest(vcpu, addr, reg2, sctns, PAGE_SIZE);
> -		if (r) {
> -			free_page((unsigned long)sctns);
> -			return kvm_s390_inject_prog_cond(vcpu, r);
> +		if (kvm_s390_pv_is_protected(vcpu->kvm)) {

I have the feeling that we might have to think about proper locking for
kvm_s390_pv_is_protected(). We have to make sure there cannot be any
races with user space. Smells like a new r/w lock maybe.


-- 
Thanks,

David / dhildenb
