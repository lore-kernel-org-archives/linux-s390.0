From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 2/4] KVM-S390: Use memdup_user() rather than duplicating
 its implementation
Date: Wed, 24 Aug 2016 11:19:28 -0400
Message-ID: <ddb2bbd9-757b-fc62-8642-ce827a7a666d@de.ibm.com>
References: <82b84c9c-38a4-4d17-910f-312668dbae01@users.sourceforge.net>
 <bb710b21-d8c4-e172-63d4-b46c80645cb3@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bb710b21-d8c4-e172-63d4-b46c80645cb3@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

On 08/17/2016 02:08 PM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 17 Aug 2016 18:41:43 +0200
> 
> * Reuse existing functionality from memdup_user() instead of keeping
>   duplicate source code.
> 
>   This issue was detected by using the Coccinelle software.
> 
> * Return directly if this copy operation failed.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

I was going to apply this patch, but it probably makes sense to respin the
first patch first as suggested to avoid me fixing up the conflicts and then
you fixing up the new conflict.

So can you respin patch 1,2 as suggested and add the acks/rb for patch 2?

> ---
>  arch/s390/kvm/guestdbg.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
> index b68db4b..8f886ee 100644
> --- a/arch/s390/kvm/guestdbg.c
> +++ b/arch/s390/kvm/guestdbg.c
> @@ -217,16 +217,9 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
>  		return -EINVAL;
> 
>  	size = dbg->arch.nr_hw_bp * sizeof(*bp_data);
> -	bp_data = kmalloc(size, GFP_KERNEL);
> -	if (!bp_data) {
> -		ret = -ENOMEM;
> -		goto error;
> -	}
> -
> -	if (copy_from_user(bp_data, dbg->arch.hw_bp, size)) {
> -		ret = -EFAULT;
> -		goto error;
> -	}
> +	bp_data = memdup_user(dbg->arch.hw_bp, size);
> +	if (IS_ERR(bp_data))
> +		return PTR_ERR(bp_data);
> 
>  	for (i = 0; i < dbg->arch.nr_hw_bp; i++) {
>  		switch (bp_data[i].type) {
> 
