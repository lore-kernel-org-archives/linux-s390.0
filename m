Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154272741C1;
	Mon, 14 Apr 2025 14:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640303; cv=none; b=ihijau53FoHYN26I+k26OObY9hXZTbsrSmdd0YtjPj72mRaFEMPcloEF1OYOBLJ6FqjG3RwLYlaStDFE+5KmpLudtp8zA5YmjgjCYegG9VghlxKid2f0c8V85cBX/1ZqGZ/TC/Bns+aqjQNro12ph/2i2j7RJpDxM+HPyhvAhhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640303; c=relaxed/simple;
	bh=mTn3FMzsj26kIxnkZNAmti2WDoD3F3JMt47fLl0UKcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxTfvsTvY9q96xvFYGxTg+2/SYwH+qnQtjmlU57hF5SWyw5VqmwanLB5NIWtzMpEDifNVOU9Tac42U7Cecd5nOqKEb4jgHDCIB1mRyTsmtS0VPNypJqePMwWQBpLkxuusf/fAUUeShgYrUq9XUjpmGpUr1dShp8u6Xcz4GtIlas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ah561Kin; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ah561Kin"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EAKA71029133;
	Mon, 14 Apr 2025 14:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=J1d9DTJcE/z+4d1uC+sEutnQDyUt9v
	5FZ9je4Eup1Ko=; b=ah561KinZjNqF6zq76DxnVBTSvamBRxYEhr7Z+gu/wYeYJ
	j7dAB+GRAIBgfgcT4RReFRSB7Mggil+evOZs4y5hwzSYaWE4QeQ1gjZ+HGRkUdNu
	pwXrRfEYgphoKE29KKWj5DPPBxTAdadEXNR3p1tOzlSCoHUJ64LwlntS5prWHWM/
	ypBEt8HygnTXrT6MFoIK9aXcP6Apa1XfK3rhxUyJOl2bhpNUByVTq6q6beBiPmV1
	wjohaUUBJj7eE9ivNowExDlwR07lfFYP7j7RrqeB2X+koXmdx0GpvTziQRFy8s24
	0VxXFpeXm2aqdcwNxTwNhj/bC9jcAny5HST8QorQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 460nc4bs6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 14:17:54 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53EEDPx6027591;
	Mon, 14 Apr 2025 14:17:53 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 460nc4bs6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 14:17:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53ECwxMl017183;
	Mon, 14 Apr 2025 14:17:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46040kpeha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 14:17:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53EEHorV51577248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 14:17:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CE2320043;
	Mon, 14 Apr 2025 14:17:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BFC320040;
	Mon, 14 Apr 2025 14:17:49 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.13.82])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 14 Apr 2025 14:17:49 +0000 (GMT)
Date: Mon, 14 Apr 2025 16:17:47 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Hugh Dickins <hughd@google.com>, Guenter Roeck <linux@roeck-us.net>,
        Juergen Gross <jgross@suse.com>, Jeremy Fitzhardinge <jeremy@goop.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, sparclinux@vger.kernel.org,
        xen-devel@lists.xenproject.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v1 2/4] mm: Cleanup apply_to_pte_range() routine
Message-ID: <Z/0ZC7HcSmoOEglw@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <cover.1744037648.git.agordeev@linux.ibm.com>
 <93102722541b1daf541fce9fb316a1a2614d8c86.1744037648.git.agordeev@linux.ibm.com>
 <D93LW58FLXOS.2U8X0CO2H9H5S@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D93LW58FLXOS.2U8X0CO2H9H5S@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: u44-EjcfNgIEy_4sPtFf7SZelDSyFVJd
X-Proofpoint-ORIG-GUID: DiJ-rrsNSTwxXUpWJqT680rFpek1uPzj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=844
 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504140102

On Fri, Apr 11, 2025 at 04:46:58PM +1000, Nicholas Piggin wrote:
> On Tue Apr 8, 2025 at 1:11 AM AEST, Alexander Gordeev wrote:
> > Reverse 'create' vs 'mm == &init_mm' conditions and move
> > page table mask modification out of the atomic context.
> >
> > Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> > ---
> >  mm/memory.c | 28 +++++++++++++++++-----------
> >  1 file changed, 17 insertions(+), 11 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 2d8c265fc7d6..f0201c8ec1ce 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -2915,24 +2915,28 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
> >  				     pte_fn_t fn, void *data, bool create,
> >  				     pgtbl_mod_mask *mask)
> >  {
> > +	int err = create ? -ENOMEM : -EINVAL;
> 
> Could you make this a new variable instead of reusing
> existing err? 'const int pte_err' or something?

Will do, when/if repost.

...

> > @@ -2944,12 +2948,14 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
> >  			}
> >  		} while (addr += PAGE_SIZE, addr != end);
> >  	}
> > -	*mask |= PGTBL_PTE_MODIFIED;
> >  
> >  	arch_leave_lazy_mmu_mode();
> >  
> >  	if (mm != &init_mm)
> >  		pte_unmap_unlock(mapped_pte, ptl);
> > +
> > +	*mask |= PGTBL_PTE_MODIFIED;
> 
> This is done just because we might as well? Less work in critical
> section?

Yes.

Thanks!
