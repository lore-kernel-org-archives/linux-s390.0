Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46916 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728054AbgDGLKt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Apr 2020 07:10:49 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 037B4e3G021602
        for <linux-s390@vger.kernel.org>; Tue, 7 Apr 2020 07:10:48 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3082f2ayut-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 07 Apr 2020 07:10:47 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Tue, 7 Apr 2020 12:10:28 +0100
Date: Tue, 7 Apr 2020 13:10:17 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v2 5/5] KVM: s390: vsie: gmap_table_walk()
 simplifications
In-Reply-To: <20200403153050.20569-6-david@redhat.com>
References: <20200403153050.20569-1-david@redhat.com>
        <20200403153050.20569-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20200407131017.471d2ca4@p-imbrenda>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Fri,  3 Apr 2020 17:30:50 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's use asce_type where applicable. Also, simplify our sanity check
> for valid table levels and convert it into a WARN_ON_ONCE(). Check if
> we even have a valid gmap shadow as the very first step.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/mm/gmap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 24ef30fb0833..a2bd8d7792e9 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -788,19 +788,19 @@ static inline unsigned long
> *gmap_table_walk(struct gmap *gmap, unsigned long gaddr, int level)
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
>  			 gaddr & (-1UL << (31 + (asce_type >> 2) *
> 11)))) return NULL;
>  
> -	table = gmap->table;
> -	switch (gmap->asce & _ASCE_TYPE_MASK) {
> +	switch (asce_type) {
>  	case _ASCE_TYPE_REGION1:
>  		table += (gaddr & _REGION1_INDEX) >> _REGION1_SHIFT;
>  		if (level == 4)

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
