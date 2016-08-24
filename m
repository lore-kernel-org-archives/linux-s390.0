From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 3/4] KVM-S390: Less function calls in
 kvm_s390_import_bp_data() after error detection
Date: Wed, 24 Aug 2016 11:10:03 -0400
Message-ID: <f9f50675-b283-4c03-8764-c7c570647fe4@de.ibm.com>
References: <82b84c9c-38a4-4d17-910f-312668dbae01@users.sourceforge.net>
 <47f88a11-b949-28ed-5589-925888a37574@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <47f88a11-b949-28ed-5589-925888a37574@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

On 08/17/2016 02:10 PM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 17 Aug 2016 19:25:50 +0200
> 
> The kfree() function was called in a few cases by the
> kvm_s390_import_bp_data() function during error handling
> even if a passed variable contained a null pointer.
> 
> Adjust jump targets according to the Linux coding style convention.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/s390/kvm/guestdbg.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
> index 8f886ee..f2514af 100644
> --- a/arch/s390/kvm/guestdbg.c
> +++ b/arch/s390/kvm/guestdbg.c
> @@ -239,7 +239,7 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
>  		wp_info = kmalloc(size, GFP_KERNEL);
>  		if (!wp_info) {
>  			ret = -ENOMEM;
> -			goto error;
> +			goto free_bp_data;
>  		}
>  	}
>  	size = nr_bp * sizeof(*bp_info);
> @@ -247,7 +247,7 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
>  		bp_info = kmalloc(size, GFP_KERNEL);
>  		if (!bp_info) {
>  			ret = -ENOMEM;
> -			goto error;
> +			goto free_wp_info;
>  		}
>  	}
> 
> @@ -257,7 +257,7 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
>  			ret = __import_wp_info(vcpu, &bp_data[i],
>  					       &wp_info[nr_wp]);
>  			if (ret)
> -				goto error;
> +				goto free_bp_info;
>  			nr_wp++;
>  			break;
>  		case KVM_HW_BP:
> @@ -273,10 +273,12 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
>  	vcpu->arch.guestdbg.nr_hw_wp = nr_wp;
>  	vcpu->arch.guestdbg.hw_wp_info = wp_info;
>  	return 0;
> -error:
> -	kfree(bp_data);
> -	kfree(wp_info);
> +free_bp_info:
>  	kfree(bp_info);
> +free_wp_info:
> +	kfree(wp_info);
> +free_bp_data:
> +	kfree(bp_data);
>  	return ret;
>  }

I agree with Cornelia, while it seems correct from a technical point of view, it will
make the code harder to maintain. For example if we ever add a new malloc and remove 
another one over time we would need to reshuffle the labels and this did went wrong
several times in the past.

Christian
