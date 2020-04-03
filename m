Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36853 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728235AbgDCMHJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Apr 2020 08:07:09 -0400
Subject: Re: [PATCH v1 1/5] KVM: s390: vsie: Fix region 1 ASCE sanity shadow
 address checks
References: <20200402184819.34215-1-david@redhat.com>
 <20200402184819.34215-2-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <51eaff3a-74dc-0649-83f7-cc47e3bd390e@redhat.com>
Date: Fri, 3 Apr 2020 14:07:00 +0200
MIME-Version: 1.0
In-Reply-To: <20200402184819.34215-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, stable@vger.kernel.org

On 02.04.20 20:48, David Hildenbrand wrote:
> In case we have a region 1 ASCE, our shadow/g3 address can have any value.
> Unfortunately, (-1UL << 64) is undefined and triggers sometimes,
> rejecting valid shadow addresses when trying to walk our shadow table
> hierarchy.
> 
> The result is that the prefix cannot get mapped and will loop basically
> forever trying to map it (-EAGAIN loop).
> 
> After all, the broken check is only a sanity check, our table shadowing
> code in kvm_s390_shadow_tables() already checks these conditions, injecting
> proper translation exceptions. Turn it into a WARN_ON_ONCE().
> 
> Fixes: 4be130a08420 ("s390/mm: add shadow gmap support")
> Cc: <stable@vger.kernel.org> # v4.8+
> Reported-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/mm/gmap.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 2fbece47ef6f..f3dbc5bdde50 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -787,14 +787,18 @@ static void gmap_call_notifier(struct gmap *gmap, unsigned long start,
>  static inline unsigned long *gmap_table_walk(struct gmap *gmap,
>  					     unsigned long gaddr, int level)
>  {
> +	const int asce_type = gmap->asce & _ASCE_TYPE_MASK;
>  	unsigned long *table;
>  
>  	if ((gmap->asce & _ASCE_TYPE_MASK) + 4 < (level * 4))
>  		return NULL;
>  	if (gmap_is_shadow(gmap) && gmap->removed)
>  		return NULL;
> -	if (gaddr & (-1UL << (31 + ((gmap->asce & _ASCE_TYPE_MASK) >> 2)*11)))
> +
> +	if (WARN_ON_ONCE(asce_type != _ASCE_TYPE_REGION1) &&
> +			 gaddr & (-1UL << (31 + (asce_type >> 2) * 11)))
>  		return NULL;

This has to be

if (WARN_ON_ONCE(asce_type != _ASCE_TYPE_REGION1 &&
		 gaddr & (-1UL << (31 + (asce_type >> 2) * 11))))

otherwise we'll get wrong warnings

-- 
Thanks,

David / dhildenb
