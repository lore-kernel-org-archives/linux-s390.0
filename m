From: David Hildenbrand <david@redhat.com>
Date: Mon, 05 Mar 2018 12:52:08 +0000
Subject: Re: [PATCH 1/2] KVM: s390: fix fallthrough annotation
Message-Id: <7fdeeb56-a377-f0af-a0f4-1e6957e7bf59@redhat.com>
In-Reply-To: <20180305122041.21002d1d.cohuck@redhat.com>
References: <20180305122041.21002d1d.cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 05.03.2018 12:16, Christian Borntraeger wrote:
> From: Sebastian Ott <sebott@linux.vnet.ibm.com>
> 
> A case statement in kvm_s390_shadow_tables uses fallthrough annotations
> which are not recognized by gcc because they are hidden within a block.
> Move these annotations out of the block to fix (W=1) warnings like below:
> 
> arch/s390/kvm/gaccess.c: In function 'kvm_s390_shadow_tables':
> arch/s390/kvm/gaccess.c:1029:26: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   case ASCE_TYPE_REGION1: {
>                           ^
> 
> Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/gaccess.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index c24bfa72baf7..8e2b8647ee12 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -1050,8 +1050,7 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
>  		rc = gmap_shadow_r2t(sg, saddr, rfte.val, *fake);
>  		if (rc)
>  			return rc;
> -		/* fallthrough */
> -	}
> +	} /* fallthrough */
>  	case ASCE_TYPE_REGION2: {
>  		union region2_table_entry rste;
>  
> @@ -1077,8 +1076,7 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
>  		rc = gmap_shadow_r3t(sg, saddr, rste.val, *fake);
>  		if (rc)
>  			return rc;
> -		/* fallthrough */
> -	}
> +	} /* fallthrough */
>  	case ASCE_TYPE_REGION3: {
>  		union region3_table_entry rtte;
>  
> @@ -1113,8 +1111,7 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
>  		rc = gmap_shadow_sgt(sg, saddr, rtte.val, *fake);
>  		if (rc)
>  			return rc;
> -		/* fallthrough */
> -	}
> +	} /* fallthrough */
>  	case ASCE_TYPE_SEGMENT: {
>  		union segment_table_entry ste;
>  
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
