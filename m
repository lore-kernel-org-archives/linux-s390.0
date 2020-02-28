Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60414 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727083AbgB1Pp5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 28 Feb 2020 10:45:57 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01SFZV35118063
        for <linux-s390@vger.kernel.org>; Fri, 28 Feb 2020 10:45:55 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yepy2kkbf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 28 Feb 2020 10:45:55 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Fri, 28 Feb 2020 15:45:53 -0000
Date: Fri, 28 Feb 2020 16:45:44 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [RFC v1 1/2] fixup for 9947ea2c1e608e32669d5caeb67b3e3fba3309e8
 "mm/gup: track FOLL_PIN pages"
In-Reply-To: <20200228154322.329228-2-imbrenda@linux.ibm.com>
References: <20200228154322.329228-1-imbrenda@linux.ibm.com>
        <20200228154322.329228-2-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20200228164544.6360f17e@p-imbrenda>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-next@vger.kernel.org, akpm@linux-foundation.org
Cc: borntraeger@de.ibm.com, david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

sorry, this one was a mistake, please ignore


On Fri, 28 Feb 2020 16:43:20 +0100
Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:

> in case pin fails, we need to unpin, just a put_page will not be
> enough
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  mm/gup.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index f589299b0d4a..0b9a806898f3 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2134,7 +2134,10 @@ static int gup_pte_range(pmd_t pmd, unsigned
> long addr, unsigned long end, goto pte_unmap;
>  
>  		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> -			put_page(head);
> +			if (flags & FOLL_GET)
> +				put_page(head);
> +			else if (flags & FOLL_PIN)
> +				unpin_user_page(head);
>  			goto pte_unmap;
>  		}
>  
