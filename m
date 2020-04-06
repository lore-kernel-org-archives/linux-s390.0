Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729306AbgDFQGP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Apr 2020 12:06:15 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 036G4BAU145375
        for <linux-s390@vger.kernel.org>; Mon, 6 Apr 2020 12:06:14 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3082g3th16-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 06 Apr 2020 12:06:14 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 6 Apr 2020 17:05:46 +0100
Subject: Re: [PATCH v2 5/5] KVM: s390: vsie: gmap_table_walk() simplifications
References: <20200403153050.20569-1-david@redhat.com>
 <20200403153050.20569-6-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 6 Apr 2020 18:06:07 +0200
MIME-Version: 1.0
In-Reply-To: <20200403153050.20569-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <408c6d94-0753-7ccb-a9d8-5018a84499ee@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>



On 03.04.20 17:30, David Hildenbrand wrote:
> Let's use asce_type where applicable. Also, simplify our sanity check for
> valid table levels and convert it into a WARN_ON_ONCE(). Check if we even
> have a valid gmap shadow as the very first step.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/mm/gmap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 24ef30fb0833..a2bd8d7792e9 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -788,19 +788,19 @@ static inline unsigned long *gmap_table_walk(struct gmap *gmap,
>  					     unsigned long gaddr, int level)
>  {
>  	const int asce_type = gmap->asce & _ASCE_TYPE_MASK;
> -	unsigned long *table;
> +	unsigned long *table = gmap->table;
>  
> -	if ((gmap->asce & _ASCE_TYPE_MASK) + 4 < (level * 4))
> -		return NULL;
>  	if (gmap_is_shadow(gmap) && gmap->removed)
>  		return NULL;
>  
> +	if (WARN_ON_ONCE(level > (asce_type >> 2) + 1))
> +		return NULL;
> +
>  	if (WARN_ON_ONCE(asce_type != _ASCE_TYPE_REGION1 &&
>  			 gaddr & (-1UL << (31 + (asce_type >> 2) * 11))))
>  		return NULL;
>  
> -	table = gmap->table;
> -	switch (gmap->asce & _ASCE_TYPE_MASK) {
> +	switch (asce_type) {
>  	case _ASCE_TYPE_REGION1:
>  		table += (gaddr & _REGION1_INDEX) >> _REGION1_SHIFT;
>  		if (level == 4)
> 
