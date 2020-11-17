Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22568 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726794AbgKQSnN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Nov 2020 13:43:13 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AHIVV8x060679
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2020 13:43:12 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34ve31mycu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2020 13:43:12 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AHIVX6g060818
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2020 13:43:11 -0500
Date: Tue, 17 Nov 2020 19:43:05 +0100
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 1/3] s390/vmem: remove redundant check
Message-ID: <20201117184305.GD4746@osiris>
References: <cover.1605000280.git.agordeev@linux.ibm.com>
 <90f322a1d24b63a639dec1876a7a5cbbf866482a.1605000280.git.agordeev@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90f322a1d24b63a639dec1876a7a5cbbf866482a.1605000280.git.agordeev@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>

On Tue, Nov 10, 2020 at 10:36:21AM +0100, Alexander Gordeev wrote:
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/s390/mm/vmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> index b239f2ba93b09..56ab9bb770f3a 100644
> --- a/arch/s390/mm/vmem.c
> +++ b/arch/s390/mm/vmem.c
> @@ -223,7 +223,7 @@ static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
>  		if (!add) {
>  			if (pmd_none(*pmd))
>  				continue;
> -			if (pmd_large(*pmd) && !add) {
> +			if (pmd_large(*pmd)) {

Applied, thanks!
