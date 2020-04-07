Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19654 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728371AbgDGLKw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Apr 2020 07:10:52 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 037B2pus094512
        for <linux-s390@vger.kernel.org>; Tue, 7 Apr 2020 07:10:51 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3082hgm9wt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 07 Apr 2020 07:10:51 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Tue, 7 Apr 2020 12:10:22 +0100
Date: Tue, 7 Apr 2020 13:05:22 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v2 3/5] KVM: s390: vsie: Fix possible race when
 shadowing region 3 tables
In-Reply-To: <20200403153050.20569-4-david@redhat.com>
References: <20200403153050.20569-1-david@redhat.com>
        <20200403153050.20569-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20200407130522.189a9a3f@p-imbrenda>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Fri,  3 Apr 2020 17:30:48 +0200
David Hildenbrand <david@redhat.com> wrote:

> We have to properly retry again by returning -EINVAL immediately in
> case somebody else instantiated the table concurrently. We missed to
> add the goto in this function only. The code now matches the other,
> similar shadowing functions.
> 
> We are overwriting an existing region 2 table entry. All allocated
> pages are added to the crst_list to be freed later, so they are not
> lost forever. However, when unshadowing the region 2 table, we
> wouldn't trigger unshadowing of the original shadowed region 3 table
> that we replaced. It would get unshadowed when the original region 3
> table is modified. As it's not connected to the page table hierarchy
> anymore, it's not going to get used anymore. However, for a limited
> time, this page table will stick around, so it's in some sense a
> temporary memory leak.
> 
> Identified by manual code inspection. I don't think this classifies as
> stable material.
> 
> Fixes: 998f637cc4b9 ("s390/mm: avoid races on region/segment/page
> table shadowing") Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/mm/gmap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index b93dd54b234a..24ef30fb0833 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -1844,6 +1844,7 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned
> long saddr, unsigned long r3t, goto out_free;
>  	} else if (*table & _REGION_ENTRY_ORIGIN) {
>  		rc = -EAGAIN;		/* Race with shadow */
> +		goto out_free;
>  	}
>  	crst_table_init(s_r3t, _REGION3_ENTRY_EMPTY);
>  	/* mark as invalid as long as the parent table is not
> protected */

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
