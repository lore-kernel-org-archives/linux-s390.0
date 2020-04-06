Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14598 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726574AbgDFNrm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Apr 2020 09:47:42 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 036DXEo3000834
        for <linux-s390@vger.kernel.org>; Mon, 6 Apr 2020 09:47:41 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3082j7p4wu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 06 Apr 2020 09:47:41 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 6 Apr 2020 14:47:17 +0100
Subject: Re: [PATCH v1 3/5] KVM: s390: vsie: Fix possible race when shadowing
 region 3 tables
References: <20200402184819.34215-1-david@redhat.com>
 <20200402184819.34215-4-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 6 Apr 2020 15:47:32 +0200
MIME-Version: 1.0
In-Reply-To: <20200402184819.34215-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <5f06a14e-1e3a-9de5-57fd-faecef3a1716@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>



On 02.04.20 20:48, David Hildenbrand wrote:
> We have to properly retry again by returning -EINVAL immediately in case
> somebody else instantiated the table concurrently. We missed to add the
> goto in this function only. The code now matches the other, similar
> shadowing functions.
> 
> We are overwriting an existing region 2 table entry. All allocated pages
> are added to the crst_list to be freed later, so they are not lost
> forever. However, when unshadowing the region 2 table, we wouldn't trigger
> unshadowing of the original shadowed region 3 table that we replaced. It
> would get unshadowed when the original region 3 table is modified. As it's
> not connected to the page table hierarchy anymore, it's not going to get
> used anymore. However, for a limited time, this page table will stick
> around, so it's in some sense a temporary memory leak.
> 
> Identified by manual code inspection. I don't think this classifies as
> stable material.
> 
> Fixes: 998f637cc4b9 ("s390/mm: avoid races on region/segment/page table shadowing")
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/mm/gmap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index f3dbc5bdde50..fd32ab566f57 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -1844,6 +1844,7 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
>  		goto out_free;
>  	} else if (*table & _REGION_ENTRY_ORIGIN) {
>  		rc = -EAGAIN;		/* Race with shadow */
> +		goto out_free;
>  	}
>  	crst_table_init(s_r3t, _REGION3_ENTRY_EMPTY);
>  	/* mark as invalid as long as the parent table is not protected */

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
