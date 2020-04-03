Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728459AbgDCR4k (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Apr 2020 13:56:40 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 033HYij8013335
        for <linux-s390@vger.kernel.org>; Fri, 3 Apr 2020 13:56:39 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 304swu7ng8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 03 Apr 2020 13:56:38 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 3 Apr 2020 18:56:18 +0100
Subject: Re: [PATCH v2 1/5] KVM: s390: vsie: Fix region 1 ASCE sanity shadow
 address checks
References: <20200403153050.20569-1-david@redhat.com>
 <20200403153050.20569-2-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 3 Apr 2020 19:56:31 +0200
MIME-Version: 1.0
In-Reply-To: <20200403153050.20569-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <59b411eb-dabe-8cac-9270-7a9f0faa63d5@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, stable@vger.kernel.org



On 03.04.20 17:30, David Hildenbrand wrote:
> In case we have a region 1 ASCE, our shadow/g3 address can have any value.
> Unfortunately, (-1UL << 64) is undefined and triggers sometimes,
> rejecting valid shadow addresses when trying to walk our shadow table
> hierarchy.

I thin the range of the addresses do not matter.
Took me a while to understand maybe rephrase that:

In case we have a region 1 the following calculation 
(31 + ((gmap->asce & _ASCE_TYPE_MASK) >> 2)*11)
results in 64. As shifts beyond the size are undefined the compiler is free to use
instructions like sllg. sllg will only use 6 bits of the shift value (here 64)
resulting in no shift at all. That means that ALL addresses will be rejected.

With that this makes sense. 

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>


> 
> The result is that the prefix cannot get mapped and will loop basically
> forever trying to map it (-EAGAIN loop).
> 
> After all, the broken check is only a sanity check, our table shadowing
> code in kvm_s390_shadow_tables() already checks these conditions, injecting
> proper translation exceptions. Turn it into a WARN_ON_ONCE().
> 
> Fixes: 4be130a08420 ("s390/mm: add shadow gmap support")
> Tested-by: Janosch Frank <frankja@linux.ibm.com>
> Reported-by: Janosch Frank <frankja@linux.ibm.com>
> Cc: <stable@vger.kernel.org> # v4.8+
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/mm/gmap.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 2fbece47ef6f..b93dd54b234a 100644
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
> +	if (WARN_ON_ONCE(asce_type != _ASCE_TYPE_REGION1 &&
> +			 gaddr & (-1UL << (31 + (asce_type >> 2) * 11))))
>  		return NULL;
> +
>  	table = gmap->table;
>  	switch (gmap->asce & _ASCE_TYPE_MASK) {
>  	case _ASCE_TYPE_REGION1:
> 
